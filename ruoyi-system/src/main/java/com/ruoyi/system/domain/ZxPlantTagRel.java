package com.ruoyi.system.domain;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class ZxPlantTagRel extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long relId;
    private Long plantId;
    private Long tagId;
    private String tagCode;
    private String tagName;
    private String tagGroup;
    private String tagDesc;
    private String status;
    private BigDecimal scoreWeight;
    private String plantName;
    private String coverImage;
    private String categoryName;
    private List<ZxPlantTagRel> tagItems = new ArrayList<ZxPlantTagRel>();

    public Long getRelId() { return relId; }
    public void setRelId(Long relId) { this.relId = relId; }
    public Long getPlantId() { return plantId; }
    public void setPlantId(Long plantId) { this.plantId = plantId; }
    public Long getTagId() { return tagId; }
    public void setTagId(Long tagId) { this.tagId = tagId; }
    public String getTagCode() { return tagCode; }
    public void setTagCode(String tagCode) { this.tagCode = tagCode; }
    public String getTagName() { return tagName; }
    public void setTagName(String tagName) { this.tagName = tagName; }
    public String getTagGroup() { return tagGroup; }
    public void setTagGroup(String tagGroup) { this.tagGroup = tagGroup; }
    public String getTagDesc() { return tagDesc; }
    public void setTagDesc(String tagDesc) { this.tagDesc = tagDesc; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public BigDecimal getScoreWeight() { return scoreWeight; }
    public void setScoreWeight(BigDecimal scoreWeight) { this.scoreWeight = scoreWeight; }
    public String getPlantName() { return plantName; }
    public void setPlantName(String plantName) { this.plantName = plantName; }
    public String getCoverImage() { return coverImage; }
    public void setCoverImage(String coverImage) { this.coverImage = coverImage; }
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
    public List<ZxPlantTagRel> getTagItems() { return tagItems; }
    public void setTagItems(List<ZxPlantTagRel> tagItems) { this.tagItems = tagItems; }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("relId", getRelId())
            .append("plantId", getPlantId())
            .append("tagId", getTagId())
            .append("tagCode", getTagCode())
            .append("tagName", getTagName())
            .append("scoreWeight", getScoreWeight())
            .toString();
    }
}