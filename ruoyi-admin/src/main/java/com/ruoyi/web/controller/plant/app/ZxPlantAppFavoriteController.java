package com.ruoyi.web.controller.plant.app;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.system.domain.ZxFavoriteRecord;
import com.ruoyi.system.service.IZxFavoriteRecordService;

@Anonymous
@RestController
@RequestMapping("/plant/app/favorite")
public class ZxPlantAppFavoriteController extends BaseController
{
    @Autowired
    private IZxFavoriteRecordService favoriteRecordService;

    @GetMapping("/list")
    public AjaxResult list(@RequestParam String visitorUid)
    {
        return success(favoriteRecordService.selectZxFavoriteRecordList(visitorUid));
    }

    @PostMapping
    public AjaxResult add(@RequestBody ZxFavoriteRecord favorite)
    {
        return toAjax(favoriteRecordService.insertZxFavoriteRecord(favorite));
    }

    @DeleteMapping("/{plantId}")
    public AjaxResult remove(@PathVariable Long plantId, @RequestParam String visitorUid)
    {
        return toAjax(favoriteRecordService.cancelFavorite(visitorUid, plantId));
    }
}