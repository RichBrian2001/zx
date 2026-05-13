<template>
  <div class="app-container">
    <el-form ref="queryForm" :model="queryParams" size="small" :inline="true" v-show="showSearch" label-width="96px">
      <el-form-item label="任务名称" prop="taskName">
        <el-input
          v-model="queryParams.taskName"
          placeholder="请输入任务名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="导入类型" prop="importType">
        <el-select v-model="queryParams.importType" placeholder="请选择导入类型" clearable>
          <el-option
            v-for="item in importTypeOptions"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="任务状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择任务状态" clearable>
          <el-option
            v-for="item in statusOptions"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="执行时间" prop="dateRange">
        <el-date-picker
          v-model="dateRange"
          type="datetimerange"
          value-format="yyyy-MM-dd HH:mm:ss"
          range-separator="-"
          start-placeholder="开始时间"
          end-placeholder="结束时间"
          style="width: 360px"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-upload2"
          size="mini"
          @click="openUploadDialog"
          v-hasPermi="['plant:import:upload']"
        >上传任务</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-caret-right"
          size="mini"
          :disabled="single"
          @click="handleExecute()"
          v-hasPermi="['plant:import:execute']"
        >执行导入</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <div class="import-helper mb8">
      <span class="helper-label">示例模板</span>
      <el-link
        v-for="item in importTypeOptions"
        :key="item.value"
        :href="resourceUrl(item.templateUrl)"
        :underline="false"
        type="primary"
        target="_blank"
      >{{ item.templateLabel }}</el-link>
    </div>

    <el-table v-loading="loading" :data="taskList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="任务编号" align="center" width="110">
        <template slot-scope="scope">
          <el-button
            v-if="hasPermission(['plant:import:detail'])"
            type="text"
            @click="handleDetail(scope.row)"
          >{{ scope.row.taskId }}</el-button>
          <span v-else>{{ scope.row.taskId }}</span>
        </template>
      </el-table-column>
      <el-table-column label="任务名称" align="center" prop="taskName" min-width="160" show-overflow-tooltip />
      <el-table-column label="导入类型" align="center" min-width="130">
        <template slot-scope="scope">
          <span>{{ formatOptionLabel(scope.row.importType, importTypeOptions) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="文件名" align="center" prop="fileName" min-width="180" show-overflow-tooltip />
      <el-table-column label="文件地址" align="center" min-width="120">
        <template slot-scope="scope">
          <el-link
            v-if="scope.row.fileUrl"
            :href="resourceUrl(scope.row.fileUrl)"
            :underline="false"
            type="primary"
            target="_blank"
          >查看文件</el-link>
          <span v-else>-</span>
        </template>
      </el-table-column>
      <el-table-column label="总数" align="center" prop="totalCount" width="80" />
      <el-table-column label="成功数" align="center" prop="successCount" width="90" />
      <el-table-column label="失败数" align="center" prop="failCount" width="90" />
      <el-table-column label="状态" align="center" width="100">
        <template slot-scope="scope">
          <el-tag :type="statusTagType(scope.row.status)" size="small">
            {{ formatOptionLabel(scope.row.status, statusOptions) }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="结果说明" align="center" prop="resultMessage" min-width="260" show-overflow-tooltip />
      <el-table-column label="执行时间" align="center" prop="executeTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.executeTime) || '-' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) || '-' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="180">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-caret-right"
            @click="handleExecute(scope.row)"
            v-hasPermi="['plant:import:execute']"
          >执行</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-view"
            @click="handleDetail(scope.row)"
            v-hasPermi="['plant:import:detail']"
          >详情</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total > 0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <el-dialog title="上传导入任务" :visible.sync="uploadOpen" width="680px" append-to-body>
      <el-form ref="uploadForm" :model="uploadForm" :rules="uploadRules" label-width="96px">
        <el-form-item label="任务名称" prop="taskName">
          <el-input v-model="uploadForm.taskName" placeholder="请输入任务名称" />
        </el-form-item>
        <el-form-item label="导入类型" prop="importType">
          <el-select v-model="uploadForm.importType" placeholder="请选择导入类型" style="width: 100%">
            <el-option
              v-for="item in importTypeOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="上传文件" required>
          <el-upload
            ref="uploader"
            action="#"
            accept=".xlsx"
            :auto-upload="false"
            :limit="1"
            :file-list="uploadFileList"
            :on-change="handleUploadChange"
            :on-remove="handleUploadRemove"
            :on-exceed="handleUploadExceed"
          >
            <el-button size="mini" type="primary" plain>选择 xlsx 文件</el-button>
            <div slot="tip" class="el-upload__tip">
              仅支持 .xlsx 文件。可先下载上方示例模板，再按对应导入类型上传。
            </div>
          </el-upload>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="uploadForm.remark" type="textarea" :rows="3" placeholder="请输入备注" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" :loading="uploading" @click="submitUpload">确 定</el-button>
        <el-button @click="closeUploadDialog">取 消</el-button>
      </div>
    </el-dialog>

    <el-dialog title="任务详情" :visible.sync="detailOpen" width="820px" append-to-body>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="任务编号">{{ detail.taskId || '-' }}</el-descriptions-item>
        <el-descriptions-item label="任务名称">{{ detail.taskName || '-' }}</el-descriptions-item>
        <el-descriptions-item label="导入类型">{{ formatOptionLabel(detail.importType, importTypeOptions) }}</el-descriptions-item>
        <el-descriptions-item label="任务状态">{{ formatOptionLabel(detail.status, statusOptions) }}</el-descriptions-item>
        <el-descriptions-item label="文件名">{{ detail.fileName || '-' }}</el-descriptions-item>
        <el-descriptions-item label="文件地址">
          <el-link
            v-if="detail.fileUrl"
            :href="resourceUrl(detail.fileUrl)"
            :underline="false"
            type="primary"
            target="_blank"
          >{{ detail.fileUrl }}</el-link>
          <span v-else>-</span>
        </el-descriptions-item>
        <el-descriptions-item label="总数">{{ detail.totalCount !== undefined && detail.totalCount !== null ? detail.totalCount : '-' }}</el-descriptions-item>
        <el-descriptions-item label="成功数">{{ detail.successCount !== undefined && detail.successCount !== null ? detail.successCount : '-' }}</el-descriptions-item>
        <el-descriptions-item label="失败数">{{ detail.failCount !== undefined && detail.failCount !== null ? detail.failCount : '-' }}</el-descriptions-item>
        <el-descriptions-item label="执行时间">{{ parseTime(detail.executeTime) || '-' }}</el-descriptions-item>
        <el-descriptions-item label="创建人">{{ detail.createBy || '-' }}</el-descriptions-item>
        <el-descriptions-item label="创建时间">{{ parseTime(detail.createTime) || '-' }}</el-descriptions-item>
        <el-descriptions-item label="更新人">{{ detail.updateBy || '-' }}</el-descriptions-item>
        <el-descriptions-item label="更新时间">{{ parseTime(detail.updateTime) || '-' }}</el-descriptions-item>
        <el-descriptions-item label="结果说明" :span="2">{{ detail.resultMessage || '-' }}</el-descriptions-item>
        <el-descriptions-item label="备注" :span="2">{{ detail.remark || '-' }}</el-descriptions-item>
      </el-descriptions>
      <div slot="footer" class="dialog-footer">
        <el-button @click="detailOpen = false">关 闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { executeImportTask, getImportTask, listImportTask, uploadImportTask } from '@/api/plant/import'
import { checkPermi } from '@/utils/permission'

export default {
  name: 'PlantAdminImport',
  data() {
    return {
      loading: true,
      uploading: false,
      showSearch: true,
      total: 0,
      ids: [],
      single: true,
      multiple: true,
      uploadOpen: false,
      detailOpen: false,
      dateRange: [],
      uploadFileList: [],
      taskList: [],
      importTypeOptions: [
        { label: '植物主数据', value: 'plant_basic', templateLabel: '植物主数据模板', templateUrl: '/profile/upload/import/plant_basic_demo.xlsx' },
        { label: '标签字典', value: 'tag_basic', templateLabel: '标签字典模板', templateUrl: '/profile/upload/import/plant_tag_demo.xlsx' }
      ],
      statusOptions: [
        { label: '待处理', value: '0' },
        { label: '处理中', value: '1' },
        { label: '已完成', value: '2' },
        { label: '失败', value: '3' }
      ],
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        taskName: undefined,
        importType: undefined,
        status: undefined
      },
      uploadForm: {
        taskName: undefined,
        importType: undefined,
        uploadFile: undefined,
        remark: undefined
      },
      detail: {},
      uploadRules: {
        taskName: [
          { required: true, message: '任务名称不能为空', trigger: 'blur' }
        ],
        importType: [
          { required: true, message: '导入类型不能为空', trigger: 'change' }
        ]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.loading = true
      listImportTask(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
        this.taskList = response.rows
        this.total = response.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    hasPermission(value) {
      return checkPermi(value)
    },
    formatOptionLabel(value, options) {
      const option = options.find(item => item.value === value)
      return option ? option.label : value || '-'
    },
    statusTagType(status) {
      if (status === '2') {
        return 'success'
      }
      if (status === '3') {
        return 'danger'
      }
      if (status === '1') {
        return 'warning'
      }
      return 'info'
    },
    resourceUrl(resource) {
      return process.env.VUE_APP_BASE_API + resource
    },
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    resetQuery() {
      this.dateRange = []
      this.resetForm('queryForm')
      this.handleQuery()
    },
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.taskId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    openUploadDialog() {
      this.resetUploadForm()
      this.uploadOpen = true
    },
    closeUploadDialog() {
      this.uploadOpen = false
      this.resetUploadForm()
    },
    resetUploadForm() {
      this.uploadForm = {
        taskName: undefined,
        importType: undefined,
        uploadFile: undefined,
        remark: undefined
      }
      this.uploadFileList = []
      this.$nextTick(() => {
        this.resetForm('uploadForm')
        if (this.$refs.uploader) {
          this.$refs.uploader.clearFiles()
        }
      })
    },
    handleUploadChange(file, fileList) {
      this.uploadForm.uploadFile = file.raw
      this.uploadFileList = fileList.slice(-1)
    },
    handleUploadRemove() {
      this.uploadForm.uploadFile = undefined
      this.uploadFileList = []
    },
    handleUploadExceed() {
      this.$modal.msgWarning('一次只能上传一个文件')
    },
    submitUpload() {
      this.$refs.uploadForm.validate(valid => {
        if (!valid) {
          return
        }
        if (!this.uploadForm.uploadFile) {
          this.$modal.msgError('请先选择上传文件')
          return
        }
        const formData = new FormData()
        formData.append('taskName', this.uploadForm.taskName)
        formData.append('importType', this.uploadForm.importType)
        formData.append('remark', this.uploadForm.remark || '')
        formData.append('uploadFile', this.uploadForm.uploadFile)
        this.uploading = true
        uploadImportTask(formData).then(() => {
          this.$modal.msgSuccess('上传成功')
          this.uploadOpen = false
          this.getList()
          this.resetUploadForm()
        }).finally(() => {
          this.uploading = false
        })
      })
    },
    handleExecute(row) {
      const taskId = row && row.taskId ? row.taskId : this.ids[0]
      if (!taskId) {
        return
      }
      this.$modal.confirm('是否确认执行导入任务编号为"' + taskId + '"的数据项？').then(() => {
        return executeImportTask(taskId)
      }).then(() => {
        this.$modal.msgSuccess('执行完成')
        this.getList()
      }).catch(() => {})
    },
    handleDetail(row) {
      const taskId = row.taskId || this.ids[0]
      getImportTask(taskId).then(response => {
        this.detail = response.data || {}
        this.detailOpen = true
      })
    }
  }
}
</script>

<style scoped>
.import-helper {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 12px 16px;
  border-radius: 6px;
  background: #f5f7fa;
}

.helper-label {
  color: #606266;
  font-size: 13px;
}
</style>