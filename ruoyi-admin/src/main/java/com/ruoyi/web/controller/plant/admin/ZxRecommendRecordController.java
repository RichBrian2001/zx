package com.ruoyi.web.controller.plant.admin;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.system.domain.ZxRecommendRecord;
import com.ruoyi.system.service.IZxRecommendRecordService;

@RestController
@RequestMapping("/plant/admin/recommend")
public class ZxRecommendRecordController extends BaseController
{
    @Autowired
    private IZxRecommendRecordService recommendRecordService;

    @PreAuthorize("@ss.hasPermi('plant:recommend:list')")
    @GetMapping("/list")
    public TableDataInfo list(ZxRecommendRecord record)
    {
        startPage();
        List<ZxRecommendRecord> list = recommendRecordService.selectZxRecommendRecordList(record);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('plant:recommend:detail')")
    @GetMapping(value = "/{recordId}")
    public AjaxResult getInfo(@PathVariable Long recordId)
    {
        return success(recommendRecordService.selectZxRecommendRecordById(recordId));
    }
}