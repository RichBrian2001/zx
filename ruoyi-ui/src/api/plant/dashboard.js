import request from '@/utils/request'

export function getDashboardOverview(query) {
  return request({
    url: '/plant/admin/dashboard/overview',
    method: 'get',
    params: query
  })
}