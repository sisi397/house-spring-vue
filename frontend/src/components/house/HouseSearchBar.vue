<template>
  <b-row class="mt-4 mb-4 text-center">
    <!-- <b-col class="sm-3">
      <b-form-input
        v-model.trim="dongCode"
        placeholder="동코드 입력...(예 : 11110)"
        @keypress.enter="sendKeyword"
      ></b-form-input>
    </b-col>
    <b-col class="sm-3" align="left">
      <b-button variant="outline-primary" @click="sendKeyword">검색</b-button>
    </b-col> -->
    <b-col class="sm-3">
      <b-form-select v-model="sidoCode" :options="sidos" @change="gugunList"></b-form-select>
    </b-col>
    <b-col class="sm-3">
      <b-form-select v-model="gugunCode" :options="guguns" @change="dongList"></b-form-select>
    </b-col>
    <!-- 동 정보 -->
    <b-col class="sm-3">
      <b-form-select v-model="dongCode" :options="dongs" @change="searchAptDong"></b-form-select>
    </b-col>

    <b-button variant="outline-primary" @click="searchAptGugun">검색</b-button>
    <!-- <b-button @click="moveMapPage">지도 보기</b-button> -->
    <!-- <router-link :to="{ name: 'Map' }" class="link"> 지도보기</router-link> -->
  </b-row>
</template>

<script>
import { mapState, mapActions, mapMutations } from "vuex";

/*
  namespaced: true를 사용했기 때문에 선언해줍니다.
  index.js 에서 modules 객체의 '키' 이름입니다.

  modules: {
    키: 값
    memberStore: memberStore,
    houseStore: houseStore
  }
*/
const houseStore = "houseStore";
const memberStore = "memberStore";
export default {
  name: "HouseSearchBar",
  data() {
    return {
      sidoCode: null,
      gugunCode: null,
      dongCode: null,

      sidoName: null,
      gugunName: null,
    };
  },
  computed: {
    ...mapState(houseStore, ["sidos", "guguns", "dongs", "houses"]),
    ...mapState(memberStore, ["userInfo"]),
    // sidos() {
    //   return this.$store.state.sidos;
    // },
  },
  created() {
    // this.$store.dispatch("getSido");
    // this.sidoList();
    this.CLEAR_SIDO_LIST();
    this.getSido();
  },
  methods: {
    ...mapActions(houseStore, ["getSido", "getGugun", "getDong", "getDongHouse", "getHouseList"]),
    ...mapMutations(houseStore, [
      "CLEAR_SIDO_LIST",
      "CLEAR_GUGUN_LIST",
      "CLEAR_DONG_LIST",
      "CLEAR_LIST",
      "CLEAR_DETAIL",
    ]),
    // sidoList() {
    //   this.getSido();
    // },
    gugunList() {
      console.log(this.sidoCode);
      this.CLEAR_GUGUN_LIST();
      this.CLEAR_LIST();
      this.CLEAR_DETAIL();
      this.gugunCode = null;
      if (this.sidoCode) this.getGugun(this.sidoCode);
    },

    dongList() {
      console.log(this.gugunCode);
      this.CLEAR_DONG_LIST();
      this.dongCode = null;
      if (this.gugunCode) this.getDong(this.gugunCode);
    },
    searchAptDong() {
      // console.log(this.dongCode);
      // if (this.dongCode) this.getDongHouse(this.dongCode);
      this.CLEAR_DETAIL();
      console.log(this.dongCode, this.userInfo.userId);
      let param = {
        dongCode: this.dongCode,
        userId: this.userInfo.userId,
      };
      if (this.dongCode) this.getDongHouse(param);
    },
    searchAptGugun() {
      // 동을 선택했다면 검색하지 못하게 방지
      if (this.dongCode != null) {
        alert("구/군까지만 선택하고 검색하세요!");
      } else {
        this.CLEAR_DETAIL();
        console.log(this.gugunCode);
        if (this.gugunCode) this.getHouseList(this.gugunCode);
      }
    },

    moveMapPage() {
      this.$router.push({ name: "Map" });
    },
  },
};
</script>

<style></style>
