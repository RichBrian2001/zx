<template>
  <div class="app-container profile-detail-page" v-loading="loading">
    <el-card shadow="never" class="mb16">
      <div slot="header" class="card-header">
        <span>画像详情</span>
        <el-button size="mini" @click="goBack">返回</el-button>
      </div>
      <el-descriptions :column="3" border>
        <el-descriptions-item label="画像编号">{{ profile.profileId || '-' }}</el-descriptions-item>
        <el-descriptions-item label="访客标识">{{ profile.visitorUid || '-' }}</el-descriptions-item>
        <el-descriptions-item label="问卷编号">{{ profile.latestQuestionnaireId || '-' }}</el-descriptions-item>
        <el-descriptions-item label="光照标签">{{ profile.lightTagCode || '-' }}</el-descriptions-item>
        <el-descriptions-item label="浇水标签">{{ profile.waterTagCode || '-' }}</el-descriptions-item>
        <el-descriptions-item label="空间标签">{{ profile.spaceTagCode || '-' }}</el-descriptions-item>
        <el-descriptions-item label="风格标签">{{ profile.styleTagCode || '-' }}</el-descriptions-item>
        <el-descriptions-item label="预算等级">{{ formatOptionLabel(profile.budgetLevel, budgetLevelOptions) }}</el-descriptions-item>
        <el-descriptions-item label="宠物偏好">{{ formatOptionLabel(profile.petPreference, petPreferenceOptions) }}</el-descriptions-item>
        <el-descriptions-item label="养护偏好">{{ formatOptionLabel(profile.carePreference, carePreferenceOptions) }}</el-descriptions-item>
        <el-descriptions-item label="最近推荐时间">{{ parseTime(profile.lastRecommendTime) || '-' }}</el-descriptions-item>
        <el-descriptions-item label="创建时间">{{ parseTime(profile.createTime) || '-' }}</el-descriptions-item>
        <el-descriptions-item label="更新时间">{{ parseTime(profile.updateTime) || '-' }}</el-descriptions-item>
      </el-descriptions>
    </el-card>

    <el-row :gutter="16" class="mb16">
      <el-col :span="12">
        <el-card shadow="never" class="detail-block">
          <div slot="header">问卷快照</div>
          <el-descriptions :column="1" border>
            <el-descriptions-item label="问卷编号">{{ profile.questionnaireId || '-' }}</el-descriptions-item>
            <el-descriptions-item label="环境摘要">{{ profile.environmentSummary || '-' }}</el-descriptions-item>
            <el-descriptions-item label="偏好摘要">{{ profile.preferenceSummary || '-' }}</el-descriptions-item>
            <el-descriptions-item label="预算值">{{ profile.budgetValue !== null && profile.budgetValue !== undefined ? profile.budgetValue : '-' }}</el-descriptions-item>
            <el-descriptions-item label="提交时间">{{ parseTime(profile.submitTime) || '-' }}</el-descriptions-item>
          </el-descriptions>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card shadow="never" class="detail-block">
          <div slot="header">画像 JSON</div>
          <pre class="json-block">{{ prettyJson(profile.profileJson) }}</pre>
        </el-card>
      </el-col>
    </el-row>

    <el-card shadow="never" class="mb16 detail-block">
      <div slot="header">问卷答案 JSON</div>
      <pre class="json-block">{{ prettyJson(profile.answerJson) }}</pre>
    </el-card>

    <el-card shadow="never" class="detail-block">
      <div slot="header">最近推荐记录</div>
      <el-table :data="profile.recentRecommendList || []">
        <el-table-column label="记录编号" align="center" prop="recordId" width="110" />
        <el-table-column label="Top1 植物ID" align="center" prop="topPlantId" width="120" />
        <el-table-column label="Top1 植物名称" align="center" prop="topPlantName" min-width="160" show-overflow-tooltip />
        <el-table-column label="推荐时间" align="center" prop="recommendTime" width="180">
          <template slot-scope="scope">
            <span>{{ parseTime(scope.row.recommendTime) }}</span>
          </template>
        </el-table-column>
        <el-table-column label="候选总数" align="center" prop="totalCandidateCount" width="100" />
        <el-table-column label="结果数量" align="center" prop="resultCount" width="100" />
      </el-table>
    </el-card>
  </div>
</template>

<script>
import { getProfile } from '@/api/plant/profile'

export default {
  name: 'PlantAdminProfileDetail',
  data() {
    return {
      loading: false,
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
      profile: {
        recentRecommendList: []
      }
    }
  },
  created() {
    this.getInfo()
  },
  methods: {
    getInfo() {
      this.loading = true
      getProfile(this.$route.params.profileId).then(response => {
        this.profile = Object.assign({ recentRecommendList: [] }, response.data)
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    formatOptionLabel(value, options) {
      const option = options.find(item => item.value === value)
      return option ? option.label : value || '-'
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
      this.$router.push('/plant-admin/profile')
    }
  }
}
</script>

<style scoped>
.profile-detail-page .card-header {
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

.json-block {
  margin: 0;
  padding: 12px;
  white-space: pre-wrap;
  word-break: break-all;
  background: #f6f8fa;
  border-radius: 4px;
  line-height: 1.6;
}
</style>