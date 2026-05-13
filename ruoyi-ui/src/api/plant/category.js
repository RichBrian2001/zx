import request from '@/utils/request'

export function listCategory(query) {
  return request({
    url: '/plant/admin/category/list',
    method: 'get',
    params: query
  })
}

export function getCategory(categoryId) {
  return request({
    url: '/plant/admin/category/' + categoryId,
    method: 'get'
  })
}

export function addCategory(data) {
  return request({
    url: '/plant/admin/category',
    method: 'post',
    data: data
  })
}

export function updateCategory(data) {
  return request({
    url: '/plant/admin/category',
    method: 'put',
    data: data
  })
}

export function delCategory(categoryId) {
  return request({
    url: '/plant/admin/category/' + categoryId,
    method: 'delete'
  })
}

export function categoryTreeSelect(query) {
  return request({
    url: '/plant/admin/category/treeselect',
    method: 'get',
    params: query
  })
}

export function listCategoryExcludeChild(categoryId) {
  return request({
    url: '/plant/admin/category/list/exclude/' + categoryId,
    method: 'get'
  })
}