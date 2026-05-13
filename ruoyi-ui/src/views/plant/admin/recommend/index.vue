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
      <el-form-item label="问卷编号" prop="questionnaireId">
        <el-input-number v-model="queryParams.questionnaireId" controls-position="right" :min="1" placeholder="问卷编号" />
      </el-form-item>
      <el-form-item label="画像编号" prop="profileId">
        <el-input-number v-model="queryParams.profileId" controls-position="right" :min="1" placeholder="画像编号" />
      </el-form-item>
      <el-form-item label="Top1 植物ID" prop="topPlantId">
        <el-input-number v-model="queryParams.topPlantId" controls-position="right" :min="1" placeholder="植物ID" />
      </el-form-item>
      <el-form-item label="来源终端" prop="sourceTerminal">
        <el-input
          v-model="queryParams.sourceTerminal"
          placeholder="请输入来源终端"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="推荐时间" prop="dateRange">
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

    <el-table v-loading="loading" :data="recommendList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="记录编号" align="center" width="110">
        <template slot-scope="scope">
          <el-button
            v-if="hasPermission(['plant:recommend:detail'])"
            type="text"
            @click="handleDetail(scope.row)"
          >{{ scope.row.recordId }}</el-button>
          <span v-else>{{ scope.row.recordId }}</span>
        </template>
      </el-table-column>
      <el-table-column label="访客标识" align="center" prop="visitorUid" min-width="160" show-overflow-tooltip />
      <el-table-column label="问卷编号" align="center" prop="questionnaireId" width="110" />
      <el-table-column label="画像编号" align="center" prop="profileId" width="110" />
      <el-table-column label="Top1 植物ID" align="center" prop="topPlantId" width="120" />
      <el-table-column label="Top1 植物名称" align="center" prop="topPlantName" min-width="150" show-overflow-tooltip />
      <el-table-column label="候选总数" align="center" prop="totalCandidateCount" width="100" />
      <el-table-column label="结果数量" align="center" prop="resultCount" width="100" />
      <el-table-column label="来源终端" align="center" prop="sourceTerminal" width="110" />
      <el-table-column label="推荐时间" align="center" prop="recommendTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.recommendTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="120">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-view"
            @click="handleDetail(scope.row)"
            v-hasPermi="['plant:recommend:detail']"
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
  </div>
</template>

<script>
import { listRecommend } from '@/api/plant/recommend'
import { checkPermi } from '@/utils/permission'

export default {
  name: 'PlantAdminRecommend',
  data() {
    return {
      loading: true,
      showSearch: true,
      total: 0,
      ids: [],
      single: true,
      multiple: true,
      dateRange: [],
      recommendList: [],
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        visitorUid: undefined,
        questionnaireId: undefined,
        profileId: undefined,
        topPlantId: undefined,
        sourceTerminal: undefined
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.loading = true
      listRecommend(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
        this.recommendList = response.rows
        this.total = response.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    hasPermission(value) {
      return checkPermi(value)
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
      this.ids = selection.map(item => item.recordId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    handleDetail(row) {
      const recordId = row.recordId || this.ids[0]
      this.$router.push('/plant-admin/recommend/detail/' + recordId)
    }
  }
}
</script>