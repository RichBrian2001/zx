import request from '@/utils/request'

const anonymousHeaders = {
  isToken: false,
  repeatSubmit: false
}

export function getHomeSummary() {
  return request({
    url: '/plant/app/home/summary',
    method: 'get',
    headers: { isToken: false }
  })
}

export function submitQuestionnaire(data) {
  return request({
    url: '/plant/app/questionnaire/submit',
    method: 'post',
    headers: anonymousHeaders,
    data
  })
}

export function buildProfile(questionnaireId, visitorUid) {
  return request({
    url: '/plant/app/profile/build',
    method: 'post',
    headers: anonymousHeaders,
    params: { questionnaireId, visitorUid }
  })
}

export function executeRecommend(data) {
  return request({
    url: '/plant/app/recommend/execute',
    method: 'post',
    headers: anonymousHeaders,
    data
  })
}

export function getRecommendResult(recordId) {
  return request({
    url: `/plant/app/recommend/${recordId}`,
    method: 'get',
    headers: { isToken: false }
  })
}

export function getPlantDetail(plantId) {
  return request({
    url: `/plant/app/plant/${plantId}`,
    method: 'get',
    headers: { isToken: false }
  })
}

export function getPublishedPlantList(pageNum, pageSize) {
  return request({
    url: '/plant/app/plants/list',
    method: 'get',
    headers: { isToken: false },
    params: { pageNum, pageSize }
  })
}

export function getAssistantEnvironment(visitorUid, latitude, longitude) {
  return request({
    url: '/plant/app/assistant/environment',
    method: 'get',
    headers: { isToken: false },
    params: { visitorUid, latitude, longitude }
  })
}

export function askPlantAssistant(data) {
  return request({
    url: '/plant/app/assistant/chat',
    method: 'post',
    headers: anonymousHeaders,
    data
  })
}

export function getHistoryList(visitorUid, pageNum, pageSize) {
  return request({
    url: '/plant/app/history/list',
    method: 'get',
    headers: { isToken: false },
    params: { visitorUid, pageNum, pageSize }
  })
}

export function getFavoriteList(visitorUid, pageNum, pageSize) {
  return request({
    url: '/plant/app/favorite/list',
    method: 'get',
    headers: { isToken: false },
    params: { visitorUid, pageNum, pageSize }
  })
}

export function addFavorite(data) {
  return request({
    url: '/plant/app/favorite',
    method: 'post',
    headers: anonymousHeaders,
    data
  })
}

export function cancelFavorite(visitorUid, plantId) {
  return request({
    url: `/plant/app/favorite/${plantId}`,
    method: 'delete',
    headers: anonymousHeaders,
    params: { visitorUid }
  })
}

export function submitFeedback(data) {
  return request({
    url: '/plant/app/feedback',
    method: 'post',
    headers: anonymousHeaders,
    data
  })
}