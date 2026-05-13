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
import com.ruoyi.system.domain.ZxFeedbackRecord;
import com.ruoyi.system.service.IZxFeedbackRecordService;

@RestController
@RequestMapping("/plant/admin/feedback")
public class ZxFeedbackRecordController extends BaseController
{
    @Autowired
    private IZxFeedbackRecordService feedbackService;

    @PreAuthorize("@ss.hasPermi('plant:feedback:list')")
    @GetMapping("/list")
    public TableDataInfo list(ZxFeedbackRecord feedback)
    {
        startPage();
        List<ZxFeedbackRecord> list = feedbackService.selectZxFeedbackRecordList(feedback);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('plant:feedback:query')")
    @GetMapping(value = "/{feedbackId}")
    public AjaxResult getInfo(@PathVariable Long feedbackId)
    {
        return success(feedbackService.selectZxFeedbackRecordById(feedbackId));
    }
}