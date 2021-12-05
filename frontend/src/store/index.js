import Vue from "vue";
import Vuex from "vuex";
// import axios from "@/util/http-common.js";
import memberStore from "@/store/modules/memberStore.js";
import boardStore from "@/store/modules/boardStore.js";
import houseStore from "@/store/modules/houseStore.js";
import newsStore from "@/store/modules/newsStore.js";
import createPersistedState from "vuex-persistedstate";

Vue.use(Vuex);

export default new Vuex.Store({
  // state: {
  //   articles: [],
  //   article: {},
  // },
  // mutations: {
  //   setArticles(state, payload) {
  //     console.log(payload);
  //     const data = payload.data;
  //     // 아이디, 글번호, 제목과 일치하는 데이터 state.articles에 저장
  //     if (payload.key === "아이디") {
  //       state.articles = data.filter((article) => article.userid === payload.word);
  //     } else if (payload.key === "글번호") {
  //       state.articles = data.filter((article) => article.articleno === parseInt(payload.word));
  //     } else if (payload.key === "제목") {
  //       state.articles = data.filter((article) => article.subject === payload.word);
  //     } else state.articles = data;
  //     console.log(state.articles);
  //   },
  //   setArticle(state, payload) {
  //     state.article = payload;
  //     // console.log(state.article);
  //   },
  // },
  // actions: {

  //   getArticles(context, payload) {
  //     axios.get("/board").then(({ data }) => {
  //       console.log(data);
  //       const key = payload.keyword;
  //       const word = payload.word;
  //       context.commit("setArticles", { data: data, key: key, word: word });
  //     });
  //   },

  //   async getArticle(context, articleno) {
  //     await axios.get(`/board/${articleno}`).then(({ data }) => {
  //       // console.log(data);
  //       context.commit("setArticle", data);
  //     });
  //   },
  // },
  modules: {
    memberStore,
    boardStore,
    houseStore,
    newsStore
  },
  plugins: [
    createPersistedState({
      // 브라우저 종료시 제거하기 위해 localStorage가 아닌 sessionStorage로 변경. (default: localStorage)
      storage: sessionStorage,
    }),
  ],
});
