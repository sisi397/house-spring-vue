import { apiInstance } from "./index.js";

const api = apiInstance();

async function login(user, success, fail) {
  await api.post(`/member/login`, JSON.stringify(user)).then(success).catch(fail);
}

async function join(user, success, fail) {
  await api.post(`/member`, JSON.stringify(user)).then(success).catch(fail);
}

async function memberUpdate(user, success, fail) {
  await api.put(`/member`, JSON.stringify(user)).then(success).catch(fail);
}

async function memberDelete(userid, success, fail) {
  await api.delete(`/member/${userid}`).then(success).catch(fail);
}

async function idCheck(userid, success, fail) {
  await api.get(`/member/idcheck/${userid}`).then(success).catch(fail);
}

async function findById(userid, success, fail) {
  api.defaults.headers["access-token"] = sessionStorage.getItem("access-token");
  await api.get(`/member/info/${userid}`).then(success).catch(fail);
}

function regBookmark(params, success, fail){
  api.post(`/map/bookmark/${params.userId}/${params.aptCode}`).then(success).catch(fail);
}

function deleteBookmark(params, success, fail){
  api.delete(`/map/bookmark/${params.userId}/${params.aptCode}`).then(success).catch(fail);
}
// function logout(success, fail)

export { login, join, memberDelete, memberUpdate, idCheck, findById, regBookmark, deleteBookmark };
