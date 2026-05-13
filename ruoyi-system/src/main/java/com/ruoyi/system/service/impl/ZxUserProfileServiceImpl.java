package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.ZxRecommendRecord;
import com.ruoyi.system.domain.ZxUserProfile;
import com.ruoyi.system.mapper.ZxRecommendRecordMapper;
import com.ruoyi.system.mapper.ZxUserProfileMapper;
import com.ruoyi.system.service.IZxUserProfileService;

@Service
public class ZxUserProfileServiceImpl implements IZxUserProfileService
{
    @Autowired
    private ZxUserProfileMapper profileMapper;

    @Autowired
    private ZxRecommendRecordMapper recommendRecordMapper;

    @Override
    public List<ZxUserProfile> selectZxUserProfileList(ZxUserProfile profile)
    {
        return profileMapper.selectZxUserProfileList(profile);
    }

    @Override
    public ZxUserProfile selectZxUserProfileById(Long profileId)
    {
        ZxUserProfile profile = profileMapper.selectZxUserProfileById(profileId);
        if (profile != null)
        {
            ZxRecommendRecord query = new ZxRecommendRecord();
            query.setProfileId(profileId);
            profile.setRecentRecommendList(recommendRecordMapper.selectZxRecommendRecordList(query));
        }
        return profile;
    }
}