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
import com.ruoyi.system.domain.ZxRecommendRule;
import com.ruoyi.system.service.IZxRecommendRuleService;

@RestController
@RequestMapping("/plant/admin/rule")
public class ZxRecommendRuleController extends BaseController
{
    @Autowired
    private IZxRecommendRuleService ruleService;

    @PreAuthorize("@ss.hasPermi('plant:rule:list')")
    @GetMapping("/list")
    public TableDataInfo list(ZxRecommendRule rule)
    {
        startPage();
        List<ZxRecommendRule> list = ruleService.selectZxRecommendRuleList(rule);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('plant:rule:query')")
    @GetMapping(value = "/{ruleId}")
    public AjaxResult getInfo(@PathVariable Long ruleId)
    {
        return success(ruleService.selectZxRecommendRuleById(ruleId));
    }

    @PreAuthorize("@ss.hasPermi('plant:rule:add')")
    @Log(title = "推荐规则", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody ZxRecommendRule rule)
    {
        if (!ruleService.checkRuleCodeUnique(rule))
        {
            return error("新增规则'" + rule.getRuleName() + "'失败，规则编码已存在");
        }
        rule.setCreateBy(getUsername());
        return toAjax(ruleService.insertZxRecommendRule(rule));
    }

    @PreAuthorize("@ss.hasPermi('plant:rule:edit')")
    @Log(title = "推荐规则", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody ZxRecommendRule rule)
    {
        if (!ruleService.checkRuleCodeUnique(rule))
        {
            return error("修改规则'" + rule.getRuleName() + "'失败，规则编码已存在");
        }
        rule.setUpdateBy(getUsername());
        return toAjax(ruleService.updateZxRecommendRule(rule));
    }

    @PreAuthorize("@ss.hasPermi('plant:rule:edit')")
    @Log(title = "推荐规则状态", businessType = BusinessType.UPDATE)
    @PutMapping("/changeStatus")
    public AjaxResult changeStatus(@RequestBody ZxRecommendRule rule)
    {
        rule.setUpdateBy(getUsername());
        return toAjax(ruleService.updateZxRecommendRuleStatus(rule));
    }

    @PreAuthorize("@ss.hasPermi('plant:rule:remove')")
    @Log(title = "推荐规则", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ruleIds}")
    public AjaxResult remove(@PathVariable Long[] ruleIds)
    {
        return toAjax(ruleService.deleteZxRecommendRuleByIds(ruleIds));
    }
}