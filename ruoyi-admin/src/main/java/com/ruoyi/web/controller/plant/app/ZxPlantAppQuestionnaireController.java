package com.ruoyi.web.controller.plant.app;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.system.domain.ZxQuestionnaireRecord;
import com.ruoyi.system.service.IZxPlantQuestionnaireService;

@Anonymous
@RestController
@RequestMapping("/plant/app")
public class ZxPlantAppQuestionnaireController extends BaseController
{
    @Autowired
    private IZxPlantQuestionnaireService questionnaireService;

    @PostMapping("/questionnaire/submit")
    public AjaxResult submit(@RequestBody ZxQuestionnaireRecord questionnaireRecord)
    {
        return success(questionnaireService.submitQuestionnaire(questionnaireRecord));
    }

    @PostMapping("/profile/build")
    public AjaxResult buildProfile(@RequestParam Long questionnaireId,
                                   @RequestParam(required = false) String visitorUid)
    {
        return success(questionnaireService.buildProfile(questionnaireId, visitorUid));
    }
}