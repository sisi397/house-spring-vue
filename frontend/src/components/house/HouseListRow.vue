<template>
  <b-row
    class="m-3 mouse-over"
    @click="selectHouse"
  >
    <b-col cols="2" class="text-center align-self-center">
      <img class="thumbnail" :src="require('@/assets/home'+parseInt(Math.random()*10)+'.jpg')" alt="Image 1">
    </b-col>
    <b-col v-if="flag == 1" cols="10" class="align-self-center">
      [{{ house.aptCode }}] {{ house.aptName }} 
      <template v-if="house.bookmark==1">
        <a @click="deletebookmark(userInfo.userId, house.aptCode)"><b-icon-star-fill></b-icon-star-fill></a>
      </template>
      <template v-else>
        <a @click="bookmark(userInfo.userId, house.aptCode)"><b-icon-star></b-icon-star></a>
      </template>
    </b-col>
    <b-col v-else cols="10" class="align-self-center">
      [{{ house.일련번호 }}] {{ house.아파트 }}
    </b-col>
  </b-row>
</template>

<script>
import { mapActions, mapState } from "vuex";
const houseStore = "houseStore";
const memberStore = "memberStore";

export default {
  name: "HouseListRow",
  data() {
    return {
      isColor: false,
      params:{
        userId:'',
        aptCode:''
      }
    };
  },
  props: {
    house: Object,
    flag: Number,
  },
  computed:{
    ...mapState(memberStore, ["userInfo"])
  },
  methods: {
    ...mapActions(houseStore, ["detailHouse", "detailHouse2", "getDongHouse"]),
    ...mapActions(memberStore, ["regBookmark", "deleteBookmark"]),
    colorChange(flag) {
      this.isColor = flag;
    },
    selectHouse() {
      console.log(this.house)
      if(this.flag == 1)
        this.detailHouse(this.house.aptCode);
      else
        this.detailHouse2(this.house);
    },
    bookmark(userId, aptCode){
      this.params.userId = userId;
      this.params.aptCode = aptCode
      this.regBookmark(this.params);
      alert("등록되었습니다.")
      this.searchAptDong();
    },
    deletebookmark(userId, aptCode){
      this.params.userId = userId;
      this.params.aptCode = aptCode
      this.deleteBookmark(this.params);
      alert("등록되었습니다.")
      this.searchAptDong();
    },
    searchAptDong() {
      console.log(this.house.dongCode, this.userInfo.userId);
      let param = {
        dongCode :this.house.dongCode,
        userId :this.userInfo.userId
      }
      if (this.house.dongCode) this.getDongHouse(param);
    },
  },
};
</script>

<style scoped>
.apt {
  width: 50px;
}
.mouse-over:hover {
  background-color: rgba(189, 219, 195, 0.63);
}
.thumbnail {
    padding: 0.15rem;
    background-color: #fff;
    border: 1px solid #dee2e6;
    border-radius: 0.25rem;
    max-width: 70px;
    height: auto;
}

.align-self-center{
  text-align:center;
  font-size: 17px;
  font-weight:500;
}
</style>
