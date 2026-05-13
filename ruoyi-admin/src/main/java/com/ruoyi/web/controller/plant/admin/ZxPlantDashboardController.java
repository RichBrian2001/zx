package com.ruoyi.web.controller.plant.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.system.service.IZxPlantDashboardService;

@RestController
@RequestMapping("/plant/admin/dashboard")
public class ZxPlantDashboardController extends BaseController
{
    @Autowired
    private IZxPlantDashboardService plantDashboardService;

    @PreAuthorize("@ss.hasPermi('plant:dashboard:query')")
    @GetMapping("/overview")
    public AjaxResult overview(@RequestParam(required = false) String startDate,
                               @RequestParam(required = false) String endDate)
    {
        return success(plantDashboardService.selectOverview(startDate, endDate));
    }
}