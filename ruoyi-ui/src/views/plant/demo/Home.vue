<template>
  <section class="demo-page">
    <div class="hero-grid">
      <div class="demo-card hero-card" v-loading="loading">
        <p class="eyebrow">植物个性化推荐系统</p>
        <h1>把空间条件和养护偏好，快速转成可解释的植物建议。</h1>
        <p class="lead">围绕空间条件、光照偏好、预算和养护投入，系统会联动植物库、推荐规则与养护内容，快速生成贴近实际场景的选植物建议。</p>
        <div class="hero-actions">
          <router-link class="primary-link" to="/plant-demo/questionnaire">开始一次推荐</router-link>
          <router-link class="secondary-link" to="/plant-demo/history">查看推荐历史</router-link>
        </div>
      </div>
      <div class="stats-column" v-loading="loading">
        <div class="stat-card">
          <span>已上架植物</span>
          <strong>{{ summary.plantTotal || 0 }}</strong>
        </div>
        <div class="stat-card accent-card">
          <span>累计推荐记录</span>
          <strong>{{ summary.recommendTotal || 0 }}</strong>
        </div>
      </div>
    </div>

    <div class="section-head">
      <div>
        <p class="section-kicker">精选植物</p>
        <h2>适合不同空间场景的精选植物</h2>
      </div>
      <router-link class="section-link" to="/plant-demo/questionnaire">从问卷进入个性推荐</router-link>
    </div>

    <div class="card-grid" v-loading="loading">
      <article v-for="item in summary.featuredPlantList" :key="item.plantId" class="plant-card">
        <div class="plant-visual" :style="plantImageStyle(item.coverImage)"></div>
        <div class="plant-body">
          <div class="pill-row">
            <span class="pill">难度 {{ item.difficultyLevel }}</span>
            <span class="pill">价格 {{ item.priceLevel }}</span>
          </div>
          <h3>{{ item.plantName }}</h3>
          <p>{{ item.plantSummary }}</p>
          <button class="text-link" @click="openPlant(item.plantId)">查看详情</button>
        </div>
      </article>
      <el-empty v-if="!loading && !summary.featuredPlantList.length" description="暂无植物数据"></el-empty>
    </div>

    <div class="section-head article-head">
      <div>
        <p class="section-kicker">养护内容</p>
        <h2>最近发布的场景文章</h2>
      </div>
    </div>

    <div class="article-grid" v-loading="loading">
      <article v-for="item in summary.latestArticleList" :key="item.articleId" class="article-card">
        <div class="article-visual" :style="articleImageStyle(item.coverImage)"></div>
        <span class="article-type">{{ item.articleType || '知识' }}</span>
        <h3>{{ item.title }}</h3>
        <p>{{ item.summary }}</p>
        <button class="text-link" @click="openArticlePlant(item.relatedPlantId)">关联植物</button>
      </article>
      <el-empty v-if="!loading && !summary.latestArticleList.length" description="暂无内容文章"></el-empty>
    </div>
  </section>
</template>

<script>
import { getHomeSummary } from '@/api/plant/app'
import { getArticleCoverStyle, getPlantCoverStyle } from '@/utils/plantAsset'

export default {
  name: 'PlantDemoHome',
  data() {
    return {
      loading: false,
      summary: {
        featuredPlantList: [],
        latestArticleList: [],
        plantTotal: 0,
        recommendTotal: 0
      }
    }
  },
  created() {
    this.loadSummary()
  },
  methods: {
    async loadSummary() {
      this.loading = true
      try {
        const response = await getHomeSummary()
        this.summary = response.data || this.summary
      } finally {
        this.loading = false
      }
    },
    openPlant(plantId) {
      this.$router.push(`/plant-demo/plant/${plantId}`)
    },
    openArticlePlant(plantId) {
      if (!plantId) {
        return
      }
      this.openPlant(plantId)
    },
    plantImageStyle(coverImage) {
      return getPlantCoverStyle(coverImage)
    },
    articleImageStyle(coverImage) {
      return getArticleCoverStyle(coverImage)
    }
  }
}
</script>

<style lang="scss" scoped>
.demo-page {
  max-width: 1200px;
  margin: 0 auto;
}

.hero-grid {
  display: grid;
  grid-template-columns: minmax(0, 1.8fr) minmax(260px, 0.8fr);
  gap: 18px;
}

.demo-card,
.stat-card,
.plant-card,
.article-card {
  border-radius: 28px;
  padding: 32px;
  background: rgba(255, 252, 246, 0.86);
  box-shadow: 0 24px 60px rgba(56, 73, 45, 0.12);
}

.hero-card {
  min-height: 360px;
  background:
    radial-gradient(circle at top right, rgba(106, 135, 85, 0.2), transparent 34%),
    rgba(255, 252, 246, 0.88);
}

.eyebrow {
  margin: 0 0 14px;
  color: #6c7c59;
  letter-spacing: 3px;
}

h1 {
  margin: 0 0 16px;
  color: #21351c;
  font-size: 46px;
  line-height: 1.1;
}

.lead {
  max-width: 640px;
  color: #4f5d42;
  font-size: 17px;
  line-height: 1.8;
}

.hero-actions {
  display: flex;
  gap: 12px;
  margin-top: 24px;
  flex-wrap: wrap;
}

.primary-link {
  display: inline-flex;
  padding: 12px 18px;
  border-radius: 999px;
  background: #274d2a;
  color: #fffdf4;
  text-decoration: none;
}

.secondary-link,
.section-link,
.text-link {
  display: inline-flex;
  align-items: center;
  color: #274d2a;
  text-decoration: none;
  background: transparent;
  border: 0;
  padding: 0;
  cursor: pointer;
  font-weight: 600;
}

.stats-column {
  display: grid;
  gap: 18px;
}

.stat-card {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  min-height: 171px;
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

.accent-card {
  background: linear-gradient(135deg, #274d2a, #5f7e45);

  span,
  strong {
    color: #fffdf4;
  }
}

.section-head {
  display: flex;
  align-items: flex-end;
  justify-content: space-between;
  margin: 34px 0 18px;
  gap: 16px;
}

.section-kicker {
  margin: 0 0 6px;
  color: #6c7c59;
  letter-spacing: 2px;
}

h2 {
  margin: 0;
  color: #21351c;
  font-size: 30px;
}

.card-grid,
.article-grid {
  display: grid;
  gap: 18px;
}

.card-grid {
  grid-template-columns: repeat(3, minmax(0, 1fr));
}

.article-grid {
  grid-template-columns: repeat(2, minmax(0, 1fr));
}

.plant-card,
.article-card {
  padding: 18px;
}

.plant-visual {
  height: 220px;
  border-radius: 22px;
}

.article-visual {
  height: 180px;
  margin-bottom: 16px;
  border-radius: 22px;
}

.plant-body {
  padding: 16px 6px 8px;

  h3 {
    margin: 10px 0 10px;
    color: #21351c;
    font-size: 22px;
  }

  p {
    min-height: 72px;
    margin: 0 0 12px;
    color: #4f5d42;
    line-height: 1.7;
  }
}

.pill-row {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
}

.pill {
  padding: 6px 10px;
  border-radius: 999px;
  background: rgba(39, 77, 42, 0.08);
  color: #45613d;
  font-size: 12px;
}

.article-card {
  min-height: 220px;

  h3 {
    margin: 16px 0 12px;
    color: #21351c;
    font-size: 24px;
    line-height: 1.35;
  }

  p {
    margin: 0 0 18px;
    color: #4f5d42;
    line-height: 1.8;
  }
}

.article-type {
  display: inline-flex;
  padding: 6px 10px;
  border-radius: 999px;
  background: #fff4d8;
  color: #8b6112;
  font-size: 12px;
}

@media (max-width: 1100px) {
  .hero-grid,
  .card-grid,
  .article-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .demo-card,
  .stat-card,
  .plant-card,
  .article-card {
    padding: 22px;
    border-radius: 22px;
  }

  h1 {
    font-size: 34px;
  }

  .section-head {
    align-items: flex-start;
    flex-direction: column;
  }
}
</style>