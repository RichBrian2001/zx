package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.ZxFavoriteRecord;

public interface IZxFavoriteRecordService
{
    public List<ZxFavoriteRecord> selectZxFavoriteRecordList(String visitorUid);

    public int insertZxFavoriteRecord(ZxFavoriteRecord favorite);

    public int cancelFavorite(String visitorUid, Long plantId);
}