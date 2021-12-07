<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Happy House</title>
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"
	crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<!-- Google fonts-->
<link
	href="https://fonts.googleapis.com/css?family=Catamaran:100,200,300,400,500,600,700,800,900"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900,900i"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<!-- Latest compiled and minified CSS 
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        -->
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Popper JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>

<body id="page-top">
	<!-- Navigation-->
	<%@include file="nav/nav.jsp"%>
	
	<!-- Header-->
	<header class="masthead text-center text-white">
		<div class="masthead-content">
			<div class="container px-5">
				<h1 class="masthead-heading mb-0">HAPPY HOUSE</h1>
				<p class="masthead-subheading mb-0" style="font-size: 30px;">행복한
					우리 집</p>
				<a class="btn btn-primary btn-xl rounded-pill mt-5" href="#scroll">Learn
					More</a>
			</div>
		</div>
	</header>

	<%-- 카카오 지도 표시 ---%>
	<div class="container">
		<section id="index_section">
			<div class="card col-sm-12 mt-1" style="min-height: 850px;">
				<div class="card-body">
					시도 : <select id="sido">
						<option value="0">선택</option>
					</select> 구군 : <select id="gugun">
						<option value="0">선택</option>
					</select> 읍면동 : <select id="dong">
						<option value="0">선택</option>
					</select>
					<button type="button" id="aptSearchBtn">검색</button>
					<table class="table mt-2">
						<colgroup>
							<col width="100">
							<col width="150">
							<col width="*">
							<col width="120">
							<col width="120">
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>아파트이름</th>
								<th class="text-center">주소</th>
								<th>건축연도</th>
								<th>최근거래금액</th>
							</tr>
						</thead>
						<tbody id="searchResult"></tbody>
					</table>
					<div id="map" style="width: 100%; height: 500px;"></div>
					<script type="text/javascript"
						src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0661d5cb63dfe8f8d72c1705f1251ae4&libraries=services"></script>
					<script type="text/javascript" src="js/map.js"></script>
					<script type="text/javascript">
				let colorArr = ['table-primary','table-success','table-danger'];
				$(document).ready(function(){					
					$.get(root + "/map/sido"
						,function(data, status){
							$.each(data, function(index, vo) {
								$("#sido").append("<option value='"+vo.sidoCode+"'>"+vo.sidoName+"</option>");
							});
						}
						, "json"
					);
				});
				$(document).on("change", "#sido", function() {
					$.get(root + "/map/gugun"
							,{sido: $("#sido").val()}
							,function(data, status){
								$("#gugun").empty();
								$("#gugun").append('<option value="0">선택</option>');
								$.each(data, function(index, vo) {
									$("#gugun").append("<option value='"+vo.gugunCode+"'>"+vo.gugunName+"</option>");
								});
							}
							, "json"
					);
				});
				$(document).on("change", "#gugun", function() {
					$.get(root + "/map/dong"
							,{gugun: $("#gugun").val()}
							,function(data, status){
								$("#dong").empty();
								$("#dong").append('<option value="0">선택</option>');
								//console.log(data);
								$.each(data, function(index, vo) {
									$("#dong").append("<option value='"+vo.dongCode+"'>"+vo.dongName+"</option>");
								});
							}
							, "json"
					);
				});
				$(document).on("change", "#dong", function() {
					$.get(root + "/map/apt"
							,{dong: $("#dong").val()}
							,function(data, status){
								$("tbody").empty();
								$.each(data, function(index, vo) {
									console.log(vo);
									let str = `
										<tr class="${'${colorArr[index%3]}'}">
											<td>${'${vo.aptCode}'}</td>
											<td>${'${vo.aptName}'}</td>
											<td>${'${vo.sidoName}'} ${'${vo.gugunName}'} ${'${vo.dongName}'} ${'${vo.jibun}'}</td>
											<td>${'${vo.buildYear}'}</td>
											<td>${'${vo.recentPrice}'}</td>
										</tr>
									`;
									console.log(str)
									$("tbody").append(str);
								});
								displayMarkers(data);
							}
							, "json"
					);
				});
				
				$(document).on("click", "#aptSearchBtn", function() {
					var param = {
							serviceKey:'dEkZqV1iRJ8XPvE6UI+CxbukUJbknDXd9kiWC/UY5Ce+JKR8W9iluMhkxfliniLdwHV57cjzblOSFtURYCNLeQ==',
							pageNo:encodeURIComponent('1'),
							numOfRows:encodeURIComponent('10'),
							LAWD_CD:encodeURIComponent($("#gugun").val()),	// 구군코드
							DEAL_YMD:encodeURIComponent('202110')	// 판매 연월. 2021.10월에 판매된 데이터 정보
					};
					$.get('http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev'
							,param
							,function(data, status){
								$("tbody").empty();
							
								//console.log(data);	// xml로 리턴
								var items = $(data).find('item');	// item을 모아 놓은 배열
								var jsonArray = new Array();	// xml을 json 배열로 바꿔야 한다.
								items.each(function() {
									var jsonObj	= new Object();
									jsonObj.aptCode = $(this).find('일련번호').text();
									jsonObj.aptName = $(this).find('아파트').text();
									jsonObj.sigunguCode = $(this).find('법정동시군구코드').text();
									jsonObj.dongCode = $(this).find('법정동읍면동코드').text();
									jsonObj.dongName = $(this).find('법정동').text();	// 서버로 가서 법정동코드+시도코드로 시,군,동 이름 얻어온다
									jsonObj.buildYear = $(this).find('건축년도').text();
									jsonObj.jibun = $(this).find('지번').text();
									jsonObj.recentPrice = $(this).find('거래금액').text();
									
									var dongcode = $(this).find('법정동시군구코드').text()+$(this).find('법정동읍면동코드').text();
									//console.log(dongcode);
									
									$.get(root + "/map/sidogugun"
											,{sigungudongCode: dongcode}
											,function(data, status){
												//console.log(data);
												
												$.each(data, function(index, vo) {
													jsonObj.sidoName = vo.sidoName;
													jsonObj.gugunName = vo.gugunName;
													
													console.log(jsonObj);
													let str = `
														<tr class="${'${colorArr[index%3]}'}">
															<td>${'${jsonObj.aptCode}'}</td>
															<td>${'${jsonObj.aptName}'}</td>
															<td>${'${jsonObj.sidoName}'} ${'${jsonObj.gugunName}'} ${'${jsonObj.dongName}'} ${'${jsonObj.jibun}'}</td>
															<td>${'${jsonObj.buildYear}'}</td>
															<td>${'${jsonObj.recentPrice}'}</td>
														</tr>
													`;
													console.log(str)
													$("tbody").append(str);
												});
												
												
												jsonObj = JSON.stringify(jsonObj);
												//String 형태로 파싱한 객체를 다시 json으로 변환
												jsonArray.push(JSON.parse(jsonObj));
												
												//console.log(jsonArray);
												displayAPIMarkers(jsonArray);
											}
											, "json"
									);
									
								});
							}
							, "xml"
					);
					/* var xhr = new XMLHttpRequest();
					var url = 'http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev';
					var queryParams = '?' + encodeURIComponent('serviceKey') + '='+encodeURIComponent(' API KEY ');
					queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); 
					queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('10'); 
					queryParams += '&' + encodeURIComponent('LAWD_CD') + '=' + encodeURIComponent($("#gugun").val()); 
					queryParams += '&' + encodeURIComponent('DEAL_YMD') + '=' + encodeURIComponent('202110'); 
					xhr.open('GET', url + queryParams);
					xhr.onreadystatechange = function () {
					    if (this.readyState == 4) {
					    	console.log(this.responseXML);
					        alert('Status: '+this.status+'nHeaders: '+JSON.stringify(this.getAllResponseHeaders())+'nBody: '+this.responseText);
					    }
					};

					xhr.send(''); */
				});
				</script>
				</div>
			</div>
		</section>
		<%------------------- --%>
	</div>

	<section>
		<div class="container px-5" style="margin-top: 30px;"></div>
	</section>

	<hr>
	<!-- Content section 2-->
	<section>
		<div class="container px-5" style="margin-top: 30px;">
			<div class="row gx-5 align-items-center">
				<div class="col-lg-4">
					<img src="${root}/img/sideAD.jpg">
				</div>
				<div class="col-lg-4">
					<h3>지혜롭게 내집 마련하기</h3>
					<div class="line"></div>
					<ul class="se2">
						<li>가용자금 확인 및 대출 계획</li>
						<li>집 종류 및 지역 선택</li>
						<li>정보 수집 & 시세파악</li>
						<li>부동산 방문 & 집구경</li>
						<li>계약 및 잔금 치르기</li>
						<li>소유권 이전 등기</li>
						<li>인테리어 공사</li>
					</ul>
					<div class="line"></div>
				</div>
				<div class="col-lg-4">
					<h3>오늘의 뉴스</h3>
					<div class="line"></div>
					<h5>서울 아파트, 매매/전세 다른 양상...상승...아시아 경제</h5>
					<ul class="se3">
						<li><a class="text-primary">서울 입주 2년차 아파트 전셋값 1억400만원 올라</a>
							한겨레</li>
						<li><a class="text-primary">12.16 거래한파...매수자가 사라졌다</a> 아시아 경제</li>
						<li><a class="text-primary">재건축 대안 뜨는 수직중축 리모델링... 추진
								속...</a> 동아일보</li>
						<li><a class="text-primary">고가기준 9억, 서울 아파트 중간값 됐다</a> 동아일보</li>
					</ul>
				</div>
			</div>
		</div>
	</section>
	<!-- Footer-->
	<div style="background-color: #fafafa; padding: 50px">
		<div class="container">
			<div class="footer-inner">
				<div class="row">
					<div class="col-md-1">
						<div class="footer-content">
							<img alt="" src="${root}/img/ssafylogo.png" width="50">
						</div>
					</div>
					<div class="col-md-8">
						<div class="footer-content">
							<h2 class="title">Find Us</h2>
							<div class="line"></div>
							<ul class="list-icons">
								<li><i class="fa fa-map-marker pr-2 text-default"></i>(SSAFY)
									서울시 강남구 테헤란로 멀티스퀘어</li>
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
		<div class="container px-5">
			<p class="m-0 text-center text-white small">Copyright &copy;
				SSAFY.All rights reserved.</p>
		</div>
	</footer>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
</body>
</html>