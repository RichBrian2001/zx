package com.ruoyi.system.domain;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class ZxPlant extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long plantId;

    private Long categoryId;

    private Long detailId;

    private String categoryName;

    private String plantName;

    private String plantCode;

    private String aliasName;

    private String coverImage;

    private String plantSummary;

    private String difficultyLevel;

    private String priceLevel;

    private String displayStatus;

    private String petSafeFlag;

    private String purgeEffectFlag;

    private String aromaFlag;

    private String suitableScene;

    private Integer sortNum;

    private String status;

    private String delFlag;

    public Long getPlantId()
    {
        return plantId;
    }

    public void setPlantId(Long plantId)
    {
        this.plantId = plantId;
    }

    @NotNull(message = "分类不能为空")
    public Long getCategoryId()
    {
        return categoryId;
    }

    public void setCategoryId(Long categoryId)
    {
        this.categoryId = categoryId;
    }

    public Long getDetailId()
    {
        return detailId;
    }

    public void setDetailId(Long detailId)
    {
        this.detailId = detailId;
    }

    public String getCategoryName()
    {
        return categoryName;
    }

    public void setCategoryName(String categoryName)
    {
        this.categoryName = categoryName;
    }

    @NotBlank(message = "植物名称不能为空")
    @Size(min = 0, max = 100, message = "植物名称长度不能超过100个字符")
    public String getPlantName()
    {
        return plantName;
    }

    public void setPlantName(String plantName)
    {
        this.plantName = plantName;
    }

    @Size(min = 0, max = 64, message = "植物编码长度不能超过64个字符")
    public String getPlantCode()
    {
        return plantCode;
    }

    public void setPlantCode(String plantCode)
    {
        this.plantCode = plantCode;
    }

    public String getAliasName()
    {
        return aliasName;
    }

    public void setAliasName(String aliasName)
    {
        this.aliasName = aliasName;
    }

    public String getCoverImage()
    {
        return coverImage;
    }

    public void setCoverImage(String coverImage)
    {
        this.coverImage = coverImage;
    }

    public String getPlantSummary()
    {
        return plantSummary;
    }

    public void setPlantSummary(String plantSummary)
    {
        this.plantSummary = plantSummary;
    }

    public String getDifficultyLevel()
    {
        return difficultyLevel;
    }

    public void setDifficultyLevel(String difficultyLevel)
    {
        this.difficultyLevel = difficultyLevel;
    }

    public String getPriceLevel()
    {
        return priceLevel;
    }

    public void setPriceLevel(String priceLevel)
    {
        this.priceLevel = priceLevel;
    }

    public String getDisplayStatus()
    {
        return displayStatus;
    }

    public void setDisplayStatus(String displayStatus)
    {
        this.displayStatus = displayStatus;
    }

    public String getPetSafeFlag()
    {
        return petSafeFlag;
    }

    public void setPetSafeFlag(String petSafeFlag)
    {
        this.petSafeFlag = petSafeFlag;
    }

    public String getPurgeEffectFlag()
    {
        return purgeEffectFlag;
    }

    public void setPurgeEffectFlag(String purgeEffectFlag)
    {
        this.purgeEffectFlag = purgeEffectFlag;
    }

    public String getAromaFlag()
    {
        return aromaFlag;
    }

    public void setAromaFlag(String aromaFlag)
    {
        this.aromaFlag = aromaFlag;
    }

    public String getSuitableScene()
    {
        return suitableScene;
    }

    public void setSuitableScene(String suitableScene)
    {
        this.suitableScene = suitableScene;
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
            .append("plantId", getPlantId())
            .append("categoryId", getCategoryId())
            .append("detailId", getDetailId())
            .append("categoryName", getCategoryName())
            .append("plantName", getPlantName())
            .append("plantCode", getPlantCode())
            .append("aliasName", getAliasName())
            .append("coverImage", getCoverImage())
            .append("plantSummary", getPlantSummary())
            .append("difficultyLevel", getDifficultyLevel())
            .append("priceLevel", getPriceLevel())
            .append("displayStatus", getDisplayStatus())
            .append("petSafeFlag", getPetSafeFlag())
            .append("purgeEffectFlag", getPurgeEffectFlag())
            .append("aromaFlag", getAromaFlag())
            .append("suitableScene", getSuitableScene())
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