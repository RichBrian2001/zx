<template>
  <section class="demo-page">
    <div class="page-head">
      <div>
        <p class="section-kicker">推荐历史</p>
        <h1>查看最近生成的推荐记录</h1>
      </div>
      <router-link class="primary-link" to="/plant-demo/questionnaire">再生成一次推荐</router-link>
    </div>

    <div class="history-grid" v-loading="loading">
      <article v-for="item in historyList" :key="item.recordId" class="history-card">
        <div class="history-visual" :style="plantVisualStyle(item.topPlantCoverImage)">
          <span class="card-time">{{ item.recommendTime }}</span>
        </div>
        <div class="history-body">
          <h2>{{ item.topPlantName }}</h2>
          <p>{{ item.environmentSummary || '未记录环境摘要' }} / {{ item.preferenceSummary || '未记录偏好摘要' }}</p>
          <div class="card-actions">
            <span class="result-badge">{{ item.resultCount }} 个结果</span>
            <button class="text-link" @click="openResult(item.recordId)">查看结果</button>
          </div>
        </div>
      </article>
      <el-empty v-if="!loading && !historyList.length" description="还没有历史推荐，先做一次问卷吧"></el-empty>
    </div>
  </section>
</template>

<script>
import { getHistoryList } from '@/api/plant/app'
import { getPlantCoverStyle } from '@/utils/plantAsset'
import { getVisitorUid } from '@/utils/plantDemo'

export default {
  name: 'PlantDemoHistory',
  data() {
    return {
      loading: false,
      historyList: []
    }
  },
  created() {
    this.loadHistory()
  },
  methods: {
    async loadHistory() {
      this.loading = true
      try {
        const response = await getHistoryList(getVisitorUid())
        this.historyList = response.data || []
      } finally {
        this.loading = false
      }
    },
    openResult(recordId) {
      this.$router.push(`/plant-demo/result/${recordId}`)
    },
    plantVisualStyle(coverImage) {
      return getPlantCoverStyle(coverImage)
    }
  }
}
</script>

<style lang="scss" scoped>
.demo-page {
  max-width: 1200px;
  margin: 0 auto;
}

.page-head {
  display: flex;
  align-items: flex-end;
  justify-content: space-between;
  gap: 16px;
  margin-bottom: 18px;
}

.section-kicker {
  margin: 0 0 8px;
  color: #6c7c59;
  letter-spacing: 2px;
}

h1,
h2 {
  margin: 0;
  color: #21351c;
}

h1 {
  font-size: 36px;
}

h2 {
  font-size: 28px;
}

.primary-link,
.text-link {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  color: #274d2a;
  text-decoration: none;
  cursor: pointer;
}

.primary-link {
  padding: 12px 18px;
  border-radius: 999px;
  background: #274d2a;
  color: #fffdf4;
}

.history-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 18px;
}

.history-card {
  overflow: hidden;
  border-radius: 28px;
  background: rgba(255, 252, 246, 0.88);
  box-shadow: 0 24px 60px rgba(56, 73, 45, 0.12);
}

.history-visual {
  min-height: 220px;
  padding: 18px;
  display: flex;
  align-items: flex-start;
}

.history-body {
  padding: 24px 28px 28px;

  p {
    margin: 16px 0 20px;
    color: #4f5d42;
    line-height: 1.8;
  }
}

.card-time,
.result-badge {
  display: inline-flex;
  padding: 8px 12px;
  border-radius: 999px;
  background: rgba(255, 252, 246, 0.88);
  color: #6c7c59;
  font-size: 12px;
}

.card-actions {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 10px;
}

@media (max-width: 900px) {
  .history-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .page-head {
    flex-direction: column;
    align-items: flex-start;
  }

  .history-visual {
    min-height: 200px;
  }
}
</style>