import {
  sidoList,
  gugunList,
  houseList,
  dongList,
  houseDongList,
  bookmarkList,
  houseDetailList,
} from "@/api/house.js";

const houseStore = {
  namespaced: true,
  state: {
    sidos: [{ value: null, text: "선택하세요" }],
    guguns: [{ value: null, text: "선택하세요" }],
    dongs: [{ value: null, text: "선택하세요" }],
    houses: [],
    house: [],
    houseOne: null,
    flag: 0,

    searchArea: [], // 검색 기록

    sidoCode: "",
    gugunCode: "",
  },

  getters: {},

  mutations: {
    SET_SIDO_LIST: (state, sidos) => {
      sidos.forEach((sido) => {
        state.sidos.push({ value: sido.sidoCode, text: sido.sidoName });
      });
    },
    SET_GUGUN_LIST: (state, guguns) => {
      const payload = guguns.data;
      state.sidoCode = guguns.sidoCode;
      // console.log(state.sidoCode);
      payload.forEach((gugun) => {
        state.guguns.push({ value: gugun.gugunCode, text: gugun.gugunName });
      });
    },
    SET_DONG_LIST: (state, dongs) => {
      const payload = dongs.data;
      state.gugunCode = dongs.gugunCode;
      // console.log(state.gugunCode);
      payload.forEach((dong) => {
        state.dongs.push({ value: dong.dongCode, text: dong.dongName });
      });
    },
    CLEAR_SIDO_LIST: (state) => {
      state.sidos = [{ value: null, text: "선택하세요" }];
    },
    CLEAR_GUGUN_LIST: (state) => {
      state.guguns = [{ value: null, text: "선택하세요" }];
    },
    CLEAR_DONG_LIST: (state) => {
      state.dongs = [{ value: null, text: "선택하세요" }];
    },
    CLEAR_LIST: (state) => {
      state.houses = [];
    },
    CLEAR_DETAIL: (state) => {
      state.house = null;
      console.log(state.house);
    },
    // 시, 구/군, 동까지 선택했을 때
    SET_HOUSE_LIST: (state, payload) => {
      //   console.log(houses);
      state.houses = payload.data;
      state.flag = payload.flag;
      // console.log(state.flag);

      if (payload.flag == 1) {
        state.searchArea.push({
          sidoName: payload.data[0].sidoName,
          gugunName: payload.data[0].gugunName,
          dongName: payload.data[0].dongName,
        });
      } else {
        state.searchArea.push({
          sidoName: state.sidos.find((code) => state.sidoCode === code.value).text,
          gugunName: state.guguns.find((code) => state.gugunCode === code.value).text,
        });
      }
      // console.log(state.searchArea);
    },
    // 시, 구/군, 동까지 선택했을 때
    SET_BOOKMARK_HOUSE_LIST: (state, payload) => {
      //   console.log(houses);
      state.houses = payload.data;
      state.flag = payload.flag;
    },
    SET_CLEAR_AREA: (state, value) => {
      state.searchArea.splice(value, 1);
    },

    SET_DETAIL_HOUSE: (state, house) => {
      state.house = house;
    },
    SET_DETAIL_BOOKMARKHOUSE: (state, house) => {
      state.houseOne = house;
      console.log(state.houseOne);
    },
  },

  actions: {
    getSido: ({ commit }) => {
      sidoList(
        ({ data }) => {
          // console.log(data);
          commit("SET_SIDO_LIST", data);
        },
        (error) => {
          console.log(error);
        }
      );
    },
    getGugun: ({ commit }, sidoCode) => {
      const params = {
        sido: sidoCode,
      };
      gugunList(
        params,
        ({ data }) => {
          // console.log(commit, response);
          commit("SET_GUGUN_LIST", { data, sidoCode });
        },
        (error) => {
          console.log(error);
        }
      );
    },
    getDong: ({ commit }, gugunCode) => {
      const params = { gugun: gugunCode };
      dongList(
        params,
        ({ data }) => {
          // console.log(commit, data);
          commit("SET_DONG_LIST", { data, gugunCode });
        },
        (error) => {
          console.log(error);
        }
      );
    },
    getDongHouse: ({ commit }, data) => {
      const params = { dong: data.dongCode, userId: data.userId };
      const flag = 1;
      houseDongList(
        params,
        ({ data }) => {
          console.log(commit, data);
          commit("SET_HOUSE_LIST", { data: data, flag });
        },
        (error) => {
          console.log(error);
        }
      );
    },
    getHouseList: ({ commit }, gugunCode) => {
      // vue cli enviroment variables 검색
      //.env.local file 생성.
      // 반드시 VUE_APP으로 시작해야 한다.
      // const SERVICE_KEY = process.env.VUE_APP_APT_DEAL_API_KEY;
      const SERVICE_KEY =
        "dEkZqV1iRJ8XPvE6UI%2BCxbukUJbknDXd9kiWC%2FUY5Ce%2BJKR8W9iluMhkxfliniLdwHV57cjzblOSFtURYCNLeQ%3D%3D";
      // "9Xo0vlglWcOBGUDxH8PPbuKnlBwbWU6aO7%2Bk3FV4baF9GXok1yxIEF%2BIwr2%2B%2F%2F4oVLT8bekKU%2Bk9ztkJO0wsBw%3D%3D";
      const flag = 2;
      const params = {
        LAWD_CD: gugunCode,
        DEAL_YMD: "202110",
        serviceKey: decodeURIComponent(SERVICE_KEY),
      };
      houseList(
        params,
        (response) => {
          console.log(response.data.response.body.items.item);
          commit("SET_HOUSE_LIST", { data: response.data.response.body.items.item, flag });
        },
        (error) => {
          console.log(error);
        }
      );
    },
    getBookmark: ({ commit }, userId) => {
      bookmarkList(
        userId,
        (response) => {
          const flag = 1;
          commit("SET_BOOKMARK_HOUSE_LIST", { data: response.data, flag });
        },
        (error) => {
          console.log(error);
        }
      );
    },
    detailHouse: ({ commit }, aptCode) => {
      const params = { aptCode: aptCode };
      houseDetailList(
        params,
        (response) => {
          console.log(response.data);
          // 나중에 house.일련번호를 이용하여 API 호출
          commit("SET_DETAIL_HOUSE", response.data);
        },
        (error) => {
          console.log(error);
        }
      );
    },
    detailBookMarkHouse: ({ commit }, house) => {
      // 나중에 house.일련번호를 이용하여 API 호출
      // console.log(house);
      commit("SET_DETAIL_BOOKMARKHOUSE", house);
    },
    detailHouse2: ({ commit }, house) => {
      // 나중에 house.일련번호를 이용하여 API 호출
      commit("SET_DETAIL_HOUSE", house);
    },
    removearea: ({ commit }, value) => {
      commit("SET_CLEAR_AREA", value);
    },
  },
};

export default houseStore;
