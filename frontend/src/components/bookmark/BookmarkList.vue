<template>
  <b-row v-if="houses && houses.length != 0">
    <b-col sm="5">
      <b-container class="bv-example-row mt-3">
        <bookmark-list-row
          v-for="(house, index) in houses"
          :key="index"
          :house="house"
          :flag="flag"
        />
      </b-container>
    </b-col>
    <b-col sm="7">
      <b-tabs content-class="mt-3">
        <b-tab title="지도" active><HouseBookMarkMap /></b-tab>
        <b-tab title="주택 정보"><HouseDetail /></b-tab>
        <b-tab title="주변 탐방"><HouseAround /></b-tab>
      </b-tabs>
    </b-col>
  </b-row>
  <b-container v-else class="bv-example-row mt-3">
    <b-row>
      <b-col><b-alert show>관심 주택을 등록해주세요.</b-alert></b-col>
    </b-row>
  </b-container>
</template>

<script>
import BookmarkListRow from "@/components/bookmark/BookmarkListRow.vue";
import HouseDetail from "@/components/house/HouseDetail.vue";
import HouseBookMarkMap from "@/components/house/HouseBookMarkMap.vue";
import HouseAround from "@/components/house/HouseAround.vue";
import { mapState, mapMutations, mapActions } from "vuex";

const houseStore = "houseStore";
const memberStore = "memberStore";

export default {
  name: "BookmarkList",
  components: {
    BookmarkListRow,
    HouseBookMarkMap,
    HouseDetail,
    HouseAround,
  },
  data() {
    return {};
  },
  computed: {
    ...mapState(houseStore, ["houses", "flag"]),
    ...mapState(memberStore, ["userInfo"]),
  },
  created() {
    this.CLEAR_LIST();
    this.CLEAR_DETAIL();
    this.getBookmark(this.userInfo.userId);
  },
  methods: {
    ...mapMutations(houseStore, ["CLEAR_LIST", "CLEAR_DETAIL"]),
    ...mapActions(houseStore, ["getBookmark"]),
  },
};
</script>

<style></style>
