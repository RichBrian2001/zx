<template>
  <div class="app-container" v-loading="loading">
    <div class="page-head">
      <div class="head-main">
        <div class="cover-box">
          <image-preview v-if="plantInfo.coverImage" :src="plantInfo.coverImage" :width="88" :height="88" />
          <div v-else class="cover-placeholder">植</div>
        </div>
        <div class="head-copy">
          <div class="head-top">
            <span class="page-kicker">植物详情配置</span>
            <el-tag size="mini">ID {{ plantInfo.plantId || $route.params.plantId }}</el-tag>
            <el-tag size="mini" :type="form.detailId ? 'success' : 'info'">{{ form.detailId ? '已配置' : '待配置' }}</el-tag>
          </div>
          <h1>{{ plantInfo.plantName || '加载中' }}</h1>
          <p>{{ plantInfo.categoryName || '未分类' }}</p>
        </div>
      </div>
      <div class="head-actions">
        <el-button @click="goBack">返回植物库</el-button>
        <el-button type="primary" :loading="saving" @click="submitForm" v-hasPermi="['plant:plant:care']">保存配置</el-button>
      </div>
    </div>

    <el-card shadow="never" class="form-card">
      <el-form ref="form" :model="form" :rules="rules" label-width="108px">
        <el-row :gutter="18">
          <el-col :span="12">
            <el-form-item label="植物ID" prop="plantId">
              <el-input :value="form.plantId" disabled />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="植物名称">
              <el-input :value="plantInfo.plantName || '-'" disabled />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="植物分类">
              <el-input :value="plantInfo.categoryName || '-'" disabled />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="详情编号">
              <el-input :value="form.detailId || '-'" disabled />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="光照要求" prop="lightRequirement">
              <el-input v-model="form.lightRequirement" placeholder="请输入光照要求" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="浇水要求" prop="waterRequirement">
              <el-input v-model="form.waterRequirement" placeholder="请输入浇水要求" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="温度范围" prop="temperatureRange">
              <el-input v-model="form.temperatureRange" placeholder="请输入温度范围" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="湿度要求" prop="humidityRequirement">
              <el-input v-model="form.humidityRequirement" placeholder="请输入湿度要求" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="生长周期" prop="growCycle">
              <el-input v-model="form.growCycle" placeholder="请输入生长周期" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="养护提示" prop="careTips">
              <el-input v-model="form.careTips" type="textarea" :rows="3" placeholder="请输入养护提示" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="风险提示" prop="riskTips">
              <el-input v-model="form.riskTips" type="textarea" :rows="3" placeholder="请输入风险提示" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="展示文案" prop="displayContent">
              <el-input v-model="form.displayContent" type="textarea" :rows="4" placeholder="请输入前台展示文案" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="备注" prop="remark">
              <el-input v-model="form.remark" type="textarea" :rows="2" placeholder="请输入备注" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import { getPlant, getPlantDetail, savePlantDetail } from '@/api/plant/plant'

function createDefaultForm(plantId) {
  return {
    detailId: undefined,
    plantId: plantId || undefined,
    lightRequirement: undefined,
    waterRequirement: undefined,
    temperatureRange: undefined,
    humidityRequirement: undefined,
    growCycle: undefined,
    careTips: undefined,
    riskTips: undefined,
    displayContent: undefined,
    remark: undefined
  }
}

export default {
  name: 'PlantAdminPlantCare',
  data() {
    return {
      loading: false,
      saving: false,
      plantInfo: {},
      form: createDefaultForm(),
      rules: {
        plantId: [
          { required: true, message: '植物ID不能为空', trigger: 'blur' }
        ]
      }
    }
  },
  created() {
    this.loadInfo()
  },
  watch: {
    '$route.params.plantId': 'loadInfo'
  },
  methods: {
    loadInfo() {
      const plantId = Number(this.$route.params.plantId)
      if (!plantId) {
        return
      }
      this.loading = true
      this.form = createDefaultForm(plantId)
      Promise.all([getPlant(plantId), getPlantDetail(plantId)]).then(([plantResponse, detailResponse]) => {
        this.plantInfo = plantResponse.data || {}
        this.form = Object.assign(createDefaultForm(plantId), detailResponse.data || {}, { plantId })
      }).finally(() => {
        this.loading = false
      })
    },
    submitForm() {
      this.$refs.form.validate(valid => {
        if (!valid) {
          return
        }
        this.saving = true
        savePlantDetail(this.form).then(() => {
          this.$modal.msgSuccess('保存成功')
          this.loadInfo()
        }).finally(() => {
          this.saving = false
        })
      })
    },
    goBack() {
      this.$router.push('/plant-admin/plant')
    }
  }
}
</script>

<style lang="scss" scoped>
.page-head {
  display: flex;
  justify-content: space-between;
  gap: 16px;
  margin-bottom: 16px;
  padding: 20px 24px;
  border-radius: 8px;
  background: #fff;
}

.head-main {
  display: flex;
  align-items: center;
  gap: 16px;
}

.cover-box {
  width: 88px;
  height: 88px;
}

.cover-placeholder {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 88px;
  height: 88px;
  border-radius: 8px;
  background: #f0f6ff;
  color: #2f74ff;
  font-size: 32px;
  font-weight: 600;
}

.head-copy h1 {
  margin: 8px 0 6px;
  font-size: 24px;
  color: #303133;
}

.head-copy p {
  margin: 0;
  color: #606266;
}

.head-top {
  display: flex;
  align-items: center;
  gap: 8px;
}

.page-kicker {
  color: #909399;
  font-size: 13px;
}

.head-actions {
  display: flex;
  align-items: flex-start;
  gap: 12px;
}

.form-card {
  padding-bottom: 8px;
}

@media (max-width: 900px) {
  .page-head {
    flex-direction: column;
  }

  .head-actions {
    justify-content: flex-start;
  }
}
</style>