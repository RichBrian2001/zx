package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.ZxQuestionnaireRecord;

public interface ZxQuestionnaireRecordMapper
{
    public int insertZxQuestionnaireRecord(ZxQuestionnaireRecord questionnaireRecord);

    public ZxQuestionnaireRecord selectZxQuestionnaireRecordById(Long questionnaireId);
}