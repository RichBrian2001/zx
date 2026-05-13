import request from '@/utils/request'

export function listProfile(query) {
  return request({
    url: '/plant/admin/profile/list',
    method: 'get',
    params: query
  })
}

export function getProfile(profileId) {
  return request({
    url: '/plant/admin/profile/' + profileId,
    method: 'get'
  })
}