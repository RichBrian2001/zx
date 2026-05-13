package com.ruoyi.system.domain;

import java.util.Date;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class ZxContentArticle extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long articleId;
    private String articleType;
    private String title;
    private String coverImage;
    private String summary;
    private String content;
    private Long relatedPlantId;
    private String relatedPlantName;
    private String status;
    private Integer sortOrder;
    private Date publishTime;
    private String delFlag;

    public Long getArticleId() { return articleId; }
    public void setArticleId(Long articleId) { this.articleId = articleId; }
    @NotBlank(message = "文章类型不能为空")
    public String getArticleType() { return articleType; }
    public void setArticleType(String articleType) { this.articleType = articleType; }
    @NotBlank(message = "标题不能为空")
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getCoverImage() { return coverImage; }
    public void setCoverImage(String coverImage) { this.coverImage = coverImage; }
    public String getSummary() { return summary; }
    public void setSummary(String summary) { this.summary = summary; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public Long getRelatedPlantId() { return relatedPlantId; }
    public void setRelatedPlantId(Long relatedPlantId) { this.relatedPlantId = relatedPlantId; }
    public String getRelatedPlantName() { return relatedPlantName; }
    public void setRelatedPlantName(String relatedPlantName) { this.relatedPlantName = relatedPlantName; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    @NotNull(message = "排序不能为空")
    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }
    public Date getPublishTime() { return publishTime; }
    public void setPublishTime(Date publishTime) { this.publishTime = publishTime; }
    public String getDelFlag() { return delFlag; }
    public void setDelFlag(String delFlag) { this.delFlag = delFlag; }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("articleId", getArticleId())
            .append("title", getTitle())
            .append("relatedPlantId", getRelatedPlantId())
            .toString();
    }
}