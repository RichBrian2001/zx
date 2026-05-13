package com.ruoyi.system.service;

import java.util.List;
import java.util.Map;

public interface IZxPlantAppAssistantService
{
    public Map<String, Object> getEnvironmentSnapshot(String visitorUid);

    public Map<String, Object> chat(String visitorUid, String question, List<Map<String, String>> history);
}