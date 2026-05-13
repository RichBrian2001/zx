package com.ruoyi.web.controller.plant.app;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.system.service.IZxPlantRecommendAppService;

@Anonymous
@RestController
@RequestMapping("/plant/app")
public class ZxPlantAppRecommendController extends BaseController
{
    @Autowired
    private IZxPlantRecommendAppService recommendAppService;

    @PostMapping("/recommend/execute")
    public AjaxResult execute(@RequestBody Map<String, Object> request)
    {
        Long questionnaireId = request.get("questionnaireId") == null ? null : Long.valueOf(String.valueOf(request.get("questionnaireId")));
        Long profileId = request.get("profileId") == null ? null : Long.valueOf(String.valueOf(request.get("profileId")));
        String visitorUid = request.get("visitorUid") == null ? null : String.valueOf(request.get("visitorUid"));
        return success(recommendAppService.executeRecommend(questionnaireId, profileId, visitorUid));
    }

    @GetMapping("/recommend/{recordId}")
    public AjaxResult getResult(@PathVariable Long recordId)
    {
        return success(recommendAppService.selectRecommendResult(recordId));
    }

    @GetMapping("/history/list")
    public AjaxResult history(@RequestParam String visitorUid)
    {
        List<Map<String, Object>> list = recommendAppService.selectHistoryList(visitorUid);
        return success(list);
    }
}