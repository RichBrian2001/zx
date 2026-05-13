<template>
  <section class="demo-page">
    <div class="hero-grid">
      <div class="hero-copy">
        <p class="section-kicker">植物百科问答</p>
        <h1>让环境状态参与回答，而不是让你重复描述。</h1>
        <p class="hero-lead">上方状态卡会优先读取浏览器定位对应的地点和天气；下方问答会自动结合位置、天气、湿度和自然光信息，给出更贴近当前环境的植物建议。</p>
        <div class="hero-meta">
          <span :class="['source-chip', hasRealLocation ? 'source-chip-real' : 'source-chip-fallback']">{{ environmentSourceText }}</span>
          <p class="source-note">{{ environmentNotice }}</p>
        </div>
      </div>
      <el-button class="refresh-button" plain :loading="environmentLoading" @click="refreshRealEnvironment">刷新环境快照</el-button>
    </div>

    <div class="environment-panel" v-loading="environmentLoading">
      <div class="status-hero">
        <div class="status-main">
          <p class="status-label">当前位置</p>
          <h2>{{ environment.location || '未获取真实位置' }}</h2>
          <p class="status-text">{{ environment.environmentSummary || '准备根据当前环境状态生成植物养护背景。' }}</p>
        </div>
        <div class="status-weather">
          <span>{{ environment.weather || '--' }}</span>
          <strong>{{ environment.temperature || '--' }}°C</strong>
          <small>更新时间 {{ environment.updateTime || '--' }}</small>
        </div>
      </div>

      <div class="metric-grid">
        <article class="metric-card">
          <span class="metric-title">空气湿度</span>
          <strong>{{ environment.humidity || '--' }}%</strong>
          <p>聊天回答会自动带入当前湿度区间。</p>
        </article>
        <article class="metric-card">
          <span class="metric-title">自然光等级</span>
          <strong>{{ environment.naturalLightLevel || '--' }}</strong>
          <p>优先对齐光照条件再讨论植物选择。</p>
        </article>
        <article class="metric-card">
          <span class="metric-title">当前场景</span>
          <strong>{{ environment.scene || '--' }}</strong>
          <p>{{ environment.space || '空间信息待生成' }}</p>
        </article>
        <article class="metric-card accent-card">
          <span class="metric-title">养护偏好</span>
          <strong>{{ environment.careLevel || '--' }}</strong>
          <p>{{ environment.preferenceSummary || '尚未生成偏好摘要' }}</p>
        </article>
      </div>
    </div>

    <div class="assistant-grid">
      <div class="chat-card">
        <div class="chat-head">
          <div>
            <p class="section-kicker">AI 对话</p>
            <h3>围绕植物知识、摆放和养护直接提问</h3>
          </div>
          <span class="hint-chip">自动携带环境背景</span>
        </div>

        <div ref="chatList" class="message-list">
          <article v-for="(item, index) in messages" :key="`${item.role}-${index}-${item.time || 'static'}`" :class="['message-item', `message-${item.role}`]">
            <div class="message-bubble">
              <span class="message-role">{{ item.role === 'assistant' ? '植选助手' : '你' }}</span>
              <p>{{ item.content }}</p>
              <small v-if="item.time || item.provider">{{ formatMeta(item) }}</small>
            </div>
          </article>
          <div v-if="sending" class="message-item message-assistant">
            <div class="message-bubble message-pending">
              <span class="message-role">植选助手</span>
              <p>正在结合环境快照组织回答…</p>
            </div>
          </div>
        </div>

        <div class="quick-list">
          <button v-for="item in quickQuestions" :key="item" type="button" class="quick-chip" @click="useQuickQuestion(item)">{{ item }}</button>
        </div>

        <div class="composer">
          <el-input
            v-model.trim="question"
            type="textarea"
            resize="none"
            :autosize="{ minRows: 3, maxRows: 5 }"
            placeholder="例如：这种光照下适合养什么入门植物？"
            @keydown.native="handleComposerKeydown"
          />
          <div class="composer-actions">
            <span>按 Enter 发送，Shift + Enter 换行</span>
            <el-button class="send-button" type="primary" :loading="sending" @click="sendQuestion">发送提问</el-button>
          </div>
        </div>
      </div>

      <aside class="guide-card">
        <p class="section-kicker">提问建议</p>
        <h3>更适合这页的问法</h3>
        <ul class="guide-list">
          <li>问“我这个环境适合哪些植物”，而不是泛泛地问“什么植物好养”。</li>
          <li>可以直接问浇水、摆放、病虫害、宠物风险，不必重复当前位置和天气。</li>
          <li>如果想要更强针对性，可以补一句你更在意颜值、香味还是维护成本。</li>
        </ul>
        <div class="guide-panel">
          <span>{{ currentIdentityTitle }}</span>
          <strong>{{ currentIdentityText }}</strong>
        </div>
      </aside>
    </div>
  </section>
</template>

<script>
import { askPlantAssistant, getAssistantEnvironment } from '@/api/plant/app'
import { getVisitorUid } from '@/utils/plantDemo'

const ASSISTANT_LOCATION_KEY = 'plant-demo-assistant-location'

export default {
  name: 'PlantDemoAssistant',
  data() {
    return {
      visitorUid: getVisitorUid(),
      environmentLoading: false,
      sending: false,
      question: '',
      environment: {},
      messages: [],
      coordinates: null
    }
  },
  computed: {
    currentIdentityTitle() {
      return this.$store.getters.token ? '当前用户' : '登录状态'
    },
    currentIdentityText() {
      if (!this.$store.getters.token) {
        return '登录后可同步问答与推荐记录'
      }
      const displayName = this.$store.getters.nickName || this.$store.getters.name || '当前用户'
      const userId = this.$store.getters.id || '--'
      return `${displayName} · ID ${userId}`
    },
    hasRealLocation() {
      return this.environment.locationSource === 'browser-weather-api'
    },
    environmentSourceText() {
      return this.hasRealLocation ? '真实定位 + 天气 API' : '环境估算'
    },
    environmentNotice() {
      return this.hasRealLocation
        ? '已根据浏览器定位获取真实城市天气，点击刷新可重新更新当前位置。'
        : '当前显示的是环境估算结果。点击“刷新环境快照”并允许定位后，将切换为真实城市位置和天气。'
    },
    quickQuestions() {
      const light = this.environment.naturalLightLevel || '这个光照'
      const scene = this.environment.scene || '这个场景'
      return [
        `${light}下适合哪些入门植物？`,
        `${scene}里现在这种湿度，浇水要注意什么？`,
        '如果要兼顾观赏性和低维护，优先怎么选？'
      ]
    }
  },
  created() {
    this.coordinates = this.restoreCachedCoordinates()
    this.loadEnvironment()
  },
  methods: {
    async loadEnvironment() {
      this.environmentLoading = true
      let usedLiveLocation = false
      try {
        const response = await getAssistantEnvironment(this.visitorUid)
        const baseEnvironment = response.data || {}

        if (this.isValidCoordinates(this.coordinates)) {
          try {
            const liveEnvironment = await this.fetchLiveEnvironmentSnapshot(this.coordinates)
            this.environment = {
              ...baseEnvironment,
              ...liveEnvironment,
              environmentSummary: this.buildLiveEnvironmentSummary(baseEnvironment, liveEnvironment)
            }
            usedLiveLocation = true
          } catch (error) {
            this.environment = baseEnvironment
          }
        } else {
          this.environment = baseEnvironment
        }

        this.upsertContextMessage()
        return usedLiveLocation
      } finally {
        this.environmentLoading = false
        this.scrollToBottom()
      }
    },
    async refreshRealEnvironment() {
      if (this.environmentLoading) {
        return
      }

      try {
        this.coordinates = await this.requestBrowserCoordinates()
        this.cacheCoordinates(this.coordinates)
        const usedLiveLocation = await this.loadEnvironment()
        if (usedLiveLocation) {
          this.$message.success('已更新为真实位置和实时天气。')
        } else {
          this.$message.warning('已获取当前位置，但天气服务暂不可用，当前仍显示环境估算。')
        }
      } catch (error) {
        this.$message.warning(this.resolveLocationErrorMessage(error))
        if (!this.environment.locationSource) {
          await this.loadEnvironment()
        }
      }
    },
    useQuickQuestion(question) {
      this.question = question
      this.sendQuestion()
    },
    handleComposerKeydown(event) {
      if (!event || event.isComposing || event.key !== 'Enter' || event.shiftKey) {
        return
      }
      event.preventDefault()
      this.sendQuestion()
    },
    async sendQuestion() {
      if (!this.question || this.sending) {
        return
      }

      const question = this.question
      const history = this.messages
        .filter(item => item.provider !== 'context')
        .map(item => ({ role: item.role, content: item.content }))
        .slice(-6)

      this.question = ''
      this.messages.push({ role: 'user', content: question, time: this.environment.updateTime })
      this.scrollToBottom()
      this.sending = true

      try {
        const response = await askPlantAssistant({
          visitorUid: this.visitorUid,
          question,
          history,
          latitude: this.coordinates && this.coordinates.latitude,
          longitude: this.coordinates && this.coordinates.longitude,
          environment: this.environment
        })
        const data = response.data || {}
        if (data.environment) {
          this.environment = data.environment
          this.upsertContextMessage()
        }
        this.messages.push({
          role: 'assistant',
          content: data.answer || '当前没有拿到有效回答，请稍后重试。',
          time: data.replyTime,
          provider: data.model || data.provider
        })
      } finally {
        this.sending = false
        this.scrollToBottom()
      }
    },
    upsertContextMessage() {
      const contextMessage = {
        role: 'assistant',
        content: `我已经读取到${this.hasRealLocation ? '当前真实位置环境快照' : '当前环境估算快照'}：${this.environment.location || '未获取真实位置'}，${this.environment.weather || '待获取'}，${this.environment.naturalLightLevel || '待获取'}。你现在可以直接问植物选择、养护、摆放或风险问题。`,
        time: this.environment.updateTime,
        provider: 'context'
      }
      if (!this.messages.length) {
        this.messages = [contextMessage]
        return
      }
      if (this.messages[0].provider === 'context') {
        this.$set(this.messages, 0, contextMessage)
        return
      }
      this.messages.unshift(contextMessage)
    },
    requestBrowserCoordinates() {
      return new Promise((resolve, reject) => {
        if (!navigator.geolocation) {
          reject(new Error('当前浏览器不支持定位'))
          return
        }

        navigator.geolocation.getCurrentPosition(position => {
          resolve({
            latitude: position.coords.latitude,
            longitude: position.coords.longitude
          })
        }, reject, {
          enableHighAccuracy: true,
          timeout: 12000,
          maximumAge: 60000
        })
      })
    },
    async fetchLiveEnvironmentSnapshot(coordinates) {
      const reverseUrl = `https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${coordinates.latitude}&lon=${coordinates.longitude}&accept-language=zh-CN`
      const weatherUrl = `https://api.open-meteo.com/v1/forecast?latitude=${coordinates.latitude}&longitude=${coordinates.longitude}&current=temperature_2m,relative_humidity_2m,weather_code,is_day,cloud_cover&timezone=Asia%2FShanghai`
      const [reverseResponse, weatherResponse] = await Promise.all([
        fetch(reverseUrl),
        fetch(weatherUrl)
      ])

      if (!reverseResponse.ok || !weatherResponse.ok) {
        throw new Error('外部环境服务暂不可用')
      }

      const reverseData = await reverseResponse.json()
      const weatherData = await weatherResponse.json()
      const current = weatherData.current || {}
      const weatherCode = Number(current.weather_code)
      const cloudCover = Number(current.cloud_cover)
      const isDay = Number(current.is_day) === 1

      return {
        location: this.buildLocationLabel(reverseData.address || {}),
        weather: this.mapWeatherText(weatherCode),
        temperature: Math.round(Number(current.temperature_2m)),
        humidity: Number(current.relative_humidity_2m),
        naturalLightLevel: this.resolveLiveNaturalLightLevel(weatherCode, cloudCover, isDay),
        updateTime: this.normalizeWeatherUpdateTime(current.time),
        locationSource: 'browser-weather-api',
        sourceLabel: '真实定位 + 天气 API',
        isRealLocation: true
      }
    },
    buildLocationLabel(address) {
      const parts = []
      this.pushLocationPart(parts, address.state)
      this.pushLocationPart(parts, this.firstNonBlank(address.city, address.town, address.county, address.municipality))
      this.pushLocationPart(parts, this.firstNonBlank(address.county, address.city_district, address.state_district, address.district))
      return parts.join(' ') || '已获取真实位置'
    },
    pushLocationPart(parts, value) {
      if (!value) {
        return
      }
      const normalized = String(value).trim()
      if (normalized && !parts.includes(normalized)) {
        parts.push(normalized)
      }
    },
    firstNonBlank(...values) {
      return values.find(value => value && String(value).trim()) || ''
    },
    mapWeatherText(weatherCode) {
      if (weatherCode === 0) {
        return '晴'
      }
      if (weatherCode === 1) {
        return '晴间多云'
      }
      if (weatherCode === 2) {
        return '多云'
      }
      if (weatherCode === 3) {
        return '阴'
      }
      if (weatherCode === 45 || weatherCode === 48) {
        return '雾'
      }
      if (weatherCode >= 51 && weatherCode <= 57) {
        return '毛毛雨'
      }
      if ((weatherCode >= 61 && weatherCode <= 67) || (weatherCode >= 80 && weatherCode <= 82)) {
        return '雨'
      }
      if ((weatherCode >= 71 && weatherCode <= 77) || (weatherCode >= 85 && weatherCode <= 86)) {
        return '雪'
      }
      if (weatherCode >= 95) {
        return '雷暴'
      }
      return '多云'
    },
    resolveLiveNaturalLightLevel(weatherCode, cloudCover, isDay) {
      if (!isDay) {
        return '夜间弱光'
      }
      if (weatherCode === 0 && cloudCover <= 20) {
        return '直射光'
      }
      if (cloudCover <= 65 && weatherCode <= 3) {
        return '散射光'
      }
      return '半阴'
    },
    normalizeWeatherUpdateTime(weatherTime) {
      if (!weatherTime) {
        return this.environment.updateTime || ''
      }
      return weatherTime.length === 16 ? `${weatherTime.replace('T', ' ')}:00` : weatherTime.replace('T', ' ')
    },
    buildLiveEnvironmentSummary(baseEnvironment, liveEnvironment) {
      return `当前位置为${liveEnvironment.location}，当前天气${liveEnvironment.weather}，环境温度约 ${liveEnvironment.temperature}°C，空气湿度约 ${liveEnvironment.humidity}% ，主要种植区域为${baseEnvironment.scene || '室内空间'}，空间尺度为${baseEnvironment.space || '中等空间'}，自然光等级为${liveEnvironment.naturalLightLevel}。`
    },
    cacheCoordinates(coordinates) {
      if (!this.isValidCoordinates(coordinates)) {
        return
      }
      localStorage.setItem(ASSISTANT_LOCATION_KEY, JSON.stringify(coordinates))
    },
    restoreCachedCoordinates() {
      const raw = localStorage.getItem(ASSISTANT_LOCATION_KEY)
      if (!raw) {
        return null
      }
      try {
        const coordinates = JSON.parse(raw)
        return this.isValidCoordinates(coordinates) ? coordinates : null
      } catch (error) {
        return null
      }
    },
    isValidCoordinates(coordinates) {
      if (!coordinates) {
        return false
      }
      return Number.isFinite(Number(coordinates.latitude)) && Number.isFinite(Number(coordinates.longitude))
    },
    resolveLocationErrorMessage(error) {
      if (!error) {
        return '未获取到真实定位，当前仍使用环境估算。'
      }
      if (error.code === 1) {
        return '定位权限被拒绝，当前仍使用环境估算。'
      }
      if (error.code === 2) {
        return '定位失败，暂时无法获取当前位置。'
      }
      if (error.code === 3) {
        return '定位超时，请稍后重试。'
      }
      return error.message || '未获取到真实定位，当前仍使用环境估算。'
    },
    scrollToBottom() {
      this.$nextTick(() => {
        const element = this.$refs.chatList
        if (!element) {
          return
        }
        element.scrollTop = element.scrollHeight
      })
    },
    formatMeta(item) {
      if (item.provider && item.time) {
        return `${item.provider} · ${item.time}`
      }
      return item.time || item.provider || ''
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

.hero-grid {
  display: flex;
  align-items: flex-end;
  justify-content: space-between;
  gap: 18px;
  margin-bottom: 18px;
}

.section-kicker {
  margin: 0 0 8px;
  color: #6c7c59;
  letter-spacing: 2px;
}

h1,
h2,
h3,
p {
  margin: 0;
}

h1 {
  color: #21351c;
  font-size: 38px;
  line-height: 1.15;
}

h2 {
  color: #21351c;
  font-size: 30px;
}

h3 {
  color: #21351c;
  font-size: 24px;
}

.hero-copy {
  max-width: 860px;
}

.hero-lead {
  margin-top: 12px;
  color: #506044;
  line-height: 1.8;
}

.hero-meta {
  margin-top: 14px;
}

.source-chip {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 8px 12px;
  border-radius: 999px;
  font-size: 12px;
}

.source-chip-real {
  background: rgba(39, 77, 42, 0.12);
  color: #2c4d2b;
}

.source-chip-fallback {
  background: rgba(117, 90, 33, 0.12);
  color: #7c5820;
}

.source-note {
  margin-top: 10px;
  color: #617054;
  line-height: 1.7;
}

.refresh-button {
  border-radius: 999px;
  border-color: var(--page-accent-line);
  background: rgba(255, 252, 246, 0.9);
  color: var(--page-accent-strong);
  font-weight: 600;
  transition: transform 0.2s ease, box-shadow 0.2s ease, background 0.2s ease;

  &:hover,
  &:focus {
    transform: translateY(-1px);
    border-color: rgba(45, 107, 55, 0.28);
    background: var(--page-accent-soft);
    color: var(--page-accent-strong);
    box-shadow: 0 12px 24px rgba(45, 107, 55, 0.12);
  }
}

.environment-panel,
.chat-card,
.guide-card {
  border-radius: 28px;
  background: rgba(255, 252, 246, 0.88);
  box-shadow: 0 24px 60px rgba(56, 73, 45, 0.12);
}

.environment-panel {
  padding: 22px;
}

.status-hero {
  display: grid;
  grid-template-columns: minmax(0, 1.6fr) minmax(240px, 0.7fr);
  gap: 18px;
  margin-bottom: 18px;
}

.status-main,
.status-weather,
.metric-card,
.guide-panel {
  border-radius: 24px;
}

.status-main {
  padding: 28px;
  background: linear-gradient(135deg, rgba(39, 77, 42, 0.1), rgba(118, 148, 94, 0.14));
}

.status-label,
.metric-title {
  color: #617054;
  font-size: 13px;
}

.status-text {
  margin-top: 14px;
  color: #506044;
  line-height: 1.8;
}

.status-weather {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  padding: 26px;
  background: linear-gradient(135deg, #274d2a, #68884e);
  color: #fffdf4;

  span {
    opacity: 0.86;
  }

  strong {
    font-size: 52px;
    line-height: 1;
  }

  small {
    opacity: 0.78;
  }
}

.metric-grid {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 14px;
}

.metric-card {
  padding: 20px;
  background: rgba(248, 244, 236, 0.9);
  border: 1px solid rgba(39, 77, 42, 0.08);

  strong {
    display: block;
    margin: 10px 0 8px;
    color: #21351c;
    font-size: 28px;
    line-height: 1.2;
  }

  p {
    color: #5a6850;
    line-height: 1.7;
    font-size: 13px;
  }
}

.accent-card {
  background: linear-gradient(160deg, rgba(39, 77, 42, 0.95), rgba(100, 132, 71, 0.9));

  .metric-title,
  strong,
  p {
    color: #fffdf4;
  }
}

.assistant-grid {
  display: grid;
  grid-template-columns: minmax(0, 1.55fr) minmax(280px, 0.65fr);
  gap: 18px;
  margin-top: 18px;
}

.chat-card {
  padding: 24px;
}

.chat-head {
  display: flex;
  align-items: flex-end;
  justify-content: space-between;
  gap: 16px;
}

.hint-chip,
.quick-chip {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  border-radius: 999px;
}

.hint-chip {
  padding: 8px 12px;
  background: rgba(39, 77, 42, 0.08);
  color: #47623f;
  font-size: 12px;
}

.message-list {
  display: flex;
  flex-direction: column;
  gap: 14px;
  height: 520px;
  margin-top: 18px;
  padding-right: 6px;
  overflow-y: auto;
}

.message-item {
  display: flex;
}

.message-user {
  justify-content: flex-end;
}

.message-bubble {
  max-width: 82%;
  padding: 16px 18px;
  border-radius: 22px;
  background: rgba(243, 239, 230, 0.92);
  color: #23371d;

  p {
    margin-top: 6px;
    line-height: 1.8;
    white-space: pre-wrap;
    word-break: break-word;
  }

  small {
    display: block;
    margin-top: 8px;
    color: #76836b;
  }
}

.message-user .message-bubble {
  background: #274d2a;
  color: #fffdf4;

  small {
    color: rgba(255, 253, 244, 0.72);
  }
}

.message-pending {
  border: 1px dashed rgba(39, 77, 42, 0.2);
}

.message-role {
  font-size: 12px;
  font-weight: 700;
  letter-spacing: 1px;
}

.quick-list {
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
  margin-top: 18px;
}

.quick-chip {
  border: 0;
  padding: 10px 14px;
  background: rgba(39, 77, 42, 0.08);
  color: #47623f;
  cursor: pointer;
  transition: transform 0.2s ease, background 0.2s ease, color 0.2s ease;

  &:hover {
    transform: translateY(-1px);
    background: rgba(45, 107, 55, 0.16);
    color: var(--page-accent-strong);
  }
}

.composer {
  margin-top: 18px;
  padding: 16px;
  border-radius: 22px;
  background: rgba(245, 241, 233, 0.9);
}

.composer ::v-deep .el-textarea__inner {
  border-radius: 18px;
  min-height: 92px !important;
  border: 1px solid var(--page-accent-line);
  background: #fffdf8;
  color: #21351c;
}

.composer ::v-deep .el-textarea__inner:focus {
  border-color: rgba(45, 107, 55, 0.3);
  box-shadow: 0 0 0 4px rgba(45, 107, 55, 0.08);
}

.composer-actions {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 14px;
  margin-top: 12px;
  color: #6a785f;
  font-size: 12px;
}

.composer-actions ::v-deep .el-button.send-button {
  min-width: 132px;
  border-radius: 999px;
  border-color: transparent;
  background: linear-gradient(135deg, var(--page-accent), #6a9150);
  box-shadow: 0 12px 24px rgba(45, 107, 55, 0.18);
  font-weight: 600;
  transition: transform 0.2s ease, box-shadow 0.2s ease, background 0.2s ease;
}

.composer-actions ::v-deep .el-button.send-button:hover,
.composer-actions ::v-deep .el-button.send-button:focus {
  transform: translateY(-1px);
  background: linear-gradient(135deg, var(--page-accent-strong), var(--page-accent));
}

.guide-card {
  padding: 24px;
}

.guide-list {
  margin: 18px 0 0;
  padding-left: 18px;
  color: #506044;
  line-height: 1.9;
}

.guide-panel {
  margin-top: 22px;
  padding: 18px;
  background: linear-gradient(135deg, #294d2c, #5d7c46);
  color: #fffdf4;

  span {
    display: block;
    opacity: 0.82;
  }

  strong {
    display: block;
    margin-top: 6px;
    font-size: 16px;
  }
}

@media (max-width: 1180px) {
  .metric-grid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }

  .assistant-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 860px) {
  .hero-grid,
  .chat-head,
  .composer-actions {
    flex-direction: column;
    align-items: flex-start;
  }

  .status-hero {
    grid-template-columns: 1fr;
  }

  .message-list {
    height: 460px;
  }
}

@media (max-width: 680px) {
  h1 {
    font-size: 32px;
  }

  .environment-panel,
  .chat-card,
  .guide-card {
    padding: 18px;
  }

  .metric-grid {
    grid-template-columns: 1fr;
  }

  .message-bubble {
    max-width: 92%;
  }
}
</style>