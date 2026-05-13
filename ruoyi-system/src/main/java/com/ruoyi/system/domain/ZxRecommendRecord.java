package com.ruoyi.system.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class ZxRecommendRecord extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long recordId;
    private String visitorUid;
    private Long questionnaireId;
    private Long profileId;
    private String requestJson;
    private String resultJson;
    private String matchRuleJson;
    private Long topPlantId;
    private String topPlantName;
    private Integer totalCandidateCount;
    private Integer resultCount;
    private String sourceTerminal;
    private Date recommendTime;
    private List<ZxRecommendItem> itemList = new ArrayList<ZxRecommendItem>();

    public Long getRecordId() { return recordId; }
    public void setRecordId(Long recordId) { this.recordId = recordId; }
    public String getVisitorUid() { return visitorUid; }
    public void setVisitorUid(String visitorUid) { this.visitorUid = visitorUid; }
    public Long getQuestionnaireId() { return questionnaireId; }
    public void setQuestionnaireId(Long questionnaireId) { this.questionnaireId = questionnaireId; }
    public Long getProfileId() { return profileId; }
    public void setProfileId(Long profileId) { this.profileId = profileId; }
    public String getRequestJson() { return requestJson; }
    public void setRequestJson(String requestJson) { this.requestJson = requestJson; }
    public String getResultJson() { return resultJson; }
    public void setResultJson(String resultJson) { this.resultJson = resultJson; }
    public String getMatchRuleJson() { return matchRuleJson; }
    public void setMatchRuleJson(String matchRuleJson) { this.matchRuleJson = matchRuleJson; }
    public Long getTopPlantId() { return topPlantId; }
    public void setTopPlantId(Long topPlantId) { this.topPlantId = topPlantId; }
    public String getTopPlantName() { return topPlantName; }
    public void setTopPlantName(String topPlantName) { this.topPlantName = topPlantName; }
    public Integer getTotalCandidateCount() { return totalCandidateCount; }
    public void setTotalCandidateCount(Integer totalCandidateCount) { this.totalCandidateCount = totalCandidateCount; }
    public Integer getResultCount() { return resultCount; }
    public void setResultCount(Integer resultCount) { this.resultCount = resultCount; }
    public String getSourceTerminal() { return sourceTerminal; }
    public void setSourceTerminal(String sourceTerminal) { this.sourceTerminal = sourceTerminal; }
    public Date getRecommendTime() { return recommendTime; }
    public void setRecommendTime(Date recommendTime) { this.recommendTime = recommendTime; }
    public List<ZxRecommendItem> getItemList() { return itemList; }
    public void setItemList(List<ZxRecommendItem> itemList) { this.itemList = itemList; }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("recordId", getRecordId())
            .append("visitorUid", getVisitorUid())
            .append("questionnaireId", getQuestionnaireId())
            .append("profileId", getProfileId())
            .append("topPlantId", getTopPlantId())
            .toString();
    }
}