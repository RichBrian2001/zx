import request from '@/utils/request'

export function listPlant(query) {
  return request({
    url: '/plant/admin/plant/list',
    method: 'get',
    params: query
  })
}

export function getPlant(plantId) {
  return request({
    url: '/plant/admin/plant/' + plantId,
    method: 'get'
  })
}

export function addPlant(data) {
  return request({
    url: '/plant/admin/plant',
    method: 'post',
    data: data
  })
}

export function updatePlant(data) {
  return request({
    url: '/plant/admin/plant',
    method: 'put',
    data: data
  })
}

export function delPlant(plantIds) {
  return request({
    url: '/plant/admin/plant/' + plantIds,
    method: 'delete'
  })
}

export function changePlantDisplayStatus(data) {
  return request({
    url: '/plant/admin/plant/changeDisplayStatus',
    method: 'put',
    data: data
  })
}

export function getPlantDetail(plantId) {
  return request({
    url: '/plant/admin/plant/detail/' + plantId,
    method: 'get'
  })
}

export function savePlantDetail(data) {
  return request({
    url: '/plant/admin/plant/detail',
    method: 'put',
    data: data
  })
}

export function categoryTreeSelect() {
  return request({
    url: '/plant/admin/category/treeselect',
    method: 'get'
  })
}