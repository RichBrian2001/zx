import request from '@/utils/request'

export function listImportTask(query) {
  return request({
    url: '/plant/admin/import/list',
    method: 'get',
    params: query
  })
}

export function getImportTask(taskId) {
  return request({
    url: '/plant/admin/import/' + taskId,
    method: 'get'
  })
}

export function uploadImportTask(formData) {
  return request({
    url: '/plant/admin/import/upload',
    method: 'post',
    data: formData,
    headers: {
      'Content-Type': 'multipart/form-data',
      repeatSubmit: false
    }
  })
}

export function executeImportTask(taskId) {
  return request({
    url: '/plant/admin/import/execute',
    method: 'post',
    params: { taskId }
  })
}