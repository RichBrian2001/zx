<template>
  <div class="app-container">
    <el-form ref="queryForm" :model="queryParams" size="small" :inline="true" v-show="showSearch" label-width="96px">
      <el-form-item label="访客标识" prop="visitorUid">
        <el-input
          v-model="queryParams.visitorUid"
          placeholder="请输入访客标识"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="记录编号" prop="recordId">
        <el-input-number v-model="queryParams.recordId" controls-position="right" :min="1" placeholder="记录编号" />
      </el-form-item>
      <el-form-item label="植物ID" prop="plantId">
        <el-input-number v-model="queryParams.plantId" controls-position="right" :min="1" placeholder="植物ID" />
      </el-form-item>
      <el-form-item label="反馈类型" prop="feedbackType">
        <el-select v-model="queryParams.feedbackType" placeholder="请选择反馈类型" clearable>
          <el-option
            v-for="item in feedbackTypeOptions"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="反馈时间" prop="dateRange">
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
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="feedbackList">
      <el-table-column label="反馈编号" align="center" width="110">
        <template slot-scope="scope">
          <el-button
            v-if="hasPermission(['plant:feedback:query'])"
            type="text"
            @click="handleDetail(scope.row)"
          >{{ scope.row.feedbackId }}</el-button>
          <span v-else>{{ scope.row.feedbackId }}</span>
        </template>
      </el-table-column>
      <el-table-column label="访客标识" align="center" prop="visitorUid" min-width="160" show-overflow-tooltip />
      <el-table-column label="记录编号" align="center" prop="recordId" width="110" />
      <el-table-column label="植物ID" align="center" prop="plantId" width="100" />
      <el-table-column label="植物名称" align="center" prop="plantName" min-width="150" show-overflow-tooltip />
      <el-table-column label="反馈类型" align="center" width="100">
        <template slot-scope="scope">
          <span>{{ formatOptionLabel(scope.row.feedbackType, feedbackTypeOptions) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="反馈原因" align="center" prop="feedbackReason" min-width="220" show-overflow-tooltip />
      <el-table-column label="补充说明" align="center" prop="extraNote" min-width="220" show-overflow-tooltip />
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="120">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-view"
            @click="handleDetail(scope.row)"
            v-hasPermi="['plant:feedback:query']"
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

    <el-dialog title="反馈详情" :visible.sync="open" width="760px" append-to-body>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="反馈编号">{{ form.feedbackId || '-' }}</el-descriptions-item>
        <el-descriptions-item label="访客标识">{{ form.visitorUid || '-' }}</el-descriptions-item>
        <el-descriptions-item label="记录编号">{{ form.recordId || '-' }}</el-descriptions-item>
        <el-descriptions-item label="植物ID">{{ form.plantId || '-' }}</el-descriptions-item>
        <el-descriptions-item label="植物名称">{{ form.plantName || '-' }}</el-descriptions-item>
        <el-descriptions-item label="反馈类型">{{ formatOptionLabel(form.feedbackType, feedbackTypeOptions) }}</el-descriptions-item>
        <el-descriptions-item label="反馈原因" :span="2">{{ form.feedbackReason || '-' }}</el-descriptions-item>
        <el-descriptions-item label="补充说明" :span="2">{{ form.extraNote || '-' }}</el-descriptions-item>
        <el-descriptions-item label="创建时间" :span="2">{{ parseTime(form.createTime) || '-' }}</el-descriptions-item>
      </el-descriptions>
      <div slot="footer" class="dialog-footer">
        <el-button @click="open = false">关 闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { getFeedback, listFeedback } from '@/api/plant/feedback'
import { checkPermi } from '@/utils/permission'

export default {
  name: 'PlantAdminFeedback',
  data() {
    return {
      loading: true,
      showSearch: true,
      total: 0,
      open: false,
      dateRange: [],
      feedbackList: [],
      feedbackTypeOptions: [
        { label: '喜欢', value: '1' },
        { label: '不喜欢', value: '2' }
      ],
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        visitorUid: undefined,
        recordId: undefined,
        plantId: undefined,
        feedbackType: undefined
      },
      form: {
        feedbackId: undefined,
        visitorUid: undefined,
        recordId: undefined,
        plantId: undefined,
        plantName: undefined,
        feedbackType: undefined,
        feedbackReason: undefined,
        extraNote: undefined,
        createTime: undefined
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.loading = true
      listFeedback(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
        this.feedbackList = response.rows
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
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    resetQuery() {
      this.dateRange = []
      this.resetForm('queryForm')
      this.handleQuery()
    },
    handleDetail(row) {
      const feedbackId = row.feedbackId
      getFeedback(feedbackId).then(response => {
        this.form = response.data || {}
        this.open = true
      })
    }
  }
}
</script>