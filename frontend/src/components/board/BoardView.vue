<template>
  <b-container class="bv-example-row mt-3">
    <b-row class="mb-1">
      <b-col>
        <b-card
          :header-html="`<h3>${article.articleno}.
          ${article.subject} </h3><div><h6>작성자: ${article.userid}</div>
          <div style='text-align:right'>조회수 : ${article.hit} `"
          class="mb-2"
          border-variant="dark"
          no-body
        >
          <b-card-body class="text-left">
            <div v-html="message" style="min-height:200px"></div>
            <div style='text-align:right'>{{article.regtime}}</div>
          </b-card-body>
        </b-card>
      </b-col>
    </b-row>
    <b-row class="mb-1 mt-4">
      <b-col class="text-left">
        <b-button variant="outline-primary" @click="listArticle">목록</b-button>
      </b-col>
      <b-col class="text-right">
        <b-button variant="outline-info" size="sm" @click="moveModifyArticle" class="mr-2"
          >글수정</b-button
        >
        <b-button variant="outline-danger" size="sm" @click="deleteArticle">글삭제</b-button>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
// import moment from "moment";
// import http from "@/util/http-common";
import { getArticle } from "@/api/board";

export default {
  data() {
    return {
      article: {},
    };
  },
  computed: {
    message() {
      if (this.article.content) return this.article.content.split("\n").join("<br>");
      return "";
    },
    // changeDateFormat() {
    //   return moment(new Date(this.article.regtime)).format(
    //     "YYYY.MM.DD hh:mm:ss"
    //   );
    // },
  },
  created() {
    // http.get(`/board/${this.$route.params.articleno}`).then(({ data }) => {
    //   this.article = data;
    // });
    getArticle(
      this.$route.params.articleno,
      (response) => {
        this.article = response.data;
      },
      (error) => {
        console.log("삭제시 에러발생!!", error);
      }
    );
  },
  methods: {
    listArticle() {
      this.$router.push({ name: "BoardList" });
    },
    moveModifyArticle() {
      this.$router.replace({
        name: "BoardUpdate",
        params: { articleno: this.article.articleno },
      });
      //   this.$router.push({ path: `/board/modify/${this.article.articleno}` });
    },
    deleteArticle() {
      if (confirm("정말로 삭제?")) {
        this.$router.replace({
          name: "BoardDelete",
          params: { articleno: this.article.articleno },
        });
      }
    },
  },
};
</script>

<style>
</style>
