import router from './router'
import store from './store'
import { Message } from 'element-ui'
import NProgress from 'nprogress'
import 'nprogress/nprogress.css'
import { getToken } from '@/utils/auth'
import { isPathMatch } from '@/utils/validate'
import { isRelogin } from '@/utils/request'

NProgress.configure({ showSpinner: false })

const whiteList = ['/login', '/register', '/plant-demo', '/plant-demo/**']
const adminHomeRoles = ['admin', 'plant_admin']

const isWhiteList = (path) => {
  return whiteList.some(pattern => isPathMatch(pattern, path))
}

const resolveHomePath = (roles = []) => {
  const normalizedRoles = Array.isArray(roles)
    ? roles.map(role => String(role).toLowerCase())
    : []
  return normalizedRoles.some(role => adminHomeRoles.includes(role)) ? '/index' : '/plant-demo/home'
}

const shouldRedirectToRoleHome = (path, roles = []) => {
  const homePath = resolveHomePath(roles)
  return path === '/' || (homePath !== '/index' && path === '/index')
}

router.beforeEach((to, from, next) => {
  NProgress.start()
  if (getToken()) {
    to.meta.title && store.dispatch('settings/setTitle', to.meta.title)
    const isLock = store.getters.isLock
    /* has token*/
    if (to.path === '/login') {
      if (store.getters.roles.length > 0) {
        next({ path: resolveHomePath(store.getters.roles) })
      } else {
        next({ path: '/' })
      }
      NProgress.done()
    } else if (isWhiteList(to.path)) {
      next()
    } else if (isLock && to.path !== '/lock') {
      next({ path: '/lock' })
      NProgress.done()
    } else if (!isLock && to.path === '/lock') {
      next({ path: '/' })
      NProgress.done()
    } else {
      if (store.getters.roles.length === 0) {
        isRelogin.show = true
        // 判断当前用户是否已拉取完user_info信息
        store.dispatch('GetInfo').then(res => {
          isRelogin.show = false
          store.dispatch('GenerateRoutes').then(accessRoutes => {
            // 根据roles权限生成可访问的路由表
            router.addRoutes(accessRoutes) // 动态添加可访问路由表
            if (shouldRedirectToRoleHome(to.path, res.roles)) {
              next({ path: resolveHomePath(res.roles), replace: true })
            } else {
              next({ ...to, replace: true }) // hack方法 确保addRoutes已完成
            }
          })
        }).catch(err => {
            store.dispatch('LogOut').then(() => {
              Message.error(err)
              next({ path: '/' })
            })
          })
      } else {
        if (shouldRedirectToRoleHome(to.path, store.getters.roles)) {
          next({ path: resolveHomePath(store.getters.roles), replace: true })
          NProgress.done()
        } else {
          next()
        }
      }
    }
  } else {
    // 没有token
    if (isWhiteList(to.path)) {
      // 在免登录白名单，直接进入
      next()
    } else {
      next(`/login?redirect=${encodeURIComponent(to.fullPath)}`) // 否则全部重定向到登录页
      NProgress.done()
    }
  }
})

router.afterEach(() => {
  NProgress.done()
})
