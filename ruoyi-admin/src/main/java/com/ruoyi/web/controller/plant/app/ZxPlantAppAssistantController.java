package com.ruoyi.web.controller.plant.app;

import jakarta.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.system.service.IZxPlantAppAssistantService;

@Anonymous
@RestController
@RequestMapping("/plant/app/assistant")
public class ZxPlantAppAssistantController extends BaseController
{
    private static final String ASSISTANT_LATITUDE_ATTRIBUTE = "plantAssistantLatitude";

    private static final String ASSISTANT_LONGITUDE_ATTRIBUTE = "plantAssistantLongitude";

    private static final String ASSISTANT_ENVIRONMENT_ATTRIBUTE = "plantAssistantEnvironmentOverride";

    @Autowired
    private IZxPlantAppAssistantService assistantService;

    @GetMapping("/environment")
    public AjaxResult environment(@RequestParam(required = false) String visitorUid,
                                  @RequestParam(required = false) Double latitude,
                                  @RequestParam(required = false) Double longitude,
                                  HttpServletRequest request)
    {
        setAssistantContext(request, latitude, longitude, null);
        return success(assistantService.getEnvironmentSnapshot(visitorUid));
    }

    @PostMapping("/chat")
    public AjaxResult chat(@RequestBody Map<String, Object> payload, HttpServletRequest request)
    {
        String visitorUid = payload.get("visitorUid") == null ? null : String.valueOf(payload.get("visitorUid"));
        String question = payload.get("question") == null ? StringUtils.EMPTY : String.valueOf(payload.get("question")).trim();
        if (StringUtils.isBlank(question))
        {
            return AjaxResult.error("问题内容不能为空");
        }
        setAssistantContext(request, extractDouble(payload.get("latitude")), extractDouble(payload.get("longitude")),
            extractEnvironment(payload.get("environment")));
        return success(assistantService.chat(visitorUid, question, extractHistory(payload.get("history"))));
    }

    private void setAssistantContext(HttpServletRequest request, Double latitude, Double longitude,
                                     Map<String, Object> environmentOverride)
    {
        request.setAttribute(ASSISTANT_LATITUDE_ATTRIBUTE, latitude);
        request.setAttribute(ASSISTANT_LONGITUDE_ATTRIBUTE, longitude);
        request.setAttribute(ASSISTANT_ENVIRONMENT_ATTRIBUTE, environmentOverride);
    }

    @SuppressWarnings("unchecked")
    private Map<String, Object> extractEnvironment(Object environmentObject)
    {
        if (environmentObject instanceof Map)
        {
            return (Map<String, Object>) environmentObject;
        }
        return null;
    }

    private Double extractDouble(Object value)
    {
        if (value instanceof Number)
        {
            return ((Number) value).doubleValue();
        }
        if (value != null && StringUtils.isNotBlank(String.valueOf(value)))
        {
            try
            {
                return Double.valueOf(String.valueOf(value));
            }
            catch (NumberFormatException ex)
            {
                return null;
            }
        }
        return null;
    }

    @SuppressWarnings("unchecked")
    private List<Map<String, String>> extractHistory(Object historyObject)
    {
        if (!(historyObject instanceof List))
        {
            return new ArrayList<Map<String, String>>();
        }

        List<Map<String, String>> result = new ArrayList<Map<String, String>>();
        List<?> historyList = (List<?>) historyObject;
        for (Object item : historyList)
        {
            if (item instanceof Map)
            {
                result.add((Map<String, String>) item);
            }
        }
        return result;
    }
}