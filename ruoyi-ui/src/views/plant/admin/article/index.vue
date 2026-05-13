<template>
  <div class="app-container article-page">
    <section class="page-hero">
      <div class="hero-copy">
        <span class="hero-kicker">内容与交付中心</span>
        <h1>内容管理</h1>
        <p>统一维护植物百科、场景指南和资讯内容，让首页卡片、植物详情和相关文章模块都使用同一套正式表达。</p>
      </div>
      <div class="hero-actions">
        <el-button
          type="primary"
          icon="el-icon-plus"
          @click="handleAdd"
          v-hasPermi="['plant:article:add']"
        >新增内容</el-button>
        <el-button icon="el-icon-refresh" @click="getList">刷新列表</el-button>
      </div>
    </section>

    <div class="summary-grid">
      <div v-for="item in summaryMetrics" :key="item.key" class="summary-card">
        <span class="summary-label">{{ item.label }}</span>
        <strong class="summary-value">{{ item.value }}</strong>
        <p class="summary-desc">{{ item.desc }}</p>
      </div>
    </div>

    <el-card v-show="showSearch" shadow="never" class="filter-card">
      <div slot="header" class="card-header">
        <div>
          <span>筛选条件</span>
          <p>按标题、类型、状态、关联植物和发布时间快速定位需要维护的内容。</p>
        </div>
      </div>

      <el-form ref="queryForm" :model="queryParams" size="small" :inline="true" label-width="88px" class="filter-form">
        <el-form-item label="内容标题" prop="title">
          <el-input
            v-model="queryParams.title"
            placeholder="请输入内容标题"
            clearable
            @keyup.enter.native="handleQuery"
          />
        </el-form-item>
        <el-form-item label="内容类型" prop="articleType">
          <el-select v-model="queryParams.articleType" placeholder="请选择内容类型" clearable>
            <el-option
              v-for="item in articleTypeOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
            <el-option
              v-for="item in articleStatusOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="关联植物ID" prop="relatedPlantId">
          <el-input-number v-model="queryParams.relatedPlantId" controls-position="right" :min="1" placeholder="关联植物ID" />
        </el-form-item>
        <el-form-item label="发布时间" prop="dateRange">
          <el-date-picker
            v-model="dateRange"
            type="datetimerange"
            value-format="yyyy-MM-dd HH:mm:ss"
            range-separator="-"
            start-placeholder="开始时间"
            end-placeholder="结束时间"
            style="width: 360px"
          />
        </el-form-item>
        <el-form-item class="filter-buttons">
          <el-button type="primary" icon="el-icon-search" @click="handleQuery">搜索内容</el-button>
          <el-button icon="el-icon-refresh" @click="resetQuery">清空筛选</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <el-card shadow="never" class="table-card">
      <div slot="header" class="card-header table-header">
        <div>
          <span>内容列表</span>
          <p>当前共 {{ total }} 条内容，支持直接进入编辑页维护文案、封面和发布状态。</p>
        </div>
        <div class="table-tools">
          <el-button
            type="success"
            plain
            icon="el-icon-edit"
            :disabled="single"
            @click="handleUpdate"
            v-hasPermi="['plant:article:edit']"
          >修改</el-button>
          <el-button
            type="danger"
            plain
            icon="el-icon-delete"
            :disabled="multiple"
            @click="handleDelete"
            v-hasPermi="['plant:article:remove']"
          >删除</el-button>
          <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
        </div>
      </div>

      <el-table v-loading="loading" :data="articleList" @selection-change="handleSelectionChange" class="article-table">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="内容编号" align="center" prop="articleId" width="110" />
        <el-table-column label="标题" align="left" min-width="240" show-overflow-tooltip>
          <template slot-scope="scope">
            <el-button
              type="text"
              class="title-button"
              @click="handleUpdate(scope.row)"
              v-hasPermi="['plant:article:edit']"
            >{{ scope.row.title }}</el-button>
            <span v-if="!hasPermission(['plant:article:edit'])">{{ scope.row.title }}</span>
          </template>
        </el-table-column>
        <el-table-column label="内容类型" align="center" width="120">
          <template slot-scope="scope">
            <span class="type-pill">{{ formatOptionLabel(scope.row.articleType, articleTypeOptions) }}</span>
          </template>
        </el-table-column>
        <el-table-column label="封面图" align="center" width="120">
          <template slot-scope="scope">
            <image-preview
              v-if="scope.row.coverImage"
              :src="scope.row.coverImage"
              width="64px"
              height="64px"
            />
            <span v-else class="placeholder-text">未配置</span>
          </template>
        </el-table-column>
        <el-table-column label="摘要" align="left" prop="summary" min-width="260" show-overflow-tooltip />
        <el-table-column label="关联植物" align="center" min-width="170" show-overflow-tooltip>
          <template slot-scope="scope">
            <div class="plant-bind">
              <strong>{{ scope.row.relatedPlantName || '未关联植物' }}</strong>
              <span v-if="scope.row.relatedPlantId">ID {{ scope.row.relatedPlantId }}</span>
            </div>
          </template>
        </el-table-column>
        <el-table-column label="状态" align="center" width="100">
          <template slot-scope="scope">
            <span :class="['status-pill', scope.row.status === '0' ? 'is-online' : 'is-draft']">
              {{ formatOptionLabel(scope.row.status, articleStatusOptions) }}
            </span>
          </template>
        </el-table-column>
        <el-table-column label="排序" align="center" prop="sortOrder" width="90" />
        <el-table-column label="发布时间" align="center" prop="publishTime" width="180">
          <template slot-scope="scope">
            <span>{{ parseTime(scope.row.publishTime) }}</span>
          </template>
        </el-table-column>
        <el-table-column label="创建时间" align="center" prop="createTime" width="180">
          <template slot-scope="scope">
            <span>{{ parseTime(scope.row.createTime) }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="180">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="text"
              icon="el-icon-edit"
              @click="handleUpdate(scope.row)"
              v-hasPermi="['plant:article:edit']"
            >修改</el-button>
            <el-button
              size="mini"
              type="text"
              icon="el-icon-delete"
              @click="handleDelete(scope.row)"
              v-hasPermi="['plant:article:remove']"
            >删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <div v-if="!loading && !articleList.length" class="empty-block">当前筛选条件下暂无内容，可直接新增一篇内容开始维护。</div>
    </el-card>

    <pagination
      v-show="total > 0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />
  </div>
</template>

<script>
import { delArticle, listArticle } from '@/api/plant/article'
import { checkPermi } from '@/utils/permission'

export default {
  name: 'PlantAdminArticle',
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      dateRange: [],
      articleList: [],
      articleTypeOptions: [
        { label: '知识内容', value: 'knowledge' },
        { label: '场景指南', value: 'guide' },
        { label: '资讯动态', value: 'news' }
      ],
      articleStatusOptions: [
        { label: '发布', value: '0' },
        { label: '草稿', value: '1' }
      ],
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        title: undefined,
        articleType: undefined,
        status: undefined,
        relatedPlantId: undefined
      }
    }
  },
  computed: {
    summaryMetrics() {
      const publishedCount = this.articleList.filter(item => item.status === '0').length
      const draftCount = this.articleList.filter(item => item.status === '1').length
      const guideCount = this.articleList.filter(item => item.articleType === 'guide').length
      const coverCount = this.articleList.filter(item => item.coverImage).length
      return [
        { key: 'total', label: '内容总数', value: this.total, desc: '当前筛选条件下的内容总量。' },
        { key: 'published', label: '当前页已发布', value: publishedCount, desc: '已经进入正式展示口径的内容。' },
        { key: 'draft', label: '当前页草稿', value: draftCount, desc: '仍待补充或校对的内容。' },
        { key: 'cover', label: '当前页已配封面', value: coverCount, desc: '已配置首图，适合首页和详情联动展示。' },
        { key: 'guide', label: '当前页场景指南', value: guideCount, desc: '场景型内容占比，便于结果页联动。' }
      ]
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.loading = true
      listArticle(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
        this.articleList = response.rows
        this.total = response.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    hasPermission(value) {
      return checkPermi(value)
    },
    formatOptionLabel(value, options) {
      const option = options.find(item => item.value === value)
      return option ? option.label : value || '-'
    },
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    resetQuery() {
      this.dateRange = []
      this.resetForm('queryForm')
      this.handleQuery()
    },
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.articleId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.$router.push('/plant-admin/article/add')
    },
    handleUpdate(row) {
      const articleId = row.articleId || this.ids[0]
      this.$router.push('/plant-admin/article/edit/' + articleId)
    },
    handleDelete(row) {
      const articleIds = row.articleId || this.ids
      this.$modal.confirm('是否确认删除内容编号为"' + articleIds + '"的数据项？').then(() => {
        return delArticle(articleIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess('删除成功')
      }).catch(() => {})
    }
  }
}
</script>

<style lang="scss" scoped>
.article-page {
  --page-accent: #2f6b3d;
  --page-accent-soft: rgba(47, 107, 61, 0.1);
}

.page-hero {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 16px;
  padding: 24px 26px;
  border-radius: 18px;
  background: linear-gradient(135deg, #f3f8ee 0%, #f8fbf5 55%, #eef5f0 100%);
  box-shadow: 0 18px 42px rgba(41, 61, 48, 0.08);
}

.hero-copy {
  max-width: 720px;

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

.hero-actions {
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
  justify-content: flex-end;
}

.summary-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
  gap: 14px;
  margin-top: 16px;
}

.summary-card,
.filter-card,
.table-card {
  border-radius: 18px;
  border: 1px solid rgba(226, 233, 227, 0.9);
  box-shadow: 0 18px 42px rgba(41, 61, 48, 0.06);
}

.summary-card {
  padding: 18px 20px;
  background: #fff;
}

.summary-label {
  display: block;
  color: #728176;
  font-size: 13px;
}

.summary-value {
  display: block;
  margin-top: 12px;
  color: #233126;
  font-size: 30px;
  line-height: 1;
}

.summary-desc {
  margin: 10px 0 0;
  color: #606f64;
  font-size: 13px;
  line-height: 1.7;
}

.filter-card {
  margin-top: 16px;
}

.card-header {
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

.filter-form {
  margin-bottom: -18px;
}

.filter-buttons {
  margin-left: auto;
}

.table-card {
  margin-top: 16px;
}

.table-header {
  align-items: center;
}

.table-tools {
  display: flex;
  align-items: center;
  gap: 10px;
  flex-wrap: wrap;
}

.title-button {
  padding: 0;
  font-weight: 600;
  color: #24432b;
}

.type-pill,
.status-pill {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 70px;
  padding: 6px 10px;
  border-radius: 999px;
  font-size: 12px;
}

.type-pill {
  background: rgba(47, 107, 61, 0.08);
  color: #365340;
}

.status-pill.is-online {
  background: rgba(47, 107, 61, 0.12);
  color: #2f6b3d;
}

.status-pill.is-draft {
  background: rgba(172, 122, 48, 0.12);
  color: #8c5b14;
}

.placeholder-text {
  color: #98a49b;
  font-size: 12px;
}

.plant-bind {
  display: flex;
  flex-direction: column;
  gap: 4px;

  strong {
    color: #233126;
    font-weight: 600;
  }

  span {
    color: #7a877d;
    font-size: 12px;
  }
}

.empty-block {
  padding: 18px 0 6px;
  color: #7a877d;
  text-align: center;
}

.article-table ::v-deep .el-table__header-wrapper th {
  background: #f6f8f4;
  color: #47574c;
}

.filter-card ::v-deep .el-card__header,
.table-card ::v-deep .el-card__header {
  border-bottom-color: #eef2ec;
}

@media (max-width: 992px) {
  .page-hero,
  .table-header {
    flex-direction: column;
    align-items: flex-start;
  }

  .hero-actions,
  .table-tools {
    width: 100%;
    justify-content: flex-start;
  }
}

@media (max-width: 768px) {
  .page-hero {
    padding: 20px;
  }

  .hero-copy h1 {
    font-size: 26px;
  }

  .summary-grid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }

  .filter-form ::v-deep .el-form-item,
  .filter-form ::v-deep .el-date-editor,
  .filter-form ::v-deep .el-select,
  .filter-form ::v-deep .el-input,
  .filter-form ::v-deep .el-input-number {
    width: 100%;
  }
}
</style>