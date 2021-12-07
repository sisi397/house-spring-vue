<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/memberHeader.jsp" %>
<script type="text/javascript">
        $(document).ready(function () {
        	var isId = false;
        	// 아이디 중복검사
        	$("#userId").keyup(function () {
        		var ckid = $("#userId").val();
        		if(ckid.length < 4 || ckid.length > 13) {
        			$("#idresult").text("아이디는 4자 이상 13자 이하입니다.").removeClass('text-primary').removeClass('text-danger').addClass('text-dark');
        			isId = false;
        		} else {
	                $.ajax({
	                	url: '${root}/member/idcheck/'+$("#userId").val(),
	                  	type: 'GET',
	                  	dataType: 'json',
	                  	success: function (response) {
	                  		console.log(response);
	                    	var cnt = parseInt(response);
	                    	if(cnt == 0) {
	                    		$("#idresult").text(ckid + "는 사용가능합니다.").removeClass('text-dark').removeClass('text-danger').addClass('text-primary');
	                    		isId = true;
	                    	} else {
	                    		$("#idresult").text(ckid + "는 사용할 수 없습니다.").removeClass('text-dark').removeClass('text-primary').addClass('text-danger');
	                    		isId = false;
	                    	}
	                  	}
					});
        		}
			});
        	
        	// 회원가입
            $("#registerBtn").click(function () {
                if (!$("#userName").val()) {
                    alert("이름 입력!!!");
                    return;
                } else if (!isId) {
                    alert("아이디 확인!!!");
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
	                  	type: 'POST',
	                  	dataType: 'json',
	                  	data: {
	                  		userId:$("#userId").val(),
	                  		userPwd:$("#userPwd").val(),
	                  		userName:$("#userName").val(),
	                  		userEmail:$("#userEmail").val(),
	                  		userPhoneNumber:$("#userPhoneNumber").val(),
	                  	},
	                  	success: function (response) {
	                  	},
	                  	error: function(err){
	                  	},
	                  	statusCode:{
	                  		200:function(){
	                  			alert("회원가입 성공");
	                  			location.href="/";
	                  		}
	                  	}
					});
                }
            });
        });
    </script>
    <body id="page-top">
        <!-- Navigation-->
        <%@include file="nav/nav.jsp" %> 
        <div>
            <p style="margin-left:130px; margin-top:10px;">Home > 회원가입</p>
        </div>
        <section>
            <div style="background-color: grey; height:800px;">
                <div class="input-form-background row">
                    <div class="input-form col-md-12 mx-auto"> <!--style="background-color: grey; height:500px;"-->
                        <h2>회원가입</h2>
                        <div class="form-inline was-validated" style="margin:50px;">
                        	<input type ="hidden" name ="act" value="register">
                            <label for="userid" class="mr-sm-2">아이디 <span class="text-danger small">*</span></label>
                            <input type="text" class="form-control mb-2 mr-sm-2" placeholder="4자 이상 13자 이하로 입력하세요." id="userId" name="userId">
                            <div id="idresult"></div>
                            <label for="userpwd" class="mr-sm-2">비밀번호 <span class="text-danger small">*</span></label>
                            <input type="password" class="form-control mb-2 mr-sm-2" id="userPwd" name="userPwd">
                            <label for="pwdCheck" class="mr-sm-2">비밀번호 확인 <span class="text-danger small">*</span></label>
                            <input type="password" class="form-control mb-2 mr-sm-2" id="pwdCheck">
                            <label for="username" class="mr-sm-2">이름 <span class="text-danger small">*</span></label>
                            <input type="text" class="form-control mb-2 mr-sm-2" placeholder="User Name" id="userName" name="userName">
                            <label for="useremail" class="mr-sm-2">이메일 <span class="text-danger small">*</span></label>
                            <input type="email" class="form-control mb-2 mr-sm-2" placeholder="email" id="userEmail" name="userEmail">
                            <label for="usertel" class="mr-sm-2">전화번호 <span class="text-danger small">*</span></label>
                            <input type="text" class="form-control mb-2 mr-sm-2" placeholder="010-xxxx-xxxx" id="userPhoneNumber" name="userPhoneNumber">
                            <button type="submit" id="registerBtn" class="btn btn-primary mb-2">등록</button>
                      
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
                      <img alt="" src="${root }/img/ssafylogo.png"  width="50">
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
        <script src="${root }/js/scripts.js"></script>
    </body>
</html>
