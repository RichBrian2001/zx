import auth from '@/plugins/auth'
import router, { constantRoutes, dynamicRoutes } from '@/router'
import { getRouters } from '@/api/menu'
import Layout from '@/layout/index'
import ParentView from '@/components/ParentView'
import InnerLink from '@/layout/components/InnerLink'
import { isExternal } from '@/utils/validate'

const permission = {
  state: {
    routes: [],
    addRoutes: [],
    defaultRoutes: [],
    topbarRouters: [],
    sidebarRouters: []
  },
  mutations: {
    SET_ROUTES: (state, routes) => {
      state.addRoutes = routes
      state.routes = constantRoutes.concat(routes)
    },
    SET_DEFAULT_ROUTES: (state, routes) => {
      state.defaultRoutes = constantRoutes.concat(routes)
    },
    SET_TOPBAR_ROUTES: (state, routes) => {
      state.topbarRouters = routes
    },
    SET_SIDEBAR_ROUTERS: (state, routes) => {
      state.sidebarRouters = routes
    },
  },
  actions: {
    // 生成路由
    GenerateRoutes({ commit }) {
      return new Promise(resolve => {
        // 向后端请求路由数据
        getRouters().then(res => {
          const sdata = JSON.parse(JSON.stringify(res.data))
          const rdata = JSON.parse(JSON.stringify(res.data))
          const sidebarRoutes = filterAsyncRouter(sdata)
          const rewriteRoutes = normalizeRewriteRoutes(filterAsyncRouter(rdata, false, true))
          const asyncRoutes = filterDynamicRoutes(dynamicRoutes)
          rewriteRoutes.push({ path: '*', redirect: '/404', hidden: true })
          router.addRoutes(asyncRoutes)
          commit('SET_ROUTES', rewriteRoutes)
          commit('SET_SIDEBAR_ROUTERS', constantRoutes.concat(sidebarRoutes))
          commit('SET_DEFAULT_ROUTES', sidebarRoutes)
          commit('SET_TOPBAR_ROUTES', sidebarRoutes)
          resolve(rewriteRoutes)
        })
      })
    }
  }
}

// 遍历后台传来的路由字符串，转换为组件对象
function filterAsyncRouter(asyncRouterMap, lastRouter = false, type = false) {
  return asyncRouterMap.filter(route => {
    if (type && route.children) {
      route.children = filterChildren(route.children)
    }
    if (route.component) {
      // Layout ParentView 组件特殊处理
      if (route.component === 'Layout') {
        route.component = Layout
      } else if (route.component === 'ParentView') {
        route.component = ParentView
      } else if (route.component === 'InnerLink') {
        route.component = InnerLink
      } else {
        route.component = loadView(route.component)
      }
    }
    if (route.children != null && route.children && route.children.length) {
      route.children = filterAsyncRouter(route.children, route, type)
    } else {
      delete route['children']
      delete route['redirect']
    }
    return true
  })
}

function filterChildren(childrenMap, lastRouter = false) {
  var children = []
  childrenMap.forEach(el => {
    const childPath = el.path || ''
    const isAbsolutePath = typeof childPath === 'string' && childPath.startsWith('/')
    el.path = lastRouter && !isAbsolutePath && !isExternal(childPath) ? lastRouter.path + '/' + childPath : childPath
    if (el.children && el.children.length && el.component === 'ParentView') {
      children = children.concat(filterChildren(el.children, el))
    } else {
      children.push(el)
    }
  })
  return children
}

function normalizeRewriteRoutes(routes) {
  const usedNames = collectRouteNames(constantRoutes)
  collectRouteNames(dynamicRoutes, usedNames)
  return normalizeRouteTree(routes, usedNames)
}

function normalizeRouteTree(routes, usedNames) {
  return routes.reduce((list, route) => {
    if (isExternal(route.path)) {
      return list
    }
    const normalizedRoute = { ...route }
    if (normalizedRoute.name) {
      normalizedRoute.name = ensureUniqueRouteName(normalizedRoute, usedNames)
    }
    if (normalizedRoute.children && normalizedRoute.children.length) {
      normalizedRoute.children = normalizeRouteTree(normalizedRoute.children, usedNames)
    }
    list.push(normalizedRoute)
    return list
  }, [])
}

function ensureUniqueRouteName(route, usedNames) {
  if (!usedNames.has(route.name)) {
    usedNames.add(route.name)
    return route.name
  }
  const baseName = buildRouteNameFromPath(route.path) || route.name
  let uniqueName = baseName
  let suffix = 2
  while (usedNames.has(uniqueName)) {
    uniqueName = `${baseName}${suffix}`
    suffix += 1
  }
  usedNames.add(uniqueName)
  return uniqueName
}

function buildRouteNameFromPath(routePath) {
  return String(routePath || '')
    .split(/[/:.?=#&_-]+/)
    .filter(Boolean)
    .map(segment => segment.replace(/[^a-zA-Z0-9]/g, ''))
    .filter(Boolean)
    .map(segment => segment.charAt(0).toUpperCase() + segment.slice(1))
    .join('')
}

function collectRouteNames(routes, usedNames = new Set()) {
  routes.forEach(route => {
    if (route.name) {
      usedNames.add(route.name)
    }
    if (route.children && route.children.length) {
      collectRouteNames(route.children, usedNames)
    }
  })
  return usedNames
}

// 动态路由遍历，验证是否具备权限
export function filterDynamicRoutes(routes) {
  const res = []
  routes.forEach(route => {
    if (route.permissions) {
      if (auth.hasPermiOr(route.permissions)) {
        res.push(route)
      }
    } else if (route.roles) {
      if (auth.hasRoleOr(route.roles)) {
        res.push(route)
      }
    }
  })
  return res
}

export const loadView = (view) => {
  if (process.env.NODE_ENV === 'development') {
    return (resolve) => require([`@/views/${view}`], resolve)
  } else {
    // 使用 import 实现生产环境的路由懒加载
    return () => import(`@/views/${view}`)
  }
}

export default permission
