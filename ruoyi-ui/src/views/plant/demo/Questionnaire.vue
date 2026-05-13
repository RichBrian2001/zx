<template>
  <section class="demo-page">
    <div class="questionnaire-grid">
      <div class="demo-card form-card">
        <p class="section-kicker">个性问卷</p>
        <h1>用 8 个问题生成你的第一版植物推荐。</h1>
        <p class="form-lead">把空间条件、光照习惯和养护投入说清楚，系统才能给出更稳定的植物建议。</p>
        <div class="preview-panel">
          <span class="preview-label">当前概览</span>
          <div class="preview-chip-row">
            <span v-for="item in summaryChips" :key="item" class="preview-chip">{{ item }}</span>
          </div>
        </div>
        <el-form ref="questionnaireForm" :model="form" :rules="rules" label-position="top" class="questionnaire-form">
          <div class="question-grid">
            <div class="question-column">
              <div class="question-card">
                <div class="question-meta">
                  <span class="question-index">01</span>
                  <p class="question-tip">先决定植物主要摆放在哪里，结果会更贴近真实使用场景。</p>
                </div>
                <el-form-item label="使用场景" prop="scene">
                  <el-radio-group v-model="form.scene">
                    <el-radio-button label="desk">桌面</el-radio-button>
                    <el-radio-button label="bedroom">卧室</el-radio-button>
                    <el-radio-button label="living">客厅</el-radio-button>
                    <el-radio-button label="office">办公室</el-radio-button>
                    <el-radio-button label="balcony">阳台</el-radio-button>
                  </el-radio-group>
                </el-form-item>
                <p class="question-feedback">当前选择：{{ formatChoice('scene') }}</p>
              </div>
              <div class="question-card">
                <div class="question-meta">
                  <span class="question-index">03</span>
                  <p class="question-tip">空间尺度会决定植物体量、摆放方式和视觉层次。</p>
                </div>
                <el-form-item label="空间大小" prop="space">
                  <el-select v-model="form.space" placeholder="请选择空间大小">
                    <el-option label="小空间" value="小空间"></el-option>
                    <el-option label="中等空间" value="中等空间"></el-option>
                    <el-option label="大空间" value="大空间"></el-option>
                  </el-select>
                </el-form-item>
                <p class="question-feedback">当前选择：{{ formatChoice('space') }}</p>
              </div>
              <div class="question-card">
                <div class="question-meta">
                  <span class="question-index">05</span>
                  <p class="question-tip">预算用于平衡植物规格、可选范围和后续维护成本。</p>
                </div>
                <el-form-item label="预算范围" prop="budget">
                  <el-select v-model="form.budget" placeholder="请选择预算">
                    <el-option label="100" value="100"></el-option>
                    <el-option label="200" value="200"></el-option>
                    <el-option label="300" value="300"></el-option>
                  </el-select>
                </el-form-item>
                <p class="question-feedback">当前选择：{{ formatChoice('budget') }}</p>
              </div>
              <div class="question-card">
                <div class="question-meta">
                  <span class="question-index">07</span>
                  <p class="question-tip">风格偏好决定推荐更偏向线条感、柔和感还是热带氛围。</p>
                </div>
                <el-form-item label="风格偏好" prop="style">
                  <el-select v-model="form.style" placeholder="请选择风格">
                    <el-option label="简约" value="简约"></el-option>
                    <el-option label="治愈" value="治愈"></el-option>
                    <el-option label="热带" value="热带"></el-option>
                  </el-select>
                </el-form-item>
                <p class="question-feedback">当前选择：{{ formatChoice('style') }}</p>
              </div>
            </div>
            <div class="question-column">
              <div class="question-card">
                <div class="question-meta">
                  <span class="question-index">02</span>
                  <p class="question-tip">光照会直接影响候选植物的耐受度和推荐优先级。</p>
                </div>
                <el-form-item label="光照条件" prop="light">
                  <el-select v-model="form.light" placeholder="请选择光照">
                    <el-option label="散射光" value="散射光"></el-option>
                    <el-option label="半阴" value="半阴"></el-option>
                    <el-option label="直射光" value="直射光"></el-option>
                  </el-select>
                </el-form-item>
                <p class="question-feedback">当前选择：{{ formatChoice('light') }}</p>
              </div>
              <div class="question-card">
                <div class="question-meta">
                  <span class="question-index">04</span>
                  <p class="question-tip">如果家里有宠物，系统会优先规避有明显风险的植物。</p>
                </div>
                <el-form-item label="是否有宠物" prop="pet">
                  <el-radio-group v-model="form.pet">
                    <el-radio-button label="否"></el-radio-button>
                    <el-radio-button label="是"></el-radio-button>
                  </el-radio-group>
                </el-form-item>
                <p class="question-feedback">当前选择：{{ formatChoice('pet') }}</p>
              </div>
              <div class="question-card">
                <div class="question-meta">
                  <span class="question-index">06</span>
                  <p class="question-tip">明确你愿意投入的精力，能避免结果只看颜值却难以长期养护。</p>
                </div>
                <el-form-item label="养护投入" prop="care">
                  <el-select v-model="form.care" placeholder="请选择养护投入">
                    <el-option label="低维护" value="低维护"></el-option>
                    <el-option label="中维护" value="中维护"></el-option>
                    <el-option label="高维护" value="高维护"></el-option>
                  </el-select>
                </el-form-item>
                <p class="question-feedback">当前选择：{{ formatChoice('care') }}</p>
              </div>
              <div class="question-card">
                <div class="question-meta">
                  <span class="question-index">08</span>
                  <p class="question-tip">最后说明你更在意功能、氛围还是观赏性，方便系统收束排序。</p>
                </div>
                <el-form-item label="种植目标" prop="goal">
                  <el-select v-model="form.goal" placeholder="请选择目标">
                    <el-option label="桌面绿植" value="桌面绿植"></el-option>
                    <el-option label="提升空间层次" value="提升空间层次"></el-option>
                    <el-option label="空气净化" value="空气净化"></el-option>
                    <el-option label="闻香观花" value="闻香观花"></el-option>
                  </el-select>
                </el-form-item>
                <p class="question-feedback">当前选择：{{ formatChoice('goal') }}</p>
              </div>
            </div>
          </div>

          <div class="form-actions">
            <el-button class="submit-button" type="primary" :loading="submitting" @click="handleSubmit">生成推荐结果</el-button>
            <el-button class="reset-button" @click="resetForm">恢复默认</el-button>
          </div>
        </el-form>
      </div>

      <aside class="demo-card side-card">
        <p class="section-kicker">推荐流程</p>
        <h2>系统会这样生成建议</h2>
        <ol class="flow-list">
	      <li>收集你的空间、光照、预算和养护偏好。</li>
	      <li>结合场景画像筛选更匹配的植物候选。</li>
	      <li>输出推荐结果、理由说明和后续养护建议。</li>
        </ol>
        <div class="info-panel">
          <span>{{ currentIdentityTitle }}</span>
          <strong>{{ currentIdentityText }}</strong>
        </div>
      </aside>
    </div>
  </section>
</template>

<script>
import { buildProfile, executeRecommend, submitQuestionnaire } from '@/api/plant/app'
import { getVisitorUid, setVisitorUid } from '@/utils/plantDemo'

const optionLabelMap = {
  scene: {
    desk: '桌面',
    bedroom: '卧室',
    living: '客厅',
    office: '办公室',
    balcony: '阳台'
  },
  light: {
    '散射光': '散射光',
    '半阴': '半阴',
    '直射光': '直射光'
  },
  space: {
    '小空间': '小空间',
    '中等空间': '中等空间',
    '大空间': '大空间'
  },
  pet: {
    '否': '无宠物',
    '是': '有宠物'
  },
  budget: {
    '100': '100 元以内',
    '200': '200 元以内',
    '300': '300 元以内'
  },
  care: {
    '低维护': '低维护',
    '中维护': '中维护',
    '高维护': '高维护'
  },
  style: {
    '简约': '简约',
    '治愈': '治愈',
    '热带': '热带'
  },
  goal: {
    '桌面绿植': '桌面绿植',
    '提升空间层次': '提升空间层次',
    '空气净化': '空气净化',
    '闻香观花': '闻香观花'
  }
}

export default {
  name: 'PlantDemoQuestionnaire',
  data() {
    return {
      submitting: false,
      visitorUid: getVisitorUid(),
      form: {
        scene: 'desk',
        light: '散射光',
        space: '小空间',
        pet: '否',
        budget: '200',
        care: '低维护',
        style: '简约',
        goal: '桌面绿植',
        sourceTerminal: 'web',
        sourceChannel: 'demo'
      },
      rules: {
        scene: [{ required: true, message: '请选择使用场景', trigger: 'change' }],
        light: [{ required: true, message: '请选择光照条件', trigger: 'change' }],
        space: [{ required: true, message: '请选择空间大小', trigger: 'change' }],
        pet: [{ required: true, message: '请选择宠物条件', trigger: 'change' }],
        budget: [{ required: true, message: '请选择预算', trigger: 'change' }],
        care: [{ required: true, message: '请选择养护投入', trigger: 'change' }],
        style: [{ required: true, message: '请选择风格偏好', trigger: 'change' }],
        goal: [{ required: true, message: '请选择种植目标', trigger: 'change' }]
      }
    }
  },
  computed: {
    currentIdentityTitle() {
      return this.$store.getters.token ? '当前用户' : '登录状态'
    },
    currentIdentityText() {
      if (!this.$store.getters.token) {
        return '登录后可同步推荐记录'
      }
      const displayName = this.$store.getters.nickName || this.$store.getters.name || '当前用户'
      const userId = this.$store.getters.id || '--'
      return `${displayName} · ID ${userId}`
    },
    summaryChips() {
      return [
        `场景 · ${this.formatChoice('scene')}`,
        `光照 · ${this.formatChoice('light')}`,
        `空间 · ${this.formatChoice('space')}`,
        `宠物 · ${this.formatChoice('pet')}`,
        `预算 · ${this.formatChoice('budget')}`,
        `养护 · ${this.formatChoice('care')}`,
        `风格 · ${this.formatChoice('style')}`,
        `目标 · ${this.formatChoice('goal')}`
      ]
    }
  },
  methods: {
    formatChoice(field) {
      const value = this.form[field]
      const mapping = optionLabelMap[field] || {}
      return mapping[value] || value || '待选择'
    },
    handleSubmit() {
      this.$refs.questionnaireForm.validate(async valid => {
        if (!valid) {
          return
        }
        this.submitting = true
        try {
          const submitResponse = await submitQuestionnaire({
            visitorUid: this.visitorUid,
            ...this.form
          })
          const questionnaireId = submitResponse.data.questionnaireId
          const responseVisitorUid = submitResponse.data.visitorUid || this.visitorUid
          setVisitorUid(responseVisitorUid)
          this.visitorUid = responseVisitorUid

          const profileResponse = await buildProfile(questionnaireId, responseVisitorUid)
          const recommendResponse = await executeRecommend({
            questionnaireId,
            profileId: profileResponse.data.profileId,
            visitorUid: responseVisitorUid
          })
          this.$message.success('推荐结果已生成')
          this.$router.push(`/plant-demo/result/${recommendResponse.data.recordId}`)
        } finally {
          this.submitting = false
        }
      })
    },
    resetForm() {
      this.$refs.questionnaireForm.resetFields()
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
  max-width: 1200px;
  margin: 0 auto;
}

.questionnaire-grid {
  display: grid;
  grid-template-columns: minmax(0, 1.7fr) minmax(280px, 0.8fr);
  gap: 18px;
}

.demo-card {
  border-radius: 28px;
  padding: 32px;
  background: rgba(255, 252, 246, 0.86);
  box-shadow: 0 24px 60px rgba(56, 73, 45, 0.12);
}

.form-card {
  background: linear-gradient(180deg, rgba(255, 252, 246, 0.96), rgba(245, 248, 239, 0.94));
}

.section-kicker {
  margin: 0 0 8px;
  color: #6c7c59;
  letter-spacing: 2px;
}

h1 {
  margin: 0 0 18px;
  color: #21351c;
  font-size: 40px;
  line-height: 1.15;
}

h2 {
  margin: 0 0 16px;
  color: #21351c;
  font-size: 28px;
  line-height: 1.3;
}

.form-lead {
  max-width: 760px;
  margin: 0;
  color: #536248;
  line-height: 1.8;
}

.preview-panel {
  margin-top: 20px;
  padding: 18px 20px;
  border-radius: 22px;
  background: linear-gradient(135deg, rgba(45, 107, 55, 0.1), rgba(116, 150, 86, 0.15));
  border: 1px solid var(--page-accent-line);
}

.preview-label {
  display: block;
  color: #5f6f55;
  font-size: 12px;
  letter-spacing: 1px;
}

.preview-chip-row {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  margin-top: 12px;
}

.preview-chip {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 8px 12px;
  border-radius: 999px;
  background: rgba(255, 252, 246, 0.82);
  color: #36553a;
  font-size: 12px;
  font-weight: 600;
}

.question-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 16px;
  margin-top: 8px;
  align-items: flex-start;
}

.question-column {
  flex: 1 1 320px;
  min-width: 0;
  display: grid;
  gap: 16px;
  align-content: start;
}

@supports (display: grid) {
  .question-grid {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
}

.question-card {
  display: flex;
  flex-direction: column;
  min-height: 100%;
  padding: 20px;
  border-radius: 24px;
  border: 1px solid rgba(45, 107, 55, 0.12);
  background: rgba(255, 253, 248, 0.92);
  box-shadow: 0 18px 36px rgba(56, 73, 45, 0.08);
  transition: transform 0.24s ease, box-shadow 0.24s ease, border-color 0.24s ease;
  animation: card-rise 0.45s ease both;

  &:hover {
    transform: translateY(-2px);
    border-color: rgba(45, 107, 55, 0.2);
    box-shadow: 0 24px 42px rgba(56, 73, 45, 0.12);
  }
}

.question-meta {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 14px;
}

.question-index {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 36px;
  height: 36px;
  border-radius: 12px;
  background: linear-gradient(135deg, var(--page-accent), #6a9150);
  color: #fffdf4;
  font-size: 13px;
  font-weight: 700;
}

.question-tip {
  color: #617155;
  font-size: 13px;
  line-height: 1.7;
}

.question-feedback {
  margin-top: auto;
  padding-top: 14px;
  color: #36553a;
  font-size: 13px;
  font-weight: 600;
}

.questionnaire-form ::v-deep .el-radio-group {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(104px, 1fr));
  gap: 10px;
  width: 100%;
}

.questionnaire-form ::v-deep .el-radio-button {
  width: 100%;
}

.questionnaire-form ::v-deep .el-form-item {
  margin-bottom: 0;
}

.questionnaire-form ::v-deep .el-form-item__content {
  display: flex;
  flex-direction: column;
}

.questionnaire-form ::v-deep .el-form-item__label {
  padding-bottom: 10px;
  color: #21351c;
  font-weight: 700;
}

.questionnaire-form ::v-deep .el-radio-button__inner {
  width: 100%;
  min-width: 0;
  padding: 12px 14px;
  border-radius: 16px !important;
  border: 1px solid var(--page-accent-line);
  background: #fbf9f3;
  color: #47623f;
  box-shadow: none;
}

.questionnaire-form ::v-deep .el-radio-button__orig-radio:checked + .el-radio-button__inner {
  background: linear-gradient(135deg, var(--page-accent), #6a9150);
  border-color: transparent;
  box-shadow: 0 12px 24px rgba(45, 107, 55, 0.18);
}

.questionnaire-form ::v-deep .el-input__inner {
  height: 48px;
  border-radius: 16px;
  border: 1px solid var(--page-accent-line);
  background: #fbf9f3;
  color: #21351c;
}

.questionnaire-form ::v-deep .el-select .el-input.is-focus .el-input__inner,
.questionnaire-form ::v-deep .el-input__inner:focus {
  border-color: rgba(45, 107, 55, 0.28);
  box-shadow: 0 0 0 4px rgba(45, 107, 55, 0.08);
}

.questionnaire-form ::v-deep .el-select {
  width: 100%;
}

.form-actions {
  display: flex;
  gap: 12px;
  padding-top: 20px;
  flex-wrap: wrap;
}

.form-actions ::v-deep .el-button {
  min-width: 136px;
  padding: 12px 20px;
  border-radius: 999px;
  font-weight: 600;
  transition: transform 0.2s ease, box-shadow 0.2s ease, background 0.2s ease;

  &:hover,
  &:focus {
    transform: translateY(-1px);
  }
}

.form-actions ::v-deep .el-button.submit-button {
  background: linear-gradient(135deg, var(--page-accent), #6a9150);
  border-color: transparent;
  box-shadow: 0 12px 24px rgba(45, 107, 55, 0.18);
}

.form-actions ::v-deep .el-button.reset-button {
  border-color: var(--page-accent-line);
  background: var(--page-accent-soft);
  color: var(--page-accent-strong);
}

.flow-list {
  margin: 0;
  padding-left: 18px;
  color: #4f5d42;
  line-height: 1.9;
}

.info-panel {
  margin-top: 24px;
  padding: 18px;
  border-radius: 20px;
  background: linear-gradient(135deg, #294d2c, #5d7c46);
  color: #fffdf4;

  span {
    display: block;
    opacity: 0.8;
  }

  strong {
    display: block;
    margin-top: 8px;
    font-size: 22px;
  }
}

@keyframes card-rise {
  from {
    opacity: 0;
    transform: translateY(12px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@media (max-width: 1100px) {
  .questionnaire-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .demo-card {
    padding: 22px;
    border-radius: 22px;
  }

  .question-grid {
    display: block;
  }

  .question-column + .question-column {
    margin-top: 16px;
  }

  h1 {
    font-size: 32px;
  }

  .form-actions {
    flex-direction: column;
  }

  .form-actions .el-button {
    width: 100%;
  }

  .question-card {
    padding: 18px;
  }
}
</style>