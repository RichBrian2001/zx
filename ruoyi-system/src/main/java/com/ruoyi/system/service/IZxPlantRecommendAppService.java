package com.ruoyi.system.service;

import java.util.List;
import java.util.Map;

public interface IZxPlantRecommendAppService
{
    public Map<String, Object> executeRecommend(Long questionnaireId, Long profileId, String visitorUid);

    public Map<String, Object> selectRecommendResult(Long recordId);

    public List<Map<String, Object>> selectHistoryList(String visitorUid);
}