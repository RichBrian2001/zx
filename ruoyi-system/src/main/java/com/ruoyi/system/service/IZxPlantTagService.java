package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.ZxPlantTag;

public interface IZxPlantTagService
{
    public ZxPlantTag selectZxPlantTagById(Long tagId);

    public List<ZxPlantTag> selectZxPlantTagList(ZxPlantTag tag);

    public boolean checkTagCodeUnique(ZxPlantTag tag);

    public int insertZxPlantTag(ZxPlantTag tag);

    public int updateZxPlantTag(ZxPlantTag tag);

    public int deleteZxPlantTagByIds(Long[] tagIds);
}