package com.ruoyi.system.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.system.domain.ZxPlantCategory;

/**
 * 植物分类Mapper接口
 */
public interface ZxPlantCategoryMapper
{
    public List<ZxPlantCategory> selectZxPlantCategoryList(ZxPlantCategory category);

    public ZxPlantCategory selectZxPlantCategoryById(Long categoryId);

    public List<ZxPlantCategory> selectChildrenZxPlantCategoryById(Long categoryId);

    public int selectNormalChildrenZxPlantCategoryById(Long categoryId);

    public int hasChildByCategoryId(Long categoryId);

    public int checkCategoryExistPlant(Long categoryId);

    public ZxPlantCategory checkCategoryNameUnique(@Param("categoryName") String categoryName, @Param("parentId") Long parentId);

    public int insertZxPlantCategory(ZxPlantCategory category);

    public int updateZxPlantCategory(ZxPlantCategory category);

    public int updateZxPlantCategoryChildren(@Param("categories") List<ZxPlantCategory> categories);

    public int updateCategoryStatusNormal(Long[] categoryIds);

    public int deleteZxPlantCategoryById(Long categoryId);
}