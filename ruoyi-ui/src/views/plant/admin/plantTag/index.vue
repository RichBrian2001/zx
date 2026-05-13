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
            <span class="page-kicker">植物标签配置</span>
            <el-tag size="mini">ID {{ plantInfo.plantId || $route.params.plantId }}</el-tag>
          </div>
          <h1>{{ plantInfo.plantName || '加载中' }}</h1>
          <p>{{ plantInfo.categoryName || '未分类' }}</p>
        </div>
      </div>
      <div class="head-actions">
        <el-button @click="goBack">返回植物库</el-button>
        <el-button type="primary" :loading="saving" @click="submitForm" v-hasPermi="['plant:plant:tag']">保存配置</el-button>
      </div>
    </div>

    <el-card shadow="never" class="summary-card">
      <div class="summary-row">
        <span>可配标签 {{ tagList.length }}</span>
        <span>已选标签 {{ selectedCount }}</span>
        <span>启用字典 {{ activeTagCount }}</span>
      </div>
    </el-card>

    <el-row :gutter="16" class="config-panels">
      <el-col :xs="24" :lg="14">
        <el-card shadow="never" class="panel-card">
          <div slot="header" class="panel-header">
            <span>可选标签列表</span>
            <span>共 {{ tagList.length }} 项</span>
          </div>
          <el-table :data="tagList">
            <el-table-column label="启用" width="80" align="center">
              <template slot-scope="scope">
                <el-checkbox v-model="scope.row.selected" />
              </template>
            </el-table-column>
            <el-table-column prop="tagId" label="标签ID" width="100" align="center" />
            <el-table-column prop="tagName" label="标签名称" min-width="140" show-overflow-tooltip />
            <el-table-column prop="tagCode" label="标签编码" min-width="160" show-overflow-tooltip />
            <el-table-column prop="tagGroup" label="标签分组" width="120" show-overflow-tooltip />
            <el-table-column prop="tagDesc" label="标签说明" min-width="220" show-overflow-tooltip />
            <el-table-column prop="status" label="字典状态" width="100" align="center">
              <template slot-scope="scope">
                <dict-tag :options="dict.type.sys_normal_disable" :value="scope.row.status" />
              </template>
            </el-table-column>
          </el-table>
        </el-card>
      </el-col>
      <el-col :xs="24" :lg="10">
        <el-card shadow="never" class="panel-card">
          <div slot="header" class="panel-header">
            <span>已配标签列表</span>
            <span>共 {{ selectedCount }} 项</span>
          </div>
          <el-empty v-if="!selectedTagList.length" :image-size="90" description="暂无已配标签" />
          <el-table v-else :data="selectedTagList">
            <el-table-column label="关联ID" width="100" align="center">
              <template slot-scope="scope">
                <span>{{ scope.row.relId || '-' }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="tagId" label="标签ID" width="100" align="center" />
            <el-table-column prop="tagName" label="标签名称" min-width="140" show-overflow-tooltip />
            <el-table-column prop="tagCode" label="标签编码" min-width="160" show-overflow-tooltip />
            <el-table-column prop="tagGroup" label="标签分组" width="120" show-overflow-tooltip />
            <el-table-column label="权重" width="150" align="center">
              <template slot-scope="scope">
                <el-input-number
                  v-model="scope.row.scoreWeight"
                  :precision="2"
                  :step="0.5"
                  :min="0"
                  :max="100"
                  controls-position="right"
                  size="small"
                />
              </template>
            </el-table-column>
            <el-table-column label="已配时间" min-width="160" align="center">
              <template slot-scope="scope">
                <span>{{ scope.row.createTime ? parseTime(scope.row.createTime) : '-' }}</span>
              </template>
            </el-table-column>
          </el-table>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { getPlantTagConfig, savePlantTagConfig } from '@/api/plant/tagRel'

export default {
  name: 'PlantAdminPlantTag',
  dicts: ['sys_normal_disable'],
  data() {
    return {
      loading: false,
      saving: false,
      plantInfo: {},
      tagList: []
    }
  },
  computed: {
    selectedCount() {
      return this.tagList.filter(item => item.selected).length
    },
    activeTagCount() {
      return this.tagList.filter(item => item.status === '0').length
    },
    selectedTagList() {
      return this.tagList.filter(item => item.selected)
    }
  },
  created() {
    this.loadConfig()
  },
  watch: {
    '$route.params.plantId': 'loadConfig'
  },
  methods: {
    loadConfig() {
      this.loading = true
      getPlantTagConfig(this.$route.params.plantId).then(response => {
        const data = response.data || {}
        this.plantInfo = data.plantInfo || {}
        const selectedMap = new Map((data.selectedTags || []).map(item => [item.tagId, item]))
        this.tagList = (data.availableTags || []).map(item => {
          const selected = selectedMap.get(item.tagId)
          return {
            ...item,
            selected: !!selected,
            scoreWeight: selected ? Number(selected.scoreWeight) : Number(item.scoreWeight || 0),
            createTime: selected ? selected.createTime : null,
            relId: selected ? selected.relId : null
          }
        })
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    buildPayload() {
      return {
        plantId: Number(this.$route.params.plantId),
        tagItems: this.tagList
          .filter(item => item.selected)
          .map(item => ({
            tagId: item.tagId,
            tagCode: item.tagCode,
            scoreWeight: item.scoreWeight || 0
          }))
      }
    },
    submitForm() {
      this.saving = true
      savePlantTagConfig(this.buildPayload()).then(() => {
        this.$modal.msgSuccess('保存成功')
        this.loadConfig()
      }).finally(() => {
        this.saving = false
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

.summary-card {
  margin-bottom: 16px;
}

.summary-row {
  display: flex;
  gap: 24px;
  color: #606266;
}

.config-panels {
  margin-bottom: 16px;
}

.panel-card {
  height: 100%;
}

.panel-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  color: #606266;
}

@media (max-width: 900px) {
  .page-head {
    flex-direction: column;
  }

  .head-actions {
    justify-content: flex-start;
  }

  .config-panels {
    margin-bottom: 0;
  }
}
</style>