<template>
  <div style="padding:0px;">
    <div class="top_main_img_wrap" style="padding:0px;">
      <img
        src="https://rt.molit.go.kr/images/new/public_main_top_new.jpg"
        alt="News"
        class="d-inline-block align-middle"
      />
    </div>
    <b-container class="bv-example-row mt-3 content text-center" style="width:70%;">
        <h2 class="underline-steelblue">오늘의 뉴스</h2>
      <news-list>
      </news-list>
    </b-container>
  </div>
</template>

<script>
import NewsList from '../components/news/NewsList.vue';

export default {
  name: "News",
  components:{
    NewsList,
  }
};
</script>

<style scoped>
div{
  background-color:#f9f9f9;
  max-width:none;
  padding:50px;
}
.underline-steelblue {
  display: inline-block;
  background: linear-gradient(
    180deg,
    rgba(255, 255, 255, 0) 70%,
    rgba(72, 190, 233, 0.3) 30%
  );
}
.mt-3{
  margin-top: 3rem !important;
}
</style>
