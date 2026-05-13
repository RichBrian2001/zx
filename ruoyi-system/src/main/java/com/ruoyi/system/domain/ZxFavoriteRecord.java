package com.ruoyi.system.domain;

import java.util.Date;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class ZxFavoriteRecord extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long favoriteId;
    private String visitorUid;
    private Long plantId;
    private String plantName;
    private String coverImage;
    private String plantSummary;
    private String difficultyLevel;
    private String priceLevel;
    private String status;
    private Date createTime;
    private Date cancelTime;

    public Long getFavoriteId() { return favoriteId; }
    public void setFavoriteId(Long favoriteId) { this.favoriteId = favoriteId; }
    public String getVisitorUid() { return visitorUid; }
    public void setVisitorUid(String visitorUid) { this.visitorUid = visitorUid; }
    public Long getPlantId() { return plantId; }
    public void setPlantId(Long plantId) { this.plantId = plantId; }
    public String getPlantName() { return plantName; }
    public void setPlantName(String plantName) { this.plantName = plantName; }
    public String getCoverImage() { return coverImage; }
    public void setCoverImage(String coverImage) { this.coverImage = coverImage; }
    public String getPlantSummary() { return plantSummary; }
    public void setPlantSummary(String plantSummary) { this.plantSummary = plantSummary; }
    public String getDifficultyLevel() { return difficultyLevel; }
    public void setDifficultyLevel(String difficultyLevel) { this.difficultyLevel = difficultyLevel; }
    public String getPriceLevel() { return priceLevel; }
    public void setPriceLevel(String priceLevel) { this.priceLevel = priceLevel; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public Date getCancelTime() { return cancelTime; }
    public void setCancelTime(Date cancelTime) { this.cancelTime = cancelTime; }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("favoriteId", getFavoriteId())
            .append("visitorUid", getVisitorUid())
            .append("plantId", getPlantId())
            .append("status", getStatus())
            .toString();
    }
}