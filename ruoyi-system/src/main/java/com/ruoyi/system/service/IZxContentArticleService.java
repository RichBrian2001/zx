package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.ZxContentArticle;

public interface IZxContentArticleService
{
    public List<ZxContentArticle> selectZxContentArticleList(ZxContentArticle article);

    public ZxContentArticle selectZxContentArticleById(Long articleId);

    public int insertZxContentArticle(ZxContentArticle article);

    public int updateZxContentArticle(ZxContentArticle article);

    public int deleteZxContentArticleByIds(Long[] articleIds);
}