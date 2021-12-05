import jwt_decode from "jwt-decode";
import { login, findById, join, memberUpdate, memberDelete, idCheck, regBookmark, deleteBookmark } from "@/api/member.js";

const memberStore = {
  namespaced: true,
  state: {
    isLogin: false,
    isLoginError: false,
    userInfo: null,
    idOk:false,
  },
  getters: {
    checkUserInfo: function (state) {
      return state.userInfo;
    },
    checkId : function(state){
      return state.idOk;
    }
  },
  mutations: {
    SET_IS_LOGIN: (state, isLogin) => {
      state.isLogin = isLogin;
    },
    SET_IS_LOGIN_ERROR: (state, isLoginError) => {
      state.isLoginError = isLoginError;
    },
    SET_USER_INFO: (state, userInfo) => {
      state.isLogin = true;
      state.userInfo = userInfo;
    },
    SET_IdOk: (state, idOk) => {
      state.idOk = idOk;
    },
  },
  actions: {
    async userConfirm({ commit }, user) {
      console.log(user)
      await login(
        user,
        (response) => {
          if (response.data.message === "success") {
            let token = response.data["access-token"];
            commit("SET_IS_LOGIN", true);
            commit("SET_IS_LOGIN_ERROR", false);
            sessionStorage.setItem("access-token", token);
          } else {
            commit("SET_IS_LOGIN", false);
            commit("SET_IS_LOGIN_ERROR", true);
          }
        },
        () => {}
      );
    },
    async userJoin(data, user){
      await join(
        user,
        () =>{
          console.log("회원가입 성공")
        },
        (error) => {
          console.log(error);
        }
      );
    },
    async userUpdate(data, user){
      await memberUpdate(
        user,
        () =>{
          console.log("수정 성공")
        },
        (error) => {
          console.log(error);
        }
      );
    },
    async userDelete({commit}, userid){
      await memberDelete(
        userid,
        () =>{
          console.log("탈퇴 성공")
          commit("SET_USER_INFO", null);
          commit("SET_IS_LOGIN", false);
          sessionStorage.removeItem("access-token");
        },
        (error) => {
          console.log(error);
        }
      );
    },
    async userIdCheck({commit}, userid){
      await idCheck(
        userid,
        (response) =>{
          if(response.data === 0)
            commit("SET_IdOk", true);
          else{
            commit("SET_IdOk", false);
          }
        },
        (error) => {
          console.log(error);
        }
      );
    },
    getUserInfo({ commit }, token) {
      let decode_token = jwt_decode(token);
      findById(
        decode_token.userid,
        (response) => {
          if (response.data.message === "success") {
            commit("SET_USER_INFO", response.data.userInfo);
          } else {
            console.log("유저 정보 없음!!");
          }
        },
        (error) => {
          console.log(error);
        }
      );
    },
    regBookmark(data, params){
      console.log(params.userId, params.aptCode)
      regBookmark(
        params,
        (res)=>{
          console.log(res);
        },
        (err)=>{
          console.log(err);
        }
      )
    },
    deleteBookmark(data, params){
      deleteBookmark(
        params,
        (res)=>{
          console.log(res);
        },
        (err)=>{
          console.log(err);
        }
      )
    }
  },
};

export default memberStore;
