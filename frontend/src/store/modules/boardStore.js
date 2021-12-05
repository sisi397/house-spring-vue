import { listArticle } from "@/api/board.js";
// getArticle
const boardStore = {
  namespaced: true,
  state: {
    // 게시판 정보
    articles: [],
    article: {},
  },
  getters: {},
  mutations: {
    // 게시판 정보
    setArticles(state, payload) {
      console.log(payload);
      const data = payload.data;
      // 아이디, 글번호, 제목과 일치하는 데이터 state.articles에 저장
      if (payload.key === "userid") {
        state.articles = data.filter((article) => article.userid === payload.word);
      } else if (payload.key === "articleno") {
        state.articles = data.filter((article) => article.articleno === parseInt(payload.word));
      } else if (payload.key === "subject") {
        state.articles = data.filter((article) => article.subject === payload.word);
      } else state.articles = data;
      console.log(state.articles);
    },
    // setArticle(state, payload) {
    //   state.article = payload;
    //   // console.log(state.article);
    // },
  },
  actions: {
    // 게시판 정보
    getArticles: ({ commit }, payload) => {
      const params = { key: payload.keyword, word: payload.word };
      console.log(params);
      listArticle(
        params,
        ({ data }) => {
          // console.log(data);
          const key = payload.keyword;
          const word = payload.word;
          commit("setArticles", { data: data, key: key, word: word });
        },
        (error) => {
          console.log(error);
        }
      );
    },

    // getArticles(context, payload) {
    //   axios.get("/board").then(({ data }) => {
    //     console.log(data);
    //     const key = payload.keyword;
    //     const word = payload.word;
    //     context.commit("setArticles", { data: data, key: key, word: word });
    //   });
    // },

    // getArticle: ({ commit }, articleno) => {
    //   getArticle(
    //     articleno,
    //     ({ data }) => {
    //       // console.log(data);
    //       commit("setArticle", data);
    //     },
    //     (error) => {
    //       console.log(error);
    //     }
    //   );
    // },

    // async getArticle(context, articleno) {
    //   await axios.get(`/board/${articleno}`).then(({ data }) => {
    //     // console.log(data);
    //     context.commit("setArticle", data);
    //   });
    // },
  },
};

export default boardStore;
