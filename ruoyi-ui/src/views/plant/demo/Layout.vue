<template>
  <div class="plant-demo-layout">
    <header class="demo-header">
      <router-link class="brand" to="/plant-demo/home">
        <span class="brand-mark">植选</span>
        <span class="brand-text">植选植物推荐</span>
      </router-link>
      <nav class="demo-nav">
        <router-link to="/plant-demo/home">首页</router-link>
        <router-link to="/plant-demo/plants">所有植物</router-link>
        <router-link to="/plant-demo/questionnaire">开始问卷</router-link>
        <router-link to="/plant-demo/assistant">植物百科问答</router-link>
        <router-link to="/plant-demo/history">推荐历史</router-link>
        <router-link to="/plant-demo/favorite">植物收藏</router-link>
      </nav>
      <el-dropdown v-if="isLoggedIn" class="identity-dropdown" trigger="click">
        <div class="visitor-chip visitor-chip-active">
          <span>当前用户</span>
          <strong>{{ currentUserText }}</strong>
        </div>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item @click.native="handleLogout">退出登录</el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
      <button v-else type="button" class="visitor-chip visitor-chip-login" @click="goLogin">
        <span>尚未登录</span>
        <strong>前往登录</strong>
      </button>
    </header>
    <main class="demo-main">
      <router-view />
    </main>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'PlantDemoLayout',
  computed: {
    ...mapGetters([
      'token',
      'id',
      'name',
      'nickName'
    ]),
    isLoggedIn() {
      return Boolean(this.token)
    },
    currentUserText() {
      if (!this.id && !this.nickName && !this.name) {
        return '正在同步用户信息'
      }
      const displayName = this.nickName || this.name || '当前用户'
      return `${displayName} · ID ${this.id || '--'}`
    }
  },
  created() {
    this.ensureCurrentUser()
  },
  methods: {
    async ensureCurrentUser() {
      if (!this.token || this.id) {
        return
      }
      try {
        await this.$store.dispatch('GetInfo')
      } catch (error) {
        await this.$store.dispatch('FedLogOut')
      }
    },
    goLogin() {
      this.$router.push({
        path: '/login',
        query: {
          redirect: this.$route.fullPath
        }
      })
    },
    handleLogout() {
      this.$confirm('确定退出当前登录状态吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$store.dispatch('LogOut').then(() => {
          location.href = '/'
        })
      }).catch(() => {})
    }
  }
}
</script>

<style lang="scss" scoped>
.plant-demo-layout {
  --demo-ink: #21351c;
  --demo-subtle: #55644a;
  --demo-surface: rgba(255, 252, 246, 0.88);
  --demo-line: rgba(39, 77, 42, 0.14);
  --demo-accent: #274d2a;
  min-height: 100vh;
  background: linear-gradient(180deg, #f4efe4 0%, #f7f4ed 48%, #eef4ec 100%);
}

.demo-header {
  position: sticky;
  top: 0;
  z-index: 10;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 20px 32px;
  gap: 20px;
  backdrop-filter: blur(16px);
}

.brand {
  display: inline-flex;
  align-items: center;
  gap: 12px;
  text-decoration: none;
}

.brand-mark {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 52px;
  height: 52px;
  border-radius: 18px;
  background: linear-gradient(135deg, #264a28, #567640);
  color: #fffdf4;
  font-size: 22px;
  font-weight: 700;
}

.brand-text {
  color: var(--demo-ink);
  font-size: 26px;
  font-weight: 700;
  letter-spacing: 1px;
}

.demo-nav {
  display: flex;
  gap: 8px;
  padding: 8px;
  border-radius: 999px;
  background: rgba(255, 252, 246, 0.72);
  box-shadow: 0 12px 28px rgba(56, 73, 45, 0.08);

  a {
    padding: 10px 16px;
    border-radius: 999px;
    color: var(--demo-subtle);
    text-decoration: none;
    transition: all 0.2s ease;
  }

  .router-link-exact-active {
    background: var(--demo-accent);
    color: #fffdf4;
    font-weight: 600;
  }
}

.identity-dropdown {
  display: inline-flex;
}

.visitor-chip {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  padding: 12px 16px;
  border: 1px solid var(--demo-line);
  border-radius: 18px;
  background: var(--demo-surface);
  color: var(--demo-subtle);
  font-size: 12px;
  cursor: pointer;
  transition: transform 0.2s ease, box-shadow 0.2s ease;

  &:hover {
    transform: translateY(-1px);
    box-shadow: 0 12px 28px rgba(56, 73, 45, 0.08);
  }

  strong {
    margin-top: 4px;
    color: var(--demo-ink);
    font-size: 14px;
  }
}

.visitor-chip-login {
  border: 1px solid var(--demo-line);
  appearance: none;
  font-family: inherit;
}

.demo-main {
  padding: 0 24px 32px;
}

@media (max-width: 1100px) {
  .demo-header {
    flex-wrap: wrap;
    justify-content: center;
  }

  .visitor-chip {
    align-items: center;
  }
}

@media (max-width: 768px) {
  .demo-header {
    padding: 18px 18px 8px;
  }

  .brand {
    width: 100%;
    justify-content: center;
  }

  .brand-text {
    font-size: 20px;
  }

  .demo-nav {
    width: 100%;
    flex-wrap: wrap;
    justify-content: center;
    border-radius: 20px;
  }

  .visitor-chip {
    width: 100%;
  }

  .demo-main {
    padding: 0 14px 24px;
  }
}
</style>