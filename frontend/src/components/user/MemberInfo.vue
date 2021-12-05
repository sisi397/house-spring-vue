<template>
  <div>
    <h1 class="underline-steelblue">
      <b-icon icon="person-lines-fill"></b-icon> 회원정보
    </h1>
    <b-form id="signupform" @submit="onSubmit" @reset="onDelete">
      <div class="mt-2">아이디 : </div>
      <b-form-input v-model="userInfo.userId" disabled></b-form-input>

      <div class="mt-2">이름 : </div>
      <b-form-input v-model="userInfo.userName" disabled></b-form-input>

      <div class="mt-2">이메일 : </div>
      <b-form-input type="email" v-model="userInfo.userEmail" disabled></b-form-input>

      <div class="mt-2">전화번호 : </div>
      <b-form-input v-model="userInfo.userPhoneNumber" disabled></b-form-input>

      <b-button type="submit" variant="info">수정</b-button>
      <b-button type="reset" variant="danger">탈퇴</b-button>
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
      onSubmit() {
        this.$router.push({ name: "MemberModify" });
      },
    ...mapActions(memberStore, ["userDelete"]),
      async onDelete(event) {
        event.preventDefault()
        await this.userDelete(this.userInfo.userId);
        this.$router.push({ name: "Home" });
        alert("탈퇴 되었습니다.")
      },
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