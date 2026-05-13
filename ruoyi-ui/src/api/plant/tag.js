import request from '@/utils/request'

export function listTag(query) {
  return request({
    url: '/plant/admin/tag/list',
    method: 'get',
    params: query
  })
}

export function getTag(tagId) {
  return request({
    url: '/plant/admin/tag/' + tagId,
    method: 'get'
  })
}

export function addTag(data) {
  return request({
    url: '/plant/admin/tag',
    method: 'post',
    data: data
  })
}

export function updateTag(data) {
  return request({
    url: '/plant/admin/tag',
    method: 'put',
    data: data
  })
}

export function delTag(tagIds) {
  return request({
    url: '/plant/admin/tag/' + tagIds,
    method: 'delete'
  })
}