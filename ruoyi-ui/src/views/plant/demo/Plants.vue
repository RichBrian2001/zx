<template>
  <section class="demo-page">
    <div class="page-head">
      <div>
        <p class="section-kicker">所有植物</p>
        <h1>浏览当前已上架的全部植物</h1>
        <p class="page-lead">按当前上架状态集中展示，支持直接进入详情页，也可以在列表中完成收藏。</p>
      </div>
      <div class="count-card">
        <span>已上架植物</span>
        <strong>{{ total }}</strong>
      </div>
    </div>

    <div class="plant-grid" v-loading="loading">
      <article v-for="item in plantList" :key="item.plantId" class="plant-card">
        <div class="plant-visual" :style="plantVisualStyle(item.coverImage)"></div>
        <div class="plant-body">
          <div class="card-top">
            <div>
              <p class="category-chip">{{ item.categoryName || '已上架植物' }}</p>
              <h2>{{ item.plantName }}</h2>
              <p v-if="item.aliasName" class="alias-name">别名：{{ item.aliasName }}</p>
            </div>
            <span class="scene-chip">{{ formatScene(item.suitableScene) }}</span>
          </div>

          <p class="summary-text">{{ item.plantSummary }}</p>

          <div class="meta-row">
            <span class="meta-pill">{{ formatDifficulty(item.difficultyLevel) }}</span>
            <span class="meta-pill">{{ formatPrice(item.priceLevel) }}</span>
            <span class="meta-pill" :class="isPetSafe(item.petSafeFlag) ? 'meta-pill-safe' : 'meta-pill-warn'">
              {{ isPetSafe(item.petSafeFlag) ? '宠物友好' : '宠物慎选' }}
            </span>
          </div>

          <div class="card-actions">
            <el-button class="detail-button" type="primary" plain @click="openPlant(item.plantId)">查看详情</el-button>
            <el-button
              class="favorite-button"
              :loading="Boolean(actionLoading[item.plantId])"
              @click="toggleFavorite(item)"
            >
              {{ isFavorite(item.plantId) ? '取消收藏' : '加入收藏' }}
            </el-button>
          </div>
        </div>
      </article>
      <el-empty v-if="!loading && !plantList.length" description="暂无已上架植物"></el-empty>
    </div>

    <div v-if="total > pageSize" class="pagination-wrap">
      <el-pagination
        background
        layout="prev, pager, next"
        :current-page.sync="pageNum"
        :page-size="pageSize"
        :total="total"
        @current-change="handlePageChange"
      />
    </div>
  </section>
</template>

<script>
import { addFavorite, cancelFavorite, getFavoriteList, getPublishedPlantList } from '@/api/plant/app'
import { getPlantCoverStyle } from '@/utils/plantAsset'
import { getVisitorUid } from '@/utils/plantDemo'

const difficultyLabelMap = {
  '1': 'L1 入门',
  '2': 'L2 进阶',
  '3': 'L3 高阶'
}

const priceLabelMap = {
  '1': 'P1 低预算',
  '2': 'P2 中预算',
  '3': 'P3 高预算'
}

export default {
  name: 'PlantDemoPlants',
  data() {
    return {
      loading: false,
      pageNum: 1,
      pageSize: 12,
      total: 0,
      plantList: [],
      favoritePlantIds: [],
      actionLoading: {}
    }
  },
  created() {
    this.loadPageData()
  },
  methods: {
    async loadPageData() {
      this.loading = true
      try {
        const [plantResponse, favoriteResponse] = await Promise.all([
          getPublishedPlantList(this.pageNum, this.pageSize),
          getFavoriteList(getVisitorUid())
        ])
        const pageData = plantResponse.data || {}
        this.plantList = pageData.rows || []
        this.total = pageData.total || 0
        this.favoritePlantIds = (favoriteResponse.data || []).map(item => item.plantId)
      } finally {
        this.loading = false
      }
    },
    handlePageChange(pageNum) {
      this.pageNum = pageNum
      this.loadPageData()
    },
    openPlant(plantId) {
      this.$router.push(`/plant-demo/plant/${plantId}`)
    },
    isFavorite(plantId) {
      return this.favoritePlantIds.includes(plantId)
    },
    isPetSafe(petSafeFlag) {
      return String(petSafeFlag) === '1'
    },
    formatDifficulty(difficultyLevel) {
      return difficultyLabelMap[String(difficultyLevel)] || `难度 ${difficultyLevel}`
    },
    formatPrice(priceLevel) {
      return priceLabelMap[String(priceLevel)] || `价格 ${priceLevel}`
    },
    formatScene(suitableScene) {
      if (!suitableScene) {
        return '多场景适配'
      }
      return suitableScene.split('、')[0]
    },
    plantVisualStyle(coverImage) {
      return getPlantCoverStyle(coverImage)
    },
    async toggleFavorite(item) {
      const plantId = item.plantId
      this.$set(this.actionLoading, plantId, true)
      try {
        if (this.isFavorite(plantId)) {
          await cancelFavorite(getVisitorUid(), plantId)
          this.favoritePlantIds = this.favoritePlantIds.filter(id => id !== plantId)
          this.$message.success('已取消收藏')
          return
        }

        await addFavorite({ visitorUid: getVisitorUid(), plantId })
        this.favoritePlantIds = [...this.favoritePlantIds, plantId]
        this.$message.success('已加入收藏')
      } finally {
        this.$set(this.actionLoading, plantId, false)
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.demo-page {
  --page-accent: #2d6b37;
  --page-accent-strong: #234f2c;
  --page-accent-soft: rgba(45, 107, 55, 0.1);
  --page-accent-line: rgba(45, 107, 55, 0.18);
  max-width: 1240px;
  margin: 0 auto;
}

.page-head {
  display: grid;
  grid-template-columns: minmax(0, 1fr) 220px;
  gap: 18px;
  align-items: stretch;
  margin-bottom: 20px;
}

.section-kicker {
  margin: 0 0 8px;
  color: #6c7c59;
  letter-spacing: 2px;
}

h1,
h2,
p {
  margin: 0;
}

h1 {
  color: #21351c;
  font-size: 36px;
}

h2 {
  color: #21351c;
  font-size: 24px;
  line-height: 1.25;
}

.page-lead {
  max-width: 780px;
  margin-top: 12px;
  color: #4f5d42;
  line-height: 1.8;
}

.count-card,
.plant-card {
  border-radius: 28px;
  background: rgba(255, 252, 246, 0.88);
  box-shadow: 0 24px 60px rgba(56, 73, 45, 0.12);
}

.count-card {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  padding: 24px 26px;
  border: 1px solid rgba(39, 77, 42, 0.1);

  span {
    color: #6b7a5a;
  }

  strong {
    color: #21351c;
    font-size: 52px;
    line-height: 1;
  }
}

.plant-grid {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 18px;
}

.plant-card {
  overflow: hidden;
}

.plant-visual {
  min-height: 220px;
}

.plant-body {
  display: flex;
  flex-direction: column;
  gap: 16px;
  padding: 22px 22px 24px;
}

.card-top {
  display: flex;
  justify-content: space-between;
  gap: 12px;
}

.category-chip,
.scene-chip,
.meta-pill {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: fit-content;
  border-radius: 999px;
}

.category-chip {
  margin-bottom: 10px;
  padding: 6px 10px;
  background: rgba(39, 77, 42, 0.08);
  color: #47623f;
  font-size: 12px;
}

.scene-chip {
  flex-shrink: 0;
  height: fit-content;
  padding: 7px 10px;
  background: rgba(237, 241, 231, 0.9);
  color: #5b6e52;
  font-size: 12px;
}

.alias-name {
  margin-top: 8px;
  color: #6b7a5a;
  font-size: 13px;
}

.summary-text {
  color: #4f5d42;
  line-height: 1.8;
  display: -webkit-box;
  overflow: hidden;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  min-height: 86px;
}

.meta-row,
.card-actions {
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
}

.meta-pill {
  padding: 8px 12px;
  background: rgba(39, 77, 42, 0.08);
  color: #47623f;
  font-size: 12px;
}

.meta-pill-safe {
  background: rgba(54, 143, 104, 0.12);
  color: #2e7b59;
}

.meta-pill-warn {
  background: rgba(222, 169, 48, 0.16);
  color: #9d6b11;
}

.card-actions {
  margin-top: auto;
}

.card-actions ::v-deep .el-button {
  min-width: 108px;
  padding: 11px 18px;
  border-radius: 999px;
  font-weight: 600;
  transition: transform 0.2s ease, box-shadow 0.2s ease, background 0.2s ease, border-color 0.2s ease;

  &:hover,
  &:focus {
    transform: translateY(-1px);
  }
}

.card-actions ::v-deep .el-button.detail-button {
  background: linear-gradient(135deg, var(--page-accent), #5f874a);
  border-color: transparent;
  color: #fffdf4;
  box-shadow: 0 12px 24px rgba(45, 107, 55, 0.18);
}

.card-actions ::v-deep .el-button.detail-button:hover,
.card-actions ::v-deep .el-button.detail-button:focus {
  background: linear-gradient(135deg, var(--page-accent-strong), var(--page-accent));
  color: #fffdf4;
}

.card-actions ::v-deep .el-button.favorite-button {
  border-color: var(--page-accent-line);
  background: var(--page-accent-soft);
  color: var(--page-accent-strong);
}

.card-actions ::v-deep .el-button.favorite-button:hover,
.card-actions ::v-deep .el-button.favorite-button:focus {
  border-color: rgba(45, 107, 55, 0.28);
  background: rgba(45, 107, 55, 0.16);
  color: var(--page-accent-strong);
}

.pagination-wrap {
  display: flex;
  justify-content: center;
  margin-top: 24px;
}

.pagination-wrap ::v-deep .el-pagination.is-background .btn-prev,
.pagination-wrap ::v-deep .el-pagination.is-background .btn-next,
.pagination-wrap ::v-deep .el-pagination.is-background .el-pager li {
  min-width: 38px;
  height: 38px;
  line-height: 38px;
  border-radius: 12px;
  background: rgba(255, 252, 246, 0.96);
  border: 1px solid var(--page-accent-line);
  color: #47623f;
  font-weight: 600;
}

.pagination-wrap ::v-deep .el-pagination.is-background .el-pager li:not(.disabled):hover,
.pagination-wrap ::v-deep .el-pagination.is-background .btn-prev:hover,
.pagination-wrap ::v-deep .el-pagination.is-background .btn-next:hover {
  color: var(--page-accent-strong);
  border-color: rgba(45, 107, 55, 0.32);
}

.pagination-wrap ::v-deep .el-pagination.is-background .el-pager li.active {
  background: linear-gradient(135deg, var(--page-accent), #5f874a);
  border-color: transparent;
  color: #fffdf4;
  box-shadow: 0 12px 24px rgba(45, 107, 55, 0.18);
}

@media (max-width: 1280px) {
  .plant-grid {
    grid-template-columns: repeat(3, minmax(0, 1fr));
  }
}

@media (max-width: 980px) {
  .page-head {
    grid-template-columns: 1fr;
  }

  .count-card {
    max-width: 260px;
  }

  .plant-grid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
}

@media (max-width: 768px) {
  h1 {
    font-size: 30px;
  }

  .plant-grid {
    grid-template-columns: 1fr;
  }

  .card-top {
    flex-direction: column;
  }

  .plant-visual {
    min-height: 210px;
  }
}
</style>