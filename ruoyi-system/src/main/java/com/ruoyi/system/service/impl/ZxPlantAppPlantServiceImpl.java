package com.ruoyi.system.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.ZxContentArticle;
import com.ruoyi.system.domain.ZxPlant;
import com.ruoyi.system.domain.ZxPlantDetail;
import com.ruoyi.system.domain.ZxPlantTagRel;
import com.ruoyi.system.mapper.ZxContentArticleMapper;
import com.ruoyi.system.mapper.ZxPlantDetailMapper;
import com.ruoyi.system.mapper.ZxPlantMapper;
import com.ruoyi.system.mapper.ZxPlantTagRelMapper;
import com.ruoyi.system.service.IZxPlantAppPlantService;

@Service
public class ZxPlantAppPlantServiceImpl implements IZxPlantAppPlantService
{
    @Autowired
    private ZxPlantMapper plantMapper;

    @Autowired
    private ZxPlantDetailMapper plantDetailMapper;

    @Autowired
    private ZxPlantTagRelMapper plantTagRelMapper;

    @Autowired
    private ZxContentArticleMapper articleMapper;

    @Override
    public List<ZxPlant> selectPublishedPlantList()
    {
        return plantMapper.selectPublishedZxPlantList();
    }

    @Override
    public Map<String, Object> selectPlantDetail(Long plantId)
    {
        ZxPlant plant = plantMapper.selectZxPlantById(plantId);
        ZxPlantDetail detail = plantDetailMapper.selectZxPlantDetailByPlantId(plantId);
        List<ZxPlantTagRel> tagList = plantTagRelMapper.selectSelectedTagListByPlantId(plantId);
        ZxContentArticle articleQuery = new ZxContentArticle();
        articleQuery.setRelatedPlantId(plantId);
        articleQuery.setStatus("0");
        List<ZxContentArticle> articleList = articleMapper.selectZxContentArticleList(articleQuery);

        Map<String, Object> result = new HashMap<String, Object>();
        if (plant != null)
        {
            result.put("plantId", plant.getPlantId());
            result.put("plantName", plant.getPlantName());
            result.put("aliasName", plant.getAliasName());
            result.put("coverImage", plant.getCoverImage());
            result.put("plantSummary", plant.getPlantSummary());
            result.put("difficultyLevel", plant.getDifficultyLevel());
            result.put("priceLevel", plant.getPriceLevel());
            result.put("petSafeFlag", plant.getPetSafeFlag());
            result.put("purgeEffectFlag", plant.getPurgeEffectFlag());
            result.put("aromaFlag", plant.getAromaFlag());
            result.put("suitableScene", plant.getSuitableScene());
        }
        if (detail != null)
        {
            result.put("lightRequirement", detail.getLightRequirement());
            result.put("waterRequirement", detail.getWaterRequirement());
            result.put("temperatureRange", detail.getTemperatureRange());
            result.put("humidityRequirement", detail.getHumidityRequirement());
            result.put("growCycle", detail.getGrowCycle());
            result.put("careTips", detail.getCareTips());
            result.put("riskTips", detail.getRiskTips());
            result.put("displayContent", detail.getDisplayContent());
        }
        result.put("tagList", tagList);
        result.put("articleList", articleList);
        return result;
    }
}