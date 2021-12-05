<template>
	<!-- Footer-->
	<footer style="background-color: #fafafa; padding-top:30px;">
		<div class="container" style="margin-top:20px;">
			<div class="footer-inner">
				<div class="row">
					<div class="col-md-2">
						<div class="footer-content">
							<img alt="" src="@/assets/ssafylogo.png" width="60">
						</div>
					</div>
					<div class="col-md-8">
						<div class="footer-content">
							<h2 class="title" style="text-align:left">Find Us</h2>
							<div class="line"></div>
							<div>
								<b-icon icon="people" scale="1"></b-icon>
								6기 구미 5반 김시은, 이인섭
							</div>
							<div>
								<b-icon icon="building" scale="1"></b-icon>
								(SSAFY)서울시 강남구 테헤란로 멀티스퀘어
							</div>
							<div>
								<b-icon icon="envelope" scale="1"></b-icon>
								admin@ssafy.com
							</div>
						</div>
					</div>
					<div class="col-md-2"></div>
				</div>
			</div>
		</div>
		<div class="py-5 bg-black">
			<div class="container px-5">
				<p class="text-center small">Copyright &copy;
					SSAFY.All rights reserved.</p>
			</div>
		</div>
	</footer>
</template>

<style scoped>
footer{
	width:100%;
	bottom:0px;
	border-top:1px solid rgb(224, 224, 224);
}
.line{
	border:1px solid rgb(224, 224, 224);
}
.footer-content > div{
	margin-top:8px;
	 text-align:left;
}
</style>