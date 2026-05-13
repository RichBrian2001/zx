package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.ZxDataImportTask;

public interface ZxDataImportTaskMapper
{
    public List<ZxDataImportTask> selectZxDataImportTaskList(ZxDataImportTask task);

    public ZxDataImportTask selectZxDataImportTaskById(Long taskId);

    public int insertZxDataImportTask(ZxDataImportTask task);

    public int updateZxDataImportTask(ZxDataImportTask task);
}