package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.ZxFeedbackRecord;
import com.ruoyi.system.mapper.ZxFeedbackRecordMapper;
import com.ruoyi.system.service.IZxFeedbackRecordService;

@Service
public class ZxFeedbackRecordServiceImpl implements IZxFeedbackRecordService
{
    @Autowired
    private ZxFeedbackRecordMapper feedbackMapper;

    @Override
    public List<ZxFeedbackRecord> selectZxFeedbackRecordList(ZxFeedbackRecord feedback)
    {
        return feedbackMapper.selectZxFeedbackRecordList(feedback);
    }

    @Override
    public ZxFeedbackRecord selectZxFeedbackRecordById(Long feedbackId)
    {
        return feedbackMapper.selectZxFeedbackRecordById(feedbackId);
    }

    @Override
    public int insertZxFeedbackRecord(ZxFeedbackRecord feedback)
    {
        return feedbackMapper.insertZxFeedbackRecord(feedback);
    }
}