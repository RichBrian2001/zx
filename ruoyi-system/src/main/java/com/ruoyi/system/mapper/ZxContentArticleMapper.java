package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.ZxContentArticle;

public interface ZxContentArticleMapper
{
    public List<ZxContentArticle> selectZxContentArticleList(ZxContentArticle article);

    public ZxContentArticle selectZxContentArticleById(Long articleId);

    public int insertZxContentArticle(ZxContentArticle article);

    public int updateZxContentArticle(ZxContentArticle article);

    public int deleteZxContentArticleByIds(Long[] articleIds);
}