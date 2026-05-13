package com.ruoyi.system.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.system.domain.ZxFavoriteRecord;

public interface ZxFavoriteRecordMapper
{
    public List<ZxFavoriteRecord> selectZxFavoriteRecordList(ZxFavoriteRecord favorite);

    public ZxFavoriteRecord selectActiveFavorite(@Param("visitorUid") String visitorUid, @Param("plantId") Long plantId);

    public int insertZxFavoriteRecord(ZxFavoriteRecord favorite);

    public int cancelFavorite(@Param("visitorUid") String visitorUid, @Param("plantId") Long plantId);
}