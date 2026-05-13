package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.ZxRecommendItem;
import com.ruoyi.system.domain.ZxRecommendRecord;

public interface ZxRecommendRecordMapper
{
    public List<ZxRecommendRecord> selectZxRecommendRecordList(ZxRecommendRecord record);

    public ZxRecommendRecord selectZxRecommendRecordById(Long recordId);

    public List<ZxRecommendItem> selectZxRecommendItemListByRecordId(Long recordId);

    public int insertZxRecommendRecord(ZxRecommendRecord record);

    public int batchInsertZxRecommendItem(List<ZxRecommendItem> list);
}