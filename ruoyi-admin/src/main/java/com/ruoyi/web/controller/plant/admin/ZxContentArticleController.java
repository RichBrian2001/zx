package com.ruoyi.web.controller.plant.admin;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.ZxContentArticle;
import com.ruoyi.system.service.IZxContentArticleService;

@RestController
@RequestMapping("/plant/admin/article")
public class ZxContentArticleController extends BaseController
{
    @Autowired
    private IZxContentArticleService articleService;

    @PreAuthorize("@ss.hasPermi('plant:article:list')")
    @GetMapping("/list")
    public TableDataInfo list(ZxContentArticle article)
    {
        startPage();
        List<ZxContentArticle> list = articleService.selectZxContentArticleList(article);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('plant:article:query')")
    @GetMapping(value = "/{articleId}")
    public AjaxResult getInfo(@PathVariable Long articleId)
    {
        return success(articleService.selectZxContentArticleById(articleId));
    }

    @PreAuthorize("@ss.hasPermi('plant:article:add')")
    @Log(title = "内容管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody ZxContentArticle article)
    {
        article.setCreateBy(getUsername());
        return toAjax(articleService.insertZxContentArticle(article));
    }

    @PreAuthorize("@ss.hasPermi('plant:article:edit')")
    @Log(title = "内容管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody ZxContentArticle article)
    {
        article.setUpdateBy(getUsername());
        return toAjax(articleService.updateZxContentArticle(article));
    }

    @PreAuthorize("@ss.hasPermi('plant:article:remove')")
    @Log(title = "内容管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{articleIds}")
    public AjaxResult remove(@PathVariable Long[] articleIds)
    {
        return toAjax(articleService.deleteZxContentArticleByIds(articleIds));
    }
}