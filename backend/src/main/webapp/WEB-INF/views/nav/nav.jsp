<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}" />
<c:if test="${cookie.ssafy_id.value ne null}">
<c:set var="idck" value=" checked"/>
<c:set var="saveid" value="${cookie.ssafy_id.value}"/>
</c:if>

 <script type="text/javascript">
     $(document).ready(function () {
    	 $('#logoutBtn').click(function(){
    		$.ajax({
    			url:'${root}/member/logout',
    			type:'GET',
    			sucess: function(response){
    			},
    			error: function(err){
    				console.log(err);
    			},
    			statusCode : {
              		200 : function(){
              			location.href="/";
              		},
              	},
    		}); 
    	 });
    	 
         $("#loginBtn").click(function () {
             if (!$("#id").val()) {
                 alert("아이디 입력!!!");
                 return;
             } else if (!$("#pwd").val()) {
                 alert("비밀번호 입력!!!");
                 return;
             } else {
            	 $.ajax({
                	url: '${root}/member/login',
                  	type: 'POST',
                  	dataType: 'json',
                  	data:{
                  		userId:$("#id").val(),
                  		userPwd:$("#pwd").val(),
                  	},
                  	success: function (response) {
                  	},
                  	error: function(err){
                  		alert("로그인 실패");
                  	},
                  	statusCode : {
                  		200 : function(){
                  			alert("로그인 되었습니다.");
                  			location.href="/";
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
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
    <div class="container px-5">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ms-auto">
            	<c:choose>
	            	<c:when test="${!empty userinfo}">
		            	<li>
		                     <button type="submit" id="logoutBtn" class="btn btn-secondary" data-toggle="modal" data-target="#myModal">
		                        	Logout
		                     </button>
		                </li>
		                <li>
		                	<form action="/member/userinfo" method="get">
		                		<input type="hidden" name="id" value="${userinfo.userId}">
		                		<input type="hidden" name="pwd" value="${userinfo.userPwd}">
		                     <input type="hidden" name="act" value="mvuserinfo">
		                     <button type="submit" class="btn btn-secondary" data-toggle="modal" data-target="#myModal">
		                         회원정보
		                     </button>
		                    </form>
		                </li>
	                </c:when>
	                <c:otherwise>
		                <li class="nav-item">
		                    <button type="button" id="signupBtn" class="btn btn-secondary" data-toggle="modal" data-target="#myModal">
		                        <a href="/member/signup" style="text-decoration:none; color:white">Sign Up</a>
		                    </button>
		                </li>
		                <li class="nav-item">
	                    <div class="dropdown">
	                        <button type="button" class="btn btn-secondary header-top-drop-2" data-toggle="dropdown">
	                          Log In
	                        </button>
	                        <div class="dropdown-menu dropdown-menu dropdown-menu-right dropdown-animation logindropdown">
	                            <div id="loginform" class=" form-inline" style="margin:25px; margin-top:30px; margin-bottom:20px;">
	                            	<input type="hidden" name="act" value="login">
	                                <label for="id" class="mr-sm-2" style="color:white">아이디</label>
	                                <input type="text" class="form-control mb-2 mr-sm-2 logindrop" placeholder="" id="id" name="userId">
	                                <label for="pwd" class="mr-sm-2" style="color:white">비밀번호</label>
	                                <input type="password" class="form-control mb-2 mr-sm-2 logindrop" placeholder="" id="pwd" name="userPwd">
	                                
	                                <button type="submit" id="loginBtn" class="btn btn-light mb-2" >로그인</button> 
	                                <label class="form-check-label" style="color:white">
					                     <input class="form-check-input" type="checkbox" id="idsave" name="idsave" value="saveok"${idck}> 아이디저장
					                </label>
	                                <button type="submit" class="btn btn-dark mb-2" style="display: block;">비밀번호 찾기</button>
	                            </div>
	                        </div>
	                      </div>
		                </li>
                	</c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
<!-- A grey horizontal navbar that becomes vertical on small screens -->
<nav class="navbar bg-light sticky-top"> <!--fixed-top--> 
    <a class="navbar-brand"href="/"><img src="${root }/img/logo.jpg" style="width:80px; height:60px; margin-left:130px; float:left"></a>

    <ul class="nav justify-content-end" style="margin-right:130px;">
        <li class="nav-item">
          <a class="nav-link" href="#">공지사항</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">오늘의 뉴스</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">주변 탐방</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">관심 지역 설정</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">관심지역 둘러보기</a>
        </li>
        <li>
            <a class="fas fa-search"></a>
        </li>
      </ul>
</nav>
        
                        