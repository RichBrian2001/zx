import request from '@/utils/request'

export function listRule(query) {
  return request({
    url: '/plant/admin/rule/list',
    method: 'get',
    params: query
  })
}

export function getRule(ruleId) {
  return request({
    url: '/plant/admin/rule/' + ruleId,
    method: 'get'
  })
}

export function addRule(data) {
  return request({
    url: '/plant/admin/rule',
    method: 'post',
    data: data
  })
}

export function updateRule(data) {
  return request({
    url: '/plant/admin/rule',
    method: 'put',
    data: data
  })
}

export function changeRuleStatus(ruleId, status) {
  return request({
    url: '/plant/admin/rule/changeStatus',
    method: 'put',
    data: {
      ruleId,
      status
    }
  })
}

export function delRule(ruleIds) {
  return request({
    url: '/plant/admin/rule/' + ruleIds,
    method: 'delete'
  })
}