import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

/* Layout */
import Layout from '@/layout'

/**
 * Note: 路由配置项
 *
 * hidden: true                     // 当设置 true 的时候该路由不会再侧边栏出现 如401，login等页面，或者如一些编辑页面/edit/1
 * alwaysShow: true                 // 当你一个路由下面的 children 声明的路由大于1个时，自动会变成嵌套的模式--如组件页面
 *                                  // 只有一个时，会将那个子路由当做根路由显示在侧边栏--如引导页面
 *                                  // 若你想不管路由下面的 children 声明的个数都显示你的根路由
 *                                  // 你可以设置 alwaysShow: true，这样它就会忽略之前定义的规则，一直显示根路由
 * redirect: noRedirect             // 当设置 noRedirect 的时候该路由在面包屑导航中不可被点击
 * name:'router-name'               // 设定路由的名字，一定要填写不然使用<keep-alive>时会出现各种问题
 * query: '{"id": 1, "name": "ry"}' // 访问路由的默认传递参数
 * roles: ['admin', 'common']       // 访问路由的角色权限
 * permissions: ['a:a:a', 'b:b:b']  // 访问路由的菜单权限
 * meta : {
    noCache: true                   // 如果设置为true，则不会被 <keep-alive> 缓存(默认 false)
    title: 'title'                  // 设置该路由在侧边栏和面包屑中展示的名字
    icon: 'svg-name'                // 设置该路由的图标，对应路径src/assets/icons/svg
    breadcrumb: false               // 如果设置为false，则不会在breadcrumb面包屑中显示
    activeMenu: '/system/user'      // 当路由设置了该属性，则会高亮相对应的侧边栏。
  }
 */

// 公共路由
export const constantRoutes = [
  {
    path: '/redirect',
    component: Layout,
    hidden: true,
    children: [
      {
        path: '/redirect/:path(.*)',
        component: () => import('@/views/redirect')
      }
    ]
  },
  {
    path: '/login',
    component: () => import('@/views/login'),
    hidden: true
  },
  {
    path: '/register',
    component: () => import('@/views/register'),
    hidden: true
  },
  {
    path: '/404',
    component: () => import('@/views/error/404'),
    hidden: true
  },
  {
    path: '/401',
    component: () => import('@/views/error/401'),
    hidden: true
  },
  {
    path: '/',
    hidden: true,
    redirect: '/index'
  },
  {
    path: '/lock',
    component: () => import('@/views/lock'),
    hidden: true,
    meta: { title: '锁定屏幕' }
  },
  {
    path: '/plant-demo',
    component: () => import('@/views/plant/demo/Layout'),
    redirect: '/plant-demo/home',
    hidden: true,
    children: [
      {
        path: 'home',
        component: () => import('@/views/plant/demo/Home'),
        name: 'PlantDemoHome',
        meta: { title: '植选植物推荐' }
      },
      {
        path: 'plants',
        component: () => import('@/views/plant/demo/Plants'),
        name: 'PlantDemoPlants',
        meta: { title: '所有植物' }
      },
      {
        path: 'questionnaire',
        component: () => import('@/views/plant/demo/Questionnaire'),
        name: 'PlantDemoQuestionnaire',
        meta: { title: '植物问卷' }
      },
      {
        path: 'assistant',
        component: () => import('@/views/plant/demo/Assistant'),
        name: 'PlantDemoAssistant',
        meta: { title: '植物百科问答' }
      },
      {
        path: 'result/:recordId',
        component: () => import('@/views/plant/demo/Result'),
        name: 'PlantDemoResult',
        meta: { title: '推荐结果' }
      },
      {
        path: 'plant/:plantId',
        component: () => import('@/views/plant/demo/PlantDetail'),
        name: 'PlantDemoPlantDetail',
        meta: { title: '植物详情' }
      },
      {
        path: 'history',
        component: () => import('@/views/plant/demo/History'),
        name: 'PlantDemoHistory',
        meta: { title: '推荐历史' }
      },
      {
        path: 'favorite',
        component: () => import('@/views/plant/demo/Favorite'),
        name: 'PlantDemoFavorite',
        meta: { title: '植物收藏' }
      },
      {
        path: 'feedback/:recordId',
        component: () => import('@/views/plant/demo/Feedback'),
        name: 'PlantDemoFeedback',
        meta: { title: '推荐反馈' }
      }
    ]
  },
  {
    path: '/user',
    component: Layout,
    hidden: true,
    redirect: 'noredirect',
    children: [
      {
        path: 'profile',
        component: () => import('@/views/system/user/profile/index'),
        name: 'Profile',
        meta: { title: '个人中心', icon: 'user' }
      }
    ]
  }
]

// 动态路由，基于用户权限动态去加载
export const dynamicRoutes = [
  {
    path: '/plant-admin/rule-hidden',
    component: Layout,
    hidden: true,
    permissions: ['plant:rule:add', 'plant:rule:edit'],
    children: [
      {
        path: '/plant-admin/rule/add',
        component: () => import('@/views/plant/admin/rule/form'),
        name: 'PlantAdminRuleAdd',
        meta: { title: '新增推荐规则', activeMenu: '/plant-admin/rule' }
      },
      {
        path: '/plant-admin/rule/edit/:ruleId(\\d+)',
        component: () => import('@/views/plant/admin/rule/form'),
        name: 'PlantAdminRuleEdit',
        meta: { title: '编辑推荐规则', activeMenu: '/plant-admin/rule' }
      }
    ]
  },
  {
    path: '/plant-admin/plant-hidden',
    component: Layout,
    hidden: true,
    permissions: ['plant:plant:add', 'plant:plant:edit'],
    children: [
      {
        path: '/plant-admin/plant/add',
        component: () => import('@/views/plant/admin/plant/form'),
        name: 'PlantAdminPlantAdd',
        meta: { title: '新增植物', activeMenu: '/plant-admin/plant' }
      },
      {
        path: '/plant-admin/plant/edit/:plantId(\\d+)',
        component: () => import('@/views/plant/admin/plant/form'),
        name: 'PlantAdminPlantEdit',
        meta: { title: '编辑植物', activeMenu: '/plant-admin/plant' }
      }
    ]
  },
  {
    path: '/plant-admin/plant/detail',
    component: Layout,
    hidden: true,
    permissions: ['plant:plant:detail'],
    children: [
      {
        path: ':plantId(\\d+)',
        component: () => import('@/views/plant/admin/plantDetail/index'),
        name: 'PlantAdminPlantDetail',
        meta: { title: '植物详情', activeMenu: '/plant-admin/plant' }
      }
    ]
  },
  {
    path: '/plant-admin/plant-care',
    component: Layout,
    hidden: true,
    permissions: ['plant:plant:care'],
    children: [
      {
        path: ':plantId(\\d+)',
        component: () => import('@/views/plant/admin/plantCare/index'),
        name: 'PlantCareConfig',
        meta: { title: '养护配置', activeMenu: '/plant-admin/plant' }
      }
    ]
  },
  {
    path: '/system/user-auth',
    component: Layout,
    hidden: true,
    permissions: ['system:user:edit'],
    children: [
      {
        path: 'role/:userId(\\d+)',
        component: () => import('@/views/system/user/authRole'),
        name: 'AuthRole',
        meta: { title: '分配角色', activeMenu: '/system/user' }
      }
    ]
  },
  {
    path: '/system/role-auth',
    component: Layout,
    hidden: true,
    permissions: ['system:role:edit'],
    children: [
      {
        path: 'user/:roleId(\\d+)',
        component: () => import('@/views/system/role/authUser'),
        name: 'AuthUser',
        meta: { title: '分配用户', activeMenu: '/system/role' }
      }
    ]
  },
  {
    path: '/system/dict-data',
    component: Layout,
    hidden: true,
    permissions: ['system:dict:list'],
    children: [
      {
        path: 'index/:dictId(\\d+)',
        component: () => import('@/views/system/dict/data'),
        name: 'Data',
        meta: { title: '字典数据', activeMenu: '/system/dict' }
      }
    ]
  },
  {
    path: '/monitor/job-log',
    component: Layout,
    hidden: true,
    permissions: ['monitor:job:list'],
    children: [
      {
        path: 'index/:jobId(\\d+)',
        component: () => import('@/views/monitor/job/log'),
        name: 'JobLog',
        meta: { title: '调度日志', activeMenu: '/monitor/job' }
      }
    ]
  },
  {
    path: '/tool/gen-edit',
    component: Layout,
    hidden: true,
    permissions: ['tool:gen:edit'],
    children: [
      {
        path: 'index/:tableId(\\d+)',
        component: () => import('@/views/tool/gen/editTable'),
        name: 'GenEdit',
        meta: { title: '修改生成配置', activeMenu: '/tool/gen' }
      }
    ]
  },
  {
    path: '/plant-admin/plant-tag',
    component: Layout,
    hidden: true,
    permissions: ['plant:plant:tag'],
    children: [
      {
        path: ':plantId(\\d+)',
        component: () => import('@/views/plant/admin/plantTag/index'),
        name: 'PlantTagConfig',
        meta: { title: '植物标签配置', activeMenu: '/plant-admin/plant' }
      }
    ]
  },
  {
    path: '/plant-admin/profile/detail',
    component: Layout,
    hidden: true,
    permissions: ['plant:profile:detail'],
    children: [
      {
        path: ':profileId(\\d+)',
        component: () => import('@/views/plant/admin/profile/detail'),
        name: 'PlantProfileDetail',
        meta: { title: '画像详情', activeMenu: '/plant-admin/profile' }
      }
    ]
  },
  {
    path: '/plant-admin/recommend/detail',
    component: Layout,
    hidden: true,
    permissions: ['plant:recommend:detail'],
    children: [
      {
        path: ':recordId(\\d+)',
        component: () => import('@/views/plant/admin/recommend/detail'),
        name: 'PlantRecommendDetail',
        meta: { title: '推荐记录详情', activeMenu: '/plant-admin/recommend' }
      }
    ]
  },
  {
    path: '/plant-admin/article-hidden',
    component: Layout,
    hidden: true,
    permissions: ['plant:article:add', 'plant:article:edit'],
    children: [
      {
        path: '/plant-admin/article/add',
        component: () => import('@/views/plant/admin/article/form'),
        name: 'PlantArticleAdd',
        meta: { title: '新增内容', activeMenu: '/plant-admin/article' }
      },
      {
        path: '/plant-admin/article/edit/:articleId(\\d+)',
        component: () => import('@/views/plant/admin/article/form'),
        name: 'PlantArticleEdit',
        meta: { title: '编辑内容', activeMenu: '/plant-admin/article' }
      }
    ]
  }
]

// 防止连续点击多次路由报错
let routerPush = Router.prototype.push
let routerReplace = Router.prototype.replace
// push
Router.prototype.push = function push(location) {
  return routerPush.call(this, location).catch(err => err)
}
// replace
Router.prototype.replace = function push(location) {
  return routerReplace.call(this, location).catch(err => err)
}

export default new Router({
  mode: 'history', // 去掉url中的#
  scrollBehavior: () => ({ y: 0 }),
  routes: constantRoutes
})
