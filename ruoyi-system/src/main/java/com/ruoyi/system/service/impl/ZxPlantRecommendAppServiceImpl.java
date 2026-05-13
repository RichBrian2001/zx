package com.ruoyi.system.service.impl;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.system.domain.ZxPlant;
import com.ruoyi.system.domain.ZxPlantDetail;
import com.ruoyi.system.domain.ZxPlantTagRel;
import com.ruoyi.system.domain.ZxQuestionnaireRecord;
import com.ruoyi.system.domain.ZxRecommendItem;
import com.ruoyi.system.domain.ZxRecommendRecord;
import com.ruoyi.system.domain.ZxRecommendRule;
import com.ruoyi.system.domain.ZxUserProfile;
import com.ruoyi.system.mapper.ZxPlantDetailMapper;
import com.ruoyi.system.mapper.ZxPlantMapper;
import com.ruoyi.system.mapper.ZxPlantTagRelMapper;
import com.ruoyi.system.mapper.ZxQuestionnaireRecordMapper;
import com.ruoyi.system.mapper.ZxRecommendRecordMapper;
import com.ruoyi.system.mapper.ZxRecommendRuleMapper;
import com.ruoyi.system.mapper.ZxUserProfileMapper;
import com.ruoyi.system.service.IZxPlantRecommendAppService;

@Service
public class ZxPlantRecommendAppServiceImpl implements IZxPlantRecommendAppService
{
    private static final BigDecimal ZERO = BigDecimal.ZERO;
    private static final BigDecimal BASE_SCORE = new BigDecimal("40");
    private static final BigDecimal TAG_WEIGHT_FACTOR = new BigDecimal("0.60");
    private static final int RESULT_LIMIT = 3;

    @Autowired
    private ZxRecommendRecordMapper recommendRecordMapper;

    @Autowired
    private ZxQuestionnaireRecordMapper questionnaireRecordMapper;

    @Autowired
    private ZxUserProfileMapper userProfileMapper;

    @Autowired
    private ZxPlantMapper plantMapper;

    @Autowired
    private ZxPlantDetailMapper plantDetailMapper;

    @Autowired
    private ZxPlantTagRelMapper plantTagRelMapper;

    @Autowired
    private ZxRecommendRuleMapper recommendRuleMapper;

    @Override
    @Transactional
    public Map<String, Object> executeRecommend(Long questionnaireId, Long profileId, String visitorUid)
    {
        ZxUserProfile profile = profileId == null ? null : userProfileMapper.selectZxUserProfileById(profileId);
        if (profile == null && visitorUid != null && !visitorUid.isEmpty())
        {
            profile = userProfileMapper.selectZxUserProfileByVisitorUid(visitorUid);
        }
        ZxQuestionnaireRecord questionnaire = questionnaireId == null ? null : questionnaireRecordMapper.selectZxQuestionnaireRecordById(questionnaireId);
        String finalVisitorUid = visitorUid;
        if ((finalVisitorUid == null || finalVisitorUid.isEmpty()) && questionnaire != null)
        {
            finalVisitorUid = questionnaire.getVisitorUid();
        }
        if ((finalVisitorUid == null || finalVisitorUid.isEmpty()) && profile != null)
        {
            finalVisitorUid = profile.getVisitorUid();
        }

        ZxPlant plantQuery = new ZxPlant();
        plantQuery.setDisplayStatus("0");
        plantQuery.setStatus("0");
        List<ZxPlant> plantList = plantMapper.selectZxPlantList(plantQuery);
        RecommendContext context = buildContext(questionnaire, profile);
        List<ZxRecommendRule> activeRules = selectActiveRules();
        List<ZxRecommendRule> triggeredRules = resolveTriggeredRules(activeRules, context);
        List<ScoredPlant> rankedPlants = scorePlants(plantList, context, triggeredRules);
        int resultCount = Math.min(RESULT_LIMIT, rankedPlants.size());

        ZxRecommendRecord record = new ZxRecommendRecord();
        record.setVisitorUid(finalVisitorUid == null ? "" : finalVisitorUid);
        record.setQuestionnaireId(questionnaireId);
        record.setProfileId(profile == null ? profileId : profile.getProfileId());
        record.setRequestJson(buildRequestJson(questionnaireId, record.getProfileId(), finalVisitorUid));
        record.setResultJson(buildResultJson(rankedPlants, resultCount));
        record.setMatchRuleJson(buildMatchRuleJson(context, triggeredRules));
        record.setTopPlantId(resultCount > 0 ? rankedPlants.get(0).plant.getPlantId() : null);
        record.setTotalCandidateCount(rankedPlants.size());
        record.setResultCount(resultCount);
        record.setSourceTerminal(questionnaire == null ? "" : questionnaire.getSourceTerminal());
        record.setRecommendTime(new Date());
        recommendRecordMapper.insertZxRecommendRecord(record);

        List<ZxRecommendItem> itemList = new ArrayList<ZxRecommendItem>();
        for (int i = 0; i < resultCount; i++)
        {
            ScoredPlant rankedPlant = rankedPlants.get(i);
            ZxRecommendItem item = new ZxRecommendItem();
            item.setRecordId(record.getRecordId());
            item.setPlantId(rankedPlant.plant.getPlantId());
            item.setScoreTotal(rankedPlant.scoreTotal.setScale(1, RoundingMode.HALF_UP));
            item.setScoreDetailJson(buildScoreDetailJson(rankedPlant.scoreDetail));
            item.setRankNum(i + 1);
            item.setReasonText(buildReasonText(rankedPlant));
            itemList.add(item);
        }
        if (!itemList.isEmpty())
        {
            recommendRecordMapper.batchInsertZxRecommendItem(itemList);
        }

        if (profile != null)
        {
            profile.setLastRecommendTime(record.getRecommendTime());
            userProfileMapper.updateZxUserProfile(profile);
        }

        Map<String, Object> result = new HashMap<String, Object>();
        result.put("recordId", record.getRecordId());
        result.put("profileId", record.getProfileId());
        result.put("topPlantId", record.getTopPlantId());
        result.put("resultCount", record.getResultCount());
        return result;
    }

    @Override
    public Map<String, Object> selectRecommendResult(Long recordId)
    {
        ZxRecommendRecord record = recommendRecordMapper.selectZxRecommendRecordById(recordId);
        Map<String, Object> result = new HashMap<String, Object>();
        if (record == null)
        {
            return result;
        }
        List<ZxRecommendItem> itemList = recommendRecordMapper.selectZxRecommendItemListByRecordId(recordId);
        List<Map<String, Object>> resultItems = new ArrayList<Map<String, Object>>();
        for (ZxRecommendItem item : itemList)
        {
            ZxPlant plant = plantMapper.selectZxPlantById(item.getPlantId());
            ZxPlantDetail detail = plantDetailMapper.selectZxPlantDetailByPlantId(item.getPlantId());
            Map<String, Object> itemMap = new HashMap<String, Object>();
            itemMap.put("plantId", item.getPlantId());
            itemMap.put("plantName", plant == null ? item.getPlantName() : plant.getPlantName());
            itemMap.put("coverImage", plant == null ? "" : plant.getCoverImage());
            itemMap.put("plantSummary", plant == null ? "" : plant.getPlantSummary());
            itemMap.put("difficultyLevel", plant == null ? "" : plant.getDifficultyLevel());
            itemMap.put("priceLevel", plant == null ? "" : plant.getPriceLevel());
            itemMap.put("petSafeFlag", plant == null ? "" : plant.getPetSafeFlag());
            itemMap.put("purgeEffectFlag", plant == null ? "" : plant.getPurgeEffectFlag());
            itemMap.put("aromaFlag", plant == null ? "" : plant.getAromaFlag());
            itemMap.put("suitableScene", plant == null ? "" : plant.getSuitableScene());
            itemMap.put("rankNum", item.getRankNum());
            itemMap.put("scoreTotal", item.getScoreTotal());
            itemMap.put("reasonText", item.getReasonText());
            itemMap.put("scoreDetailJson", item.getScoreDetailJson());
            itemMap.put("riskTips", detail == null ? "" : detail.getRiskTips());
            resultItems.add(itemMap);
        }

        result.put("recordId", record.getRecordId());
        result.put("visitorUid", record.getVisitorUid());
        result.put("recommendTime", record.getRecommendTime());
        result.put("totalCandidateCount", record.getTotalCandidateCount());
        result.put("resultCount", record.getResultCount());
        result.put("topPlantId", record.getTopPlantId());
        result.put("topPlantName", record.getTopPlantName());
        result.put("matchRuleJson", record.getMatchRuleJson());
        result.put("resultItems", resultItems);
        return result;
    }

    @Override
    public List<Map<String, Object>> selectHistoryList(String visitorUid)
    {
        ZxRecommendRecord query = new ZxRecommendRecord();
        query.setVisitorUid(visitorUid);
        List<ZxRecommendRecord> recordList = recommendRecordMapper.selectZxRecommendRecordList(query);
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        for (ZxRecommendRecord record : recordList)
        {
            ZxPlant plant = record.getTopPlantId() == null ? null : plantMapper.selectZxPlantById(record.getTopPlantId());
            ZxQuestionnaireRecord questionnaire = record.getQuestionnaireId() == null ? null : questionnaireRecordMapper.selectZxQuestionnaireRecordById(record.getQuestionnaireId());
            Map<String, Object> item = new HashMap<String, Object>();
            item.put("recordId", record.getRecordId());
            item.put("recommendTime", record.getRecommendTime());
            item.put("topPlantId", record.getTopPlantId());
            item.put("topPlantName", record.getTopPlantName());
            item.put("topPlantCoverImage", plant == null ? "" : plant.getCoverImage());
            item.put("environmentSummary", questionnaire == null ? "" : questionnaire.getEnvironmentSummary());
            item.put("preferenceSummary", questionnaire == null ? "" : questionnaire.getPreferenceSummary());
            item.put("resultCount", record.getResultCount());
            result.add(item);
        }
        return result;
    }

    private List<ScoredPlant> scorePlants(List<ZxPlant> plantList, RecommendContext context, List<ZxRecommendRule> triggeredRules)
    {
        List<ScoredPlant> rankedPlants = new ArrayList<ScoredPlant>();
        for (ZxPlant plant : plantList)
        {
            Map<String, ZxPlantTagRel> tagMap = loadTagMap(plant.getPlantId());
            ScoredPlant scoredPlant = scorePlant(plant, tagMap, context, triggeredRules);
            if (!scoredPlant.excluded)
            {
                rankedPlants.add(scoredPlant);
            }
        }
        if (rankedPlants.isEmpty())
        {
            return buildFallbackCandidates(plantList);
        }
        rankedPlants.sort((left, right) -> {
            int scoreCompare = right.scoreTotal.compareTo(left.scoreTotal);
            if (scoreCompare != 0)
            {
                return scoreCompare;
            }
            int sortLeft = left.plant.getSortNum() == null ? Integer.MAX_VALUE : left.plant.getSortNum();
            int sortRight = right.plant.getSortNum() == null ? Integer.MAX_VALUE : right.plant.getSortNum();
            if (sortLeft != sortRight)
            {
                return Integer.compare(sortLeft, sortRight);
            }
            return Long.compare(left.plant.getPlantId(), right.plant.getPlantId());
        });
        return rankedPlants;
    }

    private List<ScoredPlant> buildFallbackCandidates(List<ZxPlant> plantList)
    {
        List<ScoredPlant> fallbackList = new ArrayList<ScoredPlant>();
        for (ZxPlant plant : plantList)
        {
            ScoredPlant fallback = new ScoredPlant(plant);
            addScore(fallback, "base", BASE_SCORE, "基于当前上架植物生成兜底推荐");
            fallbackList.add(fallback);
        }
        return fallbackList;
    }

    private ScoredPlant scorePlant(ZxPlant plant, Map<String, ZxPlantTagRel> tagMap, RecommendContext context, List<ZxRecommendRule> triggeredRules)
    {
        ScoredPlant scoredPlant = new ScoredPlant(plant);
        addScore(scoredPlant, "base", BASE_SCORE, "基础上架候选");
        addTagScore(scoredPlant, tagMap, context.lightTagCode, new BigDecimal("14"), "light", "光照条件匹配");
        addTagScore(scoredPlant, tagMap, context.waterTagCode, new BigDecimal("8"), "water", "浇水频率匹配");
        addTagScore(scoredPlant, tagMap, context.spaceTagCode, new BigDecimal("12"), "space", "空间尺度匹配");
        addTagScore(scoredPlant, tagMap, resolveCareTagCode(context.care), new BigDecimal("10"), "care", "养护投入匹配");
        addTagScore(scoredPlant, tagMap, resolveBudgetTagCode(context.budgetLevel), new BigDecimal("8"), "budget", "预算区间匹配");
        addTagScore(scoredPlant, tagMap, context.styleTagCode, new BigDecimal("10"), "style", "风格偏好匹配");

        if (context.petFamily)
        {
            addTagScore(scoredPlant, tagMap, "pet_yes", new BigDecimal("14"), "pet", "宠物友好优先");
        }

        applyGoalSignals(scoredPlant, tagMap, context, plant);
        applySceneSignals(scoredPlant, tagMap, context);
        applyRules(scoredPlant, tagMap, triggeredRules);
        return scoredPlant;
    }

    private void applyGoalSignals(ScoredPlant scoredPlant, Map<String, ZxPlantTagRel> tagMap, RecommendContext context, ZxPlant plant)
    {
        if ("desktop".equals(context.goal))
        {
            addTagScore(scoredPlant, tagMap, "feature_desktop", new BigDecimal("12"), "goal", "适合桌面陈列");
        }
        else if ("layered".equals(context.goal))
        {
            addTagScore(scoredPlant, tagMap, "feature_hanging", new BigDecimal("8"), "goal", "适合做空间层次");
            addTagScore(scoredPlant, tagMap, "feature_statement", new BigDecimal("10"), "goal", "更有陈设存在感");
        }
        else if ("purify".equals(context.goal))
        {
            addTagScore(scoredPlant, tagMap, "function_purify", new BigDecimal("14"), "goal", "符合空气净化诉求");
            if ("1".equals(plant.getPurgeEffectFlag()))
            {
                addScore(scoredPlant, "goal_flag", new BigDecimal("3"), "净化属性更明确");
            }
        }
        else if ("aroma".equals(context.goal))
        {
            addTagScore(scoredPlant, tagMap, "function_aroma", new BigDecimal("14"), "goal", "符合闻香观花诉求");
            if ("1".equals(plant.getAromaFlag()))
            {
                addScore(scoredPlant, "goal_flag", new BigDecimal("3"), "香味体验更明确");
            }
        }
    }

    private void applySceneSignals(ScoredPlant scoredPlant, Map<String, ZxPlantTagRel> tagMap, RecommendContext context)
    {
        if ("desk".equals(context.scene))
        {
            addTagScore(scoredPlant, tagMap, "feature_desktop", new BigDecimal("8"), "scene", "桌面尺度更合适");
            addTagScore(scoredPlant, tagMap, "space_small", new BigDecimal("4"), "scene", "小体量摆放更轻松");
        }
        else if ("bedroom".equals(context.scene))
        {
            addTagScore(scoredPlant, tagMap, "light_low", new BigDecimal("6"), "scene", "更适合卧室弱光环境");
            addTagScore(scoredPlant, tagMap, "space_small", new BigDecimal("4"), "scene", "卧室边柜尺度更友好");
        }
        else if ("living".equals(context.scene))
        {
            addTagScore(scoredPlant, tagMap, "space_large", new BigDecimal("8"), "scene", "适合客厅落地或边柜摆放");
            addTagScore(scoredPlant, tagMap, "feature_statement", new BigDecimal("8"), "scene", "客厅陈设感更强");
        }
        else if ("office".equals(context.scene))
        {
            addTagScore(scoredPlant, tagMap, "care_easy", new BigDecimal("6"), "scene", "更适合办公节奏养护");
            addTagScore(scoredPlant, tagMap, "function_purify", new BigDecimal("6"), "scene", "办公室净化诉求更强");
        }
        else if ("balcony".equals(context.scene))
        {
            addTagScore(scoredPlant, tagMap, "light_high", new BigDecimal("8"), "scene", "阳台充足日照更适配");
            addTagScore(scoredPlant, tagMap, "function_aroma", new BigDecimal("5"), "scene", "阳台更容易形成闻香体验");
        }
    }

    private void applyRules(ScoredPlant scoredPlant, Map<String, ZxPlantTagRel> tagMap, List<ZxRecommendRule> triggeredRules)
    {
        for (ZxRecommendRule rule : triggeredRules)
        {
            String actionType = rule.getActionType();
            String actionValue = rule.getActionValue();
            if ("excludeTag".equals(actionType) && tagMap.containsKey(actionValue))
            {
                scoredPlant.excluded = true;
                return;
            }
            if (("preferTag".equals(actionType) || "addScoreByTag".equals(actionType)) && tagMap.containsKey(actionValue))
            {
                addTagScore(scoredPlant, tagMap, actionValue, defaultScore(rule.getScoreValue()), "rule_" + safe(rule.getRuleCode()), safe(rule.getRuleDesc()));
            }
            if ("appendReason".equals(actionType) && !scoredPlant.reasonParts.isEmpty())
            {
                scoredPlant.reasonParts.add(safe(rule.getRuleDesc()));
            }
        }
    }

    private Map<String, ZxPlantTagRel> loadTagMap(Long plantId)
    {
        List<ZxPlantTagRel> tagList = plantTagRelMapper.selectSelectedTagListByPlantId(plantId);
        Map<String, ZxPlantTagRel> tagMap = new HashMap<String, ZxPlantTagRel>();
        for (ZxPlantTagRel tagRel : tagList)
        {
            tagMap.put(tagRel.getTagCode(), tagRel);
        }
        return tagMap;
    }

    private List<ZxRecommendRule> selectActiveRules()
    {
        ZxRecommendRule query = new ZxRecommendRule();
        query.setStatus("0");
        return recommendRuleMapper.selectZxRecommendRuleList(query);
    }

    private List<ZxRecommendRule> resolveTriggeredRules(List<ZxRecommendRule> ruleList, RecommendContext context)
    {
        List<ZxRecommendRule> triggeredRules = new ArrayList<ZxRecommendRule>();
        for (ZxRecommendRule rule : ruleList)
        {
            if (isRuleTriggered(rule, context))
            {
                triggeredRules.add(rule);
            }
        }
        return triggeredRules;
    }

    private boolean isRuleTriggered(ZxRecommendRule rule, RecommendContext context)
    {
        String triggerField = safe(rule.getTriggerField());
        if (triggerField.isEmpty())
        {
            return false;
        }
        if ("match".equals(triggerField))
        {
            return true;
        }
        if ("budget".equals(triggerField))
        {
            return compareNumber(context.budgetValue, rule.getTriggerOperator(), rule.getTriggerValue());
        }
        return compareText(resolveContextFieldValue(context, triggerField), rule.getTriggerOperator(), rule.getTriggerValue());
    }

    private String resolveContextFieldValue(RecommendContext context, String field)
    {
        if ("scene".equals(field))
        {
            return context.scene;
        }
        if ("light".equals(field))
        {
            return context.light;
        }
        if ("space".equals(field))
        {
            return context.space;
        }
        if ("pet".equals(field))
        {
            return context.petFamily ? "true" : "false";
        }
        if ("care".equals(field))
        {
            return context.care;
        }
        if ("style".equals(field))
        {
            return context.style;
        }
        if ("goal".equals(field))
        {
            return context.goal;
        }
        return "";
    }

    private boolean compareText(String actual, String operator, String expected)
    {
        String left = safe(actual).toLowerCase();
        String right = safe(expected).toLowerCase();
        if ("=".equals(operator))
        {
            return left.equals(right);
        }
        if ("!=".equals(operator))
        {
            return !left.equals(right);
        }
        if ("contains".equalsIgnoreCase(operator))
        {
            return left.contains(right);
        }
        return false;
    }

    private boolean compareNumber(BigDecimal actual, String operator, String expected)
    {
        if (actual == null)
        {
            return false;
        }
        BigDecimal expectedValue;
        try
        {
            expectedValue = new BigDecimal(safe(expected));
        }
        catch (NumberFormatException exception)
        {
            return false;
        }
        if ("=".equals(operator))
        {
            return actual.compareTo(expectedValue) == 0;
        }
        if (">=".equals(operator))
        {
            return actual.compareTo(expectedValue) >= 0;
        }
        if (">".equals(operator))
        {
            return actual.compareTo(expectedValue) > 0;
        }
        if ("<=".equals(operator))
        {
            return actual.compareTo(expectedValue) <= 0;
        }
        if ("<".equals(operator))
        {
            return actual.compareTo(expectedValue) < 0;
        }
        return false;
    }

    private RecommendContext buildContext(ZxQuestionnaireRecord questionnaire, ZxUserProfile profile)
    {
        RecommendContext context = new RecommendContext();
        context.scene = normalizeScene(extractAnswer(questionnaire, "scene"));
        context.light = normalizeLight(extractAnswer(questionnaire, "light"), profile == null ? "" : profile.getLightTagCode());
        context.space = normalizeSpace(extractAnswer(questionnaire, "space"), profile == null ? "" : profile.getSpaceTagCode());
        context.petFamily = "1".equals(profile == null ? "" : profile.getPetPreference()) || isPetFamily(extractAnswer(questionnaire, "pet"));
        context.care = normalizeCare(extractAnswer(questionnaire, "care"), profile == null ? "" : profile.getCarePreference());
        context.style = normalizeStyle(extractAnswer(questionnaire, "style"), profile == null ? "" : profile.getStyleTagCode());
        context.goal = normalizeGoal(extractAnswer(questionnaire, "goal"));
        context.budgetValue = questionnaire == null || questionnaire.getBudgetValue() == null ? ZERO : questionnaire.getBudgetValue();
        context.budgetLevel = profile == null ? resolveBudgetLevel(context.budgetValue) : safe(profile.getBudgetLevel());
        context.lightTagCode = profile == null ? resolveLightTagCode(context.light) : safe(profile.getLightTagCode());
        context.waterTagCode = profile == null ? resolveWaterTagCode(context.care) : safe(profile.getWaterTagCode());
        context.spaceTagCode = profile == null ? resolveSpaceTagCode(context.space) : safe(profile.getSpaceTagCode());
        context.styleTagCode = profile == null ? resolveStyleTagCode(context.style) : safe(profile.getStyleTagCode());
        return context;
    }

    private String extractAnswer(ZxQuestionnaireRecord questionnaire, String key)
    {
        if (questionnaire == null || questionnaire.getAnswerJson() == null)
        {
            return "";
        }
        String prefix = "\"" + key + "\":";
        int start = questionnaire.getAnswerJson().indexOf(prefix);
        if (start < 0)
        {
            return "";
        }
        start = start + prefix.length();
        while (start < questionnaire.getAnswerJson().length() && questionnaire.getAnswerJson().charAt(start) == ' ')
        {
            start++;
        }
        if (start >= questionnaire.getAnswerJson().length())
        {
            return "";
        }
        char firstChar = questionnaire.getAnswerJson().charAt(start);
        if (firstChar == '"')
        {
            start++;
            int end = questionnaire.getAnswerJson().indexOf('"', start);
            return end < 0 ? "" : questionnaire.getAnswerJson().substring(start, end);
        }
        int end = questionnaire.getAnswerJson().indexOf(',', start);
        if (end < 0)
        {
            end = questionnaire.getAnswerJson().indexOf('}', start);
        }
        return end < 0 ? "" : questionnaire.getAnswerJson().substring(start, end).replace("\"", "").trim();
    }

    private String normalizeScene(String rawScene)
    {
        String scene = safe(rawScene).toLowerCase();
        if (scene.contains("desk") || rawScene.contains("桌面") || rawScene.contains("书桌"))
        {
            return "desk";
        }
        if (scene.contains("bedroom") || rawScene.contains("卧室"))
        {
            return "bedroom";
        }
        if (scene.contains("living") || rawScene.contains("客厅"))
        {
            return "living";
        }
        if (scene.contains("office") || rawScene.contains("办公"))
        {
            return "office";
        }
        if (scene.contains("balcony") || rawScene.contains("阳台"))
        {
            return "balcony";
        }
        return "desk";
    }

    private String normalizeLight(String rawLight, String profileLightTagCode)
    {
        String light = safe(rawLight).toLowerCase();
        if (light.contains("直射") || light.contains("high") || light.contains("强"))
        {
            return "high";
        }
        if (light.contains("半阴") || light.contains("弱光") || light.contains("low") || light.contains("shade"))
        {
            return "low";
        }
        if ("light_low".equals(profileLightTagCode))
        {
            return "low";
        }
        if ("light_high".equals(profileLightTagCode))
        {
            return "high";
        }
        return "medium";
    }

    private String normalizeSpace(String rawSpace, String profileSpaceTagCode)
    {
        String space = safe(rawSpace).toLowerCase();
        if (space.contains("small") || space.contains("desktop") || rawSpace.contains("小"))
        {
            return "small";
        }
        if (space.contains("large") || space.contains("balcony") || rawSpace.contains("大"))
        {
            return "large";
        }
        if ("space_small".equals(profileSpaceTagCode))
        {
            return "small";
        }
        if ("space_large".equals(profileSpaceTagCode))
        {
            return "large";
        }
        return "medium";
    }

    private String normalizeCare(String rawCare, String carePreference)
    {
        String care = safe(rawCare).toLowerCase();
        if (care.contains("高") || care.contains("hard") || care.contains("high"))
        {
            return "hard";
        }
        if (care.contains("中") || care.contains("medium"))
        {
            return "medium";
        }
        if ("3".equals(carePreference))
        {
            return "hard";
        }
        if ("2".equals(carePreference))
        {
            return "medium";
        }
        return "easy";
    }

    private String normalizeStyle(String rawStyle, String profileStyleTagCode)
    {
        String style = safe(rawStyle).toLowerCase();
        if (style.contains("治愈") || style.contains("healing") || "style_healing".equals(profileStyleTagCode))
        {
            return "healing";
        }
        if (style.contains("热带") || style.contains("tropical") || "style_tropical".equals(profileStyleTagCode))
        {
            return "tropical";
        }
        if (style.contains("花") || style.contains("flower") || "style_flower".equals(profileStyleTagCode))
        {
            return "flower";
        }
        return "minimal";
    }

    private String normalizeGoal(String rawGoal)
    {
        String goal = safe(rawGoal).toLowerCase();
        if (goal.contains("桌面") || goal.contains("desktop"))
        {
            return "desktop";
        }
        if (goal.contains("层次") || goal.contains("layer"))
        {
            return "layered";
        }
        if (goal.contains("净化") || goal.contains("purify"))
        {
            return "purify";
        }
        if (goal.contains("闻香") || goal.contains("观花") || goal.contains("aroma"))
        {
            return "aroma";
        }
        return "desktop";
    }

    private boolean isPetFamily(String rawPet)
    {
        return rawPet.contains("是") || rawPet.contains("true") || rawPet.contains("有") || "1".equals(rawPet);
    }

    private String resolveLightTagCode(String normalizedLight)
    {
        if ("low".equals(normalizedLight))
        {
            return "light_low";
        }
        if ("high".equals(normalizedLight))
        {
            return "light_high";
        }
        return "light_medium";
    }

    private String resolveWaterTagCode(String normalizedCare)
    {
        if ("hard".equals(normalizedCare))
        {
            return "water_high";
        }
        if ("easy".equals(normalizedCare))
        {
            return "water_low";
        }
        return "water_medium";
    }

    private String resolveSpaceTagCode(String normalizedSpace)
    {
        if ("small".equals(normalizedSpace))
        {
            return "space_small";
        }
        if ("large".equals(normalizedSpace))
        {
            return "space_large";
        }
        return "space_medium";
    }

    private String resolveStyleTagCode(String normalizedStyle)
    {
        if ("healing".equals(normalizedStyle))
        {
            return "style_healing";
        }
        if ("tropical".equals(normalizedStyle))
        {
            return "style_tropical";
        }
        if ("flower".equals(normalizedStyle))
        {
            return "style_flower";
        }
        return "style_minimal";
    }

    private String resolveBudgetLevel(BigDecimal budgetValue)
    {
        if (budgetValue == null || budgetValue.compareTo(new BigDecimal("100")) <= 0)
        {
            return "1";
        }
        if (budgetValue.compareTo(new BigDecimal("300")) < 0)
        {
            return "2";
        }
        return "3";
    }

    private String resolveCareTagCode(String care)
    {
        if ("hard".equals(care))
        {
            return "care_hard";
        }
        if ("medium".equals(care))
        {
            return "care_medium";
        }
        return "care_easy";
    }

    private String resolveBudgetTagCode(String budgetLevel)
    {
        if ("3".equals(budgetLevel))
        {
            return "price_high";
        }
        if ("2".equals(budgetLevel))
        {
            return "price_mid";
        }
        return "price_low";
    }

    private void addTagScore(ScoredPlant scoredPlant, Map<String, ZxPlantTagRel> tagMap, String tagCode, BigDecimal baseScore, String key, String reasonText)
    {
        if (tagCode == null || tagCode.isEmpty())
        {
            return;
        }
        ZxPlantTagRel tagRel = tagMap.get(tagCode);
        if (tagRel == null)
        {
            return;
        }
        BigDecimal score = defaultScore(baseScore).add(defaultScore(tagRel.getScoreWeight()).multiply(TAG_WEIGHT_FACTOR));
        addScore(scoredPlant, key, score, reasonText);
    }

    private void addScore(ScoredPlant scoredPlant, String key, BigDecimal score, String reasonText)
    {
        BigDecimal currentScore = scoredPlant.scoreDetail.containsKey(key) ? scoredPlant.scoreDetail.get(key) : ZERO;
        scoredPlant.scoreDetail.put(key, currentScore.add(score));
        scoredPlant.scoreTotal = scoredPlant.scoreTotal.add(score);
        if (reasonText != null && !reasonText.isEmpty())
        {
            scoredPlant.reasonParts.add(reasonText);
        }
    }

    private BigDecimal defaultScore(BigDecimal score)
    {
        return score == null ? ZERO : score;
    }

    private String buildRequestJson(Long questionnaireId, Long profileId, String visitorUid)
    {
        return "{\"questionnaireId\":" + valueOf(questionnaireId) + ",\"profileId\":" + valueOf(profileId) + ",\"visitorUid\":\"" + safe(visitorUid) + "\"}";
    }

    private String buildResultJson(List<ScoredPlant> rankedPlants, int resultCount)
    {
        StringBuilder builder = new StringBuilder("[");
        for (int i = 0; i < resultCount; i++)
        {
            if (i > 0)
            {
                builder.append(',');
            }
            builder.append("{\"plantId\":").append(rankedPlants.get(i).plant.getPlantId())
                .append(",\"score\":").append(formatScore(rankedPlants.get(i).scoreTotal)).append('}');
        }
        builder.append(']');
        return builder.toString();
    }

    private String buildMatchRuleJson(RecommendContext context, List<ZxRecommendRule> triggeredRules)
    {
        StringBuilder builder = new StringBuilder("{\"context\":{");
        builder.append("\"scene\":\"").append(safe(context.scene)).append("\",")
            .append("\"light\":\"").append(safe(context.light)).append("\",")
            .append("\"space\":\"").append(safe(context.space)).append("\",")
            .append("\"pet\":\"").append(context.petFamily ? "true" : "false").append("\",")
            .append("\"care\":\"").append(safe(context.care)).append("\",")
            .append("\"style\":\"").append(safe(context.style)).append("\",")
            .append("\"goal\":\"").append(safe(context.goal)).append("\",")
            .append("\"budget\":").append(formatScore(context.budgetValue))
            .append("},\"rules\":[");
        for (int i = 0; i < triggeredRules.size(); i++)
        {
            if (i > 0)
            {
                builder.append(',');
            }
            ZxRecommendRule rule = triggeredRules.get(i);
            builder.append("{\"code\":\"").append(safe(rule.getRuleCode())).append("\",")
                .append("\"desc\":\"").append(safe(rule.getRuleDesc())).append("\"}");
        }
        builder.append("]}");
        return builder.toString();
    }

    private String buildScoreDetailJson(Map<String, BigDecimal> scoreDetail)
    {
        StringBuilder builder = new StringBuilder("{");
        int index = 0;
        for (Map.Entry<String, BigDecimal> entry : scoreDetail.entrySet())
        {
            if (index > 0)
            {
                builder.append(',');
            }
            builder.append("\"").append(safe(entry.getKey())).append("\":").append(formatScore(entry.getValue()));
            index++;
        }
        builder.append('}');
        return builder.toString();
    }

    private String buildReasonText(ScoredPlant scoredPlant)
    {
        if (scoredPlant.reasonParts.isEmpty())
        {
            return "基于当前画像生成的推荐结果";
        }
        StringBuilder builder = new StringBuilder();
        int index = 0;
        for (String reason : scoredPlant.reasonParts)
        {
            if (index >= 3)
            {
                break;
            }
            if (builder.length() > 0)
            {
                builder.append('，');
            }
            builder.append(reason);
            index++;
        }
        return builder.toString();
    }

    private String formatScore(BigDecimal score)
    {
        return defaultScore(score).setScale(1, RoundingMode.HALF_UP).stripTrailingZeros().toPlainString();
    }

    private String valueOf(Long value)
    {
        return value == null ? "null" : String.valueOf(value);
    }

    private String safe(String value)
    {
        return value == null ? "" : value.replace("\"", "'");
    }

    private static class RecommendContext
    {
        private String scene;
        private String light;
        private String space;
        private boolean petFamily;
        private String care;
        private String style;
        private String goal;
        private BigDecimal budgetValue = ZERO;
        private String budgetLevel;
        private String lightTagCode;
        private String waterTagCode;
        private String spaceTagCode;
        private String styleTagCode;
    }

    private static class ScoredPlant
    {
        private final ZxPlant plant;
        private BigDecimal scoreTotal = ZERO;
        private final Map<String, BigDecimal> scoreDetail = new LinkedHashMap<String, BigDecimal>();
        private final LinkedHashSet<String> reasonParts = new LinkedHashSet<String>();
        private boolean excluded;

        private ScoredPlant(ZxPlant plant)
        {
            this.plant = plant;
        }
    }
}