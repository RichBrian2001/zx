<template>
  <section class="demo-page" v-loading="loading">
    <div class="detail-hero">
      <div class="hero-copy demo-card hero-card">
        <p class="section-kicker">植物详情</p>
        <h1>{{ detail.plantName || '植物详情加载中' }}</h1>
        <p class="lead">{{ detail.plantSummary || '这里会展示植物的养护条件、标签信息以及相关文章。' }}</p>

        <div class="hero-pills">
          <span v-for="item in heroPills" :key="item.label" class="hero-pill">
            <strong>{{ item.value }}</strong>
            <em>{{ item.label }}</em>
          </span>
        </div>

        <div class="hero-actions">
          <el-button type="primary" @click="saveFavorite">加入收藏</el-button>
          <el-button @click="$router.back()">返回上一页</el-button>
        </div>

        <div class="fact-grid">
          <div v-for="item in careFacts" :key="item.label" class="fact-card">
            <span>{{ item.label }}</span>
            <strong>{{ item.value }}</strong>
          </div>
        </div>
      </div>

      <div class="detail-side">
        <div class="hero-visual" :style="plantVisualStyle(detail.coverImage)">
          <div class="visual-caption">
            <span>{{ detail.aliasName || '植物档案' }}</span>
            <strong>{{ detail.petSafeFlag === '1' ? '更适合有宠家庭' : '室内场景推荐' }}</strong>
          </div>
        </div>
        <div class="care-panel">
          <h2>适配提醒</h2>
          <dl>
            <div v-for="item in detailInsights" :key="item.label">
              <dt>{{ item.label }}</dt>
              <dd>{{ item.value }}</dd>
            </div>
          </dl>
        </div>
      </div>
    </div>

    <div class="content-grid">
      <div class="demo-card">
        <p class="section-kicker">养护提示</p>
        <h2>日常照顾重点</h2>
        <p class="copy-text">{{ detail.careTips || '暂无养护提示' }}</p>
        <p class="copy-text warn-text">{{ detail.riskTips || '暂无风险提示' }}</p>
      </div>

      <div class="demo-card">
        <p class="section-kicker">标签</p>
        <h2>推荐标签画像</h2>
        <div v-if="tagDisplayList.length" class="tag-cloud">
          <span v-for="item in tagDisplayList" :key="item.key" class="tag-chip">
            {{ item.name }}
          </span>
        </div>
        <el-empty v-else description="暂无标签"></el-empty>
      </div>
    </div>

    <div class="demo-card article-panel">
      <div class="article-head">
        <div>
          <p class="section-kicker">相关文章</p>
          <h2>内容联动</h2>
        </div>
        <span class="article-count">{{ (detail.articleList && detail.articleList.length) || 0 }} 篇内容</span>
      </div>
      <div v-if="detail.articleList && detail.articleList.length" class="article-grid">
        <article v-for="item in detail.articleList" :key="item.articleId" class="article-card">
          <div class="article-visual" :style="articleVisualStyle(item.coverImage)"></div>
          <span class="article-type">{{ formatArticleType(item.articleType) }}</span>
          <h3>{{ item.title }}</h3>
          <p>{{ item.summary }}</p>
        </article>
      </div>
      <el-empty v-else description="暂无相关文章"></el-empty>
    </div>
  </section>
</template>

<script>
import { addFavorite, getPlantDetail } from '@/api/plant/app'
import { getArticleCoverStyle, getPlantCoverStyle } from '@/utils/plantAsset'
import { getVisitorUid } from '@/utils/plantDemo'

export default {
  name: 'PlantDemoPlantDetail',
  data() {
    return {
      loading: false,
      detail: {
        tagList: [],
        articleList: []
      }
    }
  },
  computed: {
    heroPills() {
      return [
        { label: '养护难度', value: this.detail.difficultyLevel || '待补充' },
        { label: '预算级别', value: this.detail.priceLevel || '待补充' },
        { label: '推荐场景', value: this.detail.suitableScene || '待补充' }
      ]
    },
    careFacts() {
      return [
        { label: '光照', value: this.detail.lightRequirement || '待补充' },
        { label: '浇水', value: this.detail.waterRequirement || '待补充' },
        { label: '温度', value: this.detail.temperatureRange || '待补充' },
        { label: '湿度', value: this.detail.humidityRequirement || '待补充' }
      ]
    },
    detailInsights() {
      return [
        { label: '别名', value: this.detail.aliasName || '暂无别名' },
        { label: '宠物相处', value: this.detail.petSafeFlag === '1' ? '相对更友好' : '建议保持距离' },
        { label: '适配场景', value: this.detail.suitableScene || '待补充' },
        { label: '上手建议', value: this.detail.difficultyLevel ? ('建议按 ' + this.detail.difficultyLevel + ' 难度准备养护节奏') : '待补充' }
      ]
    },
    tagDisplayList() {
      return (this.detail.tagList || []).filter(item => item && item.tagName).map(item => ({
        key: `${item.tagId}-${item.relId || item.tagCode}`,
        name: item.tagName
      }))
    }
  },
  created() {
    this.loadDetail()
  },
  watch: {
    '$route.params.plantId': 'loadDetail'
  },
  methods: {
    async loadDetail() {
      this.loading = true
      try {
        const response = await getPlantDetail(this.$route.params.plantId)
        this.detail = response.data || this.detail
      } finally {
        this.loading = false
      }
    },
    async saveFavorite() {
      await addFavorite({ visitorUid: getVisitorUid(), plantId: this.$route.params.plantId })
      this.$message.success('已加入收藏')
    },
    plantVisualStyle(coverImage) {
      return getPlantCoverStyle(coverImage)
    },
    articleVisualStyle(coverImage) {
      return getArticleCoverStyle(coverImage)
    },
    formatArticleType(type) {
      const typeMap = {
        knowledge: '植物百科',
        guide: '场景指南',
        news: '养护资讯'
      }
      return typeMap[type] || '植物百科'
    }
  }
}
</script>

<style lang="scss" scoped>
.demo-page {
  max-width: 1200px;
  margin: 0 auto;
}

.detail-hero,
.content-grid,
.article-grid,
.detail-side,
.fact-grid {
  display: grid;
  gap: 18px;
}

.detail-hero {
  grid-template-columns: minmax(0, 1.5fr) minmax(280px, 0.7fr);
}

.content-grid {
  margin-top: 18px;
  grid-template-columns: repeat(2, minmax(0, 1fr));
}

.detail-side {
  align-content: start;
}

.hero-card,
.care-panel,
.demo-card {
  border-radius: 28px;
  padding: 32px;
  background: rgba(255, 252, 246, 0.88);
  box-shadow: 0 24px 60px rgba(56, 73, 45, 0.12);
}

.hero-card {
  background: linear-gradient(180deg, rgba(255, 252, 246, 0.96) 0%, rgba(248, 252, 244, 0.92) 100%);
}

.hero-visual {
  min-height: 250px;
  border-radius: 28px;
  padding: 24px;
  display: flex;
  align-items: flex-end;
  box-shadow: 0 24px 60px rgba(56, 73, 45, 0.12);
}

.visual-caption {
  display: inline-flex;
  flex-direction: column;
  gap: 6px;
  padding: 14px 16px;
  border-radius: 18px;
  background: rgba(255, 252, 246, 0.88);

  span {
    color: #6c7c59;
    font-size: 12px;
    letter-spacing: 1px;
  }

  strong {
    color: #21351c;
    font-size: 18px;
  }
}

.section-kicker {
  margin: 0 0 8px;
  color: #6c7c59;
  letter-spacing: 2px;
}

h1,
h2,
h3 {
  margin: 0;
  color: #21351c;
}

h1 {
  font-size: 40px;
  margin-bottom: 14px;
}

h2 {
  font-size: 28px;
  margin-bottom: 16px;
}

h3 {
  font-size: 22px;
  margin-bottom: 10px;
}

.lead,
.copy-text,
.article-card p {
  color: #4f5d42;
  line-height: 1.8;
}

.hero-pills,
.hero-actions,
.tag-cloud {
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
}

.hero-pills,
.hero-actions {
  margin-top: 18px;
}

.hero-pill,
.tag-chip {
  display: inline-flex;
  align-items: center;
  padding: 8px 12px;
  border-radius: 999px;
  background: rgba(39, 77, 42, 0.08);
  color: #47623f;
  font-size: 12px;
}

.hero-pill {
  flex-direction: column;
  align-items: flex-start;
  gap: 4px;
  min-width: 112px;
  padding: 12px 14px;

  strong {
    color: #21351c;
    font-size: 18px;
    line-height: 1;
  }

  em {
    font-style: normal;
    color: #6c7c59;
  }
}

.fact-grid {
  margin-top: 24px;
  grid-template-columns: repeat(2, minmax(0, 1fr));
}

.fact-card {
  padding: 16px 18px;
  border-radius: 20px;
  background: rgba(39, 77, 42, 0.06);

  span {
    display: block;
    margin-bottom: 8px;
    color: #6c7c59;
    font-size: 12px;
    letter-spacing: 1px;
  }

  strong {
    color: #21351c;
    font-size: 18px;
    line-height: 1.4;
  }
}

.care-panel dl {
  margin: 0;
}

.care-panel div {
  display: flex;
  justify-content: space-between;
  gap: 16px;
  padding: 12px 0;
  border-bottom: 1px solid rgba(39, 77, 42, 0.08);
}

.care-panel dt {
  color: #6c7c59;
}

.care-panel dd {
  margin: 0;
  color: #21351c;
  text-align: right;
}

.warn-text {
  color: #8c4f39;
}

.article-panel {
  margin-top: 18px;
}

.article-head {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 16px;
  margin-bottom: 18px;
}

.article-grid {
  grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
}

.article-card {
  overflow: hidden;
  padding: 16px;
  border-radius: 20px;
  background: rgba(39, 77, 42, 0.06);

  h3 {
    margin-top: 14px;
  }
}

.article-visual {
  height: 164px;
  border-radius: 18px;
}

.article-type {
  display: inline-flex;
  margin-top: 14px;
  padding: 6px 10px;
  border-radius: 999px;
  background: #fff4d8;
  color: #8b6112;
  font-size: 12px;
}

.article-count {
  display: inline-flex;
  align-items: center;
  padding: 8px 12px;
  border-radius: 999px;
  background: rgba(39, 77, 42, 0.08);
  color: #47623f;
  font-size: 12px;
}

@media (max-width: 1100px) {
  .detail-hero,
  .content-grid,
  .article-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .hero-card,
  .care-panel,
  .demo-card {
    padding: 22px;
    border-radius: 22px;
  }

  h1 {
    font-size: 32px;
  }

  .hero-visual {
    min-height: 220px;
    border-radius: 22px;
  }

  .fact-grid,
  .content-grid {
    grid-template-columns: 1fr;
  }

  .article-head {
    flex-direction: column;
  }
}
</style>