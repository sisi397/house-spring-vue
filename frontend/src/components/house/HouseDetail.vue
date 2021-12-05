<template>
  <b-container v-if="house" class="bv-example-row">
    <div class="card" style="max-width:30rem;">
      <img :src="require('@/assets/home'+parseInt(Math.random()*10)+'.jpg')" alt="Image" height=300 class="card-img-top">
      <div class="card-header">
        <h3 v-if="flag == 1">{{ house[0].aptName }}</h3>
        <h3 v-else>{{ house.아파트 }}</h3>
      </div>
      <div class="card-body">
        <h6 class="card-subtitle text-muted" v-if="flag == 1">{{ house[0].sidoName + " " + house[0].gugunName + " " + house[0].dongName}} </h6>
        <h6 class="card-subtitle text-muted" v-else>{{ house.법정동 }} </h6>
      </div>
    </div>

    <div class="card" v-if="flag==1" style="max-width:30rem;">
      <div class="card-body">
        <span style="display: inline-block; margin:auto 20px;"><p style="font-size:26px; color:#4e85b8 !important;" class="card-subtitle text-muted">면적</p>{{ house[0].area }} </span>
        <span style="display: inline-block; margin:auto 20px;"><p style="font-size:26px; color:#4e85b8 !important;" class="card-subtitle text-muted">층수</p>{{ house[0].floor }} </span>
        <span style="display: inline-block; margin:auto 20px;"><p style="font-size:26px; color:#4e85b8 !important;" class="card-subtitle text-muted">준공</p>{{ house[0].buildYear }} </span>
      </div>
    </div>
    <div class="card" v-else style="max-width:30rem;">
      <div class="card-body">
        <span style="display: inline-block; margin:auto 20px;"><p style="font-size:26px; color:#4e85b8 !important;" class="card-subtitle text-muted">면적</p>{{ house.전용면적 }} </span>
        <span style="display: inline-block; margin:auto 20px;"><p style="font-size:26px; color:#4e85b8 !important;" class="card-subtitle text-muted">층수</p>{{ house.층 }} </span>
      </div>
    </div>
    
    <!-- <b-row>
      <b-col>
        <h3 v-if="flag == 1">{{ house[0].aptName }}</h3>
        <h3 v-else>{{ house.아파트 }}</h3>
      </b-col>
    </b-row>
    <b-row class="mb-2 mt-1">
      <b-col><b-img :src="require('@/assets/apt.png')" fluid-grow></b-img></b-col>
    </b-row> -->
    <div class="card" v-if="flag==1" style="max-width:30rem; overflow:auto; max-height:400px;">
      <div class="card-header">
        <h3>거래 정보</h3>
      </div>
      <div v-for="(houseinfo, index) in house" :key="index">
        <div class="card-body" style="border-bottom:0.5px solid #d7d5d5">
          <h6 class="card-subtitle text-muted">날  짜 : 
              {{ houseinfo.dealYear+"."+houseinfo.dealMonth + "." + houseinfo.dealDay }} </h6>
          <p class="card-text">거래금액 : {{ houseinfo.dealAmount | price }}원 </p>
        </div>
      </div>
    </div>

    <div class="card" v-else style="max-width:30rem;">
      <div class="card-header">
        <h3>거래 정보</h3>
      </div>
      <div class="card-body" v-if="flag == 2">
        <h6 class="card-subtitle text-muted">일련번호 : {{ house.일련번호 }}</h6>
      </div>
      <div class="card-body" style="border-bottom:0.5px solid #d7d5d5">
        <h6 class="card-subtitle text-muted">날  짜 : {{ house.년 + "." + house.월 + "." + house.일 }} </h6>
        <p class="card-text">거래금액 : {{ house.거래금액 | price }}원 </p>
      </div>
    </div>
    
      
      <!-- <b-row>
        <b-col>
          <b-alert v-if="flag == 2" show variant="secondary">일련번호 : {{ house.일련번호 }}</b-alert> -->
          <!-- <b-alert v-else show variant="secondary">일련번호 : {{ house.일련번호 }}</b-alert> -->
        <!-- </b-col>
      </b-row> -->
      <!-- <b-row>
        <b-col>
          <b-alert v-if="flag == 1" show variant="secondary">아파트 코드 : {{ house.aptCode }}</b-alert>
          <b-alert v-else show variant="secondary">아파트 코드 : {{ house.aptCode }}</b-alert>
        </b-col>
      </b-row> -->
      <!-- <b-row>
        <b-col>
          <div v-if="flag == 1">{{ houseinfo.sidoName + " " + houseinfo.gugunName + " " + houseinfo.dongName}} </div>
          <div v-else>{{ house.법정동 }} </div>
        </b-col>
      </b-row> -->
      <!-- <b-row>
        <b-col>
          <b-alert v-if="flag == 2" show variant="warning">층수 : {{ house.층 }}층</b-alert>
        </b-col>
      </b-row> -->
      <!-- <b-row>
        <b-col>
          <b-alert v-if="flag == 1 && house.dealAmount !== 'null'" show variant="danger"
            >거래금액 : 
            {{ house[0].dealAmount | price }}원</b-alert
          >
          <b-alert v-else-if="flag == 2 && house.거래금액 !== 'null'" show variant="danger"
            >거래금액 : {{ house.거래금액 | price }}원</b-alert
          >
        </b-col>
      </b-row> -->
  </b-container>
</template>

<script>
import { mapState, mapMutations } from "vuex";
const houseStore = "houseStore";

export default {
  name: "HouseDetail",
  computed: {
    ...mapState(houseStore, ["house", "flag"]),
  },
  filters: {
    price(value) {
      if (!value) return value;
     
      return  parseInt(value.replace(",","")*10000).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    },
  },
  created() {
    this.CLEAR_DETAIL();
  },
  methods: {
    ...mapMutations(houseStore, ["CLEAR_DETAIL"]),
  },
};
</script>

<style></style>
