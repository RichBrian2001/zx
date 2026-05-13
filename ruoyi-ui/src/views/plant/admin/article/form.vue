<template>
  <div class="app-container article-form-page" v-loading="loading">
    <div class="form-layout">
      <div class="main-panel">
        <section class="page-hero">
          <div class="hero-copy">
            <span class="hero-kicker">内容与交付中心</span>
            <h1>{{ title }}</h1>
            <p>维护文章封面、摘要、正文和发布时间，确保首页、植物详情页和内容卡片都使用同一套正式内容口径。</p>
          </div>
          <div class="hero-actions">
            <el-button @click="goBack">返回列表</el-button>
          </div>
        </section>

        <el-card shadow="never" class="editor-card">
          <div slot="header" class="card-header">
            <div>
              <span>内容编辑区</span>
              <p>先完成基础信息和封面配置，再补全文案与发布信息。</p>
            </div>
          </div>

          <el-form ref="form" :model="form" :rules="rules" label-width="100px" class="article-form">
            <div class="form-section">
              <div class="section-head">
                <h2>基础信息</h2>
                <p>决定文章类型、标题、封面和关联植物。</p>
              </div>
              <el-row :gutter="18">
                <el-col :xs="24" :md="12">
                  <el-form-item label="内容类型" prop="articleType">
                    <el-select v-model="form.articleType" placeholder="请选择内容类型" filterable allow-create default-first-option>
                      <el-option
                        v-for="item in articleTypeOptions"
                        :key="item.value"
                        :label="item.label"
                        :value="item.value"
                      />
                    </el-select>
                  </el-form-item>
                </el-col>
                <el-col :xs="24" :md="12">
                  <el-form-item label="内容标题" prop="title">
                    <el-input v-model="form.title" placeholder="请输入内容标题" />
                  </el-form-item>
                </el-col>
                <el-col :xs="24" :md="12">
                  <el-form-item label="封面图路径" prop="coverImage">
                    <el-input v-model="form.coverImage" placeholder="请输入封面图地址或上传后路径" />
                  </el-form-item>
                </el-col>
                <el-col :xs="24" :md="12">
                  <el-form-item label="关联植物" prop="relatedPlantId">
                    <el-select v-model="form.relatedPlantId" filterable clearable placeholder="请选择关联植物">
                      <el-option
                        v-for="item in plantOptions"
                        :key="item.plantId"
                        :label="item.plantName + ' (#' + item.plantId + ')'"
                        :value="item.plantId"
                      />
                    </el-select>
                  </el-form-item>
                </el-col>
              </el-row>
            </div>

            <div class="form-section">
              <div class="section-head">
                <h2>内容正文</h2>
                <p>摘要用于列表卡片，正文用于详情页和富文本展示。</p>
              </div>
              <el-form-item label="内容摘要" prop="summary">
                <el-input v-model="form.summary" type="textarea" :rows="3" placeholder="请输入内容摘要" />
              </el-form-item>
              <el-form-item label="正文内容" prop="content">
                <editor v-model="form.content" :min-height="280" />
              </el-form-item>
            </div>

            <div class="form-section compact-section">
              <div class="section-head">
                <h2>发布设置</h2>
                <p>控制展示状态、排序和发布时间。</p>
              </div>
              <el-row :gutter="18">
                <el-col :xs="24" :md="8">
                  <el-form-item label="状态" prop="status">
                    <el-radio-group v-model="form.status">
                      <el-radio
                        v-for="item in articleStatusOptions"
                        :key="item.value"
                        :label="item.value"
                      >{{ item.label }}</el-radio>
                    </el-radio-group>
                  </el-form-item>
                </el-col>
                <el-col :xs="24" :md="8">
                  <el-form-item label="排序" prop="sortOrder">
                    <el-input-number v-model="form.sortOrder" controls-position="right" :min="0" :max="999999" />
                  </el-form-item>
                </el-col>
                <el-col :xs="24" :md="8">
                  <el-form-item label="发布时间" prop="publishTime">
                    <el-date-picker
                      v-model="form.publishTime"
                      type="datetime"
                      value-format="yyyy-MM-dd HH:mm:ss"
                      placeholder="请选择发布时间"
                      style="width: 100%"
                    />
                  </el-form-item>
                </el-col>
                <el-col :xs="24">
                  <el-form-item label="备注" prop="remark">
                    <el-input v-model="form.remark" type="textarea" :rows="2" placeholder="请输入备注" />
                  </el-form-item>
                </el-col>
              </el-row>
            </div>
          </el-form>

          <div class="form-actions">
            <el-button type="primary" @click="submitForm">保存内容</el-button>
            <el-button @click="goBack">取消返回</el-button>
          </div>
        </el-card>
      </div>

      <aside class="side-panel">
        <el-card shadow="never" class="preview-card">
          <div slot="header" class="card-header compact-header">
            <div>
              <span>封面预览</span>
              <p>{{ articleTypeLabel }} · {{ statusLabel }}</p>
            </div>
          </div>

          <div class="cover-shell" v-if="form.coverImage">
            <image-preview :src="form.coverImage" width="100%" height="220px" />
          </div>
          <div v-else class="cover-placeholder">封面配置后将在这里预览</div>

          <dl class="meta-list">
            <div>
              <dt>标题</dt>
              <dd>{{ form.title || '未填写' }}</dd>
            </div>
            <div>
              <dt>关联植物</dt>
              <dd>{{ relatedPlantName }}</dd>
            </div>
            <div>
              <dt>发布时间</dt>
              <dd>{{ form.publishTime || '未设置' }}</dd>
            </div>
            <div>
              <dt>排序值</dt>
              <dd>{{ form.sortOrder || 0 }}</dd>
            </div>
          </dl>
        </el-card>

        <el-card shadow="never" class="tips-card">
          <div slot="header" class="card-header compact-header">
            <div>
              <span>编辑提示</span>
              <p>确保列表卡片、文章封面和详情联动保持一致。</p>
            </div>
          </div>
          <ul class="tips-list">
            <li>标题尽量直达场景，不要写成内部备注式命名。</li>
            <li>摘要建议控制在 2 到 3 行阅读长度，方便列表卡片展示。</li>
            <li>发布前检查封面比例与绿色主题页面是否协调。</li>
            <li>关联植物后，详情页相关文章区会直接复用这条内容。</li>
          </ul>
        </el-card>
      </aside>
    </div>
  </div>
</template>

<script>
import { addArticle, getArticle, updateArticle } from '@/api/plant/article'
import { listPlant } from '@/api/plant/plant'

export default {
  name: 'PlantAdminArticleForm',
  data() {
    return {
      loading: false,
      plantOptions: [],
      articleTypeOptions: [
        { label: '知识内容', value: 'knowledge' },
        { label: '场景指南', value: 'guide' },
        { label: '资讯动态', value: 'news' }
      ],
      articleStatusOptions: [
        { label: '发布', value: '0' },
        { label: '草稿', value: '1' }
      ],
      form: {},
      rules: {
        articleType: [
          { required: true, message: '内容类型不能为空', trigger: 'change' }
        ],
        title: [
          { required: true, message: '内容标题不能为空', trigger: 'blur' }
        ],
        sortOrder: [
          { required: true, message: '排序不能为空', trigger: 'blur' }
        ]
      }
    }
  },
  computed: {
    isEdit() {
      return this.$route.name === 'PlantArticleEdit'
    },
    title() {
      return this.isEdit ? '编辑内容' : '新增内容'
    },
    articleTypeLabel() {
      const target = this.articleTypeOptions.find(item => item.value === this.form.articleType)
      return target ? target.label : '未设置类型'
    },
    statusLabel() {
      const target = this.articleStatusOptions.find(item => item.value === this.form.status)
      return target ? target.label : '未设置状态'
    },
    relatedPlantName() {
      const target = this.plantOptions.find(item => item.plantId === this.form.relatedPlantId)
      return target ? target.plantName : '未关联植物'
    }
  },
  created() {
    this.loadPlantOptions()
    this.handleRouteChange()
  },
  watch: {
    '$route.fullPath': 'handleRouteChange'
  },
  methods: {
    handleRouteChange() {
      this.reset()
      if (this.isEdit) {
        this.getInfo()
      }
    },
    reset() {
      this.form = {
        articleId: undefined,
        articleType: 'knowledge',
        title: undefined,
        coverImage: undefined,
        summary: undefined,
        content: undefined,
        relatedPlantId: undefined,
        status: '0',
        sortOrder: 1,
        publishTime: this.parseTime(new Date(), '{y}-{m}-{d} {h}:{i}:{s}'),
        remark: undefined
      }
      this.resetForm('form')
    },
    loadPlantOptions() {
      listPlant({ pageNum: 1, pageSize: 1000 }).then(response => {
        this.plantOptions = response.rows || []
      })
    },
    getInfo() {
      const articleId = this.$route.params.articleId
      if (!articleId) {
        return
      }
      this.loading = true
      getArticle(articleId).then(response => {
        this.form = Object.assign({
          articleType: 'knowledge',
          status: '0',
          sortOrder: 1
        }, response.data)
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    submitForm() {
      this.$refs.form.validate(valid => {
        if (!valid) {
          return
        }
        const request = this.form.articleId ? updateArticle(this.form) : addArticle(this.form)
        request.then(() => {
          this.$modal.msgSuccess(this.form.articleId ? '修改成功' : '新增成功')
          this.goBack()
        })
      })
    },
    goBack() {
      const obj = { path: '/plant-admin/article', query: { t: Date.now() } }
      this.$tab.closeOpenPage(obj)
    }
  }
}
</script>

<style lang="scss" scoped>
.article-form-page {
  --page-accent: #2f6b3d;
  --page-accent-soft: rgba(47, 107, 61, 0.1);
}

.form-layout {
  display: grid;
  grid-template-columns: minmax(0, 1.6fr) 320px;
  gap: 18px;
}

.page-hero,
.editor-card,
.preview-card,
.tips-card {
  border-radius: 18px;
  border: 1px solid rgba(226, 233, 227, 0.9);
  box-shadow: 0 18px 42px rgba(41, 61, 48, 0.06);
}

.page-hero {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 16px;
  padding: 24px 26px;
  margin-bottom: 18px;
  background: linear-gradient(135deg, #f3f8ee 0%, #f8fbf5 55%, #eef5f0 100%);
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

.editor-card ::v-deep .el-card__body,
.preview-card ::v-deep .el-card__body,
.tips-card ::v-deep .el-card__body {
  padding: 22px 24px 24px;
}

.card-header {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 12px;

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

.compact-header {
  align-items: center;
}

.form-section + .form-section {
  margin-top: 28px;
  padding-top: 24px;
  border-top: 1px solid #eef2ec;
}

.section-head {
  margin-bottom: 18px;

  h2 {
    margin: 0;
    color: #233126;
    font-size: 20px;
  }

  p {
    margin: 6px 0 0;
    color: #718074;
    line-height: 1.6;
  }
}

.form-actions {
  display: flex;
  justify-content: center;
  gap: 12px;
  margin-top: 28px;
  padding-top: 20px;
  border-top: 1px solid #eef2ec;
}

.cover-shell,
.cover-placeholder {
  overflow: hidden;
  border-radius: 16px;
  background: #f5f8f3;
}

.cover-placeholder {
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 220px;
  color: #829087;
  text-align: center;
  padding: 20px;
}

.meta-list {
  margin: 18px 0 0;

  div {
    display: flex;
    justify-content: space-between;
    gap: 14px;
    padding: 12px 0;
    border-bottom: 1px solid #eef2ec;
  }

  dt {
    color: #738178;
  }

  dd {
    margin: 0;
    color: #233126;
    text-align: right;
  }
}

.tips-list {
  margin: 0;
  padding-left: 18px;
  color: #59675b;
  line-height: 1.9;
}

.article-form ::v-deep .el-select,
.article-form ::v-deep .el-input-number,
.article-form ::v-deep .el-date-editor {
  width: 100%;
}

@media (max-width: 1100px) {
  .form-layout {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .page-hero,
  .form-actions {
    flex-direction: column;
    align-items: stretch;
  }

  .hero-copy h1 {
    font-size: 26px;
  }
}
</style>