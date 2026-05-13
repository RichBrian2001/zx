<template>
  <div class="app-container dashboard-page" v-loading="loading">
    <section class="dashboard-hero">
      <div class="hero-copy">
        <span class="hero-kicker">植物个性化推荐系统</span>
        <h1>系统工作台</h1>
        <p>集中查看植物资源规模、推荐活跃度与近期推荐动态，作为管理端日常巡检入口。</p>
        <div class="hero-pills">
          <span v-for="item in heroPills" :key="item.key" class="hero-pill">
            <strong>{{ item.value }}</strong>
            <em>{{ item.label }}</em>
          </span>
        </div>
      </div>

      <div class="hero-panel">
        <el-form ref="queryForm" :model="queryParams" size="small" label-width="0" class="hero-form">
          <el-form-item prop="dateRange">
            <el-date-picker
              v-model="dateRange"
              type="datetimerange"
              value-format="yyyy-MM-dd HH:mm:ss"
              range-separator="-"
              start-placeholder="开始时间"
              end-placeholder="结束时间"
            />
          </el-form-item>
          <el-form-item class="hero-actions">
            <el-button type="primary" icon="el-icon-search" @click="handleQuery" v-hasPermi="['plant:dashboard:query']">刷新概览</el-button>
            <el-button icon="el-icon-refresh" @click="resetQuery">清空时间</el-button>
          </el-form-item>
        </el-form>

        <div class="hero-side-note">
          <span>当前工作重点</span>
          <p>优先检查推荐活跃度、热门植物分布和最近推荐记录，再进入规则或内容页处理。</p>
        </div>
      </div>
    </section>

    <div class="stats-grid">
      <div v-for="item in statItems" :key="item.key" :class="['stat-card', item.tone]">
        <div class="stat-label">{{ item.label }}</div>
        <div class="stat-value">{{ item.value }}</div>
        <div class="stat-desc">{{ item.desc }}</div>
      </div>
    </div>

    <el-row :gutter="16" class="dashboard-panels">
      <el-col :xs="24" :xl="8">
        <el-card shadow="never" class="panel-card action-panel">
          <div slot="header" class="section-head">
            <div>
              <span>快捷入口</span>
              <p>按冻结路由直接跳转核心管理页。</p>
            </div>
          </div>
          <div class="action-grid">
            <div
              v-for="item in visibleQuickActions"
              :key="item.path"
              class="action-card"
              @click="goRoute(item.path)"
            >
              <div class="action-title">{{ item.title }}</div>
              <div class="action-desc">{{ item.desc }}</div>
            </div>
            <div v-if="!visibleQuickActions.length" class="empty-block">当前账号暂无可用快捷入口。</div>
          </div>
        </el-card>

        <el-card shadow="never" class="panel-card hot-panel">
          <div slot="header" class="section-head">
            <div>
              <span>热门植物榜单</span>
              <p>按推荐次数降序，快速识别近期高频命中植物。</p>
            </div>
          </div>
          <div v-if="!hotPlantList.length" class="empty-block">当前暂无推荐榜单数据。</div>
          <div v-for="(item, index) in hotPlantList" :key="item.plantId" class="hot-item">
            <div class="rank-badge">{{ index + 1 }}</div>
            <div class="hot-cover">
              <image-preview v-if="item.coverImage" :src="item.coverImage" :width="56" :height="56" />
              <div v-else class="cover-placeholder">植</div>
            </div>
            <div class="hot-main">
              <div class="hot-title-row">
                <el-button
                  v-if="hasPermission(['plant:plant:detail'])"
                  type="text"
                  class="hot-title"
                  @click="goPlantDetail(item.plantId)"
                >{{ item.plantName || ('植物 #' + item.plantId) }}</el-button>
                <span v-else class="hot-title">{{ item.plantName || ('植物 #' + item.plantId) }}</span>
                <span class="hot-id">ID {{ item.plantId }}</span>
              </div>
              <div class="hot-metrics">
                <span>推荐 {{ item.recommendCount }}</span>
                <span>喜欢 {{ item.likeCount }}</span>
                <span>收藏 {{ item.favoriteCount }}</span>
              </div>
            </div>
          </div>
        </el-card>
      </el-col>

      <el-col :xs="24" :xl="16">
        <el-card shadow="never" class="panel-card table-panel">
          <div slot="header" class="section-head table-head">
            <div>
              <span>最近推荐记录</span>
              <p>最新 10 条推荐请求，可直接进入记录详情页复查画像与命中结果。</p>
            </div>
            <div class="table-summary">
              <span>最近窗口推荐数</span>
              <strong>{{ (overview.statCard && overview.statCard.recommendTotal) || 0 }}</strong>
            </div>
          </div>
          <el-table :data="recentRecommendList" size="small" class="recent-table">
            <el-table-column label="记录编号" align="center" width="110">
              <template slot-scope="scope">
                <el-button
                  v-if="hasPermission(['plant:recommend:detail'])"
                  type="text"
                  @click="goRecommendDetail(scope.row.recordId)"
                >{{ scope.row.recordId }}</el-button>
                <span v-else>{{ scope.row.recordId }}</span>
              </template>
            </el-table-column>
            <el-table-column label="访客标识" prop="visitorUid" min-width="150" show-overflow-tooltip />
            <el-table-column label="Top1 植物" prop="topPlantName" min-width="140" show-overflow-tooltip />
            <el-table-column label="结果数" prop="resultCount" align="center" width="80" />
            <el-table-column label="推荐时间" align="center" width="170">
              <template slot-scope="scope">
                <span>{{ parseTime(scope.row.recommendTime) }}</span>
              </template>
            </el-table-column>
          </el-table>
          <div v-if="!recentRecommendList.length" class="empty-block table-empty">当前暂无推荐记录。</div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { getDashboardOverview } from '@/api/plant/dashboard'
import { checkPermi } from '@/utils/permission'

export default {
  name: 'PlantAdminDashboard',
  data() {
    return {
      loading: false,
      dateRange: [],
      queryParams: {},
      overview: {
        statCard: {
          plantTotal: 0,
          onlinePlantTotal: 0,
          categoryTotal: 0,
          recommendTotal: 0,
          todayRecommendTotal: 0,
          feedbackTotal: 0,
          likeFeedbackTotal: 0,
          dislikeFeedbackTotal: 0
        },
        hotPlantList: [],
        recentRecommendList: []
      },
      quickActions: [
        { title: '植物分类', desc: '维护分类树结构', path: '/plant-admin/category', permission: 'plant:category:list' },
        { title: '植物库', desc: '进入植物主数据列表', path: '/plant-admin/plant', permission: 'plant:plant:list' },
        { title: '标签字典', desc: '维护标签类型与编码', path: '/plant-admin/tag', permission: 'plant:tag:list' },
        { title: '推荐规则', desc: '查看规则与启停状态', path: '/plant-admin/rule', permission: 'plant:rule:list' },
        { title: '内容管理', desc: '维护百科与养护文章', path: '/plant-admin/article', permission: 'plant:article:list' },
        { title: '数据导入', desc: '上传模板并执行导入', path: '/plant-admin/import', permission: 'plant:import:list' }
      ]
    }
  },
  computed: {
    heroPills() {
      const statCard = this.overview.statCard || {}
      const onlineRate = statCard.plantTotal ? Math.round(((statCard.onlinePlantTotal || 0) / statCard.plantTotal) * 100) : 0
      const likeRate = statCard.feedbackTotal ? Math.round(((statCard.likeFeedbackTotal || 0) / statCard.feedbackTotal) * 100) : 0
      return [
        { key: 'today', label: '今日推荐', value: statCard.todayRecommendTotal || 0 },
        { key: 'onlineRate', label: '上架占比', value: onlineRate + '%' },
        { key: 'likeRate', label: '喜欢反馈占比', value: likeRate + '%' }
      ]
    },
    statItems() {
      const statCard = this.overview.statCard || {}
      return [
        { key: 'plantTotal', label: '植物总数', value: statCard.plantTotal || 0, desc: '系统已登记植物条目', tone: 'tone-forest' },
        { key: 'onlinePlantTotal', label: '上架植物', value: statCard.onlinePlantTotal || 0, desc: '前台展示中的植物数量', tone: 'tone-sage' },
        { key: 'categoryTotal', label: '分类总数', value: statCard.categoryTotal || 0, desc: '植物分类树有效节点数', tone: 'tone-olive' },
        { key: 'recommendTotal', label: '推荐记录', value: statCard.recommendTotal || 0, desc: '当前窗口内推荐请求数', tone: 'tone-lime' },
        { key: 'todayRecommendTotal', label: '今日推荐', value: statCard.todayRecommendTotal || 0, desc: '统计窗口内落在今日的推荐数', tone: 'tone-forest' },
        { key: 'feedbackTotal', label: '反馈总数', value: statCard.feedbackTotal || 0, desc: '用户已提交的反馈条数', tone: 'tone-sage' },
        { key: 'likeFeedbackTotal', label: '喜欢反馈', value: statCard.likeFeedbackTotal || 0, desc: '反馈类型为喜欢', tone: 'tone-olive' },
        { key: 'dislikeFeedbackTotal', label: '不喜欢反馈', value: statCard.dislikeFeedbackTotal || 0, desc: '反馈类型为不喜欢', tone: 'tone-lime' }
      ]
    },
    hotPlantList() {
      return this.overview.hotPlantList || []
    },
    recentRecommendList() {
      return this.overview.recentRecommendList || []
    },
    visibleQuickActions() {
      return this.quickActions.filter(item => !item.permission || this.hasPermission([item.permission]))
    }
  },
  created() {
    this.getOverview()
  },
  methods: {
    getOverview() {
      this.loading = true
      getDashboardOverview(this.buildQuery()).then(response => {
        this.overview = response.data || this.overview
      }).catch(() => {
        this.overview = {
          statCard: {
            plantTotal: 0,
            onlinePlantTotal: 0,
            categoryTotal: 0,
            recommendTotal: 0,
            todayRecommendTotal: 0,
            feedbackTotal: 0,
            likeFeedbackTotal: 0,
            dislikeFeedbackTotal: 0
          },
          hotPlantList: [],
          recentRecommendList: []
        }
      }).finally(() => {
        this.loading = false
      })
    },
    buildQuery() {
      const query = {}
      if (this.dateRange && this.dateRange.length === 2) {
        query.startDate = this.dateRange[0]
        query.endDate = this.dateRange[1]
      }
      return query
    },
    hasPermission(value) {
      return checkPermi(value)
    },
    handleQuery() {
      this.getOverview()
    },
    resetQuery() {
      this.dateRange = []
      this.getOverview()
    },
    goRoute(path) {
      this.$router.push(path)
    },
    goPlantDetail(plantId) {
      if (!plantId) {
        return
      }
      this.$router.push('/plant-admin/plant/detail/' + plantId)
    },
    goRecommendDetail(recordId) {
      if (!recordId) {
        return
      }
      this.$router.push('/plant-admin/recommend/detail/' + recordId)
    }
  }
}
</script>

<style lang="scss" scoped>
.dashboard-page {
  --page-accent: #2f6b3d;
  --page-accent-soft: rgba(47, 107, 61, 0.1);
}

.dashboard-hero {
  display: grid;
  grid-template-columns: minmax(0, 1.3fr) minmax(320px, 0.8fr);
  gap: 18px;
  margin-bottom: 18px;
  padding: 28px;
  border-radius: 20px;
  background: linear-gradient(135deg, #f3f8ee 0%, #f8fbf5 55%, #eef5f0 100%);
  box-shadow: 0 18px 42px rgba(41, 61, 48, 0.08);
}

.hero-kicker {
  display: inline-flex;
  align-items: center;
  margin-bottom: 12px;
  padding: 6px 12px;
  border-radius: 999px;
  background: var(--page-accent-soft);
  color: var(--page-accent);
  font-size: 12px;
  letter-spacing: 1px;
}

.hero-copy {
  h1 {
    margin: 0 0 10px;
    font-size: 30px;
    color: #233126;
  }

  p {
    margin: 0;
    color: #58665b;
    line-height: 1.8;
  }
}

.hero-pills {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  margin-top: 20px;
}

.hero-pill {
  display: inline-flex;
  flex-direction: column;
  gap: 4px;
  min-width: 110px;
  padding: 12px 14px;
  border-radius: 16px;
  background: rgba(255, 255, 255, 0.76);

  strong {
    color: #233126;
    font-size: 22px;
    line-height: 1;
  }

  em {
    color: #718074;
    font-style: normal;
    font-size: 12px;
  }
}

.hero-panel {
  display: flex;
  flex-direction: column;
  gap: 14px;
  padding: 18px;
  border-radius: 18px;
  background: rgba(255, 255, 255, 0.72);
}

.hero-form ::v-deep .el-date-editor,
.hero-form ::v-deep .el-form-item,
.hero-form ::v-deep .el-form-item__content {
  width: 100%;
}

.hero-actions {
  display: flex;
  gap: 10px;
  margin-bottom: 0;
}

.hero-side-note {
  padding: 16px;
  border-radius: 16px;
  background: rgba(47, 107, 61, 0.06);

  span {
    display: block;
    margin-bottom: 6px;
    color: #31513b;
    font-size: 13px;
    font-weight: 600;
  }

  p {
    margin: 0;
    color: #657469;
    line-height: 1.7;
  }
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(190px, 1fr));
  gap: 14px;
  margin-bottom: 18px;
}

.stat-card,
.panel-card {
  border: 1px solid rgba(226, 233, 227, 0.9);
  border-radius: 18px;
  box-shadow: 0 18px 42px rgba(41, 61, 48, 0.06);
}

.stat-card {
  min-height: 144px;
  padding: 18px 20px;
  background: #fff;
}

.stat-label {
  margin-bottom: 14px;
  color: #738178;
  font-size: 13px;
}

.stat-value {
  margin-bottom: 8px;
  color: #233126;
  font-size: 32px;
  font-weight: 700;
  line-height: 1;
}

.stat-desc {
  color: #606f64;
  font-size: 13px;
  line-height: 1.7;
}

.tone-forest {
  background: linear-gradient(180deg, #ffffff 0%, #f4f9f1 100%);
}

.tone-sage {
  background: linear-gradient(180deg, #ffffff 0%, #f8fbf5 100%);
}

.tone-olive {
  background: linear-gradient(180deg, #ffffff 0%, #f8f7ef 100%);
}

.tone-lime {
  background: linear-gradient(180deg, #ffffff 0%, #f2f8f0 100%);
}

.dashboard-panels {
  margin-bottom: 0;
}

.panel-card {
  margin-bottom: 16px;
}

.section-head {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 16px;

  span {
    display: block;
    color: #233126;
    font-size: 16px;
    font-weight: 600;
  }

  p {
    margin: 6px 0 0;
    color: #718074;
    font-size: 13px;
    line-height: 1.6;
  }
}

.action-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
  gap: 12px;
}

.action-card {
  padding: 16px;
  border: 1px solid #e5ece3;
  border-radius: 16px;
  background: #fafcf8;
  cursor: pointer;
  transition: transform 0.2s ease, border-color 0.2s ease, box-shadow 0.2s ease;
}

.action-card:hover {
  transform: translateY(-2px);
  border-color: #cfe2d0;
  box-shadow: 0 14px 24px rgba(47, 107, 61, 0.08);
}

.action-title {
  margin-bottom: 6px;
  color: #233126;
  font-size: 15px;
  font-weight: 600;
}

.action-desc {
  color: #606f64;
  font-size: 13px;
  line-height: 1.7;
}

.hot-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 14px 0;
  border-bottom: 1px solid #edf2ec;
}

.hot-item:last-child {
  padding-bottom: 0;
  border-bottom: none;
}

.rank-badge {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 30px;
  height: 30px;
  border-radius: 50%;
  background: rgba(47, 107, 61, 0.1);
  color: #2f6b3d;
  font-weight: 700;
}

.hot-cover {
  width: 56px;
  height: 56px;
}

.cover-placeholder {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 56px;
  height: 56px;
  border-radius: 12px;
  background: #f3f7f2;
  color: #48704f;
  font-size: 24px;
  font-weight: 600;
}

.hot-main {
  flex: 1;
  min-width: 0;
}

.hot-title-row {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 6px;
}

.hot-title {
  padding: 0;
  color: #233126;
  font-size: 15px;
  font-weight: 600;
}

.hot-id {
  color: #8b988e;
  font-size: 12px;
}

.hot-metrics {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  color: #606f64;
  font-size: 13px;
}

.table-head {
  align-items: center;
}

.table-summary {
  display: inline-flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 4px;
  padding: 10px 14px;
  border-radius: 14px;
  background: rgba(47, 107, 61, 0.06);

  span {
    color: #708076;
    font-size: 12px;
  }

  strong {
    color: #233126;
    font-size: 22px;
    line-height: 1;
  }
}

.recent-table ::v-deep .el-table__header-wrapper th {
  background: #f6f8f4;
  color: #47574c;
}

.panel-card ::v-deep .el-card__header {
  border-bottom-color: #edf2ec;
}

.empty-block {
  padding: 18px 0;
  color: #869388;
  text-align: center;
}

.table-empty {
  padding-top: 12px;
}

@media (max-width: 1200px) {
  .dashboard-hero {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .dashboard-hero {
    padding: 22px;
  }

  .hero-copy h1 {
    font-size: 26px;
  }

  .hero-actions {
    flex-direction: column;
  }

  .table-head {
    flex-direction: column;
    align-items: flex-start;
  }

  .table-summary {
    align-items: flex-start;
  }
}
</style>