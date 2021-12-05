<template>
  <div>
    <div>
      <img
        src="https://rt.molit.go.kr/images/new/public_main_top_new.jpg"
        alt="게시판에 글을 남겨보세요"
        class="d-inline-block align-middle"
      />
    </div>
    <!-- class="bv-example-row mt-3 text-center" -->
    <b-container>
      <h3 class="underline-hotpink"></h3>
      <router-view></router-view>
    </b-container>
  </div>
</template>
<script>
export default {
  name: "Board",
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
