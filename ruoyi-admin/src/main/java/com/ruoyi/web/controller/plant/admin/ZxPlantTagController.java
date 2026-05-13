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
import com.ruoyi.system.domain.ZxPlantTag;
import com.ruoyi.system.service.IZxPlantTagService;

@RestController
@RequestMapping("/plant/admin/tag")
public class ZxPlantTagController extends BaseController
{
    @Autowired
    private IZxPlantTagService tagService;

    @PreAuthorize("@ss.hasPermi('plant:tag:list')")
    @GetMapping("/list")
    public TableDataInfo list(ZxPlantTag tag)
    {
        startPage();
        List<ZxPlantTag> list = tagService.selectZxPlantTagList(tag);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('plant:tag:query')")
    @GetMapping(value = "/{tagId}")
    public AjaxResult getInfo(@PathVariable Long tagId)
    {
        return success(tagService.selectZxPlantTagById(tagId));
    }

    @PreAuthorize("@ss.hasPermi('plant:tag:add')")
    @Log(title = "标签字典", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody ZxPlantTag tag)
    {
        if (!tagService.checkTagCodeUnique(tag))
        {
            return error("新增标签'" + tag.getTagName() + "'失败，标签编码已存在");
        }
        tag.setCreateBy(getUsername());
        return toAjax(tagService.insertZxPlantTag(tag));
    }

    @PreAuthorize("@ss.hasPermi('plant:tag:edit')")
    @Log(title = "标签字典", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody ZxPlantTag tag)
    {
        if (!tagService.checkTagCodeUnique(tag))
        {
            return error("修改标签'" + tag.getTagName() + "'失败，标签编码已存在");
        }
        tag.setUpdateBy(getUsername());
        return toAjax(tagService.updateZxPlantTag(tag));
    }

    @PreAuthorize("@ss.hasPermi('plant:tag:remove')")
    @Log(title = "标签字典", businessType = BusinessType.DELETE)
    @DeleteMapping("/{tagIds}")
    public AjaxResult remove(@PathVariable Long[] tagIds)
    {
        return toAjax(tagService.deleteZxPlantTagByIds(tagIds));
    }
}