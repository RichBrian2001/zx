package com.ruoyi.web.controller.plant.admin;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.system.domain.ZxUserProfile;
import com.ruoyi.system.service.IZxUserProfileService;

@RestController
@RequestMapping("/plant/admin/profile")
public class ZxUserProfileController extends BaseController
{
    @Autowired
    private IZxUserProfileService profileService;

    @PreAuthorize("@ss.hasPermi('plant:profile:list')")
    @GetMapping("/list")
    public TableDataInfo list(ZxUserProfile profile)
    {
        startPage();
        List<ZxUserProfile> list = profileService.selectZxUserProfileList(profile);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('plant:profile:detail')")
    @GetMapping(value = "/{profileId}")
    public AjaxResult getInfo(@PathVariable Long profileId)
    {
        return success(profileService.selectZxUserProfileById(profileId));
    }
}