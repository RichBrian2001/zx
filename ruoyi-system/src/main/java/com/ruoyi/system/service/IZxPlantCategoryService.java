package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.common.core.domain.TreeSelect;
import com.ruoyi.system.domain.ZxPlantCategory;

/**
 * 植物分类Service接口
 */
public interface IZxPlantCategoryService
{
    public List<ZxPlantCategory> selectZxPlantCategoryList(ZxPlantCategory category);

    public List<TreeSelect> selectZxPlantCategoryTreeList(ZxPlantCategory category);

    public List<ZxPlantCategory> buildZxPlantCategoryTree(List<ZxPlantCategory> categories);

    public List<TreeSelect> buildZxPlantCategoryTreeSelect(List<ZxPlantCategory> categories);

    public ZxPlantCategory selectZxPlantCategoryById(Long categoryId);

    public int selectNormalChildrenZxPlantCategoryById(Long categoryId);

    public boolean hasChildByCategoryId(Long categoryId);

    public boolean checkCategoryExistPlant(Long categoryId);

    public boolean checkCategoryNameUnique(ZxPlantCategory category);

    public int insertZxPlantCategory(ZxPlantCategory category);

    public int updateZxPlantCategory(ZxPlantCategory category);

    public int deleteZxPlantCategoryById(Long categoryId);
}