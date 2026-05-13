package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.ZxFeedbackRecord;

public interface IZxFeedbackRecordService
{
    public List<ZxFeedbackRecord> selectZxFeedbackRecordList(ZxFeedbackRecord feedback);

    public ZxFeedbackRecord selectZxFeedbackRecordById(Long feedbackId);

    public int insertZxFeedbackRecord(ZxFeedbackRecord feedback);
}