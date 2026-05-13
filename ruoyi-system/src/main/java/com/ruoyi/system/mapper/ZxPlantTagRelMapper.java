package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.ZxPlantTagRel;

public interface ZxPlantTagRelMapper
{
    public List<ZxPlantTagRel> selectSelectedTagListByPlantId(Long plantId);

    public List<ZxPlantTagRel> selectAvailableTagList();

    public int deleteZxPlantTagRelByPlantId(Long plantId);

    public int batchInsertZxPlantTagRel(List<ZxPlantTagRel> list);
}