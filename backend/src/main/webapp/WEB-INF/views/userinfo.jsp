<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/memberHeader.jsp" %>
<script type="text/javascript">
     $(document).ready(function () {
    	 $("#deleteBtn").click(function(){
    		 $.ajax({
             	url: '${root}/member/${userinfo.userId}',
               	type: 'DELETE',
               	dataType: 'json',
               	success: function (response) {
               		alert("탈퇴하였습니다.");
               		location.href="/";
              	},
              	error: function(err){
              		alert("탈퇴실패");
              	},
    		 });
    	 });
    	 
         $("#updateBtn").click(function () {
        	 if (!$("#userName").val()) {
                 alert("이름 입력!!!");
                 return;
             } else if (!$("#userPwd").val()) {
                 alert("비밀번호 입력!!!");
                 return;
             } else if ($("#userPwd").val() != $("#pwdCheck").val()) {
                 alert("비밀번호 확인!!!");
                 return;
             } else {
            	 $.ajax({
                	url: '${root}/member',
                  	type: 'PUT',
                  	dataType: 'json',
                  	data:{
                  		userId:$("#userId").val(),
                  		userPwd:$("#userPwd").val(),
                  		userName:$("#userName").val(),
                  		userEmail:$("#userEmail").val(),
                  		userPhoneNumber:$("#userPhoneNumber").val(),
                  	},
                  	success: function (response) {
                  	},
                  	error: function(err){
                  		alert("수정 실패");
                  	},
                  	statusCode : {
                  		200 : function(){
                  			alert("수정 되었습니다.");
                  		},
                  		404 : function(){
                  			alert("다시 입력해주세요.");
                  		}
                  	},
				});
             }
         });
     });

 </script>
    <body id="page-top">
        <!-- Navigation-->
         <%@include file="nav/nav.jsp" %> 
        
        <div>
            <p style="margin-left:130px; margin-top:10px;">Home > 회원 정보</p>
        </div>
        <section>
            <div style="background-color: grey; height:750px;">
                <div class="input-form-background row">
                    <div class="input-form col-md-12 mx-auto"> <!--style="background-color: grey; height:500px;"-->
                        <h2>회원 정보 확인</h2>
                        <div class="form-inline was-validated" style="margin:30px;">
                       		<input type="hidden" name="act" value="modify">
                           	<label class="mr-sm-2" for="inputId">아이디<span class="text-danger small">*</span></label>
                           	<input class="form-control mb-2 mr-sm-2" type="text" id="userId" name="userId" value="${userinfo.userId}" disabled >
                          	<label class="mr-sm-2" for="inputPwd">비밀번호<span class="text-danger small">*</span></label>
                          	<input class="form-control mb-2 mr-sm-2" type="password" id="userPwd" name="userPwd" value="">
                          	<label class="mr-sm-2" for="inputPwd">비밀번호 확인<span class="text-danger small">*</span></label>
                          	<input class="form-control mb-2 mr-sm-2" type="password" id="pwdCheck" value="">
                            <label class="mr-sm-2" for="inputName">이름<span class="text-danger small">*</span></label>
                            <input class="form-control mb-2 mr-sm-2" type="text" id="userName" name="userName" value="${userinfo.userName}" >
                            <label class="mr-sm-2" for="inputEmail">이메일<span class="text-danger small">*</span></label>
                            <input class="form-control mb-2 mr-sm-2" type="email" id="userEmail" name="userEmail" value="${userinfo.userEmail}" >
                            <label class="mr-sm-2" for="phoneNumber" >전화번호<span class="text-danger small">*</span></label>
                            <input class="form-control mb-2 mr-sm-2" type="tel" id="userPhoneNumber" name="userPhoneNumber" value="${userinfo.userPhoneNumber}" >
                          	<button type="submit" id="updateBtn" class="btn btn-info mb-2">수정</button>
                          	<button type="button" id="deleteBtn" class="btn btn-danger mb-2">탈퇴</button>
	                    </div>

                    </div>
                </div>
            </div>
        </section>
        <!-- Footer-->
        <div style="background-color: #fafafa; padding:50px">
            <div class="container">
              <div class="footer-inner">
                <div class="row">
                 <div class="col-md-1">
                    <div class="footer-content">
                      <img alt="" src="assets/img/ssafylogo.png"  width="50">
                    </div>
                  </div>
                  <div class="col-md-8">
                    <div class="footer-content">
                      <h2 class="title">Find Us</h2>
                      <div class="line"></div>
                      <ul class="list-icons">
                        <li><i class="fa fa-map-marker pr-2 text-default"></i>(SSAFY) 서울시 강남구  테헤란로 멀티스퀘어</li>
                        <li><i class="fa fa-phone pr-2 text-default"></i> 1544-9001</li>
                        <li><i class="material-icons">&#xe0be;</i>admin@ssafy.com</li>
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
            </div>
        </div>
        <footer class="py-5 bg-black">
            <div class="container px-5"><p class="m-0 text-center text-white small">Copyright &copy; SSAFY.All rights reserved.</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>
