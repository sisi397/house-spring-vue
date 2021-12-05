<template>
  <div>
    <div class="top_main_img_wrap">
      <img
        src="https://rt.molit.go.kr/images/new/public_main_top_new.jpg"
        alt="쉽고 편리한 아파트 매매 검색"
        class="d-inline-block align-middle"
      />
    </div>
    <!-- class="bv-example-row mt-3 mb-5 text-center" -->
    <b-container class="bv-example-row mt-3 mb-5 text-center">
      <h3 class="underline-orange"><b-icon icon="house-fill"></b-icon> 주택정보</h3>
      <h5 class="mt-2" style="text-align: left">
        최근 검색 기록 <b-icon :icon="icon" @click="searchListShow"></b-icon>
      </h5>
      <b-row v-show="searchList">
        <b-col v-if="searchArea.length >= 1">
          <div style="width: 50%; height: 150px; overflow: auto">
            <!-- <b-table-simple hover responsive>
              <b-tr v-for="(area, index) in searchArea" :key="index">
                <b-td class="content">{{ area.sidoName }}</b-td>
                <b-td class="content">{{ area.gugunName }}</b-td>
                <b-td class="content">{{ area.dongName }}</b-td>
              </b-tr>
            </b-table-simple> -->

            <b-list-group v-for="(area, index) in searchArea" :key="index">
              <b-list-group-item>
                {{ searchArea[searchArea.length - (index + 1)].sidoName }}
                {{ searchArea[searchArea.length - (index + 1)].gugunName }}
                {{ searchArea[searchArea.length - (index + 1)].dongName }}

                <b-icon
                  icon="X"
                  class="iconx"
                  @click="removeArea(searchArea.length - (index + 1))"
                ></b-icon>
              </b-list-group-item>
            </b-list-group>
          </div>
        </b-col>
        <b-col v-else class="text-center">검색 기록이 없습니다.</b-col>
      </b-row>
      <b-row>
        <b-col>
          <house-search-bar></house-search-bar>
        </b-col>
      </b-row>
      <b-row>
        <b-col cols="6" align="left">
          <house-list />
        </b-col>
        <b-col cols="6">
          <house-detail />
        </b-col>
      </b-row>
      <!-- 지도 표시 -->
      <b-row>
        <house-map></house-map>
      </b-row>
    </b-container>
  </div>
</template>
<script>
import HouseSearchBar from "@/components/house/HouseSearchBar.vue";
import HouseList from "@/components/house/HouseList.vue";
import HouseDetail from "@/components/house/HouseDetail.vue";
import HouseMap from "@/components/house/HouseMap.vue";

import { mapState, mapActions } from "vuex";
const houseStore = "houseStore";

export default {
  name: "House",
  components: {
    HouseSearchBar,
    HouseList,
    HouseDetail,
    HouseMap,
  },
  data() {
    return {
      searchList: false,
      icon: "caret-down",
    };
  },
  computed: {
    ...mapState(houseStore, ["searchArea"]),
  },
  methods: {
    ...mapActions(houseStore, ["removearea"]),
    searchListShow() {
      if (this.searchList) {
        this.searchList = false;
        this.icon = "caret-down";
      } else {
        this.searchList = true;
        this.icon = "caret-up";
      }
    },
    removeArea(value) {
      this.removearea(value);
    },
  },
};
</script>
<style scoped>
.underline-orange {
  display: inline-block;
  background: linear-gradient(180deg, rgba(255, 255, 255, 0) 70%, rgba(231, 149, 27, 0.3) 30%);
}
.mt-3 {
  margin-top: 70px !important;
}
.iconx {
  color: red;
  width: 20px;
}
.iconx:hover {
  cursor: pointer;
}
</style>
