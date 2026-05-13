package com.ruoyi.system.domain;

import java.math.BigDecimal;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class ZxRecommendRule extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long ruleId;

    private String ruleName;

    private String ruleCode;

    private String ruleType;

    private String triggerField;

    private String triggerOperator;

    private String triggerValue;

    private String actionType;

    private String actionValue;

    private BigDecimal scoreValue;

    private Integer priorityNum;

    private String status;

    private String ruleDesc;

    public Long getRuleId()
    {
        return ruleId;
    }

    public void setRuleId(Long ruleId)
    {
        this.ruleId = ruleId;
    }

    @NotBlank(message = "规则名称不能为空")
    @Size(min = 0, max = 100, message = "规则名称长度不能超过100个字符")
    public String getRuleName()
    {
        return ruleName;
    }

    public void setRuleName(String ruleName)
    {
        this.ruleName = ruleName;
    }

    @NotBlank(message = "规则编码不能为空")
    @Size(min = 0, max = 64, message = "规则编码长度不能超过64个字符")
    public String getRuleCode()
    {
        return ruleCode;
    }

    public void setRuleCode(String ruleCode)
    {
        this.ruleCode = ruleCode;
    }

    @NotBlank(message = "规则类型不能为空")
    public String getRuleType()
    {
        return ruleType;
    }

    public void setRuleType(String ruleType)
    {
        this.ruleType = ruleType;
    }

    public String getTriggerField()
    {
        return triggerField;
    }

    public void setTriggerField(String triggerField)
    {
        this.triggerField = triggerField;
    }

    public String getTriggerOperator()
    {
        return triggerOperator;
    }

    public void setTriggerOperator(String triggerOperator)
    {
        this.triggerOperator = triggerOperator;
    }

    public String getTriggerValue()
    {
        return triggerValue;
    }

    public void setTriggerValue(String triggerValue)
    {
        this.triggerValue = triggerValue;
    }

    public String getActionType()
    {
        return actionType;
    }

    public void setActionType(String actionType)
    {
        this.actionType = actionType;
    }

    public String getActionValue()
    {
        return actionValue;
    }

    public void setActionValue(String actionValue)
    {
        this.actionValue = actionValue;
    }

    public BigDecimal getScoreValue()
    {
        return scoreValue;
    }

    public void setScoreValue(BigDecimal scoreValue)
    {
        this.scoreValue = scoreValue;
    }

    @NotNull(message = "优先级不能为空")
    public Integer getPriorityNum()
    {
        return priorityNum;
    }

    public void setPriorityNum(Integer priorityNum)
    {
        this.priorityNum = priorityNum;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getRuleDesc()
    {
        return ruleDesc;
    }

    public void setRuleDesc(String ruleDesc)
    {
        this.ruleDesc = ruleDesc;
    }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("ruleId", getRuleId())
            .append("ruleName", getRuleName())
            .append("ruleCode", getRuleCode())
            .append("ruleType", getRuleType())
            .append("triggerField", getTriggerField())
            .append("triggerOperator", getTriggerOperator())
            .append("triggerValue", getTriggerValue())
            .append("actionType", getActionType())
            .append("actionValue", getActionValue())
            .append("scoreValue", getScoreValue())
            .append("priorityNum", getPriorityNum())
            .append("status", getStatus())
            .append("ruleDesc", getRuleDesc())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}