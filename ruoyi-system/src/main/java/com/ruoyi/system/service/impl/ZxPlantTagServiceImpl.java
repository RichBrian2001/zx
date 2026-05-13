package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.ZxPlantTag;
import com.ruoyi.system.mapper.ZxPlantTagMapper;
import com.ruoyi.system.service.IZxPlantTagService;

@Service
public class ZxPlantTagServiceImpl implements IZxPlantTagService
{
    @Autowired
    private ZxPlantTagMapper tagMapper;

    @Override
    public ZxPlantTag selectZxPlantTagById(Long tagId)
    {
        return tagMapper.selectZxPlantTagById(tagId);
    }

    @Override
    public List<ZxPlantTag> selectZxPlantTagList(ZxPlantTag tag)
    {
        return tagMapper.selectZxPlantTagList(tag);
    }

    @Override
    public boolean checkTagCodeUnique(ZxPlantTag tag)
    {
        Long tagId = StringUtils.isNull(tag.getTagId()) ? -1L : tag.getTagId();
        ZxPlantTag info = tagMapper.checkTagCodeUnique(tag.getTagCode());
        if (StringUtils.isNotNull(info) && info.getTagId().longValue() != tagId.longValue())
        {
            return false;
        }
        return true;
    }

    @Override
    public int insertZxPlantTag(ZxPlantTag tag)
    {
        return tagMapper.insertZxPlantTag(tag);
    }

    @Override
    public int updateZxPlantTag(ZxPlantTag tag)
    {
        return tagMapper.updateZxPlantTag(tag);
    }

    @Override
    public int deleteZxPlantTagByIds(Long[] tagIds)
    {
        return tagMapper.deleteZxPlantTagByIds(tagIds);
    }
}