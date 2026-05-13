package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.ZxFeedbackRecord;

public interface ZxFeedbackRecordMapper
{
    public List<ZxFeedbackRecord> selectZxFeedbackRecordList(ZxFeedbackRecord feedback);

    public ZxFeedbackRecord selectZxFeedbackRecordById(Long feedbackId);

    public int insertZxFeedbackRecord(ZxFeedbackRecord feedback);
}