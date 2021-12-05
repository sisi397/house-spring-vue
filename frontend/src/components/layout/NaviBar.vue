<template>
  <div>
    <b-navbar id="navstyle" toggleable="lg" :class="this.className" fixed="top">
      <b-navbar-brand href="#" @click="navbarcolor">
        <router-link to="/">
          <img
            src="@/assets/happyhouse.png"
            class="d-inline-block align-middle"
            width="105px"
            height="55px"
            alt="Kitten"
          />
        </router-link>
      </b-navbar-brand>

      <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

      <b-collapse id="nav-collapse" is-nav>
        <b-navbar-nav>
          <b-nav-item href="#" @click="navbarcolor" style="font-size:17px;"
            ><router-link :to="{ name: 'Home' }" class="link"> HOME</router-link></b-nav-item
          >
          <b-nav-item href="#" @click="navbarcolor"
            ><router-link :to="{ name: 'House' }" class="link" style="font-size:17px;"
              ><b-icon icon="house-fill" font-scale="1"></b-icon> 주택정보</router-link
            ></b-nav-item
          >
          <b-nav-item href="#" @click="navbarcolor" style="font-size:17px;"
            ><router-link :to="{ name: 'Bookmark' }" class="link">
              관심주택 둘러보기</router-link
            ></b-nav-item
          >
          <b-nav-item href="#" @click="navbarcolor" style="font-size:17px;"
            ><router-link :to="{ name: 'Board' }" class="link"> 게시판</router-link></b-nav-item
          >
          <b-nav-item href="#" @click="navbarcolor" style="font-size:17px;"
            ><router-link :to="{ name: 'News' }" class="link"> 오늘의 뉴스</router-link></b-nav-item
          >
        </b-navbar-nav>

        <b-navbar-nav class="ml-auto" v-if="userInfo">
          <b-nav-item href="#" @click="navbarcolor"
            ><router-link :to="{ name: 'MemberInfo' }" class="link" style="font-size:17px;"
              ><b-icon icon="person-circle"></b-icon> 회원정보</router-link
            ></b-nav-item
          >
          <b-nav-item href="#"
            ><a @click.prevent="onClickLogout" class="link" style="font-size:17px;"
              ><b-icon icon="key"></b-icon> Logout</a
            ></b-nav-item
          >
        </b-navbar-nav>

        <b-navbar-nav class="ml-auto" v-else>
          <b-nav-item href="#" @click="navbarcolor"
            ><router-link :to="{ name: 'SignUp' }" class="link" style="font-size:16px;"
              ><b-icon icon="person-circle"></b-icon> SignUp</router-link
            ></b-nav-item
          >
          <b-nav-item href="#" @click="navbarcolor"
            ><router-link :to="{ name: 'SignIn' }" class="link" style="font-size:16px;"
              ><b-icon icon="key"></b-icon> Login</router-link
            ></b-nav-item
          >
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>
  </div>
</template>

<script>
import { mapState, mapMutations } from "vuex";

const memberStore = "memberStore";

export default {
  name: "NaviBar",
  data() {
    return {
      className: "navbarcolor",
    };
  },
  created() {
    this.className = "navbarcolor";
  },
  computed: {
    ...mapState(memberStore, ["isLogin", "userInfo"]),
  },
  methods: {
    ...mapMutations(memberStore, ["SET_IS_LOGIN", "SET_USER_INFO"]),
    onClickLogout() {
      this.SET_IS_LOGIN(false);
      this.SET_USER_INFO(null);
      console.log(this.isLogin, this.userInfo);
      sessionStorage.removeItem("access-token");
      if (this.$route.path != "/") this.$router.push({ name: "Home" });
      alert("로그아웃 되었습니다.");
    },
    navbarcolor() {
      this.className = "navbarcolor";
    },
  },
};

window.addEventListener("scroll", function () {
    if (document.documentElement.scrollTop >= 300) {
      document.getElementById("navstyle").className =
        "navbarblack navbar navbar-light fixed-top navbar-expand-lg";
    } else {
      document.getElementById("navstyle").className =
        "navbarcolor navbar navbar-light fixed-top navbar-expand-lg";
    }
});
</script>

<style>
.navbarcolor {
  background-color: #8896a505;
}
.navbarblack {
  background-color: rgb(54, 148, 54);
}
.link {
  text-decoration: none;
  color: white;
  margin: 10px;
}
.link:hover {
  text-decoration: none;
  color: rgb(226, 189, 140);
}
</style>
