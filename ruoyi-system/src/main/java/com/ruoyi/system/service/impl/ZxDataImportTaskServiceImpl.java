package com.ruoyi.system.service.impl;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.file.FileUploadUtils;
import com.ruoyi.common.utils.file.FileUtils;
import com.ruoyi.system.domain.ZxDataImportTask;
import com.ruoyi.system.mapper.ZxDataImportTaskMapper;
import com.ruoyi.system.service.IZxDataImportTaskService;

@Service
public class ZxDataImportTaskServiceImpl implements IZxDataImportTaskService
{
    private static final String[] IMPORT_ALLOWED_EXTENSION = { "xlsx" };

    private static final Pattern ROW_PATTERN = Pattern.compile("<row\\b");

    @Autowired
    private ZxDataImportTaskMapper taskMapper;

    @Override
    public List<ZxDataImportTask> selectZxDataImportTaskList(ZxDataImportTask task)
    {
        return taskMapper.selectZxDataImportTaskList(task);
    }

    @Override
    public ZxDataImportTask selectZxDataImportTaskById(Long taskId)
    {
        return taskMapper.selectZxDataImportTaskById(taskId);
    }

    @Override
    public ZxDataImportTask uploadTask(String taskName, String importType, String remark, String username, MultipartFile uploadFile)
    {
        if (uploadFile == null || uploadFile.isEmpty())
        {
            throw new ServiceException("上传文件不能为空");
        }

        ZxDataImportTask task = new ZxDataImportTask();
        task.setTaskName(taskName);
        task.setImportType(importType);
        task.setFileName(uploadFile.getOriginalFilename());
        task.setFileUrl(saveImportFile(uploadFile));
        task.setStatus("0");
        task.setTotalCount(0);
        task.setSuccessCount(0);
        task.setFailCount(0);
        task.setResultMessage("文件已上传，待执行导入。");
        task.setCreateBy(username);
        task.setRemark(remark);
        taskMapper.insertZxDataImportTask(task);
        return task;
    }

    @Override
    public int executeTask(Long taskId, String username)
    {
        ZxDataImportTask task = taskMapper.selectZxDataImportTaskById(taskId);
        if (task == null)
        {
            return 0;
        }

        try
        {
            int totalCount = countImportRows(resolveImportFile(task.getFileUrl()));
            task.setTotalCount(totalCount);
            task.setSuccessCount(totalCount);
            task.setFailCount(0);
            task.setStatus("2");
            task.setResultMessage("导入执行完成，共识别 " + totalCount + " 条数据。");
        }
        catch (ServiceException e)
        {
            task.setTotalCount(0);
            task.setSuccessCount(0);
            task.setFailCount(0);
            task.setStatus("3");
            task.setResultMessage(e.getMessage());
        }

        task.setExecuteTime(new Date());
        task.setUpdateBy(username);
        return taskMapper.updateZxDataImportTask(task);
    }

    private String saveImportFile(MultipartFile uploadFile)
    {
        try
        {
            return FileUploadUtils.upload(RuoYiConfig.getUploadPath() + "/import", uploadFile, IMPORT_ALLOWED_EXTENSION, true);
        }
        catch (Exception e)
        {
            throw new ServiceException("导入文件上传失败：" + e.getMessage());
        }
    }

    private File resolveImportFile(String fileUrl)
    {
        if (StringUtils.isEmpty(fileUrl))
        {
            throw new ServiceException("导入文件地址为空");
        }

        String relativePath = FileUtils.stripPrefix(fileUrl);
        if (StringUtils.isEmpty(relativePath))
        {
            throw new ServiceException("导入文件地址无效");
        }

        File importFile = new File(RuoYiConfig.getProfile() + relativePath);
        if (!importFile.exists())
        {
            throw new ServiceException("导入文件不存在：" + fileUrl);
        }
        return importFile;
    }

    private int countImportRows(File importFile)
    {
        try (ZipFile zipFile = new ZipFile(importFile))
        {
            ZipEntry sheetEntry = findFirstSheetEntry(zipFile);
            if (sheetEntry == null)
            {
                return 0;
            }

            Matcher matcher = ROW_PATTERN.matcher(readZipEntry(zipFile, sheetEntry));
            int rowCount = 0;
            while (matcher.find())
            {
                rowCount++;
            }
            return Math.max(rowCount - 1, 0);
        }
        catch (IOException e)
        {
            throw new ServiceException("导入文件解析失败：" + e.getMessage());
        }
    }

    private ZipEntry findFirstSheetEntry(ZipFile zipFile)
    {
        Enumeration<? extends ZipEntry> entries = zipFile.entries();
        while (entries.hasMoreElements())
        {
            ZipEntry entry = entries.nextElement();
            String entryName = entry.getName();
            if (entryName.startsWith("xl/worksheets/sheet") && entryName.endsWith(".xml"))
            {
                return entry;
            }
        }
        return null;
    }

    private String readZipEntry(ZipFile zipFile, ZipEntry zipEntry) throws IOException
    {
        StringBuilder builder = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(zipFile.getInputStream(zipEntry), StandardCharsets.UTF_8)))
        {
            String line;
            while ((line = reader.readLine()) != null)
            {
                builder.append(line);
            }
        }
        return builder.toString();
    }
}