package com.ruoyi.system.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.system.domain.ZxPlant;
import com.ruoyi.system.domain.ZxPlantTagRel;
import com.ruoyi.system.mapper.ZxPlantMapper;
import com.ruoyi.system.mapper.ZxPlantTagRelMapper;
import com.ruoyi.system.service.IZxPlantTagRelService;

@Service
public class ZxPlantTagRelServiceImpl implements IZxPlantTagRelService
{
    @Autowired
    private ZxPlantTagRelMapper tagRelMapper;

    @Autowired
    private ZxPlantMapper plantMapper;

    @Override
    public Map<String, Object> selectPlantTagConfig(Long plantId)
    {
        Map<String, Object> result = new HashMap<String, Object>();
        ZxPlant plant = plantMapper.selectZxPlantById(plantId);
        result.put("plantInfo", plant);
        result.put("availableTags", tagRelMapper.selectAvailableTagList());
        result.put("selectedTags", tagRelMapper.selectSelectedTagListByPlantId(plantId));
        return result;
    }

    @Override
    @Transactional
    public int savePlantTagConfig(ZxPlantTagRel request)
    {
        tagRelMapper.deleteZxPlantTagRelByPlantId(request.getPlantId());
        List<ZxPlantTagRel> tagItems = request.getTagItems();
        if (tagItems == null || tagItems.isEmpty())
        {
            return 1;
        }
        for (ZxPlantTagRel item : tagItems)
        {
            item.setPlantId(request.getPlantId());
            item.setCreateBy(request.getUpdateBy());
        }
        return tagRelMapper.batchInsertZxPlantTagRel(tagItems);
    }
}