package com.ruoyi.system.domain;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class ZxPlantTag extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long tagId;

    private String tagName;

    private String tagCode;

    private String tagGroup;

    private String tagDesc;

    private Integer sortNum;

    private String status;

    private String delFlag;

    public Long getTagId()
    {
        return tagId;
    }

    public void setTagId(Long tagId)
    {
        this.tagId = tagId;
    }

    @NotBlank(message = "标签名称不能为空")
    @Size(min = 0, max = 100, message = "标签名称长度不能超过100个字符")
    public String getTagName()
    {
        return tagName;
    }

    public void setTagName(String tagName)
    {
        this.tagName = tagName;
    }

    @NotBlank(message = "标签编码不能为空")
    @Size(min = 0, max = 64, message = "标签编码长度不能超过64个字符")
    public String getTagCode()
    {
        return tagCode;
    }

    public void setTagCode(String tagCode)
    {
        this.tagCode = tagCode;
    }

    @NotBlank(message = "标签分组不能为空")
    public String getTagGroup()
    {
        return tagGroup;
    }

    public void setTagGroup(String tagGroup)
    {
        this.tagGroup = tagGroup;
    }

    public String getTagDesc()
    {
        return tagDesc;
    }

    public void setTagDesc(String tagDesc)
    {
        this.tagDesc = tagDesc;
    }

    @NotNull(message = "排序不能为空")
    public Integer getSortNum()
    {
        return sortNum;
    }

    public void setSortNum(Integer sortNum)
    {
        this.sortNum = sortNum;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getDelFlag()
    {
        return delFlag;
    }

    public void setDelFlag(String delFlag)
    {
        this.delFlag = delFlag;
    }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("tagId", getTagId())
            .append("tagName", getTagName())
            .append("tagCode", getTagCode())
            .append("tagGroup", getTagGroup())
            .append("tagDesc", getTagDesc())
            .append("sortNum", getSortNum())
            .append("status", getStatus())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}