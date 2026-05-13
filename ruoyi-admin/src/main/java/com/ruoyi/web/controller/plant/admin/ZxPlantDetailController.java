package com.ruoyi.web.controller.plant.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
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
import com.ruoyi.system.domain.ZxPlantDetail;
import com.ruoyi.system.service.IZxPlantDetailService;

@RestController
@RequestMapping("/plant/admin/plant/detail")
public class ZxPlantDetailController extends BaseController
{
    @Autowired
    private IZxPlantDetailService detailService;

    @PreAuthorize("@ss.hasPermi('plant:plant:detail')")
    @GetMapping("/{plantId}")
    public AjaxResult getInfo(@PathVariable Long plantId)
    {
        return success(detailService.selectZxPlantDetailByPlantId(plantId));
    }

    @PreAuthorize("@ss.hasPermi('plant:plant:care')")
    @Log(title = "植物详情配置", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult save(@Validated @RequestBody ZxPlantDetail detail)
    {
        if (detail.getDetailId() == null)
        {
            detail.setCreateBy(getUsername());
        }
        else
        {
            detail.setUpdateBy(getUsername());
        }
        return toAjax(detailService.saveZxPlantDetail(detail));
    }
}