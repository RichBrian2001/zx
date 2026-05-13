package com.ruoyi.system.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class ZxUserProfile extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long profileId;
    private String visitorUid;
    private Long latestQuestionnaireId;
    private Long questionnaireId;
    private String profileJson;
    private String lightTagCode;
    private String waterTagCode;
    private String spaceTagCode;
    private String styleTagCode;
    private String budgetLevel;
    private String petPreference;
    private String carePreference;
    private Date lastRecommendTime;
    private String answerJson;
    private String environmentSummary;
    private String preferenceSummary;
    private java.math.BigDecimal budgetValue;
    private Date submitTime;
    private List<ZxRecommendRecord> recentRecommendList = new ArrayList<ZxRecommendRecord>();

    public Long getProfileId() { return profileId; }
    public void setProfileId(Long profileId) { this.profileId = profileId; }
    public String getVisitorUid() { return visitorUid; }
    public void setVisitorUid(String visitorUid) { this.visitorUid = visitorUid; }
    public Long getLatestQuestionnaireId() { return latestQuestionnaireId; }
    public void setLatestQuestionnaireId(Long latestQuestionnaireId) { this.latestQuestionnaireId = latestQuestionnaireId; }
    public Long getQuestionnaireId() { return questionnaireId; }
    public void setQuestionnaireId(Long questionnaireId) { this.questionnaireId = questionnaireId; }
    public String getProfileJson() { return profileJson; }
    public void setProfileJson(String profileJson) { this.profileJson = profileJson; }
    public String getLightTagCode() { return lightTagCode; }
    public void setLightTagCode(String lightTagCode) { this.lightTagCode = lightTagCode; }
    public String getWaterTagCode() { return waterTagCode; }
    public void setWaterTagCode(String waterTagCode) { this.waterTagCode = waterTagCode; }
    public String getSpaceTagCode() { return spaceTagCode; }
    public void setSpaceTagCode(String spaceTagCode) { this.spaceTagCode = spaceTagCode; }
    public String getStyleTagCode() { return styleTagCode; }
    public void setStyleTagCode(String styleTagCode) { this.styleTagCode = styleTagCode; }
    public String getBudgetLevel() { return budgetLevel; }
    public void setBudgetLevel(String budgetLevel) { this.budgetLevel = budgetLevel; }
    public String getPetPreference() { return petPreference; }
    public void setPetPreference(String petPreference) { this.petPreference = petPreference; }
    public String getCarePreference() { return carePreference; }
    public void setCarePreference(String carePreference) { this.carePreference = carePreference; }
    public Date getLastRecommendTime() { return lastRecommendTime; }
    public void setLastRecommendTime(Date lastRecommendTime) { this.lastRecommendTime = lastRecommendTime; }
    public String getAnswerJson() { return answerJson; }
    public void setAnswerJson(String answerJson) { this.answerJson = answerJson; }
    public String getEnvironmentSummary() { return environmentSummary; }
    public void setEnvironmentSummary(String environmentSummary) { this.environmentSummary = environmentSummary; }
    public String getPreferenceSummary() { return preferenceSummary; }
    public void setPreferenceSummary(String preferenceSummary) { this.preferenceSummary = preferenceSummary; }
    public java.math.BigDecimal getBudgetValue() { return budgetValue; }
    public void setBudgetValue(java.math.BigDecimal budgetValue) { this.budgetValue = budgetValue; }
    public Date getSubmitTime() { return submitTime; }
    public void setSubmitTime(Date submitTime) { this.submitTime = submitTime; }
    public List<ZxRecommendRecord> getRecentRecommendList() { return recentRecommendList; }
    public void setRecentRecommendList(List<ZxRecommendRecord> recentRecommendList) { this.recentRecommendList = recentRecommendList; }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("profileId", getProfileId())
            .append("visitorUid", getVisitorUid())
            .append("latestQuestionnaireId", getLatestQuestionnaireId())
            .append("questionnaireId", getQuestionnaireId())
            .append("profileJson", getProfileJson())
            .toString();
    }
}