import defaultSettings from '@/settings'
import { useDynamicTitle } from '@/utils/dynamicTitle'

const STORAGE_KEY = 'layout-setting'
const persistedSettingKeys = ['theme', 'sideTheme', 'navType', 'tagsView', 'tagsViewPersist', 'tagsIcon', 'tagsViewStyle', 'fixedHeader', 'sidebarLogo', 'dynamicTitle', 'footerVisible']
const { sideTheme, showSettings, navType, tagsView, tagsViewPersist, tagsIcon, tagsViewStyle, fixedHeader, sidebarLogo, dynamicTitle, footerVisible, footerContent } = defaultSettings

function getStoredLayoutSetting() {
  const rawSetting = localStorage.getItem(STORAGE_KEY)
  if (!rawSetting) {
    return {}
  }
  try {
    return JSON.parse(rawSetting) || {}
  } catch (error) {
    localStorage.removeItem(STORAGE_KEY)
    return {}
  }
}

function buildLayoutSetting(state) {
  return persistedSettingKeys.reduce((result, key) => {
    result[key] = state[key]
    return result
  }, {})
}

function persistLayoutSetting(state) {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(buildLayoutSetting(state)))
}

const storageSetting = getStoredLayoutSetting()
const state = {
  title: '',
  theme: storageSetting.theme || '#409EFF',
  sideTheme: storageSetting.sideTheme || sideTheme,
  showSettings: showSettings,
  navType: storageSetting.navType === undefined ? navType : storageSetting.navType,
  tagsView: storageSetting.tagsView === undefined ? tagsView : storageSetting.tagsView,
  tagsViewPersist: storageSetting.tagsViewPersist === undefined ? tagsViewPersist : storageSetting.tagsViewPersist,
  tagsIcon: storageSetting.tagsIcon === undefined ? tagsIcon : storageSetting.tagsIcon,
  tagsViewStyle: storageSetting.tagsViewStyle === undefined ? tagsViewStyle : storageSetting.tagsViewStyle,
  fixedHeader: storageSetting.fixedHeader === undefined ? fixedHeader : storageSetting.fixedHeader,
  sidebarLogo: storageSetting.sidebarLogo === undefined ? sidebarLogo : storageSetting.sidebarLogo,
  dynamicTitle: storageSetting.dynamicTitle === undefined ? dynamicTitle : storageSetting.dynamicTitle,
  footerVisible: storageSetting.footerVisible === undefined ? footerVisible : storageSetting.footerVisible,
  footerContent: footerContent
}
const mutations = {
  CHANGE_SETTING: (state, { key, value }) => {
    if (state.hasOwnProperty(key)) {
      state[key] = value
    }
  },
  SET_TITLE: (state, title) => {
    state.title = title
  }
}

const actions = {
  // 修改布局设置
  changeSetting({ commit, state }, data) {
    commit('CHANGE_SETTING', data)
    if (persistedSettingKeys.includes(data.key)) {
      persistLayoutSetting(state)
    }
  },
  // 持久化当前布局设置
  persistSettings({ state }) {
    persistLayoutSetting(state)
  },
  // 设置网页标题
  setTitle({ commit }, title) {
    commit('SET_TITLE', title)
    useDynamicTitle()
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}

