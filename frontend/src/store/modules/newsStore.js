import {
    listNews
  } from "@/api/news.js";
  
  const newsStore = {
    namespaced: true,
    state: {
      newslist:[]
    },
  
    getters: {},
  
    mutations: {
      SET_NEWS_LIST: (state, news) => {
        state.newslist = news;
      },
    },
  
    actions: {
      getListNews: ({ commit }) => {
        listNews(
          (response) => {
            console.log(response.data);
            commit("SET_NEWS_LIST", response.data);
          },
          (error) => {
            console.log(error);
          }
        );
      },
    },
  };
  
  export default newsStore;
  