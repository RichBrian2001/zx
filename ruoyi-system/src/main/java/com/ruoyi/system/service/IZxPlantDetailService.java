package com.ruoyi.system.service;

import com.ruoyi.system.domain.ZxPlantDetail;

public interface IZxPlantDetailService
{
    public ZxPlantDetail selectZxPlantDetailByPlantId(Long plantId);

    public int saveZxPlantDetail(ZxPlantDetail detail);
}