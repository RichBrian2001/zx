package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.ZxFavoriteRecord;
import com.ruoyi.system.mapper.ZxFavoriteRecordMapper;
import com.ruoyi.system.service.IZxFavoriteRecordService;

@Service
public class ZxFavoriteRecordServiceImpl implements IZxFavoriteRecordService
{
    @Autowired
    private ZxFavoriteRecordMapper favoriteRecordMapper;

    @Override
    public List<ZxFavoriteRecord> selectZxFavoriteRecordList(String visitorUid)
    {
        ZxFavoriteRecord favorite = new ZxFavoriteRecord();
        favorite.setVisitorUid(visitorUid);
        return favoriteRecordMapper.selectZxFavoriteRecordList(favorite);
    }

    @Override
    public int insertZxFavoriteRecord(ZxFavoriteRecord favorite)
    {
        ZxFavoriteRecord exists = favoriteRecordMapper.selectActiveFavorite(favorite.getVisitorUid(), favorite.getPlantId());
        if (exists != null)
        {
            return 1;
        }
        favorite.setStatus("0");
        return favoriteRecordMapper.insertZxFavoriteRecord(favorite);
    }

    @Override
    public int cancelFavorite(String visitorUid, Long plantId)
    {
        return favoriteRecordMapper.cancelFavorite(visitorUid, plantId);
    }
}