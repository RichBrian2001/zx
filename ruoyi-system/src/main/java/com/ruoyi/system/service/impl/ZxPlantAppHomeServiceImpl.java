package com.ruoyi.system.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.ZxContentArticle;
import com.ruoyi.system.domain.ZxPlant;
import com.ruoyi.system.domain.ZxRecommendRecord;
import com.ruoyi.system.mapper.ZxContentArticleMapper;
import com.ruoyi.system.mapper.ZxPlantMapper;
import com.ruoyi.system.mapper.ZxRecommendRecordMapper;
import com.ruoyi.system.service.IZxPlantAppHomeService;

@Service
public class ZxPlantAppHomeServiceImpl implements IZxPlantAppHomeService
{
    @Autowired
    private ZxPlantMapper plantMapper;

    @Autowired
    private ZxContentArticleMapper articleMapper;

    @Autowired
    private ZxRecommendRecordMapper recommendRecordMapper;

    @Override
    public Map<String, Object> getHomeSummary()
    {
        ZxPlant plantQuery = new ZxPlant();
        plantQuery.setDisplayStatus("0");
        plantQuery.setStatus("0");
        List<ZxPlant> plantList = plantMapper.selectZxPlantList(plantQuery);

        ZxContentArticle articleQuery = new ZxContentArticle();
        articleQuery.setStatus("0");
        List<ZxContentArticle> articleList = articleMapper.selectZxContentArticleList(articleQuery);

        List<ZxRecommendRecord> recommendList = recommendRecordMapper.selectZxRecommendRecordList(new ZxRecommendRecord());

        Map<String, Object> result = new HashMap<String, Object>();
        result.put("featuredPlantList", sliceList(plantList, 6));
        result.put("latestArticleList", sliceList(articleList, 5));
        result.put("plantTotal", plantList.size());
        result.put("recommendTotal", recommendList.size());
        return result;
    }

    private <T> List<T> sliceList(List<T> source, int size)
    {
        List<T> result = new ArrayList<T>();
        for (int i = 0; i < source.size() && i < size; i++)
        {
            result.add(source.get(i));
        }
        return result;
    }
}