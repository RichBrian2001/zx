const VISITOR_UID_KEY = 'plant-demo-visitor-uid'

export function getVisitorUid() {
  let visitorUid = window.localStorage.getItem(VISITOR_UID_KEY)
  if (!visitorUid) {
    visitorUid = `visitor-${Date.now()}`
    window.localStorage.setItem(VISITOR_UID_KEY, visitorUid)
  }
  return visitorUid
}

export function setVisitorUid(visitorUid) {
  if (visitorUid) {
    window.localStorage.setItem(VISITOR_UID_KEY, visitorUid)
  }
}