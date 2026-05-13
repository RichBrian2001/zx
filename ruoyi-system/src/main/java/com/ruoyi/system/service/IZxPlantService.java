package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.ZxPlant;

public interface IZxPlantService
{
    public ZxPlant selectZxPlantById(Long plantId);

    public List<ZxPlant> selectZxPlantList(ZxPlant plant);

    public int insertZxPlant(ZxPlant plant);

    public int updateZxPlant(ZxPlant plant);

    public int updateZxPlantDisplayStatus(ZxPlant plant);

    public int deleteZxPlantByIds(Long[] plantIds);
}