<template>
  <div>
    <!-- Header-->
    <header class="masthead text-center text-white">
      <div class="masthead-content">
        <div class="container px-5 title" style="height: 350px">
          <h1 class="masthead-heading mb-0" style="padding-top: 50px">HAPPY HOUSE</h1>
          <div class="bannerline"></div>
          <p class="masthead-subheading mb-0" style="font-size: 30px">행복한 우리 집</p>
          <a class="btn btn-primary btn-xl rounded-pill mt-5" href="/house">Learn More</a>
        </div>
      </div>
    </header>
    <section v-if="userInfo" style="background-color: rgb(247, 247, 247)">
      <div
        style="
          width: 60%;
          padding-top: 40px;
          padding-bottom: 40px;
          margin: 0px auto;
          overflow: auto;
        "
      >
        <h2 class="mb-4" style="text-align: left">관심 주택 정보</h2>
        <div class="cardgroup">
          <span class="cardrow" v-for="(house, index) in houses" :key="index">
            <h4 style="text-align: left; margin-bottom: 15px">{{ house.aptName }}</h4>
            <p style="text-align: left">{{ house.recentPrice | price }}원</p>
            <p class="text-muted" style="text-align: left">
              {{ house.gugunName + " " + house.dongName }}
            </p>
          </span>
        </div>
      </div>
    </section>
    <section class="about" style="padding-bottom: 0px">
      <div class="line1"></div>
      <div class="line2"></div>
      <span class="txt">
        HAPPY HOUSE
        <!-- <img src="@/assets/happyhouse.png" alt=""> -->
      </span>
      <div class="title">
        <h2>주택 정보</h2>
        <p>
          Happy House는 주택 거래 정보 서비스를 제공합니다.<br />
          주택 정보를 확인해보세요.
        </p>
        <a href="house">more</a>
      </div>
      <ul class="banner">
        <li data-aos="fade-up" data-aos-duratjion="3000">
          <img src="@/assets/house3.jpg" alt="" />
        </li>
        <li data-aos="fade-up" data-aos-duratjion="3000">
          <img src="@/assets/house2.jpg" alt="" />
        </li>
        <li data-aos="fade-up" data-aos-duratjion="3000">
          <img src="@/assets/house1.jpg" alt="" />
        </li>
        <li data-aos="fade-up" data-aos-duratjion="3000">
          <img src="@/assets/house4.jpg" alt="" />
        </li>
      </ul>
    </section>
    <section style="background-color: rgb(247 247 247); padding-top: 40px; padding-bottom: 40px">
      <div data-aos="fade-up" data-aos-duratjion="3000">
        <router-link :to="{ name: 'House' }" style="color: black">
          <!-- 391 411 122 238 1010 223-->
          <b-card
            overlay
            img-src="https://rt.molit.go.kr/images/new/public_main_top_new.jpg"
            img-alt="Card Image"
            text-variant="black"
            title="주택 거래 정보"
            sub-title=""
            style="width: 60%; margin: 40px auto"
          >
          </b-card>
        </router-link>
      </div>
      <div
        style="margin-bottom: 50px; border-radius: 8px"
        data-aos="fade-up"
        data-aos-duratjion="3000"
      >
        <router-link :to="{ name: 'Bookmark' }">
          <b-card
            overlay
            img-src="https://picsum.photos/900/250/?image=3"
            img-alt="Card Image"
            text-variant="white"
            title="관심주택"
            sub-title=""
            style="width: 30%; margin: 0px auto; margin-right:20px;display: inline-block"
          >
          </b-card>
        </router-link>
        <router-link :to="{ name: 'Board' }">
          <b-card
            overlay
            img-src="https://picsum.photos/900/250/?image=1010"
            img-alt="Card Image"
            text-variant="white"
            title="게시판"
            sub-title=""
            style="width: 30%; margin: 0px auto; display: inline-block"
          >
          </b-card>
        </router-link>
      </div>
    </section>
    <!-- Content section 2-->
    <section style="width: 100%">
      <div class="container px-5" style="margin: 80px auto">
        <div class="row gx-5 align-items-center">
          <div class="col-lg-4">
            <img src="@/assets/sideAD.jpg" />
          </div>
          <div class="col-lg-4">
            <h3>지혜롭게 내집 마련하기</h3>
            <div class="line"></div>
            <ul class="se2">
              <li>가용자금 확인 및 대출 계획</li>
              <li>집 종류 및 지역 선택</li>
              <li>정보 수집 & 시세파악</li>
              <li>부동산 방문 & 집구경</li>
              <li>계약 및 잔금 치르기</li>
              <li>소유권 이전 등기</li>
              <li>인테리어 공사</li>
            </ul>
            <div class="line"></div>
          </div>
          <div class="col-lg-4">
            <h3 style="margin-bottom: 0px">오늘의 뉴스</h3>
            <div style="text-align: right">
              <router-link :to="{ name: 'News' }" style="font-size: 17px">more</router-link>
            </div>
            <div class="line"></div>
            <ul class="se3">
              <li v-for="(news, index) in newslist" :key="index">
                <a v-if="index < 4" class="text-primary" :href="news.url">{{ news.title }}</a>
              </li>
            </ul>
            <div class="line"></div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
import { mapState, mapMutations, mapActions } from "vuex";

const houseStore = "houseStore";
const memberStore = "memberStore";
const newsStore = "newsStore";

export default {
  name: "Main",
  props: {
    msg: String,
  },
  components: {},
  data() {
    return {};
  },
  computed: {
    ...mapState(houseStore, ["houses", "flag"]),
    ...mapState(memberStore, ["userInfo"]),
    ...mapState(newsStore, ["newslist"]),
  },
  filters: {
    price(value) {
      if (!value) return value;

      return parseInt(value.replace(",", "") * 10000)
        .toString()
        .replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    },
  },
  created() {
    console.log(this.userInfo);
    if (this.userInfo != null) {
      this.CLEAR_LIST();
      this.CLEAR_DETAIL();
      this.getBookmark(this.userInfo.userId);
    }
    this.getListNews();
  },
  methods: {
    ...mapMutations(houseStore, ["CLEAR_LIST", "CLEAR_DETAIL"]),
    ...mapActions(houseStore, ["getBookmark"]),
    ...mapActions(newsStore, ["getListNews"]),
  },
};
</script>

<style scoped>
.container {
  max-width: 1350px;
}
.underline-steelblue {
  display: inline-block;
  background: linear-gradient(180deg, rgba(255, 255, 255, 0) 70%, rgba(72, 190, 233, 0.3) 30%);
}
header.masthead {
  position: relative;
  overflow: hidden;
  padding-top: calc(7rem + 72px);
  padding-bottom: 7rem;
  /*background: linear-gradient(0deg, #ff6a00 0%, #ee0979 100%);*/
  background-image: url("../assets/header.jpg");
  background-repeat: no-repeat;
  background-position: center center;
  background-attachment: scroll;
  background-size: cover;
}
@keyframes slid-up {
  0% {
    opacity: 0;
  }
  40% {
    opacity: 0;
    transform: translateY(40px);
  }
}
.title {
  animation-name: slid-up;
  animation-duration: 1s;
}
.bannerline {
  background: linear-gradient(
    to right,
    rgba(231, 226, 226, 0.884) 0%,
    rgba(224, 219, 219, 0.534) 35%,
    rgba(236, 232, 232, 0.5) 70%,
    transparent 100%
  );
  bottom: -1px;
  left: 0px;
  content: "";
  width: 70%;
  margin: 20px auto;
  position: relative;
  height: 3px;
}
.line {
  background: linear-gradient(
    to right,
    rgba(0, 0, 0, 0.18) 0%,
    rgba(0, 0, 0, 0.12) 35%,
    rgba(0, 0, 0, 0.05) 70%,
    transparent 100%
  );
  bottom: -1px;
  left: 0px;
  content: "";
  width: 100%;
  margin-bottom: 15px;
  position: relative;
  height: 2px;
}
.line1 {
  background: linear-gradient(
    to right,
    rgba(0, 0, 0, 0.18) 0%,
    rgba(0, 0, 0, 0.12) 35%,
    rgba(0, 0, 0, 0.05) 70%,
    transparent 100%
  );
  bottom: -1px;
  left: 0px;
  content: "";
  width: 100%;
  margin-bottom: 15px;
  position: relative;
  height: 2px;
  z-index: -1;
}
.line2 {
  background: linear-gradient(
    to bottom,
    rgba(0, 0, 0, 0.18) 0%,
    rgba(0, 0, 0, 0.12) 35%,
    rgba(0, 0, 0, 0.05) 70%,
    transparent 100%
  );
  bottom: -1px;
  left: 0px;
  content: "";
  width: 2px;
  margin-bottom: 15px;
  position: absolute;
  height: 100%;
  top: 40px;
  left: 40px;
  z-index: 3;
}
.se2 {
  list-style: none;
  padding: 0px;
}
.se2 > li,
.se3 > li {
  margin: 10px;
  text-align: left;
}
.se3 {
  list-style-type: square;
  padding: 10px;
}
.card-img {
  border-radius: 25px;
}

ul > li {
  list-style: none;
}
section.about {
  width: 95%;
  margin: 40px auto;
  padding: 100px 0;
  height: 800px;
  box-sizing: border-box;
  /* background: url("../assets/.png") no-repeat center/cover; */
  position: relative;
}

@keyframes width-ani {
  0% {
    width: 0%;
  }
  30% {
    width: 0%;
  }
}

.txt {
  color: #f5f3f1;
  font-weight: bolder;
  font-size: 100px;
  float: left;
  margin-left: 70px;
}

section.about .txtImg {
  position: absolute;
  left: 0;
  top: 20%;
  display: block;
  width: 100%;
  overflow: hidden;
}

section.about .title {
  position: absolute;
  left: 8%;
  top: 35%;
}

section.about .title h2 {
  font-size: 30px;
  margin-bottom: 20px;
}

section.about .title p {
  font-size: 19px;
  line-height: 1.6;
  margin-bottom: 30px;
}

section.about .title a {
  font-size: 24px;
  display: inline-block;
  position: relative;
}

section.about .title a:before {
  content: "";
  width: 80px;
  height: 15px;
  background-color: rgba(0, 0, 0, 0.08);
  position: absolute;
  bottom: 0;
}

section.about .banner li {
  position: absolute;
  box-shadow: 5px 6px 15px rgba(3, 3, 3, 0.4);
  width: 15%;
}

section.about .banner li img {
  width: 100%;
}

section.about .banner li:nth-child(1) {
  left: 48%;
  top: 15%;
  animation-name: slid-up;
  animation-duration: 1.2s;
}

section.about .banner li:nth-child(2) {
  left: 40%;
  top: 50%;
}

section.about .banner li:nth-child(3) {
  left: 58%;
  top: 62%;
}

section.about .banner li:nth-child(4) {
  right: 2%;
  width: 32%;
  top: 6%;
  max-width: 580px;
}

section.about .title a:hover:before,
section.about .title a:focus:before {
  width: 0%;
  transition: all 0.3s;
}

.cardgroup {
  display: flex;
  overflow-y: hidden;
  overflow-x: scroll;
  padding: 20px;
  object-fit: contain;
  width: 100%;
  max-height: 200px;
  margin-right: 10px;
  transition: transform 450ms;
}
.cardrow {
  min-width: 300px;
  padding: 1.25rem;
  background-color: #fff;
  border: 1px solid rgba(0, 0, 0, 0.125);
  margin-right: 20px;
}
.more:hover {
  color: black;
}
.card{
  border : 0px;
  background-color: #f7f7f7;
}
</style>
