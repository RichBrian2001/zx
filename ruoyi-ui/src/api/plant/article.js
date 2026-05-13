import request from '@/utils/request'

export function listArticle(query) {
  return request({
    url: '/plant/admin/article/list',
    method: 'get',
    params: query
  })
}

export function getArticle(articleId) {
  return request({
    url: '/plant/admin/article/' + articleId,
    method: 'get'
  })
}

export function addArticle(data) {
  return request({
    url: '/plant/admin/article',
    method: 'post',
    data: data
  })
}

export function updateArticle(data) {
  return request({
    url: '/plant/admin/article',
    method: 'put',
    data: data
  })
}

export function delArticle(articleIds) {
  return request({
    url: '/plant/admin/article/' + articleIds,
    method: 'delete'
  })
}