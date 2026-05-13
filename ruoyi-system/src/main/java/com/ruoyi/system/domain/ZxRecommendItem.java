package com.ruoyi.system.domain;

import java.math.BigDecimal;
import java.util.Date;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class ZxRecommendItem extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long itemId;
    private Long recordId;
    private Long plantId;
    private String plantName;
    private BigDecimal scoreTotal;
    private String scoreDetailJson;
    private Integer rankNum;
    private String reasonText;
    private Date createTime;

    public Long getItemId() { return itemId; }
    public void setItemId(Long itemId) { this.itemId = itemId; }
    public Long getRecordId() { return recordId; }
    public void setRecordId(Long recordId) { this.recordId = recordId; }
    public Long getPlantId() { return plantId; }
    public void setPlantId(Long plantId) { this.plantId = plantId; }
    public String getPlantName() { return plantName; }
    public void setPlantName(String plantName) { this.plantName = plantName; }
    public BigDecimal getScoreTotal() { return scoreTotal; }
    public void setScoreTotal(BigDecimal scoreTotal) { this.scoreTotal = scoreTotal; }
    public String getScoreDetailJson() { return scoreDetailJson; }
    public void setScoreDetailJson(String scoreDetailJson) { this.scoreDetailJson = scoreDetailJson; }
    public Integer getRankNum() { return rankNum; }
    public void setRankNum(Integer rankNum) { this.rankNum = rankNum; }
    public String getReasonText() { return reasonText; }
    public void setReasonText(String reasonText) { this.reasonText = reasonText; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("itemId", getItemId())
            .append("recordId", getRecordId())
            .append("plantId", getPlantId())
            .append("scoreTotal", getScoreTotal())
            .toString();
    }
}