<template>
  <div class="app-container recommend-detail-page" v-loading="loading">
    <el-card shadow="never" class="mb16">
      <div slot="header" class="card-header">
        <span>推荐记录详情</span>
        <el-button size="mini" @click="goBack">返回</el-button>
      </div>
      <el-descriptions :column="3" border>
        <el-descriptions-item label="记录编号">{{ record.recordId || '-' }}</el-descriptions-item>
        <el-descriptions-item label="访客标识">{{ record.visitorUid || '-' }}</el-descriptions-item>
        <el-descriptions-item label="问卷编号">{{ record.questionnaireId || '-' }}</el-descriptions-item>
        <el-descriptions-item label="画像编号">{{ record.profileId || '-' }}</el-descriptions-item>
        <el-descriptions-item label="Top1 植物ID">{{ record.topPlantId || '-' }}</el-descriptions-item>
        <el-descriptions-item label="Top1 植物名称">{{ record.topPlantName || '-' }}</el-descriptions-item>
        <el-descriptions-item label="候选总数">{{ record.totalCandidateCount || 0 }}</el-descriptions-item>
        <el-descriptions-item label="结果数量">{{ record.resultCount || 0 }}</el-descriptions-item>
        <el-descriptions-item label="来源终端">{{ record.sourceTerminal || '-' }}</el-descriptions-item>
        <el-descriptions-item label="推荐时间">{{ parseTime(record.recommendTime) || '-' }}</el-descriptions-item>
      </el-descriptions>
    </el-card>

    <el-row :gutter="16" class="mb16">
      <el-col :span="8">
        <el-card shadow="never" class="detail-block">
          <div slot="header">请求快照 JSON</div>
          <pre class="json-block">{{ prettyJson(record.requestJson) }}</pre>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card shadow="never" class="detail-block">
          <div slot="header">结果 JSON</div>
          <pre class="json-block">{{ prettyJson(record.resultJson) }}</pre>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card shadow="never" class="detail-block">
          <div slot="header">命中规则 JSON</div>
          <pre class="json-block">{{ prettyJson(record.matchRuleJson) }}</pre>
        </el-card>
      </el-col>
    </el-row>

    <el-card shadow="never" class="detail-block">
      <div slot="header">推荐明细</div>
      <el-table :data="record.itemList || []">
        <el-table-column label="明细编号" align="center" prop="itemId" width="110" />
        <el-table-column label="植物ID" align="center" prop="plantId" width="100" />
        <el-table-column label="植物名称" align="center" prop="plantName" min-width="150" show-overflow-tooltip />
        <el-table-column label="总分" align="center" prop="scoreTotal" width="100" />
        <el-table-column label="分数明细" align="center" min-width="220">
          <template slot-scope="scope">
            <pre class="json-inline">{{ prettyJson(scope.row.scoreDetailJson) }}</pre>
          </template>
        </el-table-column>
        <el-table-column label="排名" align="center" prop="rankNum" width="80" />
        <el-table-column label="推荐原因" align="center" prop="reasonText" min-width="220" show-overflow-tooltip />
        <el-table-column label="创建时间" align="center" prop="createTime" width="180">
          <template slot-scope="scope">
            <span>{{ parseTime(scope.row.createTime) }}</span>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script>
import { getRecommend } from '@/api/plant/recommend'

export default {
  name: 'PlantAdminRecommendDetail',
  data() {
    return {
      loading: false,
      record: {
        itemList: []
      }
    }
  },
  created() {
    this.getInfo()
  },
  watch: {
    '$route.params.recordId': 'getInfo'
  },
  methods: {
    getInfo() {
      const recordId = this.$route.params.recordId
      if (!recordId) {
        return
      }
      this.loading = true
      this.record = { itemList: [] }
      getRecommend(recordId).then(response => {
        this.record = Object.assign({ itemList: [] }, response.data)
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    prettyJson(value) {
      if (!value) {
        return '-'
      }
      if (typeof value === 'object') {
        return JSON.stringify(value, null, 2)
      }
      try {
        return JSON.stringify(JSON.parse(value), null, 2)
      } catch (error) {
        return value
      }
    },
    goBack() {
      this.$router.push('/plant-admin/recommend')
    }
  }
}
</script>

<style scoped>
.recommend-detail-page .card-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.mb16 {
  margin-bottom: 16px;
}

.detail-block {
  min-height: 100%;
}

.json-block,
.json-inline {
  margin: 0;
  padding: 12px;
  white-space: pre-wrap;
  word-break: break-all;
  background: #f6f8fa;
  border-radius: 4px;
  line-height: 1.6;
}

.json-inline {
  padding: 8px;
}
</style>