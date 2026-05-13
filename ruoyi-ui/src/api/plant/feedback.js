import request from '@/utils/request'

export function listFeedback(query) {
  return request({
    url: '/plant/admin/feedback/list',
    method: 'get',
    params: query
  })
}

export function getFeedback(feedbackId) {
  return request({
    url: '/plant/admin/feedback/' + feedbackId,
    method: 'get'
  })
}