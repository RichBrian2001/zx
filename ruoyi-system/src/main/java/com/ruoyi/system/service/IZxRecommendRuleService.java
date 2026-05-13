package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.ZxRecommendRule;

public interface IZxRecommendRuleService
{
    public ZxRecommendRule selectZxRecommendRuleById(Long ruleId);

    public List<ZxRecommendRule> selectZxRecommendRuleList(ZxRecommendRule rule);

    public boolean checkRuleCodeUnique(ZxRecommendRule rule);

    public int insertZxRecommendRule(ZxRecommendRule rule);

    public int updateZxRecommendRule(ZxRecommendRule rule);

    public int updateZxRecommendRuleStatus(ZxRecommendRule rule);

    public int deleteZxRecommendRuleByIds(Long[] ruleIds);
}