<template>
  <div>
    <h1 class="underline-steelblue">
      <b-icon icon="person-lines-fill"></b-icon> 회원가입
    </h1>
    <b-form  id="signupform" @submit="onSubmit" @reset="onReset" v-if="show">
      <div class="mt-2">아이디 : </div>
      <b-form-input v-model="form.userId" placeholder="Enter id" @keyup="idcheck"></b-form-input>
      <div :class="{msgcolor : this.msgcolor}">{{msg}}</div>

      <div class="mt-2">비밀번호 : </div>
      <b-form-input type="password" v-model="form.userPwd" placeholder="영문 숫자 포함 6자리 이상"></b-form-input>

      <div class="mt-2">비밀번호 확인 : <span :class="{msgcolor : this.msgpwdcolor}">{{msgPwd}}</span></div>
      <b-form-input type="password" v-model="userPwdCheck" placeholder="비밀번호 확인" @keyup="pwdcheck"></b-form-input>

      <div class="mt-2">이름 : </div>
      <b-form-input v-model="form.userName" placeholder="User Name"></b-form-input>

      <div class="mt-2">이메일 : </div>
      <b-form-input type="email" v-model="form.userEmail" placeholder="User Email"></b-form-input>
      <b-form-text id="input-live-help">We'll never share your email with anyone else.</b-form-text>

      <div class="mt-2">전화번호 : </div>
      <b-form-input v-model="form.userPhoneNumber" placeholder="User PhoneNumber"></b-form-input>

      <b-button type="submit" variant="info">가입</b-button>
      <b-button type="reset" variant="danger">취소</b-button>
    </b-form>
  </div>
</template>

<script>
  import { mapState, mapActions, mapGetters } from "vuex";

  const memberStore = "memberStore";
  export default {
    data() {
      return {
        form: {
          userId:'',
          userPwd:'',
          userName:'',
          userEmail:'',
          userPhoneNumber:'',
        },
        userPwdCheck:'',
        msg:'',
        msgPwd:'',
        show: true,
        msgcolor:false,
        msgpwdcolor:false,
      }
    },
    computed: {
      ...mapState(memberStore, ["userInfo", "isOk"]),
      ...mapGetters(memberStore, ["checkId"])
    },
    methods: {
    ...mapActions(memberStore, ["userJoin", "userIdCheck"]),
      async onSubmit(event) {
        event.preventDefault()
        if(this.form.userId == '') alert("아이디를 입력해주세요.")
        else if(this.checkId == false) alert("아이디를 다시 입력해주세요.")
        else if(this.form.userId.length < 4 || this.form.userId.length >13) alert("아이디를 다시 입력해주세요.")
        else if(this.form.userPwd == '') alert("비밀번호를 입력해주세요.")
        else if(this.msgPwd == "불일치") {
          alert("비밀번호 확인을 다시 입력해주세요.")
          this.userPwdCheck = ''
        }
        else if(this.userPwdCheck == '') alert("비밀번호 확인을 입력해주세요.")
        else if(this.form.userName == '') alert("이름을 입력해주세요.")
        else if(this.form.userEmail == '') alert("이메일을 입력해주세요.")
        else if(this.form.userPhoneNumber == '') alert("전화번호를 입력해주세요.")
        else{
          await this.userJoin(this.form);
          this.$router.push({ name: "Home" });
          alert("회원가입 완료되었습니다.")
        }
      }, 
      onReset(event) {
        event.preventDefault()
        this.$router.push({ name: "Home" });
      },
      pwdcheck(){
        if(this.form.userPwd === this.userPwdCheck){
          this.msgPwd = "일치"
          this.msgpwdcolor = false;
        }else{
          this.msgPwd = "불일치"
          this.msgpwdcolor = true;
        }
      },
      async idcheck(){
        if(this.form.userId.length < 4 || this.form.userId.length >13){
          this.msg = "아이디는 4자 이상 13자 이하입니다.";
          this.msgcolor = true;
        }else{
          this.msg = "";
          await this.userIdCheck(this.form.userId);
          
          console.log(this.checkId)
          if(this.checkId){
            this.msg="사용가능한 아이디 입니다.";
            this.msgcolor = false;
          }else{
            this.msg = "사용 불가능한 아이디 입니다."
            this.msgcolor = true
          }
        }
      }
    },
  }
</script>

<style scoped>
.msgcolor{
  color:red;
}
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