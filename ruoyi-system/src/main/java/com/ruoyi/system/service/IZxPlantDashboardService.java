package com.ruoyi.system.service;

import java.util.Map;

public interface IZxPlantDashboardService
{
    public Map<String, Object> selectOverview(String startDate, String endDate);
}