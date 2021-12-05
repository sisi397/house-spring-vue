<template>
  <b-container class="bv-example-row mt-3 content text-center">
    <h3>지도 보기</h3>
    <b-row>
      <b-col>
        <house-map></house-map>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
// import MapView from "@/components/map/MapView.vue";
import HouseMap from "@/components/house/HouseMap.vue";
export default {
  name: "Map",
  components: {
    // MapView,
    HouseMap,
  },
};
</script>

<style scoped>
.underline-hotpink {
  display: inline-block;
  background: linear-gradient(180deg, rgba(255, 255, 255, 0) 70%, rgba(231, 27, 139, 0.3) 30%);
}
.mt-3 {
  margin-top: 3rem !important;
}
</style>
