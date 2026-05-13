package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.ZxPlant;

public interface ZxPlantMapper
{
    public ZxPlant selectZxPlantById(Long plantId);

    public List<ZxPlant> selectPublishedZxPlantList();

    public List<ZxPlant> selectZxPlantList(ZxPlant plant);

    public int insertZxPlant(ZxPlant plant);

    public int updateZxPlant(ZxPlant plant);

    public int updateZxPlantDisplayStatus(ZxPlant plant);

    public int deleteZxPlantByIds(Long[] plantIds);
}