import request from '@/utils/request'

export function getPlantTagConfig(plantId) {
  return request({
    url: '/plant/admin/plant/tag/' + plantId,
    method: 'get'
  })
}

export function savePlantTagConfig(data) {
  return request({
    url: '/plant/admin/plant/tag',
    method: 'put',
    data: data
  })
}