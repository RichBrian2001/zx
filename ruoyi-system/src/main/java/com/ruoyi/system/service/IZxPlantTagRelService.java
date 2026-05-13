package com.ruoyi.system.service;

import java.util.Map;
import com.ruoyi.system.domain.ZxPlantTagRel;

public interface IZxPlantTagRelService
{
    public Map<String, Object> selectPlantTagConfig(Long plantId);

    public int savePlantTagConfig(ZxPlantTagRel request);
}