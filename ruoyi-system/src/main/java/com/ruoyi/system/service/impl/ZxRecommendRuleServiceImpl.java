package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.ZxRecommendRule;
import com.ruoyi.system.mapper.ZxRecommendRuleMapper;
import com.ruoyi.system.service.IZxRecommendRuleService;

@Service
public class ZxRecommendRuleServiceImpl implements IZxRecommendRuleService
{
    @Autowired
    private ZxRecommendRuleMapper ruleMapper;

    @Override
    public ZxRecommendRule selectZxRecommendRuleById(Long ruleId)
    {
        return ruleMapper.selectZxRecommendRuleById(ruleId);
    }

    @Override
    public List<ZxRecommendRule> selectZxRecommendRuleList(ZxRecommendRule rule)
    {
        return ruleMapper.selectZxRecommendRuleList(rule);
    }

    @Override
    public boolean checkRuleCodeUnique(ZxRecommendRule rule)
    {
        Long ruleId = StringUtils.isNull(rule.getRuleId()) ? -1L : rule.getRuleId();
        ZxRecommendRule info = ruleMapper.checkRuleCodeUnique(rule.getRuleCode());
        if (StringUtils.isNotNull(info) && info.getRuleId().longValue() != ruleId.longValue())
        {
            return false;
        }
        return true;
    }

    @Override
    public int insertZxRecommendRule(ZxRecommendRule rule)
    {
        return ruleMapper.insertZxRecommendRule(rule);
    }

    @Override
    public int updateZxRecommendRule(ZxRecommendRule rule)
    {
        return ruleMapper.updateZxRecommendRule(rule);
    }

    @Override
    public int updateZxRecommendRuleStatus(ZxRecommendRule rule)
    {
        return ruleMapper.updateZxRecommendRuleStatus(rule);
    }

    @Override
    public int deleteZxRecommendRuleByIds(Long[] ruleIds)
    {
        return ruleMapper.deleteZxRecommendRuleByIds(ruleIds);
    }
}