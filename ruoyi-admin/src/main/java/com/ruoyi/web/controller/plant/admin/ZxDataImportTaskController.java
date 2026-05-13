package com.ruoyi.web.controller.plant.admin;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.ZxDataImportTask;
import com.ruoyi.system.service.IZxDataImportTaskService;

@RestController
@RequestMapping("/plant/admin/import")
public class ZxDataImportTaskController extends BaseController
{
    @Autowired
    private IZxDataImportTaskService importTaskService;

    @PreAuthorize("@ss.hasPermi('plant:import:list')")
    @GetMapping("/list")
    public TableDataInfo list(ZxDataImportTask task)
    {
        startPage();
        List<ZxDataImportTask> list = importTaskService.selectZxDataImportTaskList(task);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('plant:import:detail')")
    @GetMapping(value = "/{taskId}")
    public AjaxResult getInfo(@PathVariable Long taskId)
    {
        return success(importTaskService.selectZxDataImportTaskById(taskId));
    }

    @PreAuthorize("@ss.hasPermi('plant:import:upload')")
    @Log(title = "数据导入上传", businessType = BusinessType.IMPORT)
    @PostMapping("/upload")
    public AjaxResult upload(@RequestParam String taskName,
                             @RequestParam String importType,
                             @RequestParam(required = false) String remark,
                             @RequestParam(required = false) MultipartFile uploadFile)
    {
        return success(importTaskService.uploadTask(taskName, importType, remark, getUsername(), uploadFile));
    }

    @PreAuthorize("@ss.hasPermi('plant:import:execute')")
    @Log(title = "数据导入执行", businessType = BusinessType.UPDATE)
    @PostMapping("/execute")
    public AjaxResult execute(@RequestParam Long taskId)
    {
        return toAjax(importTaskService.executeTask(taskId, getUsername()));
    }
}