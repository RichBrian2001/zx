package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.ZxContentArticle;
import com.ruoyi.system.mapper.ZxContentArticleMapper;
import com.ruoyi.system.service.IZxContentArticleService;

@Service
public class ZxContentArticleServiceImpl implements IZxContentArticleService
{
    @Autowired
    private ZxContentArticleMapper articleMapper;

    @Override
    public List<ZxContentArticle> selectZxContentArticleList(ZxContentArticle article)
    {
        return articleMapper.selectZxContentArticleList(article);
    }

    @Override
    public ZxContentArticle selectZxContentArticleById(Long articleId)
    {
        return articleMapper.selectZxContentArticleById(articleId);
    }

    @Override
    public int insertZxContentArticle(ZxContentArticle article)
    {
        return articleMapper.insertZxContentArticle(article);
    }

    @Override
    public int updateZxContentArticle(ZxContentArticle article)
    {
        return articleMapper.updateZxContentArticle(article);
    }

    @Override
    public int deleteZxContentArticleByIds(Long[] articleIds)
    {
        return articleMapper.deleteZxContentArticleByIds(articleIds);
    }
}