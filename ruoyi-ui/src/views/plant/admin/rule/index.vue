<template>
  <div class="app-container">
    <el-form ref="queryForm" :model="queryParams" size="small" :inline="true" v-show="showSearch" label-width="82px">
      <el-form-item label="规则名称" prop="ruleName">
        <el-input
          v-model="queryParams.ruleName"
          placeholder="请输入规则名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="规则编码" prop="ruleCode">
        <el-input
          v-model="queryParams.ruleCode"
          placeholder="请输入规则编码"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="规则类型" prop="ruleType">
        <el-select v-model="queryParams.ruleType" placeholder="请选择规则类型" clearable>
          <el-option
            v-for="item in ruleTypeOptions"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
          <el-option
            v-for="dict in dict.type.sys_normal_disable"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
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
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['plant:rule:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['plant:rule:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['plant:rule:remove']"
        >删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="ruleList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="规则编号" align="center" prop="ruleId" width="100" />
      <el-table-column label="规则名称" align="center" prop="ruleName" min-width="160" show-overflow-tooltip />
      <el-table-column label="规则编码" align="center" prop="ruleCode" min-width="180" show-overflow-tooltip />
      <el-table-column label="规则类型" align="center" min-width="110">
        <template slot-scope="scope">
          <span>{{ formatOptionLabel(scope.row.ruleType, ruleTypeOptions) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="触发字段" align="center" min-width="120">
        <template slot-scope="scope">
          <span>{{ formatOptionLabel(scope.row.triggerField, triggerFieldOptions) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作符" align="center" min-width="100">
        <template slot-scope="scope">
          <span>{{ formatOptionLabel(scope.row.triggerOperator, triggerOperatorOptions) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="触发值" align="center" prop="triggerValue" min-width="120" show-overflow-tooltip />
      <el-table-column label="动作类型" align="center" min-width="120">
        <template slot-scope="scope">
          <span>{{ formatOptionLabel(scope.row.actionType, actionTypeOptions) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="动作值" align="center" prop="actionValue" min-width="140" show-overflow-tooltip />
      <el-table-column label="加权分值" align="center" prop="scoreValue" width="100" />
      <el-table-column label="优先级" align="center" prop="priorityNum" width="90" />
      <el-table-column label="状态" align="center" width="100">
        <template slot-scope="scope">
          <el-switch
            v-model="scope.row.status"
            active-value="0"
            inactive-value="1"
            @change="handleStatusChange(scope.row)"
            v-hasPermi="['plant:rule:changeStatus']"
          />
          <dict-tag v-if="!hasPermission(['plant:rule:changeStatus'])" :options="dict.type.sys_normal_disable" :value="scope.row.status" />
        </template>
      </el-table-column>
      <el-table-column label="规则说明" align="center" prop="ruleDesc" min-width="220" show-overflow-tooltip />
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="更新时间" align="center" prop="updateTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.updateTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="180">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['plant:rule:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['plant:rule:remove']"
          >删除</el-button>
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
import { changeRuleStatus, delRule, listRule } from '@/api/plant/rule'
import { checkPermi } from '@/utils/permission'

export default {
  name: 'PlantAdminRule',
  dicts: ['sys_normal_disable'],
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      ruleList: [],
      ruleTypeOptions: [
        { label: '过滤规则', value: 'filter' },
        { label: '加分规则', value: 'score' },
        { label: '解释规则', value: 'explain' }
      ],
      triggerFieldOptions: [
        { label: '宠物偏好 pet', value: 'pet' },
        { label: '空间 space', value: 'space' },
        { label: '光照 light', value: 'light' },
        { label: '养护 care', value: 'care' },
        { label: '目标 goal', value: 'goal' },
        { label: '风格 style', value: 'style' },
        { label: '预算 budget', value: 'budget' },
        { label: '命中 match', value: 'match' }
      ],
      triggerOperatorOptions: [
        { label: '等于 =', value: '=' },
        { label: '小于等于 <=', value: '<=' },
        { label: '大于等于 >=', value: '>=' }
      ],
      actionTypeOptions: [
        { label: '排除标签 excludeTag', value: 'excludeTag' },
        { label: '优先标签 preferTag', value: 'preferTag' },
        { label: '标签加分 addScoreByTag', value: 'addScoreByTag' },
        { label: '追加原因 appendReason', value: 'appendReason' }
      ],
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        ruleName: undefined,
        ruleCode: undefined,
        ruleType: undefined,
        status: undefined
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.loading = true
      listRule(this.queryParams).then(response => {
        this.ruleList = response.rows
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
      this.resetForm('queryForm')
      this.handleQuery()
    },
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.ruleId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.$router.push('/plant-admin/rule/add')
    },
    handleUpdate(row) {
      const ruleId = row.ruleId || this.ids[0]
      if (!ruleId) {
        return
      }
      this.$router.push('/plant-admin/rule/edit/' + ruleId)
    },
    handleStatusChange(row) {
      const text = row.status === '0' ? '启用' : '停用'
      const previousStatus = row.status === '0' ? '1' : '0'
      this.$modal.confirm('确认要"' + text + '"规则“' + row.ruleName + '”吗？').then(() => {
        return changeRuleStatus(row.ruleId, row.status)
      }).then(() => {
        this.$modal.msgSuccess(text + '成功')
      }).catch(() => {
        row.status = previousStatus
      })
    },
    submitForm() {
      this.$refs.form.validate(valid => {
        if (!valid) {
          return
        }
        if (this.form.ruleId !== undefined) {
          updateRule(this.form).then(() => {
            this.$modal.msgSuccess('修改成功')
            this.open = false
            this.getList()
          })
        } else {
          addRule(this.form).then(() => {
            this.$modal.msgSuccess('新增成功')
            this.open = false
            this.getList()
          })
        }
      })
    },
    handleDelete(row) {
      const ruleIds = row.ruleId || this.ids
      this.$modal.confirm('是否确认删除推荐规则编号为"' + ruleIds + '"的数据项？').then(() => {
        return delRule(ruleIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess('删除成功')
      }).catch(() => {})
    }
  }
}
</script>