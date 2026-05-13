package com.ruoyi.system.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.system.domain.ZxQuestionnaireRecord;
import com.ruoyi.system.domain.ZxUserProfile;
import com.ruoyi.system.mapper.ZxQuestionnaireRecordMapper;
import com.ruoyi.system.mapper.ZxUserProfileMapper;
import com.ruoyi.system.service.IZxPlantQuestionnaireService;

@Service
public class ZxPlantQuestionnaireServiceImpl implements IZxPlantQuestionnaireService
{
    @Autowired
    private ZxQuestionnaireRecordMapper questionnaireRecordMapper;

    @Autowired
    private ZxUserProfileMapper userProfileMapper;

    @Override
    @Transactional
    public Map<String, Object> submitQuestionnaire(ZxQuestionnaireRecord questionnaireRecord)
    {
        if (questionnaireRecord.getVisitorUid() == null || questionnaireRecord.getVisitorUid().isEmpty())
        {
            questionnaireRecord.setVisitorUid("visitor-" + System.currentTimeMillis());
        }
        questionnaireRecord.setAnswerJson(buildAnswerJson(questionnaireRecord));
        questionnaireRecord.setEnvironmentSummary(joinParts(resolveSceneLabel(questionnaireRecord.getScene()), questionnaireRecord.getLight(), questionnaireRecord.getSpace()));
        questionnaireRecord.setPreferenceSummary(joinParts(questionnaireRecord.getPet(), questionnaireRecord.getCare(), questionnaireRecord.getStyle(), questionnaireRecord.getGoal()));
        questionnaireRecord.setBudgetValue(parseBudget(questionnaireRecord.getBudget()));
        questionnaireRecord.setSubmitIp("");
        questionnaireRecord.setSubmitTime(new Date());
        questionnaireRecordMapper.insertZxQuestionnaireRecord(questionnaireRecord);

        Map<String, Object> result = new HashMap<String, Object>();
        result.put("questionnaireId", questionnaireRecord.getQuestionnaireId());
        result.put("visitorUid", questionnaireRecord.getVisitorUid());
        result.put("environmentSummary", questionnaireRecord.getEnvironmentSummary());
        result.put("preferenceSummary", questionnaireRecord.getPreferenceSummary());
        result.put("submitTime", questionnaireRecord.getSubmitTime());
        return result;
    }

    @Override
    @Transactional
    public Map<String, Object> buildProfile(Long questionnaireId, String visitorUid)
    {
        ZxQuestionnaireRecord questionnaireRecord = questionnaireRecordMapper.selectZxQuestionnaireRecordById(questionnaireId);
        Map<String, Object> result = new HashMap<String, Object>();
        if (questionnaireRecord == null)
        {
            return result;
        }
        String finalVisitorUid = visitorUid;
        if (finalVisitorUid == null || finalVisitorUid.isEmpty())
        {
            finalVisitorUid = questionnaireRecord.getVisitorUid();
        }
        ZxUserProfile profile = userProfileMapper.selectZxUserProfileByVisitorUid(finalVisitorUid);
        if (profile == null)
        {
            profile = new ZxUserProfile();
            profile.setVisitorUid(finalVisitorUid);
        }
        profile.setLatestQuestionnaireId(questionnaireId);
        profile.setLightTagCode(resolveLightTagCode(questionnaireRecord.getAnswerJson()));
        profile.setWaterTagCode(resolveWaterTagCode(questionnaireRecord.getAnswerJson()));
        profile.setSpaceTagCode(resolveSpaceTagCode(questionnaireRecord.getAnswerJson()));
        profile.setStyleTagCode(resolveStyleTagCode(questionnaireRecord.getAnswerJson()));
        profile.setBudgetLevel(resolveBudgetLevel(questionnaireRecord.getBudgetValue()));
        profile.setPetPreference(resolvePetPreference(questionnaireRecord.getAnswerJson()));
        profile.setCarePreference(resolveCarePreference(questionnaireRecord.getAnswerJson()));
        profile.setProfileJson(buildProfileJson(profile));
        profile.setLastRecommendTime(null);
        if (profile.getProfileId() == null)
        {
            userProfileMapper.insertZxUserProfile(profile);
        }
        else
        {
            userProfileMapper.updateZxUserProfile(profile);
        }
        result.put("profileId", profile.getProfileId());
        result.put("lightTagCode", profile.getLightTagCode());
        result.put("waterTagCode", profile.getWaterTagCode());
        result.put("spaceTagCode", profile.getSpaceTagCode());
        result.put("styleTagCode", profile.getStyleTagCode());
        result.put("budgetLevel", profile.getBudgetLevel());
        result.put("petPreference", profile.getPetPreference());
        result.put("carePreference", profile.getCarePreference());
        return result;
    }

    private String buildAnswerJson(ZxQuestionnaireRecord questionnaireRecord)
    {
        return "{"
            + "\"scene\":\"" + safe(questionnaireRecord.getScene()) + "\"," 
            + "\"light\":\"" + safe(questionnaireRecord.getLight()) + "\"," 
            + "\"space\":\"" + safe(questionnaireRecord.getSpace()) + "\"," 
            + "\"pet\":\"" + safe(questionnaireRecord.getPet()) + "\"," 
            + "\"budget\":\"" + safe(questionnaireRecord.getBudget()) + "\"," 
            + "\"care\":\"" + safe(questionnaireRecord.getCare()) + "\"," 
            + "\"style\":\"" + safe(questionnaireRecord.getStyle()) + "\"," 
            + "\"goal\":\"" + safe(questionnaireRecord.getGoal()) + "\"}"
            .replace("\", ", "\",");
    }

    private String joinParts(String... values)
    {
        StringBuilder builder = new StringBuilder();
        for (String value : values)
        {
            if (value == null || value.isEmpty())
            {
                continue;
            }
            if (builder.length() > 0)
            {
                builder.append(" / ");
            }
            builder.append(value);
        }
        return builder.toString();
    }

    private BigDecimal parseBudget(String budget)
    {
        if (budget == null || budget.isEmpty())
        {
            return BigDecimal.ZERO;
        }
        if (budget.contains("300"))
        {
            return new BigDecimal("300");
        }
        if (budget.contains("200"))
        {
            return new BigDecimal("200");
        }
        if (budget.contains("100"))
        {
            return new BigDecimal("100");
        }
        return new BigDecimal("150");
    }

    private String resolveLightTagCode(String answerJson)
    {
        String light = extract(answerJson, "light");
        String normalizedLight = light.toLowerCase();
        if (light.contains("直射") || light.contains("强") || normalizedLight.contains("high"))
        {
            return "light_high";
        }
        if (light.contains("半阴") || light.contains("弱光") || normalizedLight.contains("low") || normalizedLight.contains("shade"))
        {
            return "light_low";
        }
        return "light_medium";
    }

    private String resolveWaterTagCode(String answerJson)
    {
        String care = extract(answerJson, "care");
        if (care.contains("低"))
        {
            return "water_low";
        }
        if (care.contains("高"))
        {
            return "water_high";
        }
        return "water_medium";
    }

    private String resolveSpaceTagCode(String answerJson)
    {
        String space = extract(answerJson, "space");
        String normalizedSpace = space.toLowerCase();
        if (space.contains("小") || normalizedSpace.contains("small") || normalizedSpace.contains("desktop"))
        {
            return "space_small";
        }
        if (space.contains("大") || normalizedSpace.contains("large") || normalizedSpace.contains("balcony"))
        {
            return "space_large";
        }
        return "space_medium";
    }

    private String resolveStyleTagCode(String answerJson)
    {
        String style = extract(answerJson, "style");
        String normalizedStyle = style.toLowerCase();
        if (style.contains("治愈") || normalizedStyle.contains("healing"))
        {
            return "style_healing";
        }
        if (style.contains("热带") || normalizedStyle.contains("tropical"))
        {
            return "style_tropical";
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

    private String resolvePetPreference(String answerJson)
    {
        String pet = extract(answerJson, "pet");
        return (pet.contains("是") || pet.contains("有") || pet.equalsIgnoreCase("yes") || pet.equals("1")) ? "1" : "0";
    }

    private String resolveCarePreference(String answerJson)
    {
        String care = extract(answerJson, "care");
        String normalizedCare = care.toLowerCase();
        if (care.contains("高") || normalizedCare.contains("hard") || normalizedCare.contains("high"))
        {
            return "3";
        }
        if (care.contains("中") || normalizedCare.contains("medium"))
        {
            return "2";
        }
        return "1";
    }

    private String resolveSceneLabel(String scene)
    {
        if (scene == null || scene.isEmpty())
        {
            return "";
        }
        if ("desk".equalsIgnoreCase(scene))
        {
            return "桌面";
        }
        if ("bedroom".equalsIgnoreCase(scene))
        {
            return "卧室";
        }
        if ("living".equalsIgnoreCase(scene))
        {
            return "客厅";
        }
        if ("office".equalsIgnoreCase(scene))
        {
            return "办公室";
        }
        if ("balcony".equalsIgnoreCase(scene))
        {
            return "阳台";
        }
        return scene;
    }

    private String buildProfileJson(ZxUserProfile profile)
    {
        return "{"
            + "\"lightTagCode\":\"" + safe(profile.getLightTagCode()) + "\","
            + "\"waterTagCode\":\"" + safe(profile.getWaterTagCode()) + "\","
            + "\"spaceTagCode\":\"" + safe(profile.getSpaceTagCode()) + "\","
            + "\"styleTagCode\":\"" + safe(profile.getStyleTagCode()) + "\","
            + "\"budgetLevel\":\"" + safe(profile.getBudgetLevel()) + "\","
            + "\"petPreference\":\"" + safe(profile.getPetPreference()) + "\","
            + "\"carePreference\":\"" + safe(profile.getCarePreference()) + "\"}"
            .replace("\", ", "\",");
    }

    private String extract(String json, String key)
    {
        if (json == null || json.isEmpty())
        {
            return "";
        }
        String prefix = "\"" + key + "\":\"";
        int start = json.indexOf(prefix);
        if (start < 0)
        {
            return "";
        }
        start = start + prefix.length();
        int end = json.indexOf("\"", start);
        if (end < 0)
        {
            return "";
        }
        return json.substring(start, end);
    }

    private String safe(String value)
    {
        return value == null ? "" : value.replace("\"", "'");
    }
}