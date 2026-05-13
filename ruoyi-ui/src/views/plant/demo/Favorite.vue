<template>
  <section class="demo-page">
    <div class="page-head">
      <div>
        <p class="section-kicker">植物收藏</p>
        <h1>你保留下来的候选植物</h1>
      </div>
      <router-link class="secondary-link" to="/plant-demo/history">从历史中继续挑选</router-link>
    </div>

    <div class="favorite-grid" v-loading="loading">
      <article v-for="item in favoriteList" :key="item.favoriteId" class="favorite-card">
        <div class="favorite-visual" :style="plantVisualStyle(item.coverImage)"></div>
        <div class="favorite-body">
          <h2>{{ item.plantName }}</h2>
          <p>{{ item.plantSummary }}</p>
          <div class="tag-row">
            <span class="tag-item">难度 {{ item.difficultyLevel }}</span>
            <span class="tag-item">价格 {{ item.priceLevel }}</span>
          </div>
          <div class="card-actions">
            <el-button type="primary" plain @click="openPlant(item.plantId)">查看详情</el-button>
            <el-button @click="removeFavorite(item.plantId)">取消收藏</el-button>
          </div>
        </div>
      </article>
      <el-empty v-if="!loading && !favoriteList.length" description="还没有收藏植物"></el-empty>
    </div>
  </section>
</template>

<script>
import { cancelFavorite, getFavoriteList } from '@/api/plant/app'
import { getPlantCoverStyle } from '@/utils/plantAsset'
import { getVisitorUid } from '@/utils/plantDemo'

export default {
  name: 'PlantDemoFavorite',
  data() {
    return {
      loading: false,
      favoriteList: []
    }
  },
  created() {
    this.loadFavoriteList()
  },
  methods: {
    async loadFavoriteList() {
      this.loading = true
      try {
        const response = await getFavoriteList(getVisitorUid())
        this.favoriteList = response.data || []
      } finally {
        this.loading = false
      }
    },
    openPlant(plantId) {
      this.$router.push(`/plant-demo/plant/${plantId}`)
    },
    async removeFavorite(plantId) {
      await cancelFavorite(getVisitorUid(), plantId)
      this.$message.success('已取消收藏')
      this.loadFavoriteList()
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
  font-size: 26px;
}

.secondary-link {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 12px 18px;
  border-radius: 999px;
  border: 1px solid rgba(39, 77, 42, 0.18);
  color: #274d2a;
  text-decoration: none;
}

.favorite-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 18px;
}

.favorite-card {
  overflow: hidden;
  border-radius: 28px;
  background: rgba(255, 252, 246, 0.88);
  box-shadow: 0 24px 60px rgba(56, 73, 45, 0.12);
}

.favorite-visual {
  min-height: 220px;
}

.favorite-body {
  padding: 24px 28px 28px;

  p {
    margin: 14px 0 18px;
    color: #4f5d42;
    line-height: 1.8;
  }
}

.tag-row,
.card-actions {
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
}

.tag-item {
  display: inline-flex;
  padding: 8px 12px;
  border-radius: 999px;
  background: rgba(39, 77, 42, 0.08);
  color: #47623f;
  font-size: 12px;
}

.card-actions {
  margin-top: 18px;
}

@media (max-width: 900px) {
  .favorite-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .page-head {
    flex-direction: column;
    align-items: flex-start;
  }

  .favorite-visual {
    min-height: 200px;
  }
}
</style>