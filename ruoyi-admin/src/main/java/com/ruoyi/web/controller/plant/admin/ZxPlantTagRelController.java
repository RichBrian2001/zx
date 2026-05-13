package com.ruoyi.web.controller.plant.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.ZxPlantTagRel;
import com.ruoyi.system.service.IZxPlantTagRelService;

@RestController
@RequestMapping("/plant/admin/plant/tag")
public class ZxPlantTagRelController extends BaseController
{
    @Autowired
    private IZxPlantTagRelService tagRelService;

    @PreAuthorize("@ss.hasPermi('plant:plant:tag')")
    @GetMapping("/{plantId}")
    public AjaxResult getInfo(@PathVariable Long plantId)
    {
        return success(tagRelService.selectPlantTagConfig(plantId));
    }

    @PreAuthorize("@ss.hasPermi('plant:plant:tag')")
    @Log(title = "植物标签配置", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult save(@RequestBody ZxPlantTagRel request)
    {
        request.setUpdateBy(getUsername());
        return toAjax(tagRelService.savePlantTagConfig(request));
    }
}