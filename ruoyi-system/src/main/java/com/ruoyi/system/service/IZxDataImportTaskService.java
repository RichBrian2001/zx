package com.ruoyi.system.service;

import java.util.List;
import org.springframework.web.multipart.MultipartFile;
import com.ruoyi.system.domain.ZxDataImportTask;

public interface IZxDataImportTaskService
{
    public List<ZxDataImportTask> selectZxDataImportTaskList(ZxDataImportTask task);

    public ZxDataImportTask selectZxDataImportTaskById(Long taskId);

    public ZxDataImportTask uploadTask(String taskName, String importType, String remark, String username, MultipartFile uploadFile);

    public int executeTask(Long taskId, String username);
}