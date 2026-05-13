package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.ZxPlantDetail;

public interface ZxPlantDetailMapper
{
    public ZxPlantDetail selectZxPlantDetailByPlantId(Long plantId);

    public int insertZxPlantDetail(ZxPlantDetail detail);

    public int updateZxPlantDetail(ZxPlantDetail detail);
}