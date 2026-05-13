package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.ZxUserProfile;

public interface ZxUserProfileMapper
{
    public List<ZxUserProfile> selectZxUserProfileList(ZxUserProfile profile);

    public ZxUserProfile selectZxUserProfileById(Long profileId);

    public ZxUserProfile selectZxUserProfileByVisitorUid(String visitorUid);

    public int insertZxUserProfile(ZxUserProfile profile);

    public int updateZxUserProfile(ZxUserProfile profile);
}