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
      <el-form-item label="光照标签" prop="lightTagCode">
        <el-input
          v-model="queryParams.lightTagCode"
          placeholder="请输入光照标签编码"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="空间标签" prop="spaceTagCode">
        <el-input
          v-model="queryParams.spaceTagCode"
          placeholder="请输入空间标签编码"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="预算等级" prop="budgetLevel">
        <el-select v-model="queryParams.budgetLevel" placeholder="请选择预算等级" clearable>
          <el-option
            v-for="item in budgetLevelOptions"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="宠物偏好" prop="petPreference">
        <el-select v-model="queryParams.petPreference" placeholder="请选择宠物偏好" clearable>
          <el-option
            v-for="item in petPreferenceOptions"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="养护偏好" prop="carePreference">
        <el-select v-model="queryParams.carePreference" placeholder="请选择养护偏好" clearable>
          <el-option
            v-for="item in carePreferenceOptions"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="最近推荐" prop="dateRange">
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

    <el-table v-loading="loading" :data="profileList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="画像编号" align="center" prop="profileId" width="100" />
      <el-table-column label="访客标识" align="center" min-width="160" show-overflow-tooltip>
        <template slot-scope="scope">
          <el-button
            type="text"
            @click="handleDetail(scope.row)"
            v-hasPermi="['plant:profile:detail']"
          >{{ scope.row.visitorUid }}</el-button>
          <span v-if="!hasPermission(['plant:profile:detail'])">{{ scope.row.visitorUid }}</span>
        </template>
      </el-table-column>
      <el-table-column label="问卷编号" align="center" prop="latestQuestionnaireId" width="120" />
      <el-table-column label="光照标签" align="center" prop="lightTagCode" min-width="120" show-overflow-tooltip />
      <el-table-column label="浇水标签" align="center" prop="waterTagCode" min-width="120" show-overflow-tooltip />
      <el-table-column label="空间标签" align="center" prop="spaceTagCode" min-width="120" show-overflow-tooltip />
      <el-table-column label="风格标签" align="center" prop="styleTagCode" min-width="120" show-overflow-tooltip />
      <el-table-column label="预算等级" align="center" width="110">
        <template slot-scope="scope">
          <span>{{ formatOptionLabel(scope.row.budgetLevel, budgetLevelOptions) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="宠物偏好" align="center" width="110">
        <template slot-scope="scope">
          <span>{{ formatOptionLabel(scope.row.petPreference, petPreferenceOptions) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="养护偏好" align="center" width="110">
        <template slot-scope="scope">
          <span>{{ formatOptionLabel(scope.row.carePreference, carePreferenceOptions) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="最近推荐时间" align="center" prop="lastRecommendTime" width="170">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.lastRecommendTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="更新时间" align="center" prop="updateTime" width="170">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.updateTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="120">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-view"
            @click="handleDetail(scope.row)"
            v-hasPermi="['plant:profile:detail']"
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
import { listProfile } from '@/api/plant/profile'
import { checkPermi } from '@/utils/permission'

export default {
  name: 'PlantAdminProfile',
  data() {
    return {
      loading: true,
      showSearch: true,
      total: 0,
      ids: [],
      single: true,
      multiple: true,
      dateRange: [],
      profileList: [],
      budgetLevelOptions: [
        { label: '低预算', value: '1' },
        { label: '中预算', value: '2' },
        { label: '高预算', value: '3' }
      ],
      petPreferenceOptions: [
        { label: '有宠物', value: '1' },
        { label: '无宠物', value: '0' }
      ],
      carePreferenceOptions: [
        { label: '低养护', value: '1' },
        { label: '中养护', value: '2' },
        { label: '高养护', value: '3' }
      ],
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        visitorUid: undefined,
        lightTagCode: undefined,
        spaceTagCode: undefined,
        budgetLevel: undefined,
        petPreference: undefined,
        carePreference: undefined
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.loading = true
      listProfile(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
        this.profileList = response.rows
        this.total = response.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    formatOptionLabel(value, options) {
      const option = options.find(item => item.value === value)
      return option ? option.label : value || '-'
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
      this.ids = selection.map(item => item.profileId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    handleDetail(row) {
      const profileId = row.profileId || this.ids[0]
      this.$router.push('/plant-admin/profile/detail/' + profileId)
    }
  }
}
</script>