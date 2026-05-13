package com.ruoyi.system.domain;

import java.math.BigDecimal;
import java.util.Date;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class ZxQuestionnaireRecord extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long questionnaireId;
    private String visitorUid;
    private String sourceTerminal;
    private String sourceChannel;
    private String answerJson;
    private String environmentSummary;
    private String preferenceSummary;
    private BigDecimal budgetValue;
    private String submitIp;
    private Date submitTime;
    private String scene;
    private String light;
    private String space;
    private String pet;
    private String budget;
    private String care;
    private String style;
    private String goal;

    public Long getQuestionnaireId() { return questionnaireId; }
    public void setQuestionnaireId(Long questionnaireId) { this.questionnaireId = questionnaireId; }
    public String getVisitorUid() { return visitorUid; }
    public void setVisitorUid(String visitorUid) { this.visitorUid = visitorUid; }
    public String getSourceTerminal() { return sourceTerminal; }
    public void setSourceTerminal(String sourceTerminal) { this.sourceTerminal = sourceTerminal; }
    public String getSourceChannel() { return sourceChannel; }
    public void setSourceChannel(String sourceChannel) { this.sourceChannel = sourceChannel; }
    public String getAnswerJson() { return answerJson; }
    public void setAnswerJson(String answerJson) { this.answerJson = answerJson; }
    public String getEnvironmentSummary() { return environmentSummary; }
    public void setEnvironmentSummary(String environmentSummary) { this.environmentSummary = environmentSummary; }
    public String getPreferenceSummary() { return preferenceSummary; }
    public void setPreferenceSummary(String preferenceSummary) { this.preferenceSummary = preferenceSummary; }
    public BigDecimal getBudgetValue() { return budgetValue; }
    public void setBudgetValue(BigDecimal budgetValue) { this.budgetValue = budgetValue; }
    public String getSubmitIp() { return submitIp; }
    public void setSubmitIp(String submitIp) { this.submitIp = submitIp; }
    public Date getSubmitTime() { return submitTime; }
    public void setSubmitTime(Date submitTime) { this.submitTime = submitTime; }
    public String getScene() { return scene; }
    public void setScene(String scene) { this.scene = scene; }
    public String getLight() { return light; }
    public void setLight(String light) { this.light = light; }
    public String getSpace() { return space; }
    public void setSpace(String space) { this.space = space; }
    public String getPet() { return pet; }
    public void setPet(String pet) { this.pet = pet; }
    public String getBudget() { return budget; }
    public void setBudget(String budget) { this.budget = budget; }
    public String getCare() { return care; }
    public void setCare(String care) { this.care = care; }
    public String getStyle() { return style; }
    public void setStyle(String style) { this.style = style; }
    public String getGoal() { return goal; }
    public void setGoal(String goal) { this.goal = goal; }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("questionnaireId", getQuestionnaireId())
            .append("visitorUid", getVisitorUid())
            .append("sourceTerminal", getSourceTerminal())
            .append("submitTime", getSubmitTime())
            .toString();
    }
}