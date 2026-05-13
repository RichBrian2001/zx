<template>
  <div class="app-container" v-loading="loading">
    <div class="page-head">
      <div class="head-main">
        <div class="cover-box">
          <image-preview v-if="plant.coverImage" :src="plant.coverImage" :width="88" :height="88" />
          <div v-else class="cover-placeholder">植</div>
        </div>
        <div class="head-copy">
          <div class="head-top">
            <span class="page-kicker">植物详情</span>
            <el-tag size="mini">ID {{ plant.plantId || $route.params.plantId }}</el-tag>
            <el-tag size="mini" :type="plant.detailId ? 'success' : 'info'">{{ plant.detailId ? '已配置养护' : '未配置养护' }}</el-tag>
          </div>
          <h1>{{ plant.plantName || '加载中' }}</h1>
          <p>{{ plant.categoryName || '未分类' }} / {{ difficultyLabel(plant.difficultyLevel) }} / {{ priceLabel(plant.priceLevel) }}</p>
        </div>
      </div>
      <div class="head-actions">
        <el-button @click="goBack">返回植物库</el-button>
        <el-button type="primary" @click="goCare" v-hasPermi="['plant:plant:care']">养护配置</el-button>
      </div>
    </div>

    <el-row :gutter="16">
      <el-col :span="16">
        <el-card shadow="never" class="mb16">
          <div slot="header">基础信息</div>
          <el-descriptions :column="2" border>
            <el-descriptions-item label="植物ID">{{ plant.plantId || '-' }}</el-descriptions-item>
            <el-descriptions-item label="植物名称">{{ plant.plantName || '-' }}</el-descriptions-item>
            <el-descriptions-item label="别名">{{ plant.aliasName || '-' }}</el-descriptions-item>
            <el-descriptions-item label="植物编码">{{ plant.plantCode || '-' }}</el-descriptions-item>
            <el-descriptions-item label="植物分类">{{ plant.categoryName || '-' }}</el-descriptions-item>
            <el-descriptions-item label="详情配置">{{ plant.detailId ? '已配置' : '未配置' }}</el-descriptions-item>
          </el-descriptions>
        </el-card>

        <el-card shadow="never" class="mb16">
          <div slot="header">展示与属性</div>
          <el-descriptions :column="3" border>
            <el-descriptions-item label="养护难度">{{ difficultyLabel(plant.difficultyLevel) }}</el-descriptions-item>
            <el-descriptions-item label="价格带">{{ priceLabel(plant.priceLevel) }}</el-descriptions-item>
            <el-descriptions-item label="前台展示">{{ displayStatusLabel(plant.displayStatus) }}</el-descriptions-item>
            <el-descriptions-item label="宠物友好">{{ petSafeLabel(plant.petSafeFlag) }}</el-descriptions-item>
            <el-descriptions-item label="净化效果">{{ yesNoLabel(plant.purgeEffectFlag) }}</el-descriptions-item>
            <el-descriptions-item label="香味属性">{{ yesNoLabel(plant.aromaFlag) }}</el-descriptions-item>
            <el-descriptions-item label="排序值">{{ plant.sortNum !== undefined && plant.sortNum !== null ? plant.sortNum : '-' }}</el-descriptions-item>
            <el-descriptions-item label="数据状态">
              <dict-tag :options="dict.type.sys_normal_disable" :value="plant.status" />
            </el-descriptions-item>
            <el-descriptions-item label="封面路径">{{ plant.coverImage || '-' }}</el-descriptions-item>
          </el-descriptions>
        </el-card>

        <el-card shadow="never">
          <div slot="header">说明信息</div>
          <el-descriptions :column="1" border>
            <el-descriptions-item label="植物简介">{{ plant.plantSummary || '-' }}</el-descriptions-item>
            <el-descriptions-item label="适用场景">{{ plant.suitableScene || '-' }}</el-descriptions-item>
            <el-descriptions-item label="备注">{{ plant.remark || '-' }}</el-descriptions-item>
          </el-descriptions>
        </el-card>
      </el-col>

      <el-col :span="8">
        <el-card shadow="never" class="meta-card">
          <div slot="header">维护信息</div>
          <el-descriptions :column="1" border>
            <el-descriptions-item label="详情编号">{{ plant.detailId || '-' }}</el-descriptions-item>
            <el-descriptions-item label="创建人">{{ plant.createBy || '-' }}</el-descriptions-item>
            <el-descriptions-item label="创建时间">{{ parseTime(plant.createTime) || '-' }}</el-descriptions-item>
            <el-descriptions-item label="更新人">{{ plant.updateBy || '-' }}</el-descriptions-item>
            <el-descriptions-item label="更新时间">{{ parseTime(plant.updateTime) || '-' }}</el-descriptions-item>
          </el-descriptions>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { getPlant } from '@/api/plant/plant'

export default {
  name: 'PlantAdminPlantDetail',
  dicts: ['sys_normal_disable'],
  data() {
    return {
      loading: false,
      plant: {},
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
      ]
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
      this.plant = {}
      getPlant(plantId).then(response => {
        this.plant = response.data || {}
      }).finally(() => {
        this.loading = false
      })
    },
    difficultyLabel(value) {
      const matched = this.difficultyOptions.find(item => item.value === value)
      return matched ? matched.label : value || '-'
    },
    priceLabel(value) {
      const matched = this.priceOptions.find(item => item.value === value)
      return matched ? matched.label : value || '-'
    },
    displayStatusLabel(value) {
      const matched = this.displayStatusOptions.find(item => item.value === value)
      return matched ? matched.label : value || '-'
    },
    petSafeLabel(value) {
      if (value === '1') {
        return '友好'
      }
      if (value === '0') {
        return '慎选'
      }
      return value || '-'
    },
    yesNoLabel(value) {
      if (value === '1') {
        return '有'
      }
      if (value === '0') {
        return '无'
      }
      return value || '-'
    },
    goBack() {
      this.$router.push('/plant-admin/plant')
    },
    goCare() {
      if (!this.plant.plantId) {
        return
      }
      this.$router.push('/plant-admin/plant-care/' + this.plant.plantId)
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

.mb16 {
  margin-bottom: 16px;
}

.meta-card {
  height: 100%;
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