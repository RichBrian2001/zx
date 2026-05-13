package com.ruoyi.system.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.ZxPlantDetail;
import com.ruoyi.system.mapper.ZxPlantDetailMapper;
import com.ruoyi.system.service.IZxPlantDetailService;

@Service
public class ZxPlantDetailServiceImpl implements IZxPlantDetailService
{
    @Autowired
    private ZxPlantDetailMapper detailMapper;

    @Override
    public ZxPlantDetail selectZxPlantDetailByPlantId(Long plantId)
    {
        return detailMapper.selectZxPlantDetailByPlantId(plantId);
    }

    @Override
    public int saveZxPlantDetail(ZxPlantDetail detail)
    {
        if (StringUtils.isNull(detail.getDetailId()))
        {
            return detailMapper.insertZxPlantDetail(detail);
        }
        return detailMapper.updateZxPlantDetail(detail);
    }
}