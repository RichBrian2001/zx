<template>
  <div class="app-container plant-form-page" v-loading="loading">
    <el-card shadow="never">
      <div slot="header" class="card-header">
        <span>{{ title }}</span>
        <el-button size="mini" @click="goBack">返回</el-button>
      </div>

      <el-form ref="form" :model="form" :rules="rules" label-width="96px">
        <el-row :gutter="18">
          <el-col :span="12">
            <el-form-item label="植物分类" prop="categoryId">
              <treeselect
                v-model="form.categoryId"
                :options="categoryOptions"
                :normalizer="normalizer"
                placeholder="请选择植物分类"
                no-results-text="暂无分类"
                no-options-text="暂无分类"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="植物名称" prop="plantName">
              <el-input v-model="form.plantName" placeholder="请输入植物名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="植物编码" prop="plantCode">
              <el-input v-model="form.plantCode" placeholder="请输入植物编码" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="别名" prop="aliasName">
              <el-input v-model="form.aliasName" placeholder="请输入别名" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="封面图片" prop="coverImage">
              <image-upload v-model="form.coverImage" :limit="1" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="植物简介" prop="plantSummary">
              <el-input v-model="form.plantSummary" type="textarea" :rows="3" placeholder="请输入植物简介" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="养护难度" prop="difficultyLevel">
              <el-select v-model="form.difficultyLevel" placeholder="请选择养护难度">
                <el-option
                  v-for="item in difficultyOptions"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value"
                />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="价格带" prop="priceLevel">
              <el-select v-model="form.priceLevel" placeholder="请选择价格带">
                <el-option
                  v-for="item in priceOptions"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value"
                />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="前台展示" prop="displayStatus">
              <el-radio-group v-model="form.displayStatus">
                <el-radio
                  v-for="item in displayStatusOptions"
                  :key="item.value"
                  :label="item.value"
                >{{ item.label }}</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="宠物友好" prop="petSafeFlag">
              <el-radio-group v-model="form.petSafeFlag">
                <el-radio label="1">友好</el-radio>
                <el-radio label="0">慎选</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="净化效果" prop="purgeEffectFlag">
              <el-radio-group v-model="form.purgeEffectFlag">
                <el-radio label="1">有</el-radio>
                <el-radio label="0">无</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="香味属性" prop="aromaFlag">
              <el-radio-group v-model="form.aromaFlag">
                <el-radio label="1">有</el-radio>
                <el-radio label="0">无</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="排序" prop="sortNum">
              <el-input-number v-model="form.sortNum" controls-position="right" :min="0" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="数据状态" prop="status">
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
            <el-form-item label="适用场景" prop="suitableScene">
              <el-input v-model="form.suitableScene" type="textarea" :rows="2" placeholder="请输入适用场景，多个场景可用顿号分隔" />
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
import Treeselect from '@riophae/vue-treeselect'
import '@riophae/vue-treeselect/dist/vue-treeselect.css'
import { addPlant, categoryTreeSelect, getPlant, updatePlant } from '@/api/plant/plant'

export default {
  name: 'PlantAdminPlantForm',
  components: { Treeselect },
  dicts: ['sys_normal_disable'],
  data() {
    return {
      loading: false,
      categoryOptions: [],
      form: {},
      difficultyOptions: [
        { label: 'L1 入门', value: '1' },
        { label: 'L2 进阶', value: '2' },
        { label: 'L3 专业', value: '3' }
      ],
      priceOptions: [
        { label: 'P1 低预算', value: '1' },
        { label: 'P2 中预算', value: '2' },
        { label: 'P3 高预算', value: '3' }
      ],
      displayStatusOptions: [
        { label: '展示', value: '0' },
        { label: '隐藏', value: '1' }
      ],
      rules: {
        categoryId: [
          { required: true, message: '植物分类不能为空', trigger: 'change' }
        ],
        plantName: [
          { required: true, message: '植物名称不能为空', trigger: 'blur' }
        ],
        difficultyLevel: [
          { required: true, message: '养护难度不能为空', trigger: 'change' }
        ],
        priceLevel: [
          { required: true, message: '价格带不能为空', trigger: 'change' }
        ],
        displayStatus: [
          { required: true, message: '前台展示状态不能为空', trigger: 'change' }
        ],
        sortNum: [
          { required: true, message: '排序不能为空', trigger: 'blur' }
        ],
        status: [
          { required: true, message: '数据状态不能为空', trigger: 'change' }
        ]
      }
    }
  },
  computed: {
    isEdit() {
      return this.$route.name === 'PlantAdminPlantEdit'
    },
    title() {
      return this.isEdit ? '编辑植物' : '新增植物'
    }
  },
  created() {
    this.reset()
    this.getCategoryOptions()
    if (this.isEdit) {
      this.getInfo()
    }
  },
  methods: {
    reset() {
      this.form = {
        plantId: undefined,
        categoryId: undefined,
        plantName: undefined,
        plantCode: undefined,
        aliasName: undefined,
        coverImage: undefined,
        plantSummary: undefined,
        difficultyLevel: '1',
        priceLevel: '1',
        displayStatus: '0',
        petSafeFlag: '0',
        purgeEffectFlag: '0',
        aromaFlag: '0',
        suitableScene: undefined,
        sortNum: 0,
        status: '0',
        remark: undefined
      }
      this.resetForm('form')
    },
    getCategoryOptions() {
      categoryTreeSelect().then(response => {
        this.categoryOptions = response.data || []
      })
    },
    normalizer(node) {
      if (node.children && !node.children.length) {
        delete node.children
      }
      return {
        id: node.id,
        label: node.label,
        children: node.children
      }
    },
    getInfo() {
      const plantId = this.$route.params.plantId
      if (!plantId) {
        return
      }
      this.loading = true
      getPlant(plantId).then(response => {
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
        const request = this.form.plantId ? updatePlant(this.form) : addPlant(this.form)
        request.then(() => {
          this.$modal.msgSuccess(this.form.plantId ? '修改成功' : '新增成功')
          this.goBack()
        })
      })
    },
    goBack() {
      const obj = { path: '/plant-admin/plant', query: { t: Date.now() } }
      this.$tab.closeOpenPage(obj)
    }
  }
}
</script>

<style scoped>
.plant-form-page .card-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.form-actions {
  margin-top: 20px;
  text-align: center;
}
</style>