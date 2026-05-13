package com.ruoyi.web.controller.plant.admin;

import java.util.List;
import org.apache.commons.lang3.ArrayUtils;
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
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.ZxPlantCategory;
import com.ruoyi.system.service.IZxPlantCategoryService;

/**
 * 植物分类后台接口
 */
@RestController
@RequestMapping("/plant/admin/category")
public class ZxPlantCategoryController extends BaseController
{
    @Autowired
    private IZxPlantCategoryService categoryService;

    @PreAuthorize("@ss.hasPermi('plant:category:list')")
    @GetMapping("/list")
    public AjaxResult list(ZxPlantCategory category)
    {
        List<ZxPlantCategory> categories = categoryService.selectZxPlantCategoryList(category);
        return success(categories);
    }

    @PreAuthorize("@ss.hasPermi('plant:category:list')")
    @GetMapping("/list/exclude/{categoryId}")
    public AjaxResult excludeChild(@PathVariable(value = "categoryId", required = false) Long categoryId)
    {
        List<ZxPlantCategory> categories = categoryService.selectZxPlantCategoryList(new ZxPlantCategory());
        categories.removeIf(category -> category.getCategoryId().intValue() == categoryId
            || ArrayUtils.contains(StringUtils.split(category.getAncestors(), ","), categoryId + ""));
        return success(categories);
    }

    @PreAuthorize("@ss.hasPermi('plant:category:list')")
    @GetMapping("/treeselect")
    public AjaxResult treeselect(ZxPlantCategory category)
    {
        return success(categoryService.selectZxPlantCategoryTreeList(category));
    }

    @PreAuthorize("@ss.hasPermi('plant:category:query')")
    @GetMapping(value = "/{categoryId}")
    public AjaxResult getInfo(@PathVariable Long categoryId)
    {
        return success(categoryService.selectZxPlantCategoryById(categoryId));
    }

    @PreAuthorize("@ss.hasPermi('plant:category:add')")
    @Log(title = "植物分类", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody ZxPlantCategory category)
    {
        if (!categoryService.checkCategoryNameUnique(category))
        {
            return error("新增分类'" + category.getCategoryName() + "'失败，同级分类名称已存在");
        }
        category.setCreateBy(getUsername());
        return toAjax(categoryService.insertZxPlantCategory(category));
    }

    @PreAuthorize("@ss.hasPermi('plant:category:edit')")
    @Log(title = "植物分类", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody ZxPlantCategory category)
    {
        if (!categoryService.checkCategoryNameUnique(category))
        {
            return error("修改分类'" + category.getCategoryName() + "'失败，同级分类名称已存在");
        }
        else if (category.getCategoryId().equals(category.getParentId()))
        {
            return error("修改分类'" + category.getCategoryName() + "'失败，上级分类不能是自己");
        }
        else if (StringUtils.equals("1", category.getStatus()) && categoryService.selectNormalChildrenZxPlantCategoryById(category.getCategoryId()) > 0)
        {
            return error("该分类包含未停用的子分类，不允许直接停用");
        }
        category.setUpdateBy(getUsername());
        return toAjax(categoryService.updateZxPlantCategory(category));
    }

    @PreAuthorize("@ss.hasPermi('plant:category:remove')")
    @Log(title = "植物分类", businessType = BusinessType.DELETE)
    @DeleteMapping("/{categoryId}")
    public AjaxResult remove(@PathVariable Long categoryId)
    {
        if (categoryService.hasChildByCategoryId(categoryId))
        {
            return warn("存在下级分类，不允许删除");
        }
        if (categoryService.checkCategoryExistPlant(categoryId))
        {
            return warn("分类下存在植物数据，不允许删除");
        }
        return toAjax(categoryService.deleteZxPlantCategoryById(categoryId));
    }
}