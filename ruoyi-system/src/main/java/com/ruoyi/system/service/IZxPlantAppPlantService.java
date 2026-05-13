package com.ruoyi.system.service;

import java.util.List;
import java.util.Map;
import com.ruoyi.system.domain.ZxPlant;

public interface IZxPlantAppPlantService
{
    public List<ZxPlant> selectPublishedPlantList();

    public Map<String, Object> selectPlantDetail(Long plantId);
}