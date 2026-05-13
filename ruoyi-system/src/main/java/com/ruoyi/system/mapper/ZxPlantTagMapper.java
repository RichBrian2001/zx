package com.ruoyi.system.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.system.domain.ZxPlantTag;

public interface ZxPlantTagMapper
{
    public ZxPlantTag selectZxPlantTagById(Long tagId);

    public List<ZxPlantTag> selectZxPlantTagList(ZxPlantTag tag);

    public ZxPlantTag checkTagCodeUnique(@Param("tagCode") String tagCode);

    public int insertZxPlantTag(ZxPlantTag tag);

    public int updateZxPlantTag(ZxPlantTag tag);

    public int deleteZxPlantTagByIds(Long[] tagIds);
}