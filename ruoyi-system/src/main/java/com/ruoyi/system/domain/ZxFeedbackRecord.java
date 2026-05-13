package com.ruoyi.system.domain;

import java.util.Date;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class ZxFeedbackRecord extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long feedbackId;
    private String visitorUid;
    private Long recordId;
    private Long plantId;
    private String plantName;
    private String feedbackType;
    private String feedbackReason;
    private String extraNote;
    private Date createTime;

    public Long getFeedbackId() { return feedbackId; }
    public void setFeedbackId(Long feedbackId) { this.feedbackId = feedbackId; }
    public String getVisitorUid() { return visitorUid; }
    public void setVisitorUid(String visitorUid) { this.visitorUid = visitorUid; }
    public Long getRecordId() { return recordId; }
    public void setRecordId(Long recordId) { this.recordId = recordId; }
    public Long getPlantId() { return plantId; }
    public void setPlantId(Long plantId) { this.plantId = plantId; }
    public String getPlantName() { return plantName; }
    public void setPlantName(String plantName) { this.plantName = plantName; }
    public String getFeedbackType() { return feedbackType; }
    public void setFeedbackType(String feedbackType) { this.feedbackType = feedbackType; }
    public String getFeedbackReason() { return feedbackReason; }
    public void setFeedbackReason(String feedbackReason) { this.feedbackReason = feedbackReason; }
    public String getExtraNote() { return extraNote; }
    public void setExtraNote(String extraNote) { this.extraNote = extraNote; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("feedbackId", getFeedbackId())
            .append("recordId", getRecordId())
            .append("plantId", getPlantId())
            .append("feedbackType", getFeedbackType())
            .toString();
    }
}