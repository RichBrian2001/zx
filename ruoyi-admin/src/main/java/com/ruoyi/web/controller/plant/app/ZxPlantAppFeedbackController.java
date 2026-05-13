package com.ruoyi.web.controller.plant.app;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.system.domain.ZxFeedbackRecord;
import com.ruoyi.system.service.IZxFeedbackRecordService;

@Anonymous
@RestController
@RequestMapping("/plant/app")
public class ZxPlantAppFeedbackController extends BaseController
{
    @Autowired
    private IZxFeedbackRecordService feedbackRecordService;

    @PostMapping("/feedback")
    public AjaxResult submit(@RequestBody ZxFeedbackRecord feedbackRecord)
    {
        return toAjax(feedbackRecordService.insertZxFeedbackRecord(feedbackRecord));
    }
}