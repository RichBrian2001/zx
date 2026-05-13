import request from '@/utils/request'

export function listRecommend(query) {
  return request({
    url: '/plant/admin/recommend/list',
    method: 'get',
    params: query
  })
}

export function getRecommend(recordId) {
  return request({
    url: '/plant/admin/recommend/' + recordId,
    method: 'get'
  })
}