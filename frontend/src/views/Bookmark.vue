<template>
  <div>
    <div class="top_main_img_wrap">
      <img
        src="https://rt.molit.go.kr/images/new/public_main_top_new.jpg"
        alt="관심지역을 설정하세요"
      />
    </div>
    <b-container class="bv-example-row mt-3 text-center">
      <h3 class="underline-hotpink mb-4">관심주택</h3>
      <BookmarkList />
    </b-container>
  </div>
</template>
<script>
import BookmarkList from "@/components/bookmark/BookmarkList.vue";
export default {
  name: "Bookmark",
  components: {
    BookmarkList,
  },
};
</script>
<style scoped>
.underline-hotpink {
  display: inline-block;
  background: linear-gradient(180deg, rgba(255, 255, 255, 0) 70%, rgba(231, 27, 139, 0.3) 30%);
}
.mt-3 {
  margin-top: 70px !important;
}
.container{
  max-width:1400px;
}
</style>
