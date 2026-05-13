package com.ruoyi.system.service;

import java.util.Map;
import com.ruoyi.system.domain.ZxQuestionnaireRecord;

public interface IZxPlantQuestionnaireService
{
    public Map<String, Object> submitQuestionnaire(ZxQuestionnaireRecord questionnaireRecord);

    public Map<String, Object> buildProfile(Long questionnaireId, String visitorUid);
}