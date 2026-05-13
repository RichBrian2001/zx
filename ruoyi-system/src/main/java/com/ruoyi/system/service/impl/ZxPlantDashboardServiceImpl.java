package com.ruoyi.system.service.impl;

import java.util.ArrayList;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.ZxFavoriteRecord;
import com.ruoyi.system.domain.ZxFeedbackRecord;
import com.ruoyi.system.domain.ZxPlant;
import com.ruoyi.system.domain.ZxPlantCategory;
import com.ruoyi.system.domain.ZxRecommendRecord;
import com.ruoyi.system.mapper.ZxFavoriteRecordMapper;
import com.ruoyi.system.mapper.ZxFeedbackRecordMapper;
import com.ruoyi.system.mapper.ZxPlantMapper;
import com.ruoyi.system.mapper.ZxRecommendRecordMapper;
import com.ruoyi.system.service.IZxPlantCategoryService;
import com.ruoyi.system.service.IZxPlantDashboardService;

@Service
public class ZxPlantDashboardServiceImpl implements IZxPlantDashboardService
{
    @Autowired
    private IZxPlantCategoryService categoryService;

    @Autowired
    private ZxPlantMapper plantMapper;

    @Autowired
    private ZxRecommendRecordMapper recommendRecordMapper;

    @Autowired
    private ZxFeedbackRecordMapper feedbackRecordMapper;

    @Autowired
    private ZxFavoriteRecordMapper favoriteRecordMapper;

    @Override
    public Map<String, Object> selectOverview(String startDate, String endDate)
    {
        ZxPlant plantQuery = new ZxPlant();
        ZxRecommendRecord recordQuery = new ZxRecommendRecord();
        ZxFeedbackRecord feedbackQuery = new ZxFeedbackRecord();
        ZxFavoriteRecord favoriteQuery = new ZxFavoriteRecord();
        if (startDate != null && !startDate.isEmpty())
        {
            recordQuery.getParams().put("beginTime", startDate);
            feedbackQuery.getParams().put("beginTime", startDate);
        }
        if (endDate != null && !endDate.isEmpty())
        {
            recordQuery.getParams().put("endTime", endDate);
            feedbackQuery.getParams().put("endTime", endDate);
        }
        List<ZxPlant> plantList = plantMapper.selectZxPlantList(plantQuery);
        List<ZxPlantCategory> categoryList = categoryService.selectZxPlantCategoryList(new ZxPlantCategory());
        List<ZxRecommendRecord> recommendList = recommendRecordMapper.selectZxRecommendRecordList(recordQuery);
        List<ZxFeedbackRecord> feedbackList = feedbackRecordMapper.selectZxFeedbackRecordList(feedbackQuery);
        List<ZxFavoriteRecord> favoriteList = favoriteRecordMapper.selectZxFavoriteRecordList(favoriteQuery);

        Map<Long, ZxPlant> plantMap = buildPlantMap(plantList);
        Map<Long, Integer> recommendCountMap = buildRecommendCountMap(recommendList);
        Map<Long, Integer> likeCountMap = buildFeedbackCountMap(feedbackList, "1");
        Map<Long, Integer> favoriteCountMap = buildFavoriteCountMap(favoriteList);

        Map<String, Object> overview = new HashMap<String, Object>();
        overview.put("statCard", buildStatCard(plantList, categoryList.size(), recommendList, feedbackList));
        overview.put("hotPlantList", buildHotPlantList(plantMap, recommendCountMap, likeCountMap, favoriteCountMap));
        overview.put("recentRecommendList", buildRecentRecommendList(recommendList, plantMap));
        return overview;
    }

    private Map<Long, ZxPlant> buildPlantMap(List<ZxPlant> plantList)
    {
        Map<Long, ZxPlant> plantMap = new HashMap<Long, ZxPlant>();
        for (ZxPlant plant : plantList)
        {
            if (plant.getPlantId() != null)
            {
                plantMap.put(plant.getPlantId(), plant);
            }
        }
        return plantMap;
    }

    private Map<Long, Integer> buildRecommendCountMap(List<ZxRecommendRecord> recommendList)
    {
        Map<Long, Integer> recommendCountMap = new HashMap<Long, Integer>();
        for (ZxRecommendRecord record : recommendList)
        {
            if (record.getTopPlantId() == null)
            {
                continue;
            }
            Integer count = recommendCountMap.get(record.getTopPlantId());
            recommendCountMap.put(record.getTopPlantId(), count == null ? 1 : count + 1);
        }
        return recommendCountMap;
    }

    private Map<Long, Integer> buildFeedbackCountMap(List<ZxFeedbackRecord> feedbackList, String feedbackType)
    {
        Map<Long, Integer> feedbackCountMap = new HashMap<Long, Integer>();
        for (ZxFeedbackRecord feedback : feedbackList)
        {
            if (feedback.getPlantId() == null || !feedbackType.equals(feedback.getFeedbackType()))
            {
                continue;
            }
            Integer count = feedbackCountMap.get(feedback.getPlantId());
            feedbackCountMap.put(feedback.getPlantId(), count == null ? 1 : count + 1);
        }
        return feedbackCountMap;
    }

    private Map<Long, Integer> buildFavoriteCountMap(List<ZxFavoriteRecord> favoriteList)
    {
        Map<Long, Integer> favoriteCountMap = new HashMap<Long, Integer>();
        for (ZxFavoriteRecord favorite : favoriteList)
        {
            if (favorite.getPlantId() == null)
            {
                continue;
            }
            Integer count = favoriteCountMap.get(favorite.getPlantId());
            favoriteCountMap.put(favorite.getPlantId(), count == null ? 1 : count + 1);
        }
        return favoriteCountMap;
    }

    private Map<String, Object> buildStatCard(List<ZxPlant> plantList,
                                              int categoryTotal,
                                              List<ZxRecommendRecord> recommendList,
                                              List<ZxFeedbackRecord> feedbackList)
    {
        int onlinePlantTotal = 0;
        for (ZxPlant plant : plantList)
        {
            if ("0".equals(plant.getDisplayStatus()))
            {
                onlinePlantTotal++;
            }
        }

        int todayRecommendTotal = 0;
        LocalDate today = LocalDate.now();
        for (ZxRecommendRecord record : recommendList)
        {
            if (record.getRecommendTime() != null && toLocalDate(record.getRecommendTime()).equals(today))
            {
                todayRecommendTotal++;
            }
        }

        int likeFeedbackTotal = 0;
        int dislikeFeedbackTotal = 0;
        for (ZxFeedbackRecord feedback : feedbackList)
        {
            if ("1".equals(feedback.getFeedbackType()))
            {
                likeFeedbackTotal++;
            }
            else if ("2".equals(feedback.getFeedbackType()))
            {
                dislikeFeedbackTotal++;
            }
        }

        Map<String, Object> statCard = new HashMap<String, Object>();
        statCard.put("plantTotal", plantList.size());
        statCard.put("onlinePlantTotal", onlinePlantTotal);
        statCard.put("categoryTotal", categoryTotal);
        statCard.put("recommendTotal", recommendList.size());
        statCard.put("todayRecommendTotal", todayRecommendTotal);
        statCard.put("feedbackTotal", feedbackList.size());
        statCard.put("likeFeedbackTotal", likeFeedbackTotal);
        statCard.put("dislikeFeedbackTotal", dislikeFeedbackTotal);
        return statCard;
    }

    private List<Map<String, Object>> buildHotPlantList(Map<Long, ZxPlant> plantMap,
                                                        Map<Long, Integer> recommendCountMap,
                                                        Map<Long, Integer> likeCountMap,
                                                        Map<Long, Integer> favoriteCountMap)
    {
        List<Map<String, Object>> hotPlantList = new ArrayList<Map<String, Object>>();
        for (Map.Entry<Long, Integer> entry : recommendCountMap.entrySet())
        {
            Long plantId = entry.getKey();
            ZxPlant plant = plantMap.get(plantId);
            Map<String, Object> item = new HashMap<String, Object>();
            item.put("plantId", plantId);
            item.put("plantName", plant != null ? plant.getPlantName() : null);
            item.put("coverImage", plant != null ? plant.getCoverImage() : null);
            item.put("recommendCount", entry.getValue());
            item.put("likeCount", likeCountMap.containsKey(plantId) ? likeCountMap.get(plantId) : 0);
            item.put("favoriteCount", favoriteCountMap.containsKey(plantId) ? favoriteCountMap.get(plantId) : 0);
            hotPlantList.add(item);
        }
        hotPlantList.sort((left, right) -> {
            int recommendCompare = Integer.compare((Integer) right.get("recommendCount"), (Integer) left.get("recommendCount"));
            if (recommendCompare != 0)
            {
                return recommendCompare;
            }
            int likeCompare = Integer.compare((Integer) right.get("likeCount"), (Integer) left.get("likeCount"));
            if (likeCompare != 0)
            {
                return likeCompare;
            }
            int favoriteCompare = Integer.compare((Integer) right.get("favoriteCount"), (Integer) left.get("favoriteCount"));
            if (favoriteCompare != 0)
            {
                return favoriteCompare;
            }
            return Long.compare((Long) left.get("plantId"), (Long) right.get("plantId"));
        });
        if (hotPlantList.size() > 10)
        {
            return new ArrayList<Map<String, Object>>(hotPlantList.subList(0, 10));
        }
        return hotPlantList;
    }

    private List<Map<String, Object>> buildRecentRecommendList(List<ZxRecommendRecord> recommendList, Map<Long, ZxPlant> plantMap)
    {
        List<Map<String, Object>> recentRecommendList = new ArrayList<Map<String, Object>>();
        for (int i = 0; i < recommendList.size() && i < 10; i++)
        {
            ZxRecommendRecord record = recommendList.get(i);
            ZxPlant plant = record.getTopPlantId() == null ? null : plantMap.get(record.getTopPlantId());
            Map<String, Object> item = new HashMap<String, Object>();
            item.put("recordId", record.getRecordId());
            item.put("visitorUid", record.getVisitorUid());
            item.put("topPlantId", record.getTopPlantId());
            item.put("topPlantName", plant != null ? plant.getPlantName() : record.getTopPlantName());
            item.put("resultCount", record.getResultCount());
            item.put("recommendTime", record.getRecommendTime());
            recentRecommendList.add(item);
        }
        return recentRecommendList;
    }

    private LocalDate toLocalDate(java.util.Date date)
    {
        return date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
    }
}