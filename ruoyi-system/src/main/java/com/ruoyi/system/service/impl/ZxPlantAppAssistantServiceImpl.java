package com.ruoyi.system.service.impl;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.system.domain.ZxQuestionnaireRecord;
import com.ruoyi.system.domain.ZxUserProfile;
import com.ruoyi.system.mapper.ZxQuestionnaireRecordMapper;
import com.ruoyi.system.mapper.ZxUserProfileMapper;
import com.ruoyi.system.service.IZxPlantAppAssistantService;

@Service
public class ZxPlantAppAssistantServiceImpl implements IZxPlantAppAssistantService
{
    private static final String ASSISTANT_LATITUDE_ATTRIBUTE = "plantAssistantLatitude";

    private static final String ASSISTANT_LONGITUDE_ATTRIBUTE = "plantAssistantLongitude";

    private static final String ASSISTANT_ENVIRONMENT_ATTRIBUTE = "plantAssistantEnvironmentOverride";

    private static final Logger log = LoggerFactory.getLogger(ZxPlantAppAssistantServiceImpl.class);

    private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    @Autowired
    private ZxUserProfileMapper userProfileMapper;

    @Autowired
    private ZxQuestionnaireRecordMapper questionnaireRecordMapper;

    @Value("${plant.assistant.apiUrl:https://open.bigmodel.cn/api/paas/v4/chat/completions}")
    private String apiUrl;

    @Value("${plant.assistant.apiKey:}")
    private String apiKey;

    @Value("${plant.assistant.model:glm-4.5-air}")
    private String model;

    @Value("${plant.assistant.timeoutSeconds:15}")
    private long timeoutSeconds;

    @Value("${plant.assistant.reverseGeocodeUrl:https://nominatim.openstreetmap.org/reverse}")
    private String reverseGeocodeUrl;

    @Value("${plant.assistant.weatherApiUrl:https://api.open-meteo.com/v1/forecast}")
    private String weatherApiUrl;

    @Value("${plant.assistant.userAgent:RuoYi-Plant-Demo/1.0}")
    private String assistantUserAgent;

    @Override
    public Map<String, Object> getEnvironmentSnapshot(String visitorUid)
    {
        return buildEnvironmentSnapshot(visitorUid, resolveRequestLatitude(), resolveRequestLongitude());
    }

    @Override
    public Map<String, Object> chat(String visitorUid, String question, List<Map<String, String>> history)
    {
        Map<String, Object> environment = resolveChatEnvironment(resolveRequestEnvironmentOverride(), visitorUid,
            resolveRequestLatitude(), resolveRequestLongitude());
        Map<String, String> assistantReply = callAssistant(question, history, environment);

        Map<String, Object> result = new HashMap<String, Object>();
        result.put("answer", assistantReply.get("answer"));
        result.put("provider", assistantReply.get("provider"));
        result.put("model", assistantReply.get("model"));
        result.put("replyTime", DATE_TIME_FORMATTER.format(LocalDateTime.now()));
        result.put("environment", environment);
        return result;
    }

    @SuppressWarnings("unchecked")
    private Map<String, Object> resolveRequestEnvironmentOverride()
    {
        Object value = getRequestAttribute(ASSISTANT_ENVIRONMENT_ATTRIBUTE);
        if (value instanceof Map)
        {
            return (Map<String, Object>) value;
        }
        return null;
    }

    private Double resolveRequestLatitude()
    {
        return parseRequestDouble(getRequestAttribute(ASSISTANT_LATITUDE_ATTRIBUTE));
    }

    private Double resolveRequestLongitude()
    {
        return parseRequestDouble(getRequestAttribute(ASSISTANT_LONGITUDE_ATTRIBUTE));
    }

    private Object getRequestAttribute(String attributeName)
    {
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
        return requestAttributes == null ? null : requestAttributes.getAttribute(attributeName, RequestAttributes.SCOPE_REQUEST);
    }

    private Double parseRequestDouble(Object value)
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

    private Map<String, Object> buildEnvironmentSnapshot(String visitorUid, Double latitude, Double longitude)
    {
        ZxUserProfile profile = null;
        ZxQuestionnaireRecord questionnaire = null;

        if (StringUtils.isNotBlank(visitorUid))
        {
            profile = userProfileMapper.selectZxUserProfileByVisitorUid(visitorUid);
        }
        if (profile != null && profile.getLatestQuestionnaireId() != null)
        {
            questionnaire = questionnaireRecordMapper.selectZxQuestionnaireRecordById(profile.getLatestQuestionnaireId());
        }

        String sceneCode = questionnaire != null ? questionnaire.getScene() : StringUtils.EMPTY;
        String sceneLabel = resolveSceneLabel(sceneCode);
        int seed = resolveSeed(visitorUid, questionnaire);
        String spaceLabel = questionnaire != null && StringUtils.isNotBlank(questionnaire.getSpace()) ? questionnaire.getSpace() : resolveSpaceLabel(profile, seed);
        String careLabel = questionnaire != null && StringUtils.isNotBlank(questionnaire.getCare()) ? questionnaire.getCare() : resolveCareLabel(profile);
        String preferenceSummary = questionnaire != null && StringUtils.isNotBlank(questionnaire.getPreferenceSummary())
            ? questionnaire.getPreferenceSummary()
            : buildPreferenceSummary(questionnaire, profile);

        Map<String, Object> liveEnvironment = fetchRealEnvironment(latitude, longitude);
        boolean isRealLocation = Boolean.TRUE.equals(liveEnvironment.get("isRealLocation"));
        String location = isRealLocation ? String.valueOf(liveEnvironment.get("location")) : resolveFallbackLocation(sceneLabel);
        String weather = isRealLocation ? String.valueOf(liveEnvironment.get("weather")) : resolveEstimatedWeather(seed);
        String naturalLightLevel = isRealLocation
            ? String.valueOf(liveEnvironment.get("naturalLightLevel"))
            : resolveEstimatedNaturalLightLevel(questionnaire, profile, seed);
        int temperature = isRealLocation ? parseInteger(liveEnvironment.get("temperature"), resolveEstimatedTemperature(sceneCode, weather, seed))
            : resolveEstimatedTemperature(sceneCode, weather, seed);
        int humidity = isRealLocation ? parseInteger(liveEnvironment.get("humidity"), resolveEstimatedHumidity(weather, questionnaire, seed))
            : resolveEstimatedHumidity(weather, questionnaire, seed);
        String updateTime = isRealLocation ? String.valueOf(liveEnvironment.get("updateTime")) : DATE_TIME_FORMATTER.format(LocalDateTime.now());
        String environmentSummary = isRealLocation
            ? buildEnvironmentSummary(location, weather, temperature, humidity, naturalLightLevel, sceneLabel, spaceLabel)
            : buildFallbackEnvironmentSummary(weather, temperature, humidity, naturalLightLevel, sceneLabel, spaceLabel);

        Map<String, Object> result = new HashMap<String, Object>();
        result.put("visitorUid", StringUtils.defaultIfBlank(visitorUid, "guest"));
        result.put("location", location);
        result.put("weather", weather);
        result.put("temperature", temperature);
        result.put("humidity", humidity);
        result.put("naturalLightLevel", naturalLightLevel);
        result.put("updateTime", updateTime);
        result.put("scene", sceneLabel);
        result.put("space", spaceLabel);
        result.put("careLevel", careLabel);
        result.put("environmentSummary", environmentSummary);
        result.put("preferenceSummary", preferenceSummary);
        result.put("locationSource", isRealLocation ? "browser-weather-api" : "demo-fallback");
        result.put("sourceLabel", isRealLocation ? "真实定位 + 天气 API" : "环境估算");
        result.put("isRealLocation", isRealLocation);
        return result;
    }

    private Map<String, Object> resolveChatEnvironment(Map<String, Object> environmentOverride, String visitorUid,
                                                       Double latitude, Double longitude)
    {
        if (hasUsableEnvironmentOverride(environmentOverride))
        {
            return environmentOverride;
        }
        return buildEnvironmentSnapshot(visitorUid, latitude, longitude);
    }

    private int resolveSeed(String visitorUid, ZxQuestionnaireRecord questionnaire)
    {
        String seedText = StringUtils.defaultIfBlank(visitorUid, "guest") + "|"
            + (questionnaire != null ? StringUtils.defaultString(questionnaire.getScene()) : StringUtils.EMPTY) + "|"
            + (questionnaire != null ? StringUtils.defaultString(questionnaire.getLight()) : StringUtils.EMPTY);
        return seedText.hashCode() & Integer.MAX_VALUE;
    }

    private boolean hasUsableEnvironmentOverride(Map<String, Object> environmentOverride)
    {
        return environmentOverride != null
            && StringUtils.isNotBlank(String.valueOf(environmentOverride.get("location")))
            && StringUtils.isNotBlank(String.valueOf(environmentOverride.get("weather")))
            && environmentOverride.get("humidity") != null
            && StringUtils.isNotBlank(String.valueOf(environmentOverride.get("naturalLightLevel")));
    }

    private Map<String, Object> fetchRealEnvironment(Double latitude, Double longitude)
    {
        if (!isValidCoordinate(latitude, longitude))
        {
            return Collections.emptyMap();
        }

        try
        {
            JSONObject weatherCurrent = fetchCurrentWeather(latitude, longitude);
            String location = reverseGeocode(latitude, longitude);
            if (weatherCurrent == null || StringUtils.isBlank(location))
            {
                return Collections.emptyMap();
            }

            int weatherCode = weatherCurrent.getIntValue("weather_code");
            int cloudCover = weatherCurrent.getIntValue("cloud_cover");
            boolean isDay = weatherCurrent.getIntValue("is_day") == 1;

            Map<String, Object> result = new HashMap<String, Object>();
            result.put("location", location);
            result.put("weather", mapWeatherText(weatherCode));
            result.put("temperature", (int) Math.round(weatherCurrent.getDoubleValue("temperature_2m")));
            result.put("humidity", weatherCurrent.getIntValue("relative_humidity_2m"));
            result.put("naturalLightLevel", resolveLiveNaturalLightLevel(weatherCode, cloudCover, isDay));
            result.put("updateTime", normalizeWeatherUpdateTime(weatherCurrent.getString("time")));
            result.put("isRealLocation", true);
            return result;
        }
        catch (Exception ex)
        {
            log.warn("Failed to fetch live environment, fallback snapshot will be used", ex);
            return Collections.emptyMap();
        }
    }

    private JSONObject fetchCurrentWeather(Double latitude, Double longitude) throws Exception
    {
        String requestUrl = weatherApiUrl + "?latitude=" + latitude + "&longitude=" + longitude
            + "&current=temperature_2m,relative_humidity_2m,weather_code,is_day,cloud_cover&timezone=Asia%2FShanghai";
        HttpRequest request = HttpRequest.newBuilder(URI.create(requestUrl))
            .header(HttpHeaders.ACCEPT, MediaType.APPLICATION_JSON_VALUE)
            .timeout(Duration.ofSeconds(timeoutSeconds))
            .GET()
            .build();
        HttpResponse<String> response = buildHttpClient().send(request, HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));
        if (response.statusCode() < 200 || response.statusCode() >= 300)
        {
            return null;
        }

        JSONObject responseObject = JSON.parseObject(response.body());
        return responseObject == null ? null : responseObject.getJSONObject("current");
    }

    private String reverseGeocode(Double latitude, Double longitude) throws Exception
    {
        String requestUrl = reverseGeocodeUrl + "?format=jsonv2&lat=" + latitude + "&lon=" + longitude + "&accept-language=zh-CN";
        HttpRequest request = HttpRequest.newBuilder(URI.create(requestUrl))
            .header(HttpHeaders.ACCEPT, MediaType.APPLICATION_JSON_VALUE)
            .header(HttpHeaders.USER_AGENT, assistantUserAgent)
            .timeout(Duration.ofSeconds(timeoutSeconds))
            .GET()
            .build();
        HttpResponse<String> response = buildHttpClient().send(request, HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));
        if (response.statusCode() < 200 || response.statusCode() >= 300)
        {
            return StringUtils.EMPTY;
        }

        JSONObject responseObject = JSON.parseObject(response.body());
        JSONObject address = responseObject == null ? null : responseObject.getJSONObject("address");
        return buildLocationLabel(address);
    }

    private HttpClient buildHttpClient()
    {
        return HttpClient.newBuilder()
            .connectTimeout(Duration.ofSeconds(timeoutSeconds))
            .build();
    }

    private String buildLocationLabel(JSONObject address)
    {
        if (address == null)
        {
            return StringUtils.EMPTY;
        }

        Set<String> parts = new LinkedHashSet<String>();
        addLocationPart(parts, address.getString("state"));
        addLocationPart(parts, firstNonBlank(address.getString("city"), address.getString("town"), address.getString("county"), address.getString("municipality")));
        addLocationPart(parts, firstNonBlank(address.getString("county"), address.getString("city_district"), address.getString("state_district"), address.getString("district")));

        if (parts.isEmpty())
        {
            return StringUtils.EMPTY;
        }
        return String.join(" ", parts);
    }

    private void addLocationPart(Set<String> parts, String value)
    {
        if (StringUtils.isBlank(value))
        {
            return;
        }
        parts.add(StringUtils.trim(value));
    }

    private String firstNonBlank(String... values)
    {
        for (String value : values)
        {
            if (StringUtils.isNotBlank(value))
            {
                return value;
            }
        }
        return StringUtils.EMPTY;
    }

    private boolean isValidCoordinate(Double latitude, Double longitude)
    {
        return latitude != null && longitude != null
            && latitude >= -90 && latitude <= 90
            && longitude >= -180 && longitude <= 180;
    }

    private String resolveFallbackLocation(String sceneLabel)
    {
        return StringUtils.isNotBlank(sceneLabel) && !"室内空间".equals(sceneLabel) ? sceneLabel + "（未定位）" : "未获取真实位置";
    }

    private String resolveEstimatedNaturalLightLevel(ZxQuestionnaireRecord questionnaire, ZxUserProfile profile, int seed)
    {
        if (questionnaire != null && StringUtils.isNotBlank(questionnaire.getLight()))
        {
            return questionnaire.getLight();
        }
        if (profile != null)
        {
            if (StringUtils.containsIgnoreCase(profile.getLightTagCode(), "high") || StringUtils.contains(profile.getLightTagCode(), "sun"))
            {
                return "直射光";
            }
            if (StringUtils.containsIgnoreCase(profile.getLightTagCode(), "low") || StringUtils.contains(profile.getLightTagCode(), "shade"))
            {
                return "半阴";
            }
        }
        return seed % 3 == 0 ? "直射光" : (seed % 3 == 1 ? "散射光" : "半阴");
    }

    private String resolveEstimatedWeather(int seed)
    {
        String[] options = { "晴", "多云", "阴", "小雨" };
        return options[seed % options.length];
    }

    private int resolveEstimatedTemperature(String sceneCode, String weather, int seed)
    {
        int base = 22 + (seed % 5);
        if ("balcony".equals(sceneCode))
        {
            base += 2;
        }
        if ("小雨".equals(weather) || "阴".equals(weather))
        {
            base -= 1;
        }
        return base;
    }

    private int resolveEstimatedHumidity(String weather, ZxQuestionnaireRecord questionnaire, int seed)
    {
        int humidity = 48 + (seed % 18);
        if ("小雨".equals(weather))
        {
            humidity += 10;
        }
        if (questionnaire != null && "高维护".equals(questionnaire.getCare()))
        {
            humidity += 4;
        }
        return Math.min(humidity, 82);
    }

    private int parseInteger(Object value, int defaultValue)
    {
        if (value instanceof Number)
        {
            return ((Number) value).intValue();
        }
        if (value != null && StringUtils.isNumeric(String.valueOf(value)))
        {
            return Integer.parseInt(String.valueOf(value));
        }
        return defaultValue;
    }

    private String resolveSceneLabel(String sceneCode)
    {
        if ("desk".equals(sceneCode))
        {
            return "桌面";
        }
        if ("bedroom".equals(sceneCode))
        {
            return "卧室";
        }
        if ("living".equals(sceneCode))
        {
            return "客厅";
        }
        if ("office".equals(sceneCode))
        {
            return "办公室";
        }
        if ("balcony".equals(sceneCode))
        {
            return "阳台";
        }
        return "室内空间";
    }

    private String resolveSpaceLabel(ZxUserProfile profile, int seed)
    {
        if (profile != null && StringUtils.isNotBlank(profile.getSpaceTagCode()))
        {
            if (StringUtils.containsIgnoreCase(profile.getSpaceTagCode(), "large"))
            {
                return "大空间";
            }
            if (StringUtils.containsIgnoreCase(profile.getSpaceTagCode(), "small"))
            {
                return "小空间";
            }
        }
        return seed % 3 == 0 ? "大空间" : (seed % 3 == 1 ? "中等空间" : "小空间");
    }

    private String resolveCareLabel(ZxUserProfile profile)
    {
        if (profile == null || StringUtils.isBlank(profile.getCarePreference()))
        {
            return "中维护";
        }
        if (StringUtils.contains(profile.getCarePreference(), "低"))
        {
            return "低维护";
        }
        if (StringUtils.contains(profile.getCarePreference(), "高"))
        {
            return "高维护";
        }
        return "中维护";
    }

    private String buildEnvironmentSummary(String location, String weather, int temperature, int humidity,
                                           String naturalLightLevel, String sceneLabel, String spaceLabel)
    {
        return "当前位置为" + location + "，当前天气" + weather + "，环境温度约 " + temperature + "°C，空气湿度约 "
            + humidity + "% ，主要种植区域为" + sceneLabel + "，空间尺度为" + spaceLabel + "，自然光等级为" + naturalLightLevel + "。";
    }

    private String buildFallbackEnvironmentSummary(String weather, int temperature, int humidity,
                                                   String naturalLightLevel, String sceneLabel, String spaceLabel)
    {
        return "当前尚未获取浏览器真实定位，以下环境为基于问卷条件和当前时间估算的环境快照。点击“刷新环境快照”并允许定位后，将切换为真实城市位置和天气。"
            + "当前估算天气" + weather + "，环境温度约 " + temperature + "°C，空气湿度约 " + humidity + "% ，主要种植区域为"
            + sceneLabel + "，空间尺度为" + spaceLabel + "，自然光等级暂按" + naturalLightLevel + "估算。";
    }

    private String buildPreferenceSummary(ZxQuestionnaireRecord questionnaire, ZxUserProfile profile)
    {
        List<String> parts = new ArrayList<String>();
        if (questionnaire != null)
        {
            if (StringUtils.isNotBlank(questionnaire.getGoal()))
            {
                parts.add("目标偏向" + questionnaire.getGoal());
            }
            if (StringUtils.isNotBlank(questionnaire.getStyle()))
            {
                parts.add("风格偏好" + questionnaire.getStyle());
            }
            if (StringUtils.isNotBlank(questionnaire.getPet()))
            {
                parts.add("宠物条件为" + questionnaire.getPet());
            }
        }
        if (profile != null && StringUtils.isNotBlank(profile.getBudgetLevel()))
        {
            parts.add("预算等级" + profile.getBudgetLevel());
        }
        if (profile != null && StringUtils.isNotBlank(profile.getCarePreference()))
        {
            parts.add("养护投入倾向" + profile.getCarePreference());
        }
        return parts.isEmpty() ? "当前为首次咨询场景，建议优先给出适合新手、说明清晰的植物知识答复。" : String.join("，", parts) + "。";
    }

    private Map<String, String> callAssistant(String question, List<Map<String, String>> history, Map<String, Object> environment)
    {
        if (StringUtils.isBlank(apiKey))
        {
            return buildReply(buildFallbackAnswer(question, environment), "local-fallback");
        }

        try
        {
            JSONObject payload = new JSONObject();
            payload.put("model", model);
            payload.put("temperature", 0.6);
            payload.put("top_p", 0.85);
            payload.put("max_tokens", 1024);
            payload.put("messages", buildMessages(question, history, environment));

            HttpRequest request = HttpRequest.newBuilder(URI.create(apiUrl))
                .header(HttpHeaders.AUTHORIZATION, "Bearer " + apiKey)
                .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .timeout(Duration.ofSeconds(timeoutSeconds))
                .POST(HttpRequest.BodyPublishers.ofString(JSON.toJSONString(payload), StandardCharsets.UTF_8))
                .build();

            HttpClient client = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(timeoutSeconds))
                .build();
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));
            if (response.statusCode() < 200 || response.statusCode() >= 300)
            {
                log.warn("Plant assistant request failed, status={}, body={}", response.statusCode(), response.body());
                return buildReply(buildFallbackAnswer(question, environment), "local-fallback");
            }

            String answer = extractAssistantAnswer(response.body());
            return StringUtils.isNotBlank(answer)
                ? buildReply(structureAssistantAnswer(answer, environment), "bigmodel")
                : buildReply(buildFallbackAnswer(question, environment), "local-fallback");
        }
        catch (Exception ex)
        {
            log.warn("Plant assistant request failed, fallback will be used", ex);
            return buildReply(buildFallbackAnswer(question, environment), "local-fallback");
        }
    }

    private Map<String, String> buildReply(String answer, String provider)
    {
        Map<String, String> result = new HashMap<String, String>();
        result.put("answer", answer);
        result.put("provider", provider);
        result.put("model", "bigmodel".equals(provider) ? model : "local-fallback");
        return result;
    }

    private JSONArray buildMessages(String question, List<Map<String, String>> history, Map<String, Object> environment)
    {
        JSONArray messages = new JSONArray();

        JSONObject systemMessage = new JSONObject();
        systemMessage.put("role", "system");
        systemMessage.put("content", buildSystemPrompt(environment));
        messages.add(systemMessage);

        List<Map<String, String>> sanitizedHistory = sanitizeHistory(history);
        boolean duplicatedQuestion = hasTrailingDuplicateQuestion(sanitizedHistory, question);

        for (Map<String, String> item : sanitizedHistory)
        {
            JSONObject historyMessage = new JSONObject();
            historyMessage.put("role", item.get("role"));
            historyMessage.put("content", item.get("content"));
            messages.add(historyMessage);
        }

        if (!duplicatedQuestion)
        {
            JSONObject userMessage = new JSONObject();
            userMessage.put("role", "user");
            userMessage.put("content", question);
            messages.add(userMessage);
        }
        return messages;
    }

    private boolean hasTrailingDuplicateQuestion(List<Map<String, String>> sanitizedHistory, String question)
    {
        if (sanitizedHistory == null || sanitizedHistory.isEmpty())
        {
            return false;
        }

        Map<String, String> lastMessage = sanitizedHistory.get(sanitizedHistory.size() - 1);
        return lastMessage != null
            && "user".equals(lastMessage.get("role"))
            && StringUtils.equals(StringUtils.trimToEmpty(lastMessage.get("content")), StringUtils.trimToEmpty(question));
    }

    private List<Map<String, String>> sanitizeHistory(List<Map<String, String>> history)
    {
        if (history == null || history.isEmpty())
        {
            return Collections.emptyList();
        }

        List<Map<String, String>> result = new ArrayList<Map<String, String>>();
        int start = Math.max(history.size() - 6, 0);
        for (int i = start; i < history.size(); i++)
        {
            Map<String, String> item = history.get(i);
            if (item == null)
            {
                continue;
            }
            String role = item.get("role");
            String content = item.get("content");
            if (!"user".equals(role) && !"assistant".equals(role))
            {
                continue;
            }
            if (StringUtils.isBlank(content))
            {
                continue;
            }

            Map<String, String> cleanItem = new HashMap<String, String>();
            cleanItem.put("role", role);
            cleanItem.put("content", content);
            result.add(cleanItem);
        }
        return result;
    }

    private String buildSystemPrompt(Map<String, Object> environment)
    {
        return "你是植物个性化推荐系统中的植物百科问答助手。请基于以下环境快照回答，并把这些信息视为当前已知上下文，不要要求用户重复描述环境。"
            + "回答范围聚焦植物选择、养护、风险提示、摆放和场景建议；如果问题偏离植物主题，先简短回应，再把话题拉回植物。"
            + "回答格式固定为两段：第一段以‘环境判断：’开头，并且必须显式同时提到当前位置、天气、湿度和自然光等级四项背景；第二段以‘建议：’开头，给出 2 到 4 条具体建议。"
            + "环境快照：当前位置=" + environment.get("location")
            + "；天气=" + environment.get("weather")
            + "；温度=" + environment.get("temperature") + "°C"
            + "；湿度=" + environment.get("humidity") + "%"
            + "；自然光等级=" + environment.get("naturalLightLevel")
            + "；场景=" + environment.get("scene")
            + "；空间大小=" + environment.get("space")
            + "；养护投入=" + environment.get("careLevel")
                + "；快照来源=" + environment.get("sourceLabel")
            + "；环境摘要=" + environment.get("environmentSummary")
            + "；偏好摘要=" + environment.get("preferenceSummary")
            + "。不要省略环境判断段，也不要只回答植物名单。";
    }

    private String extractAssistantAnswer(String responseBody)
    {
        JSONObject responseObject = JSON.parseObject(responseBody);
        JSONArray choices = responseObject.getJSONArray("choices");
        if (choices == null || choices.isEmpty())
        {
            return StringUtils.EMPTY;
        }

        JSONObject firstChoice = choices.getJSONObject(0);
        if (firstChoice == null)
        {
            return StringUtils.EMPTY;
        }

        JSONObject message = firstChoice.getJSONObject("message");
        if (message == null)
        {
            return StringUtils.EMPTY;
        }

        Object content = message.get("content");
        if (content instanceof String)
        {
            return (String) content;
        }
        if (content instanceof JSONArray)
        {
            StringBuilder builder = new StringBuilder();
            JSONArray contentArray = (JSONArray) content;
            for (int i = 0; i < contentArray.size(); i++)
            {
                JSONObject item = contentArray.getJSONObject(i);
                if (item != null && StringUtils.isNotBlank(item.getString("text")))
                {
                    builder.append(item.getString("text"));
                }
            }
            return builder.toString();
        }
        return content == null ? StringUtils.EMPTY : String.valueOf(content);
    }

    private String buildFallbackAnswer(String question, Map<String, Object> environment)
    {
        String light = String.valueOf(environment.get("naturalLightLevel"));
        String weather = String.valueOf(environment.get("weather"));
        String location = String.valueOf(environment.get("location"));
        String careLevel = String.valueOf(environment.get("careLevel"));
        Integer humidity = Integer.valueOf(String.valueOf(environment.get("humidity")));

        StringBuilder builder = new StringBuilder();

        if (StringUtils.containsAny(question, "浇水", "水"))
        {
            builder.append("在这种湿度条件下，建议采用“见干见湿”的节奏：先摸表层 2 到 3 厘米土壤，再决定是否补水；低维护场景尤其不要按固定天数机械浇水。 ");
        }
        else if (StringUtils.containsAny(question, "光照", "晒", "太阳"))
        {
            builder.append("如果你当前区域主要是").append(light)
                .append("，优先把耐受度更匹配的植物放在主展示位；直射光环境要逐步增晒，半阴环境则更适合金钱树、吊兰、豆瓣绿这类容错更高的品种。 ");
        }
        else if (StringUtils.containsAny(question, "推荐", "选", "哪种", "适合"))
        {
            builder.append("按这个环境，首批更稳妥的方向是从吊兰、金钱树、豆瓣绿这类稳定型植物开始；如果你有更强的层次感需求，再考虑龟背竹或琴叶榕，但它们对空间和后续养护更敏感。 ");
        }
        else
        {
            builder.append("你这类环境提问时，最重要的是同时看光照、湿度和养护投入，不要只盯植物颜值。若你继续细化到“浇水 / 光照 / 病虫害 / 适合植物名单”，我可以按这个环境背景继续拆解。 ");
        }

        builder.append("当前你的养护投入倾向是").append(careLevel)
            .append("，所以建议优先选择解释成本低、容错率更高的养护方案。{}");
        return structureAssistantAnswer(builder.toString().replace("{}", StringUtils.EMPTY), environment);
    }

    private String structureAssistantAnswer(String answer, Map<String, Object> environment)
    {
        String trimmedAnswer = StringUtils.defaultString(answer).trim();
        if (StringUtils.contains(trimmedAnswer, "环境判断：") && StringUtils.contains(trimmedAnswer, "建议："))
        {
            return normalizeStructuredAnswer(trimmedAnswer);
        }
        String structuredAdvice = trimmedAnswer.startsWith("建议：") ? trimmedAnswer : "建议：" + trimmedAnswer;
        return buildEnvironmentJudgement(environment) + "\n" + structuredAdvice;
    }

    private String normalizeStructuredAnswer(String answer)
    {
        int environmentStart = answer.indexOf("环境判断：");
        int firstAdviceStart = answer.indexOf("建议：", environmentStart);
        if (environmentStart < 0 || firstAdviceStart < 0)
        {
            return answer;
        }

        int lastAdviceStart = answer.lastIndexOf("建议：");
        String environmentPart = answer.substring(environmentStart, firstAdviceStart).trim();
        String advicePart = answer.substring(lastAdviceStart >= firstAdviceStart ? lastAdviceStart : firstAdviceStart).trim();
        return environmentPart + "\n" + advicePart;
    }

    private String buildEnvironmentJudgement(Map<String, Object> environment)
    {
        return "环境判断：当前位置" + environment.get("location")
            + "，当前天气" + environment.get("weather")
            + "，空气湿度约 " + environment.get("humidity") + "%"
            + "，自然光等级为" + environment.get("naturalLightLevel") + "。";
    }

    private String mapWeatherText(int weatherCode)
    {
        if (weatherCode == 0)
        {
            return "晴";
        }
        if (weatherCode == 1)
        {
            return "晴间多云";
        }
        if (weatherCode == 2)
        {
            return "多云";
        }
        if (weatherCode == 3)
        {
            return "阴";
        }
        if (weatherCode == 45 || weatherCode == 48)
        {
            return "雾";
        }
        if (weatherCode >= 51 && weatherCode <= 57)
        {
            return "毛毛雨";
        }
        if ((weatherCode >= 61 && weatherCode <= 67) || (weatherCode >= 80 && weatherCode <= 82))
        {
            return "雨";
        }
        if ((weatherCode >= 71 && weatherCode <= 77) || (weatherCode >= 85 && weatherCode <= 86))
        {
            return "雪";
        }
        if (weatherCode >= 95)
        {
            return "雷暴";
        }
        return "多云";
    }

    private String resolveLiveNaturalLightLevel(int weatherCode, int cloudCover, boolean isDay)
    {
        if (!isDay)
        {
            return "夜间弱光";
        }
        if (weatherCode == 0 && cloudCover <= 20)
        {
            return "直射光";
        }
        if (cloudCover <= 65 && weatherCode <= 3)
        {
            return "散射光";
        }
        return "半阴";
    }

    private String normalizeWeatherUpdateTime(String weatherTime)
    {
        if (StringUtils.isBlank(weatherTime))
        {
            return DATE_TIME_FORMATTER.format(LocalDateTime.now());
        }
        String normalized = weatherTime.replace('T', ' ');
        return normalized.length() == 16 ? normalized + ":00" : normalized;
    }
}