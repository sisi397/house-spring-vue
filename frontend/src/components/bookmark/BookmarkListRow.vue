<template>
  <b-row
    class="m-2 mouse-over"
    @click="selectHouse"
  >
    <b-col cols="2" class="text-center align-self-center">
      <img class="thumbnail" :src="require('@/assets/home'+parseInt(Math.random()*10)+'.jpg')" alt="Image 1">
    </b-col>
    <b-col v-if="flag == 1" cols="10" class="align-self-center">
      [{{ house.aptCode }}] {{ house.aptName }}
      <a @click="deletebookmark(userInfo.userId, house.aptCode)"
        ><b-icon-star-fill></b-icon-star-fill
      ></a>
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
      params: {
        userId: "",
        aptCode: "",
      },
    };
  },
  props: {
    house: Object,
    flag: Number,
    key:Number,
  },
  computed: {
    ...mapState(memberStore, ["userInfo"]),
    ...mapState(houseStore, ["houses"]),
  },
  methods: {
    ...mapActions(houseStore, ["detailBookMarkHouse", "detailHouse", "getDongHouse", "getBookmark"]),
    ...mapActions(memberStore, ["regBookmark", "deleteBookmark"]),
    // colorChange(flag) {
    //   this.isColor = flag;
    // },
    selectHouse() {
      console.log(this.house);
      this.detailHouse(this.house.aptCode);
      this.detailBookMarkHouse(this.house);
    },
    deletebookmark(userId, aptCode) {
      this.params.userId = userId;
      this.params.aptCode = aptCode;
      this.deleteBookmark(this.params);
      alert("등록 취소되었습니다.");
      this.getBookmark(this.userInfo.userId);
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
