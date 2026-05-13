package com.ruoyi.web.controller.plant.app;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.system.domain.ZxPlant;
import com.ruoyi.system.service.IZxPlantAppPlantService;

@Anonymous
@RestController
@RequestMapping("/plant/app")
public class ZxPlantAppPlantController extends BaseController
{
    @Autowired
    private IZxPlantAppPlantService appPlantService;

    @GetMapping("/plants/list")
    public AjaxResult list()
    {
        startPage();
        List<ZxPlant> plantList = appPlantService.selectPublishedPlantList();
        TableDataInfo dataTable = getDataTable(plantList);
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("rows", dataTable.getRows());
        result.put("total", dataTable.getTotal());
        return success(result);
    }

    @GetMapping("/plant/{plantId}")
    public AjaxResult getInfo(@PathVariable Long plantId)
    {
        return success(appPlantService.selectPlantDetail(plantId));
    }
}