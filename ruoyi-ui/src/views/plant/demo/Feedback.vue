<template>
  <section class="demo-page" v-loading="loading">
    <div class="feedback-grid">
      <div class="demo-card">
        <p class="section-kicker">推荐反馈</p>
        <h1>告诉系统这次推荐是否贴近你的预期。</h1>
        <el-form ref="feedbackForm" :model="form" :rules="rules" label-position="top">
          <el-form-item label="反馈植物" prop="plantId">
            <el-select v-model="form.plantId" placeholder="请选择反馈植物">
              <el-option v-for="item in result.resultItems" :key="item.plantId" :label="item.plantName" :value="item.plantId"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="反馈类型" prop="feedbackType">
            <el-radio-group v-model="form.feedbackType">
              <el-radio-button label="1">喜欢</el-radio-button>
              <el-radio-button label="2">不喜欢</el-radio-button>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="反馈原因" prop="feedbackReason">
            <el-input v-model="form.feedbackReason" placeholder="例如：和空间条件匹配、造型更喜欢"></el-input>
          </el-form-item>
          <el-form-item label="补充说明" prop="extraNote">
            <el-input v-model="form.extraNote" type="textarea" :rows="4" placeholder="可补充更细的喜好或顾虑"></el-input>
          </el-form-item>
          <div class="form-actions">
            <el-button type="primary" :loading="submitting" @click="handleSubmit">提交反馈</el-button>
            <el-button @click="$router.push(`/plant-demo/result/${$route.params.recordId}`)">返回结果页</el-button>
          </div>
        </el-form>
      </div>

      <aside class="demo-card side-card">
        <p class="section-kicker">当前记录</p>
        <h2>{{ result.topPlantName || '推荐记录' }}</h2>
        <p class="side-copy">记录编号 #{{ result.recordId || $route.params.recordId }}，当前返回 {{ result.resultCount || 0 }} 个候选植物。</p>
      </aside>
    </div>
  </section>
</template>

<script>
import { getRecommendResult, submitFeedback } from '@/api/plant/app'
import { getVisitorUid } from '@/utils/plantDemo'

export default {
  name: 'PlantDemoFeedback',
  data() {
    return {
      loading: false,
      submitting: false,
      result: {
        recordId: null,
        topPlantName: '',
        resultCount: 0,
        resultItems: []
      },
      form: {
        plantId: null,
        feedbackType: '1',
        feedbackReason: '',
        extraNote: ''
      },
      rules: {
        plantId: [{ required: true, message: '请选择反馈植物', trigger: 'change' }],
        feedbackType: [{ required: true, message: '请选择反馈类型', trigger: 'change' }],
        feedbackReason: [{ required: true, message: '请输入反馈原因', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.loadResult()
  },
  methods: {
    async loadResult() {
      this.loading = true
      try {
        const response = await getRecommendResult(this.$route.params.recordId)
        this.result = response.data || this.result
        if (this.result.resultItems && this.result.resultItems.length) {
          this.form.plantId = this.result.resultItems[0].plantId
        }
      } finally {
        this.loading = false
      }
    },
    handleSubmit() {
      this.$refs.feedbackForm.validate(async valid => {
        if (!valid) {
          return
        }
        this.submitting = true
        try {
          await submitFeedback({
            visitorUid: getVisitorUid(),
            recordId: Number(this.$route.params.recordId),
            ...this.form
          })
          this.$message.success('反馈已提交')
          this.$router.push(`/plant-demo/result/${this.$route.params.recordId}`)
        } finally {
          this.submitting = false
        }
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.demo-page {
  max-width: 1200px;
  margin: 0 auto;
}

.feedback-grid {
  display: grid;
  grid-template-columns: minmax(0, 1.6fr) minmax(280px, 0.7fr);
  gap: 18px;
}

.demo-card {
  border-radius: 28px;
  padding: 32px;
  background: rgba(255, 252, 246, 0.88);
  box-shadow: 0 24px 60px rgba(56, 73, 45, 0.12);
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
  margin-bottom: 18px;
  font-size: 38px;
}

h2 {
  margin-bottom: 12px;
  font-size: 30px;
}

::v-deep .el-select {
  width: 100%;
}

.form-actions {
  display: flex;
  gap: 12px;
  padding-top: 10px;
  flex-wrap: wrap;
}

.side-copy {
  color: #4f5d42;
  line-height: 1.8;
}

@media (max-width: 1100px) {
  .feedback-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .demo-card {
    padding: 22px;
    border-radius: 22px;
  }

  h1 {
    font-size: 32px;
  }
}
</style>