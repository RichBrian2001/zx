<template>
  <section class="demo-page">
    <div class="result-grid" v-loading="loading">
      <div>
        <div class="hero-card">
          <div class="hero-top">
            <div class="hero-copy">
              <p class="section-kicker">推荐结果</p>
              <h1>{{ result.topPlantName || '正在生成推荐摘要' }}</h1>
              <p class="lead">根据你当前的空间、光照和养护偏好，系统优先返回了 {{ result.resultCount || 0 }} 个候选植物。首位推荐可以直接加入收藏或继续查看详情。</p>
              <div class="meta-row">
                <span class="meta-pill">记录 #{{ result.recordId }}</span>
                <span class="meta-pill">候选 {{ result.totalCandidateCount || 0 }}</span>
                <span class="meta-pill">返回 {{ result.resultCount || 0 }}</span>
              </div>
              <div class="hero-actions">
                <router-link class="primary-link" :to="`/plant-demo/feedback/${$route.params.recordId}`">提交反馈</router-link>
                <router-link class="secondary-link" to="/plant-demo/favorite">查看收藏</router-link>
              </div>
            </div>
            <div class="hero-visual" :style="topPlantVisualStyle">
              <div class="hero-visual-badge">
                <span>首位推荐</span>
                <strong>{{ topPlantItem.plantName || result.topPlantName || '植物建议' }}</strong>
              </div>
            </div>
          </div>
        </div>

        <div class="cards-head">
          <div>
            <p class="section-kicker">推荐卡片</p>
            <h2>可解释推荐结果</h2>
          </div>
          <router-link class="secondary-link" to="/plant-demo/history">查看历史</router-link>
        </div>

        <div class="result-card-list">
          <article v-for="item in result.resultItems" :key="item.plantId" class="result-card">
            <div class="result-visual" :style="plantVisualStyle(item.coverImage)"></div>
            <div class="result-main">
              <div class="result-header">
                <div>
                  <span class="rank-badge">TOP {{ item.rankNum }}</span>
                  <h3>{{ item.plantName }}</h3>
                </div>
                <div class="score-box">
                  <strong>{{ item.scoreTotal }}</strong>
                  <span>总分</span>
                </div>
              </div>
              <p class="reason-text">{{ item.reasonText }}</p>
              <div class="tag-row">
                <span class="tag-item">难度 {{ item.difficultyLevel }}</span>
                <span class="tag-item">价格 {{ item.priceLevel }}</span>
                <span class="tag-item">场景 {{ item.suitableScene }}</span>
              </div>
              <div class="detail-stack">
                <div class="risk-panel">
                  <label>风险提示</label>
                  <p>{{ item.riskTips || '暂无额外风险提示' }}</p>
                </div>
                <div class="detail-panel">
                  <label>推荐依据</label>
                  <ul class="detail-list">
                    <li v-for="detail in scoreBreakdownList(item)" :key="detail.key" class="detail-item">
                      <div class="detail-item-head">
                        <strong>{{ detail.label }}</strong>
                        <span v-if="detail.scoreText">+{{ detail.scoreText }} 分</span>
                      </div>
                      <p>{{ detail.description }}</p>
                    </li>
                  </ul>
                </div>
              </div>
              <div class="card-actions">
                <el-button type="primary" plain @click="openPlant(item.plantId)">查看详情</el-button>
                <el-button :loading="favoriteLoadingId === item.plantId" @click="saveFavorite(item.plantId)">加入收藏</el-button>
              </div>
            </div>
          </article>
          <el-empty v-if="!loading && !result.resultItems.length" description="暂无推荐结果"></el-empty>
        </div>
      </div>

      <aside class="side-panel">
        <div class="side-card">
          <p class="section-kicker">匹配说明</p>
          <p class="side-summary">{{ matchSummary.overview }}</p>
          <div class="match-chip-row" v-if="matchSummary.contextPills.length">
            <span v-for="item in matchSummary.contextPills" :key="item.key" class="match-chip">{{ item.label }} · {{ item.value }}</span>
          </div>
          <div class="match-rule-panel">
            <label>本次命中重点</label>
            <ul class="match-rule-list">
              <li v-for="rule in matchSummary.ruleTexts" :key="rule">{{ rule }}</li>
            </ul>
          </div>
        </div>
      </aside>
    </div>
  </section>
</template>

<script>
import { addFavorite, getRecommendResult } from '@/api/plant/app'
import { getPlantCoverStyle } from '@/utils/plantAsset'
import { getVisitorUid } from '@/utils/plantDemo'

const scoreDetailMetaMap = {
  base: {
    label: '基础适配',
    description: '该植物已通过基础候选筛选，具备进入本次排序的基本条件。'
  },
  light: {
    label: '光照契合',
    description: '当前采光条件与它的生长需求更一致。'
  },
  water: {
    label: '养护节奏',
    description: '浇水频率和维护强度更贴近你的日常节奏。'
  },
  space: {
    label: '空间尺度',
    description: '体量和摆放方式更适合当前空间大小。'
  },
  care: {
    label: '养护投入',
    description: '所需投入和你愿意付出的精力更加匹配。'
  },
  budget: {
    label: '预算匹配',
    description: '更容易落在这次的预算范围内。'
  },
  style: {
    label: '风格偏好',
    description: '和你偏好的空间气质更容易保持统一。'
  },
  pet: {
    label: '宠物考虑',
    description: '在宠物家庭场景下获得了更高优先级。'
  },
  goal: {
    label: '目标诉求',
    description: '更贴近这次种植想要达成的主要目标。'
  },
  goal_flag: {
    label: '目标强化',
    description: '在核心用途上还有额外加分。'
  },
  scene: {
    label: '场景适配',
    description: '和你当前计划摆放的场景更加贴合。'
  }
}

const matchContextLabelMap = {
  scene: '使用场景',
  light: '光照条件',
  space: '空间大小',
  pet: '宠物条件',
  care: '养护投入',
  style: '风格偏好',
  goal: '种植目标',
  budget: '预算参考'
}

const sceneTextMap = {
  desk: '桌面',
  bedroom: '卧室',
  living: '客厅',
  office: '办公室',
  balcony: '阳台'
}

const lightTextMap = {
  low: '弱光或半阴',
  medium: '散射光',
  high: '充足日照'
}

const spaceTextMap = {
  small: '小空间',
  medium: '中等空间',
  large: '大空间'
}

const careTextMap = {
  easy: '低维护',
  medium: '中维护',
  hard: '高维护'
}

const styleTextMap = {
  minimal: '简约',
  healing: '治愈',
  tropical: '热带',
  flower: '观花'
}

const goalTextMap = {
  desktop: '桌面陈列',
  layered: '提升空间层次',
  purify: '空气净化',
  aroma: '闻香观花'
}

export default {
  name: 'PlantDemoResult',
  data() {
    return {
      loading: false,
      favoriteLoadingId: null,
      result: {
        recordId: null,
        topPlantId: null,
        topPlantName: '',
        resultCount: 0,
        totalCandidateCount: 0,
        matchRuleJson: '[]',
        resultItems: []
      }
    }
  },
  computed: {
    topPlantItem() {
      if (!this.result.resultItems || !this.result.resultItems.length) {
        return {}
      }
      return this.result.resultItems.find(item => item.plantId === this.result.topPlantId) || this.result.resultItems[0]
    },
    topPlantVisualStyle() {
      return getPlantCoverStyle(this.topPlantItem.coverImage)
    },
    matchSummary() {
      return this.buildMatchSummary(this.result.matchRuleJson)
    }
  },
  created() {
    this.loadResult()
  },
  watch: {
    '$route.params.recordId': 'loadResult'
  },
  methods: {
    async loadResult() {
      this.loading = true
      try {
        const response = await getRecommendResult(this.$route.params.recordId)
        this.result = response.data || this.result
      } finally {
        this.loading = false
      }
    },
    openPlant(plantId) {
      this.$router.push(`/plant-demo/plant/${plantId}`)
    },
    async saveFavorite(plantId) {
      this.favoriteLoadingId = plantId
      try {
        await addFavorite({ visitorUid: getVisitorUid(), plantId })
        this.$message.success('已加入收藏')
      } finally {
        this.favoriteLoadingId = null
      }
    },
    plantVisualStyle(coverImage) {
      return getPlantCoverStyle(coverImage)
    },
    parseJsonObject(value, fallback = {}) {
      if (!value) {
        return fallback
      }
      if (typeof value === 'object') {
        return value
      }
      try {
        const parsed = JSON.parse(value)
        return parsed && typeof parsed === 'object' ? parsed : fallback
      } catch (error) {
        return fallback
      }
    },
    formatScoreValue(value) {
      const numeric = Number(value)
      if (!Number.isFinite(numeric)) {
        return ''
      }
      return numeric.toFixed(1).replace(/\.0$/, '')
    },
    formatMatchContextValue(key, value) {
      if (value === null || value === undefined || value === '') {
        return ''
      }
      if (key === 'scene') {
        return sceneTextMap[value] || value
      }
      if (key === 'light') {
        return lightTextMap[value] || value
      }
      if (key === 'space') {
        return spaceTextMap[value] || value
      }
      if (key === 'pet') {
        return value === true || value === 'true' ? '有宠物家庭' : '无宠物家庭'
      }
      if (key === 'care') {
        return careTextMap[value] || value
      }
      if (key === 'style') {
        return styleTextMap[value] || value
      }
      if (key === 'goal') {
        return goalTextMap[value] || value
      }
      if (key === 'budget') {
        const budget = Number(value)
        return Number.isFinite(budget) && budget > 0 ? `${budget} 元以内` : ''
      }
      return value
    },
    buildMatchSummary(matchRuleJson) {
      const parsed = this.parseJsonObject(matchRuleJson)
      const context = parsed.context || {}
      const rules = Array.isArray(parsed.rules) ? parsed.rules : []
      const contextPills = Object.keys(matchContextLabelMap)
        .map(key => {
          const formattedValue = this.formatMatchContextValue(key, context[key])
          if (!formattedValue) {
            return null
          }
          return {
            key,
            label: matchContextLabelMap[key],
            value: formattedValue
          }
        })
        .filter(Boolean)

      const ruleTexts = rules
        .map(rule => rule && (rule.desc || rule.code || ''))
        .filter(Boolean)

      const overview = contextPills.length
        ? `本次排序主要结合了${contextPills.map(item => `${item.label}${item.value}`).join('、')}等信息。`
        : '本次排序主要依据问卷画像完成基础匹配和优先级判断。'

      return {
        overview,
        contextPills,
        ruleTexts: ruleTexts.length ? ruleTexts : ['当前没有额外触发单独展示的规则，结果以基础画像匹配为主。']
      }
    },
    scoreBreakdownList(item) {
      const scoreDetail = this.parseJsonObject(item.scoreDetailJson)
      const detailList = Object.keys(scoreDetail)
        .map(key => {
          const numericScore = Number(scoreDetail[key])
          if (!Number.isFinite(numericScore) || numericScore <= 0) {
            return null
          }
          const meta = key.indexOf('rule_') === 0
            ? {
              label: '规则加成',
              description: '命中了额外的筛选规则，因此在排序中获得了补充加分。'
            }
            : (scoreDetailMetaMap[key] || {
              label: '综合加成',
              description: '该植物在当前画像下获得了补充适配加分。'
            })

          return {
            key,
            label: meta.label,
            description: meta.description,
            scoreValue: numericScore,
            scoreText: this.formatScoreValue(numericScore)
          }
        })
        .filter(Boolean)
        .sort((left, right) => right.scoreValue - left.scoreValue)

      if (detailList.length) {
        return detailList.slice(0, 5)
      }

      return [{
        key: `reason-${item.plantId}`,
        label: '综合判断',
        description: item.reasonText || '系统已根据当前画像完成综合排序。',
        scoreText: ''
      }]
    }
  }
}
</script>

<style lang="scss" scoped>
.demo-page {
  max-width: 1200px;
  margin: 0 auto;
}

.result-grid {
  display: grid;
  grid-template-columns: minmax(0, 1.8fr) minmax(260px, 0.8fr);
  gap: 18px;
}

.hero-card,
.result-card,
.side-card {
  border-radius: 28px;
  padding: 32px;
  background: rgba(255, 252, 246, 0.86);
  box-shadow: 0 24px 60px rgba(56, 73, 45, 0.12);
}

.hero-card {
  background:
    radial-gradient(circle at top right, rgba(106, 135, 85, 0.22), transparent 36%),
    rgba(255, 252, 246, 0.9);
}

.hero-top {
  display: grid;
  grid-template-columns: minmax(0, 1.2fr) 300px;
  gap: 18px;
  align-items: stretch;
}

.hero-visual {
  min-height: 240px;
  border-radius: 24px;
  padding: 20px;
  display: flex;
  align-items: flex-end;
}

.hero-visual-badge {
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

h1 {
  margin: 0 0 14px;
  color: #21351c;
  font-size: 38px;
}

h2 {
  margin: 0;
  color: #21351c;
  font-size: 28px;
}

h3 {
  margin: 8px 0 0;
  color: #21351c;
  font-size: 28px;
}

.lead {
  max-width: 760px;
  color: #4f5d42;
  line-height: 1.8;
}

.meta-row,
.tag-row,
.hero-actions,
.card-actions {
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
}

.meta-row {
  margin-top: 18px;
}

.hero-actions {
  margin-top: 18px;
}

.meta-pill,
.tag-item,
.rank-badge {
  display: inline-flex;
  align-items: center;
  padding: 8px 12px;
  border-radius: 999px;
  background: rgba(39, 77, 42, 0.08);
  color: #47623f;
  font-size: 12px;
}

.primary-link,
.secondary-link {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 12px 18px;
  border-radius: 999px;
  text-decoration: none;
}

.primary-link {
  background: #274d2a;
  color: #fffdf4;
}

.secondary-link {
  color: #274d2a;
  border: 1px solid rgba(39, 77, 42, 0.2);
}

.cards-head {
  display: flex;
  align-items: flex-end;
  justify-content: space-between;
  margin: 28px 0 16px;
  gap: 14px;
}

.result-card-list {
  display: grid;
  gap: 18px;
}

.result-card {
  display: grid;
  grid-template-columns: 220px minmax(0, 1fr);
  gap: 18px;
  padding: 18px;
}

.result-visual {
  min-height: 100%;
  border-radius: 22px;
}

.result-header {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 12px;
}

.score-box {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  color: #45613d;

  strong {
    color: #21351c;
    font-size: 34px;
    line-height: 1;
  }
}

.reason-text {
  margin: 16px 0 16px;
  color: #4f5d42;
  line-height: 1.8;
}

.detail-stack {
  display: grid;
  gap: 16px;
  margin-top: 18px;

  label {
    display: block;
    margin-bottom: 8px;
    color: #617255;
    font-size: 12px;
    letter-spacing: 1px;
    text-transform: uppercase;
  }

  p,
  .detail-list {
    margin: 0;
    color: #3d5140;
    line-height: 1.7;
  }
}

.risk-panel p,
.detail-list {
  padding: 16px;
  border-radius: 18px;
  background: rgba(39, 77, 42, 0.06);
}

.risk-panel p {
  position: relative;
  padding-left: 18px;
  word-break: break-word;

  &::before {
    content: '';
    position: absolute;
    left: 0;
    top: 16px;
    bottom: 16px;
    width: 4px;
    border-radius: 999px;
    background: rgba(140, 79, 57, 0.55);
  }
}

.detail-list {
  list-style: none;
}

.detail-item + .detail-item {
  margin-top: 14px;
  padding-top: 14px;
  border-top: 1px solid rgba(39, 77, 42, 0.12);
}

.detail-item-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  color: #274d2a;

  strong {
    font-size: 14px;
  }

  span {
    color: #5d7a53;
    font-size: 13px;
    font-weight: 600;
    white-space: nowrap;
  }
}

.detail-item p {
  margin-top: 6px;
  padding: 0;
  border-radius: 0;
  background: transparent;
}

.card-actions {
  margin-top: 18px;
}

.side-summary {
  margin: 0;
  color: #4f5d42;
  line-height: 1.8;
}

.side-panel {
  align-self: start;
  padding: 12px;
  border-radius: 28px;
  background: rgba(255, 252, 246, 0.62);
  box-shadow: 0 24px 60px rgba(56, 73, 45, 0.08);
}

.side-card {
  background:
    radial-gradient(circle at top right, rgba(106, 135, 85, 0.14), transparent 34%),
    rgba(255, 252, 246, 0.9);
  box-shadow: none;
}

.match-chip-row {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  margin-top: 16px;
}

.match-chip {
  display: inline-flex;
  align-items: center;
  padding: 8px 12px;
  border-radius: 999px;
  background: rgba(39, 77, 42, 0.08);
  color: #3f5b3a;
  font-size: 12px;
}

.match-rule-panel {
  margin-top: 18px;
  border-radius: 20px;
  padding: 18px;
  background: rgba(39, 77, 42, 0.06);

  label {
    display: block;
    margin-bottom: 10px;
    color: #617255;
    font-size: 12px;
    letter-spacing: 1px;
    text-transform: uppercase;
  }
}

.match-rule-list {
  margin: 0;
  padding-left: 18px;
  color: #3d5140;
  line-height: 1.8;
}

@media (max-width: 1100px) {
  .result-grid,
  .hero-top,
  .result-card {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .hero-card,
  .result-card,
  .side-card {
    padding: 22px;
    border-radius: 22px;
  }

  .cards-head,
  .result-header {
    flex-direction: column;
    align-items: flex-start;
  }

  .detail-item-head {
    align-items: flex-start;
    flex-direction: column;
  }

  .hero-visual {
    min-height: 220px;
  }
}
</style>