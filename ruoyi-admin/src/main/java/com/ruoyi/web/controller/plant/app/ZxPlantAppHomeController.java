package com.ruoyi.web.controller.plant.app;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.system.service.IZxPlantAppHomeService;

@Anonymous
@RestController
@RequestMapping("/plant/app/home")
public class ZxPlantAppHomeController extends BaseController
{
    @Autowired
    private IZxPlantAppHomeService appHomeService;

    @GetMapping("/summary")
    public AjaxResult summary()
    {
        return success(appHomeService.getHomeSummary());
    }
}