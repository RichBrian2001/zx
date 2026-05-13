package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.ZxUserProfile;

public interface IZxUserProfileService
{
    public List<ZxUserProfile> selectZxUserProfileList(ZxUserProfile profile);

    public ZxUserProfile selectZxUserProfileById(Long profileId);
}