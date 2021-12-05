<template>
  <div id="loginform">
    <h1 class="underline-steelblue" style="margin-bottom:20px;">
      <b-icon icon="person-lines-fill"></b-icon> 로그인
    </h1>
      <b-row>
      <b-col></b-col>
      <b-col cols="8">
        <b-card class="text-center mt-3 logincard" style="max-width: 40rem; margin:auto;" align="left">
          <b-form class="text-left">
            <b-alert show variant="danger" v-if="isLoginError"
              >아이디 또는 비밀번호를 확인하세요.</b-alert
            >
            <b-form-group label="아이디:" label-for="userid">
              <b-form-input
                id="userid"
                v-model="user.userId"
                required
                placeholder="아이디 입력...."
                @keyup.enter="confirm"
              ></b-form-input>
            </b-form-group>
            <b-form-group label="비밀번호:" label-for="userpwd">
              <b-form-input
                type="password"
                id="userpwd"
                v-model="user.userPwd"
                required
                placeholder="비밀번호 입력...."
                @keyup.enter="confirm"
              ></b-form-input>
            </b-form-group>
            <b-button
              type="button"
              variant="primary"
              class="m-1"
              @click="confirm"
              >로그인</b-button
            >
            <b-button
              type="button"
              variant="success"
              class="m-1"
              @click="movePage"
              >회원가입</b-button
            >
          </b-form>
        </b-card>
      </b-col>
      <b-col></b-col>
    </b-row>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
const memberStore = "memberStore";

export default {
  name: "MemberLogin",
  data() {
    return {
      user: {
        userId: "",
        userPwd: "",
      },
    };
  },
  computed: {
    ...mapState(memberStore, ["isLogin", "isLoginError"]),
  },
  methods: {
    ...mapActions(memberStore, ["userConfirm", "getUserInfo"]),
    async confirm() {
      await this.userConfirm(this.user);
      let token = sessionStorage.getItem("access-token");
      console.log(this.isLogin)
      console.log(this.isLoginError)
      if (this.isLogin) {
        await this.getUserInfo(token);
        this.$router.push({ name: "Home" });
      }
    },
    movePage() {
      this.$router.push({ name: "SignUp" });
    },
  },
};
</script>

<style scoped>
.logincard{
  border-radius: 8px; 
  border: 1px solid rgb(194, 194, 194);
  padding:15px
}
.container{
  background-color:rgb(245, 245, 245); 
}
input{
  margin-bottom:30px;
}
.mt-2{
  float:left;
}
button{
  margin:20px;
  width:100px;
  height:50px;
}
</style>