package com.ruoyi.system.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.core.domain.TreeSelect;
import com.ruoyi.common.core.text.Convert;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.ZxPlantCategory;
import com.ruoyi.system.mapper.ZxPlantCategoryMapper;
import com.ruoyi.system.service.IZxPlantCategoryService;

/**
 * 植物分类Service实现
 */
@Service
public class ZxPlantCategoryServiceImpl implements IZxPlantCategoryService
{
    @Autowired
    private ZxPlantCategoryMapper categoryMapper;

    @Override
    public List<ZxPlantCategory> selectZxPlantCategoryList(ZxPlantCategory category)
    {
        return categoryMapper.selectZxPlantCategoryList(category);
    }

    @Override
    public List<TreeSelect> selectZxPlantCategoryTreeList(ZxPlantCategory category)
    {
        List<ZxPlantCategory> categories = selectZxPlantCategoryList(category);
        return buildZxPlantCategoryTreeSelect(categories);
    }

    @Override
    public List<ZxPlantCategory> buildZxPlantCategoryTree(List<ZxPlantCategory> categories)
    {
        List<ZxPlantCategory> returnList = new ArrayList<ZxPlantCategory>();
        List<Long> categoryIds = categories.stream().map(ZxPlantCategory::getCategoryId).collect(Collectors.toList());
        for (ZxPlantCategory category : categories)
        {
            if (!categoryIds.contains(category.getParentId()))
            {
                recursionFn(categories, category);
                returnList.add(category);
            }
        }
        if (returnList.isEmpty())
        {
            returnList = categories;
        }
        return returnList;
    }

    @Override
    public List<TreeSelect> buildZxPlantCategoryTreeSelect(List<ZxPlantCategory> categories)
    {
        List<ZxPlantCategory> categoryTrees = buildZxPlantCategoryTree(categories);
        return categoryTrees.stream().map(this::buildTreeSelect).collect(Collectors.toList());
    }

    @Override
    public ZxPlantCategory selectZxPlantCategoryById(Long categoryId)
    {
        return categoryMapper.selectZxPlantCategoryById(categoryId);
    }

    @Override
    public int selectNormalChildrenZxPlantCategoryById(Long categoryId)
    {
        return categoryMapper.selectNormalChildrenZxPlantCategoryById(categoryId);
    }

    @Override
    public boolean hasChildByCategoryId(Long categoryId)
    {
        return categoryMapper.hasChildByCategoryId(categoryId) > 0;
    }

    @Override
    public boolean checkCategoryExistPlant(Long categoryId)
    {
        return categoryMapper.checkCategoryExistPlant(categoryId) > 0;
    }

    @Override
    public boolean checkCategoryNameUnique(ZxPlantCategory category)
    {
        Long categoryId = StringUtils.isNull(category.getCategoryId()) ? -1L : category.getCategoryId();
        Long parentId = StringUtils.isNull(category.getParentId()) ? 0L : category.getParentId();
        ZxPlantCategory info = categoryMapper.checkCategoryNameUnique(category.getCategoryName(), parentId);
        if (StringUtils.isNotNull(info) && info.getCategoryId().longValue() != categoryId.longValue())
        {
            return false;
        }
        return true;
    }

    @Override
    @Transactional
    public int insertZxPlantCategory(ZxPlantCategory category)
    {
        Long parentId = StringUtils.isNull(category.getParentId()) ? 0L : category.getParentId();
        category.setParentId(parentId);
        if (parentId.longValue() == 0L)
        {
            category.setAncestors("0");
        }
        else
        {
            ZxPlantCategory parentCategory = categoryMapper.selectZxPlantCategoryById(parentId);
            if (StringUtils.isNull(parentCategory))
            {
                throw new ServiceException("上级分类不存在");
            }
            if (!StringUtils.equals("0", parentCategory.getStatus()))
            {
                throw new ServiceException("分类停用，不允许新增子分类");
            }
            category.setAncestors(parentCategory.getAncestors() + "," + parentCategory.getCategoryId());
        }
        return categoryMapper.insertZxPlantCategory(category);
    }

    @Override
    @Transactional
    public int updateZxPlantCategory(ZxPlantCategory category)
    {
        Long parentId = StringUtils.isNull(category.getParentId()) ? 0L : category.getParentId();
        category.setParentId(parentId);
        ZxPlantCategory oldCategory = categoryMapper.selectZxPlantCategoryById(category.getCategoryId());
        if (StringUtils.isNull(oldCategory))
        {
            throw new ServiceException("分类不存在");
        }

        String newAncestors = "0";
        if (parentId.longValue() != 0L)
        {
            ZxPlantCategory newParentCategory = categoryMapper.selectZxPlantCategoryById(parentId);
            if (StringUtils.isNull(newParentCategory))
            {
                throw new ServiceException("上级分类不存在");
            }
            newAncestors = newParentCategory.getAncestors() + "," + newParentCategory.getCategoryId();
        }

        String oldAncestors = oldCategory.getAncestors();
        category.setAncestors(newAncestors);
        updateCategoryChildren(category.getCategoryId(), newAncestors, oldAncestors);

        int result = categoryMapper.updateZxPlantCategory(category);
        if (StringUtils.equals("0", category.getStatus()) && StringUtils.isNotEmpty(category.getAncestors())
            && !StringUtils.equals("0", category.getAncestors()))
        {
            updateParentCategoryStatusNormal(category);
        }
        return result;
    }

    @Override
    public int deleteZxPlantCategoryById(Long categoryId)
    {
        return categoryMapper.deleteZxPlantCategoryById(categoryId);
    }

    private void updateParentCategoryStatusNormal(ZxPlantCategory category)
    {
        Long[] categoryIds = Convert.toLongArray(category.getAncestors());
        if (StringUtils.isNotEmpty(categoryIds))
        {
            categoryMapper.updateCategoryStatusNormal(categoryIds);
        }
    }

    private void updateCategoryChildren(Long categoryId, String newAncestors, String oldAncestors)
    {
        List<ZxPlantCategory> children = categoryMapper.selectChildrenZxPlantCategoryById(categoryId);
        for (ZxPlantCategory child : children)
        {
            child.setAncestors(child.getAncestors().replaceFirst(oldAncestors, newAncestors));
        }
        if (!children.isEmpty())
        {
            categoryMapper.updateZxPlantCategoryChildren(children);
        }
    }

    private void recursionFn(List<ZxPlantCategory> list, ZxPlantCategory category)
    {
        List<ZxPlantCategory> childList = getChildList(list, category);
        category.setChildren(childList);
        for (ZxPlantCategory child : childList)
        {
            if (hasChild(list, child))
            {
                recursionFn(list, child);
            }
        }
    }

    private List<ZxPlantCategory> getChildList(List<ZxPlantCategory> list, ZxPlantCategory category)
    {
        List<ZxPlantCategory> childList = new ArrayList<ZxPlantCategory>();
        for (ZxPlantCategory item : list)
        {
            if (StringUtils.isNotNull(item.getParentId()) && item.getParentId().longValue() == category.getCategoryId().longValue())
            {
                childList.add(item);
            }
        }
        return childList;
    }

    private boolean hasChild(List<ZxPlantCategory> list, ZxPlantCategory category)
    {
        return !getChildList(list, category).isEmpty();
    }

    private TreeSelect buildTreeSelect(ZxPlantCategory category)
    {
        TreeSelect treeSelect = new TreeSelect();
        treeSelect.setId(category.getCategoryId());
        treeSelect.setLabel(category.getCategoryName());
        treeSelect.setDisabled(StringUtils.equals("1", category.getStatus()));
        treeSelect.setChildren(category.getChildren().stream().map(this::buildTreeSelect).collect(Collectors.toList()));
        return treeSelect;
    }
}