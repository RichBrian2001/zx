<template>
  <div class="app-container" v-loading="loading">
    <el-card shadow="never">
      <div slot="header" class="card-header">
        <span>{{ title }}</span>
        <el-button size="mini" @click="goBack">返回</el-button>
      </div>

      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row :gutter="18">
          <el-col :span="12">
            <el-form-item label="规则名称" prop="ruleName">
              <el-input v-model="form.ruleName" placeholder="请输入规则名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="规则编码" prop="ruleCode">
              <el-input v-model="form.ruleCode" placeholder="请输入规则编码" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="规则类型" prop="ruleType">
              <el-select v-model="form.ruleType" placeholder="请选择规则类型" filterable allow-create default-first-option>
                <el-option
                  v-for="item in ruleTypeOptions"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value"
                />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="优先级" prop="priorityNum">
              <el-input-number v-model="form.priorityNum" controls-position="right" :min="0" :max="999999" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="触发字段" prop="triggerField">
              <el-select v-model="form.triggerField" placeholder="请选择触发字段" filterable allow-create default-first-option>
                <el-option
                  v-for="item in triggerFieldOptions"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value"
                />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="操作符" prop="triggerOperator">
              <el-select v-model="form.triggerOperator" placeholder="请选择操作符" filterable allow-create default-first-option>
                <el-option
                  v-for="item in triggerOperatorOptions"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value"
                />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="触发值" prop="triggerValue">
              <el-input v-model="form.triggerValue" placeholder="请输入触发值" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="动作类型" prop="actionType">
              <el-select v-model="form.actionType" placeholder="请选择动作类型" filterable allow-create default-first-option>
                <el-option
                  v-for="item in actionTypeOptions"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value"
                />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="动作值" prop="actionValue">
              <el-input v-model="form.actionValue" placeholder="请输入动作值" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="加权分值" prop="scoreValue">
              <el-input-number v-model="form.scoreValue" controls-position="right" :precision="2" :step="1" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="规则说明" prop="ruleDesc">
              <el-input v-model="form.ruleDesc" type="textarea" :rows="3" placeholder="请输入规则说明" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="状态" prop="status">
              <el-radio-group v-model="form.status">
                <el-radio
                  v-for="dict in dict.type.sys_normal_disable"
                  :key="dict.value"
                  :label="dict.value"
                >{{ dict.label }}</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="备注" prop="remark">
              <el-input v-model="form.remark" type="textarea" :rows="2" placeholder="请输入备注" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>

      <div class="form-actions">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="goBack">取 消</el-button>
      </div>
    </el-card>
  </div>
</template>

<script>
import { addRule, getRule, updateRule } from '@/api/plant/rule'

export default {
  name: 'PlantAdminRuleForm',
  dicts: ['sys_normal_disable'],
  data() {
    return {
      loading: false,
      form: {},
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
      rules: {
        ruleName: [
          { required: true, message: '规则名称不能为空', trigger: 'blur' }
        ],
        ruleCode: [
          { required: true, message: '规则编码不能为空', trigger: 'blur' }
        ],
        ruleType: [
          { required: true, message: '规则类型不能为空', trigger: 'change' }
        ],
        triggerField: [
          { required: true, message: '触发字段不能为空', trigger: 'change' }
        ],
        triggerOperator: [
          { required: true, message: '操作符不能为空', trigger: 'change' }
        ],
        actionType: [
          { required: true, message: '动作类型不能为空', trigger: 'change' }
        ],
        priorityNum: [
          { required: true, message: '优先级不能为空', trigger: 'blur' }
        ],
        status: [
          { required: true, message: '状态不能为空', trigger: 'change' }
        ]
      }
    }
  },
  computed: {
    isEdit() {
      return this.$route.name === 'PlantAdminRuleEdit'
    },
    title() {
      return this.isEdit ? '编辑推荐规则' : '新增推荐规则'
    }
  },
  created() {
    this.reset()
    if (this.isEdit) {
      this.getInfo()
    }
  },
  methods: {
    reset() {
      this.form = {
        ruleId: undefined,
        ruleName: undefined,
        ruleCode: undefined,
        ruleType: 'filter',
        triggerField: undefined,
        triggerOperator: '=',
        triggerValue: undefined,
        actionType: undefined,
        actionValue: undefined,
        scoreValue: 0,
        priorityNum: 0,
        status: '0',
        ruleDesc: undefined,
        remark: undefined
      }
      this.resetForm('form')
    },
    getInfo() {
      const ruleId = this.$route.params.ruleId
      if (!ruleId) {
        return
      }
      this.loading = true
      getRule(ruleId).then(response => {
        this.form = Object.assign({}, this.form, response.data || {})
      }).finally(() => {
        this.loading = false
      })
    },
    submitForm() {
      this.$refs.form.validate(valid => {
        if (!valid) {
          return
        }
        const request = this.form.ruleId ? updateRule(this.form) : addRule(this.form)
        request.then(() => {
          this.$modal.msgSuccess(this.form.ruleId ? '修改成功' : '新增成功')
          this.goBack()
        })
      })
    },
    goBack() {
      const obj = { path: '/plant-admin/rule', query: { t: Date.now() } }
      this.$tab.closeOpenPage(obj)
    }
  }
}
</script>