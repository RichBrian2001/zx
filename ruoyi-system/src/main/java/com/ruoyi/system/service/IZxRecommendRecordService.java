package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.ZxRecommendRecord;

public interface IZxRecommendRecordService
{
    public List<ZxRecommendRecord> selectZxRecommendRecordList(ZxRecommendRecord record);

    public ZxRecommendRecord selectZxRecommendRecordById(Long recordId);
}