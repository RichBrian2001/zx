package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.ZxRecommendRecord;
import com.ruoyi.system.mapper.ZxRecommendRecordMapper;
import com.ruoyi.system.service.IZxRecommendRecordService;

@Service
public class ZxRecommendRecordServiceImpl implements IZxRecommendRecordService
{
    @Autowired
    private ZxRecommendRecordMapper recordMapper;

    @Override
    public List<ZxRecommendRecord> selectZxRecommendRecordList(ZxRecommendRecord record)
    {
        return recordMapper.selectZxRecommendRecordList(record);
    }

    @Override
    public ZxRecommendRecord selectZxRecommendRecordById(Long recordId)
    {
        ZxRecommendRecord record = recordMapper.selectZxRecommendRecordById(recordId);
        if (record != null)
        {
            record.setItemList(recordMapper.selectZxRecommendItemListByRecordId(recordId));
        }
        return record;
    }
}