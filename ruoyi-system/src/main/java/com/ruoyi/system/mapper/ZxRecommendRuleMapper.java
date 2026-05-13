package com.ruoyi.system.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.system.domain.ZxRecommendRule;

public interface ZxRecommendRuleMapper
{
    public ZxRecommendRule selectZxRecommendRuleById(Long ruleId);

    public List<ZxRecommendRule> selectZxRecommendRuleList(ZxRecommendRule rule);

    public ZxRecommendRule checkRuleCodeUnique(@Param("ruleCode") String ruleCode);

    public int insertZxRecommendRule(ZxRecommendRule rule);

    public int updateZxRecommendRule(ZxRecommendRule rule);

    public int updateZxRecommendRuleStatus(ZxRecommendRule rule);

    public int deleteZxRecommendRuleByIds(Long[] ruleIds);
}