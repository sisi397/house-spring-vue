<template>
  <b-container v-if="houses && houses.length != 0" class="bv-example-row" style="max-height:750px; overflow:auto">
    <house-list-row v-for="(house, index) in houses" :key="index" :house="house" :flag="flag"/>
  </b-container>
  <b-container v-else class="bv-example-row mt-3">
    <b-row>
      <b-col><b-alert style="background-color: rgba(189, 219, 195, 0.63);" show>주택 목록이 없습니다.</b-alert></b-col>
    </b-row>
  </b-container>
</template>

<script>
import HouseListRow from "@/components/house/HouseListRow.vue";
import { mapState, mapMutations } from "vuex";

const houseStore = "houseStore";

export default {
  name: "HouseList",
  components: {
    HouseListRow,
  },
  data() {
    return {};
  },
  computed: {
    ...mapState(houseStore, ["houses", "flag"]),
  },
  created() {
    this.CLEAR_LIST();
    this.CLEAR_DETAIL();
  },
  methods: {
    ...mapMutations(houseStore, ["CLEAR_LIST", "CLEAR_DETAIL"]),
  },
};
</script>

<style></style>
