<template>
  <div>
    <h1 class="underline-steelblue">
      <b-icon icon="person-lines-fill"></b-icon> 회원정보 수정
    </h1>
    <b-form id="signupform" @submit="onSubmit" @reset="onCancel">
      <div class="mt-2">아이디 : </div>
      <b-form-input v-model="userInfo.userId" disabled></b-form-input>

      <div class="mt-2">비밀번호 : </div>
      <b-form-input type="password" v-model="userInfo.userPwd"></b-form-input>

      <div class="mt-2">이름 : </div>
      <b-form-input v-model="userInfo.userName"></b-form-input>

      <div class="mt-2">이메일 : </div>
      <b-form-input type="email" v-model="userInfo.userEmail"></b-form-input>
      <b-form-text id="input-live-help">We'll never share your email with anyone else.</b-form-text>

      <div class="mt-2">전화번호 : </div>
      <b-form-input v-model="userInfo.userPhoneNumber"></b-form-input>

      <b-button type="submit" variant="info">수정</b-button>
      <b-button type="reset" variant="danger">취소</b-button>
    </b-form>
  </div>
</template>

<script>
  import { mapState, mapActions } from "vuex";

  const memberStore = "memberStore";
  export default {
    computed: {
      ...mapState(memberStore, ["userInfo"]),
    },
    methods: {
      ...mapActions(memberStore, ["userUpdate"]),
      async onSubmit(event) {
        event.preventDefault()
        console.log(this.userInfo)
        await this.userUpdate(this.userInfo);
        this.$router.push({ name: "MemberInfo" });
        alert("수정 완료되었습니다.")
      },
      onCancel() {
       this.$router.push({ name: "MemberInfo" });
      }
    }
  }
</script>

<style scoped>

#signupform{
 background-color:white;
 max-width:900px;
 padding:60px 150px; 
 margin:40px auto;
 border-radius: 8px; 
 border: 1px solid rgb(194, 194, 194)
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