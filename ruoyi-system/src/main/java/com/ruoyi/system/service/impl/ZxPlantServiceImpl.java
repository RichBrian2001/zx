package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.ZxPlant;
import com.ruoyi.system.mapper.ZxPlantMapper;
import com.ruoyi.system.service.IZxPlantService;

@Service
public class ZxPlantServiceImpl implements IZxPlantService
{
    @Autowired
    private ZxPlantMapper plantMapper;

    @Override
    public ZxPlant selectZxPlantById(Long plantId)
    {
        return plantMapper.selectZxPlantById(plantId);
    }

    @Override
    public List<ZxPlant> selectZxPlantList(ZxPlant plant)
    {
        return plantMapper.selectZxPlantList(plant);
    }

    @Override
    public int insertZxPlant(ZxPlant plant)
    {
        return plantMapper.insertZxPlant(plant);
    }

    @Override
    public int updateZxPlant(ZxPlant plant)
    {
        return plantMapper.updateZxPlant(plant);
    }

    @Override
    public int updateZxPlantDisplayStatus(ZxPlant plant)
    {
        return plantMapper.updateZxPlantDisplayStatus(plant);
    }

    @Override
    public int deleteZxPlantByIds(Long[] plantIds)
    {
        return plantMapper.deleteZxPlantByIds(plantIds);
    }
}