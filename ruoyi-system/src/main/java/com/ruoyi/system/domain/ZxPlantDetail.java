package com.ruoyi.system.domain;

import jakarta.validation.constraints.NotNull;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class ZxPlantDetail extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long detailId;

    private Long plantId;

    private String plantName;

    private String coverImage;

    private String categoryName;

    private String lightRequirement;

    private String waterRequirement;

    private String temperatureRange;

    private String humidityRequirement;

    private String growCycle;

    private String careTips;

    private String riskTips;

    private String displayContent;

    @NotNull(message = "植物ID不能为空")
    public Long getPlantId()
    {
        return plantId;
    }

    public void setPlantId(Long plantId)
    {
        this.plantId = plantId;
    }

    public Long getDetailId()
    {
        return detailId;
    }

    public void setDetailId(Long detailId)
    {
        this.detailId = detailId;
    }

    public String getPlantName()
    {
        return plantName;
    }

    public void setPlantName(String plantName)
    {
        this.plantName = plantName;
    }

    public String getCoverImage()
    {
        return coverImage;
    }

    public void setCoverImage(String coverImage)
    {
        this.coverImage = coverImage;
    }

    public String getCategoryName()
    {
        return categoryName;
    }

    public void setCategoryName(String categoryName)
    {
        this.categoryName = categoryName;
    }

    public String getLightRequirement()
    {
        return lightRequirement;
    }

    public void setLightRequirement(String lightRequirement)
    {
        this.lightRequirement = lightRequirement;
    }

    public String getWaterRequirement()
    {
        return waterRequirement;
    }

    public void setWaterRequirement(String waterRequirement)
    {
        this.waterRequirement = waterRequirement;
    }

    public String getTemperatureRange()
    {
        return temperatureRange;
    }

    public void setTemperatureRange(String temperatureRange)
    {
        this.temperatureRange = temperatureRange;
    }

    public String getHumidityRequirement()
    {
        return humidityRequirement;
    }

    public void setHumidityRequirement(String humidityRequirement)
    {
        this.humidityRequirement = humidityRequirement;
    }

    public String getGrowCycle()
    {
        return growCycle;
    }

    public void setGrowCycle(String growCycle)
    {
        this.growCycle = growCycle;
    }

    public String getCareTips()
    {
        return careTips;
    }

    public void setCareTips(String careTips)
    {
        this.careTips = careTips;
    }

    public String getRiskTips()
    {
        return riskTips;
    }

    public void setRiskTips(String riskTips)
    {
        this.riskTips = riskTips;
    }

    public String getDisplayContent()
    {
        return displayContent;
    }

    public void setDisplayContent(String displayContent)
    {
        this.displayContent = displayContent;
    }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("detailId", getDetailId())
            .append("plantId", getPlantId())
            .append("plantName", getPlantName())
            .append("lightRequirement", getLightRequirement())
            .append("waterRequirement", getWaterRequirement())
            .append("temperatureRange", getTemperatureRange())
            .append("humidityRequirement", getHumidityRequirement())
            .append("growCycle", getGrowCycle())
            .append("careTips", getCareTips())
            .append("riskTips", getRiskTips())
            .append("displayContent", getDisplayContent())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}