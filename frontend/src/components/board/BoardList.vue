<template>
  <b-container class="bv-example-row mt-3" style="min-height:600px;">
    <b-row>
      <b-col>
        <h3>게시판</h3>
      </b-col>
    </b-row>
    <b-row class="mb-4 mt-5">
      <b-col class="sm-3">
        <b-form-select id="skey" name="key" class="form-control" v-model="keyword">
          <option>전체</option>
          <option value="userid">아이디</option>
          <option value="articleno">글번호</option>
          <option value="subject">제목</option>
        </b-form-select>
      </b-col>
      <b-col class="sm-3">
        <input
          type="text"
          class="ml-1 form-control"
          id="sword"
          name="word"
          value=""
          v-model="word"
        />
      </b-col>
      <b-button variant="outline-primary" @click="searchArticle">검색</b-button>
    </b-row>
    <b-row>
      <b-col v-if="articles.length">
        <b-table-simple hover responsive>
          <colgroup>
            <col width="10%">
            <col width="20%">
            <col width="30%">
            <col width="10%">
            <col width="10%">
            <col width="10%">
          </colgroup>
          <b-thead head-variant="dark">
            <b-tr>
              <b-th>글번호</b-th>
              <b-th>제목</b-th>
              <b-th>내용</b-th>
              <b-th>조회수</b-th>
              <b-th>작성자</b-th>
              <b-th>작성일</b-th>
            </b-tr>
          </b-thead>
          <tbody>
            <!-- 하위 component인 ListRow에 데이터 전달(props) -->
            <board-list-row v-for="(article, index) in articles" :key="index" v-bind="article" />
          </tbody>
        </b-table-simple>
      </b-col>
      <b-col v-else class="text-center">도서 목록이 없습니다.</b-col>
    </b-row>
    
    <b-row class="mb-1 mt-3">
      <b-col class="text-right">
        <b-button variant="outline-primary" @click="moveWrite()">글쓰기</b-button>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import { mapState, mapActions } from "vuex";
import BoardListRow from "@/components/board/child/BoardListRow";
// import { listArticle } from "@/api/board.js";
const boardStore = "boardStore";
export default {
  name: "BoardList",
  components: {
    BoardListRow,
  },
  data() {
    return {
      keyword: "",
      word: "",
      // articles: [],
    };
  },
  computed: {
    ...mapState(boardStore, ["articles"]),
    // articles() {
    //   return this.$store.state.articles;
    // },
  },
  created() {
    // http.get(`/board`).then(({ data }) => {
    //   this.articles = data;
    // });
    this.getArticles({ keyword: this.keyword, word: this.word });
  },
  methods: {
    ...mapActions(boardStore, ["getArticles"]),
    moveWrite() {
      this.$router.push({ name: "BoardWrite" });
    },
    searchArticle() {
      if (this.keyword === "글번호") this.word = parseInt(this.word);
      // 전체를 선택하면 입력 값 없도록 설정
      else if (this.keyword === "전체") this.word = "";
      this.getArticles({ keyword: this.keyword, word: this.word });
      // this.$store.dispatch("getArticles", { keyword: this.keyword, word: this.word });
    },
  },
};
</script>

<style scope>
.tdClass {
  width: 50px;
  text-align: center;
}
.tdSubject {
  width: 300px;
  text-align: left;
}
</style>
