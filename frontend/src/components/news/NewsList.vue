<template>
  <div id="scrollbar1" class="mt-4">
      <div class="scroll-area" style="">
        <tempalte v-for="(news,index) in newslist" :key="index">
            <a :href="news.url" style="text-decoration:none; color: black;">
            <b-card :img-src="news.imgURL" img-alt="Card image" img-left class="mb-3">
            <b-card-title style="margin-bottom:30px;">{{news.title}}</b-card-title>
            <b-card-text>
                {{news.content}}
            </b-card-text>
            </b-card>
            </a>
        </tempalte>
      </div>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";

const newsStore = "newsStore";

  export default {
    computed: {
        ...mapState(newsStore, ["newslist"]),
    },
    created() {
        this.getListNews();
    },
    methods: {
        ...mapActions(newsStore, ["getListNews"]),
    },
  }
</script>

<style scoped>
#scrollbar1 .scroll-area{
    width:100%;
    height: 800px;
    overflow: auto; 
    padding: 0 10px; 
    left: 0px;
    right: 300px;
    top: 0px;
    bottom: 0px; 
    margin: auto;
    font-size: 14px;
    color: #fff;
}

#scrollbar1 ::-webkit-scrollbar {
    width: 8px;
    height: 8px;
}
 
#scrollbar1 ::-webkit-scrollbar-track {
    background-color: rgba(228, 224, 224, 0.959);
    border-radius: 35px;
}
 
#scrollbar1 ::-webkit-scrollbar-thumb {
    background-color: rgb(146, 144, 144);
    border-radius: 5px;
}
</style>