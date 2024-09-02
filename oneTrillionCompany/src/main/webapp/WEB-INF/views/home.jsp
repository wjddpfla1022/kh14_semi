<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- Swiper cdn-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<script
	src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

<!-- jquery cdn -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- 자바스크립트 작성 영역 -->

<style>
.btn.btn-more {
	background-color: rgb(196, 227, 255);
	font-size: 16px;
	padding: 1.5em;
	padding-left: 3em;
	padding-right: 3em;
	padding-bottom: 2.5em;
	margin-bottom: 3px;
	border: none;
}

.image-align {
	display: flex;
	flex-wrap: wrap;
	gap: 50px;
}

.image-align>a {
	text-decoration: none;
	color: black;
}

a>h4 {
	margin: 0.3em;
}

body {
	height: 2000px;
}

.sideBann {
	position: absolute;
}

   .sidebar-toggle {
        top: 330px !important;
        left: 10px !important;
        box-shadow: 0 0 0px 0px #2d3436 !important;
      }
         #ck-sidebar + .sidebar {
        background-color: white !important;
   
      }
</style>

<script type="text/javascript">
	$(function() {
		// 기본 위치(top)값
		var floatPosition = parseInt($(".sideBann").css('top'));

		// scroll 인식
		$(window).scroll(function() {

			// 현재 스크롤 위치
			var currentTop = $(window).scrollTop();
			var bannerTop = currentTop + floatPosition + "px";

			//이동 애니메이션
			$(".sideBann").stop().animate({
				"top" : bannerTop
			}, 0);

		});

		// var swiper = new Swiper(선택자, 옵션객체);
		var swiper = new Swiper('.swiper', {

			// Optional parameters
			direction : 'horizontal',
			loop : true, // 슬라이드 종료지점과 시작지점을 연결 할 것인가
			autoplay : true,
			autoplay : {
				delay : 2000,
				disableOnInteraction : true, // 사용자가 제어중일 경우 자동재생 해제
				pauseOnMouseEnter : true,
			},

			// If we need pagination
			//                 pagination: {
			//                     el: '.swiper-pagination', // 적용대상
			//                     clickable:true, //클릭하여 이동 가능
			//                     type:'progressbar',
			//                 },

			// Navigation arrows
			navigation : {
				nextEl : '.swiper-button-next',
				prevEl : '.swiper-button-prev',
				hideOnClick : true,
			},

		// And if we need scrollbar
		// scrollbar: {
		//     el: '.swiper-scrollbar',
		//     enable: false,
		// },
		});
	});
</script>
</head>
<body>

<!-- 보는 시점에 사이드바 배치 -->
	<div class="sideBann">
	<!--사이드바 배치-->
	<label for="ck-sidebar" class="sidebar-toggle"> 
	<i class="fa-solid fa-angle-right fa-2x"></i>
	</label>
	<input type="checkbox" id="ck-sidebar">
	
	<div class="sidebar">
		<div class="row mt-50">
		<img src="http://via.placeholder.com/250.png" width="100%">
		</div>
	
		<div class="row center">
			<b style="box-shadow: 0 0 1px 0;">ONE 공지</b><b style="box-shadow: 0 0 1px 0">ONE 공지</b><br>
			<b style="box-shadow: 0 0 1px 0">ONE 공지</b><b style="box-shadow: 0 0 1px 0">ONE 공지</b>
		</div><hr>
		
		<div class="row">
		<span style="font-weight:bolder; font-size: 12px">무통장 안내</span><br><br>
		<span style="font-weight:bolder; font-size: 12px">국민은행 <b style="font-size: 11px; color: #999;">000000-00-000000</b></span><br>
		<span style="font-weight:bolder; font-size: 12px">예금주 <b style="font-size: 11px; color: #999;">주식회사 패션홀릭</b></span><br><br>
		<span class="field field-underline" style="font-size: 11px; color: #999;">* 입금 시 입금자명과 금액을</span><br>
		<span class="field field-underline" style="font-size: 11px; color: #999;">꼭 확인해주세요.</span><br>
		<span style="font-size: 11px; color: #999;">무통장 입금 자동확인까지</span><br>
		<span style="font-size: 11px; color: #999;">30분 정도 소요 됩니다.</span><br>
		</div><br><br><hr>
	
	<div class="row">
		<span>고객센터</span>
	</div>
	<div class="row">
		<span style="font-weight: bolder;">010-1234-5678</span>
	</div>
	<div class="row">
		<span style="font-size: 11px">월요일 - 금요일 09:30 - 18:30</span><br>
		<span style="font-size: 11px">점심시간 11:30 - 12:30</span>
	</div> 
	
	</div>
</div>

	<div class="container w-600 my-50">
		<div class="row center">
			<h1 class="mt-30 mb-50">이달의 상품</h1>
		</div>
		<div class="row center">
			<!-- Slider main container -->
			<div class="swiper">
				<!-- Additional required wrapper -->
				<div class="swiper-wrapper">
					<!-- Slides -->
					<div class="swiper-slide">
						<a href="#"><img src="http://via.placeholder.com/300.png"></a>
					</div>
					<div class="swiper-slide">
						<a href="#"><img src="http://via.placeholder.com/300.png"></a>
					</div>
					<div class="swiper-slide">
						<a href="#"><img src="http://via.placeholder.com/300.png"></a>
					</div>
					<div class="swiper-slide">
						<a href="#"><img src="http://via.placeholder.com/300.png"></a>
					</div>
					<div class="swiper-slide">
						<a href="#"><img src="http://via.placeholder.com/300.png"></a>
					</div>
					<div class="swiper-slide">
						<a href="#"><img src="http://via.placeholder.com/300.png"></a>
					</div>
					<div class="swiper-slide">
						<a href="#"><img src="http://via.placeholder.com/300.png"></a>
					</div>
				</div>
				<!-- If we need pagination -->
				<div class="swiper-pagination"></div>

				<!-- If we need navigation buttons -->
				<div class="swiper-button-prev"></div>
				<div class="swiper-button-next"></div>


				<!-- If we need scrollbar -->
				<!-- <div class="swiper-scrollbar""></div> -->
			</div>
		</div>
	</div>
	<div class="container w-700">

		<div class="row center">
			<h2>Best Item</h2>
		</div>
		<div class="row image-align">
			<a href="#"><img src="http://via.placeholder.com/200.png">
			<h4>BestItem</h4>
				</h4></a> <a href="#"><img src="http://via.placeholder.com/200.png">
			<h4>BestItem</h4></a> <a href="#"><img
				src="http://via.placeholder.com/200.png">
			<h4>BestItem</h4></a> <a href="#"><img
				src="http://via.placeholder.com/200.png">
			<h4>BestItem</h4></a> <a href="#"><img
				src="http://via.placeholder.com/200.png">
			<h4>BestItem</h4></a> <a href="#"><img
				src="http://via.placeholder.com/200.png">
			<h4>BestItem</h4></a> <a href="#"><img
				src="http://via.placeholder.com/200.png">
			<h4>BestItem</h4></a> <a href="#"><img
				src="http://via.placeholder.com/200.png">
			<h4>BestItem</h4></a> <a href="#"><img
				src="http://via.placeholder.com/200.png">
			<h4>BestItem</h4></a>
		</div>
	</div>
	</div>
	</div>
	<div class="container w-700">
		<div class="row" style="height: 120px;"></div>
		<div class="row center">
			<h2>상의 Best</h2>
		</div>
		<div class="row image-align">
			<a href="#"><img src="http://via.placeholder.com/200.png">
			<h4>상의</h4></a> <a href="#"><img
				src="http://via.placeholder.com/200.png">
			<h4>상의</h4></a> <a href="#"><img
				src="http://via.placeholder.com/200.png">
			<h4>상의</h4></a> <a href="#"><img
				src="http://via.placeholder.com/200.png">
			<h4>상의</h4></a> <a href="#"><img
				src="http://via.placeholder.com/200.png">
			<h4>상의</h4></a> <a href="#"><img
				src="http://via.placeholder.com/200.png">
			<h4>상의</h4></a> <a href="#"><img
				src="http://via.placeholder.com/200.png">
			<h4>상의</h4></a> <a href="#"><img
				src="http://via.placeholder.com/200.png">
			<h4>상의</h4></a> <a href="#"><img
				src="http://via.placeholder.com/200.png">
			<h4>상의</h4></a>
		</div>
	</div>
</body>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>