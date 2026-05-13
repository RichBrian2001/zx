package com.ruoyi.web.controller.plant.admin;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.ZxPlant;
import com.ruoyi.system.service.IZxPlantService;

@RestController
@RequestMapping("/plant/admin/plant")
public class ZxPlantController extends BaseController
{
    @Autowired
    private IZxPlantService plantService;

    @PreAuthorize("@ss.hasPermi('plant:plant:list')")
    @GetMapping("/list")
    public TableDataInfo list(ZxPlant plant)
    {
        startPage();
        List<ZxPlant> list = plantService.selectZxPlantList(plant);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('plant:plant:detail')")
    @GetMapping(value = "/{plantId}")
    public AjaxResult getInfo(@PathVariable Long plantId)
    {
        return success(plantService.selectZxPlantById(plantId));
    }

    @PreAuthorize("@ss.hasPermi('plant:plant:add')")
    @Log(title = "植物库", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody ZxPlant plant)
    {
        plant.setCreateBy(getUsername());
        return toAjax(plantService.insertZxPlant(plant));
    }

    @PreAuthorize("@ss.hasPermi('plant:plant:edit')")
    @Log(title = "植物库", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody ZxPlant plant)
    {
        plant.setUpdateBy(getUsername());
        return toAjax(plantService.updateZxPlant(plant));
    }

    @PreAuthorize("@ss.hasPermi('plant:plant:edit')")
    @Log(title = "植物库状态", businessType = BusinessType.UPDATE)
    @PutMapping("/changeDisplayStatus")
    public AjaxResult changeDisplayStatus(@RequestBody ZxPlant plant)
    {
        plant.setUpdateBy(getUsername());
        return toAjax(plantService.updateZxPlantDisplayStatus(plant));
    }

    @PreAuthorize("@ss.hasPermi('plant:plant:remove')")
    @Log(title = "植物库", businessType = BusinessType.DELETE)
    @DeleteMapping("/{plantIds}")
    public AjaxResult remove(@PathVariable Long[] plantIds)
    {
        return toAjax(plantService.deleteZxPlantByIds(plantIds));
    }
}