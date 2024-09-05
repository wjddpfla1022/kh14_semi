<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>oneTrillion</title>

<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
<script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>
<!-- 내가 만든 스타일 시트를 불러오는 코드 -->
<link rel="stylesheet" type="text/css" href="/css/commons.css">
<!-- <link rel="stylesheet" type="text/css" href="/css/test.css"> -->
<!-- font awesome-->
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

</head>
<style>
/*카테고리 메뉴 디자인*/
.menu {
	background-color: white;
	font-size: 16px;
    width: 100%;
    box-shadow: 0 0 1px 0 rgb(53, 53, 53);
}

.menu :hover {
	filter: brightness(100%);

}

.menu ul {
	background-color: white;
}

.menu ul :hover {
	background-color: #dfe6e9;
}

.menu ul>li{
background-color: white;
}

.menu>li>ul ul {
	background-color: white;
}

.top-menu {
	background-color: white;
	font-size: 12px;
}

.top-menu :hover {
	background-color: #dfe6e9;;
}

.all-menu-ul {
	list-style-type: none;
	/* 기본 리스트 스타일 제거 */
	margin: 0;
	/* 기본 마진 제거 */
	padding: 0;
	/* 기본 패딩 제거 */
	display: flex;
	/* flexbox를 사용하여 가로 배치 */
	font-size: 12px;
}
/*글씨굵기*/
#favorite{
	font-weight:bolder;
}

session 수
.hide{
	color: white;
}


/* .ul-horizon{

        }
        .li-horizon{
            display: inline-block;
            margin-right: 20px;
        }  */
        .modal{
            position: absolute;
            display: none;

            justify-content: center;
            top: 0;
            left: 0;

            width: 100%;
            height: 200%;

            background-color: rgba(0, 0, 0, 0.4);
            
            z-index : 9999;
        }

        .modal-body{
            position: absolute;
            top: 15%;

            width: 360px;
            height: 200px;

            padding: 20px;

            text-align: center;

            background-color: #ecf0f1;
            border-radius: 10px;
            box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);

            transform: translateY(-50%);

        }
        .btn-close-modal {
        	font-size: 12px;
        	padding: 0.3em 0.5em;
        }

    </style>
<link rel="stylesheet" type="text/css" href="/js/checkbox.js">
<!-- jquery cdn -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js">
	
</script>
<script>
	$(document).ready(
			function() {

				$('#favorite').on(
						'click',
						function(e) {

							var bookmarkURL = window.location.href;

							var bookmarkTitle = document.title;

							var triggerDefault = false;

							alert((navigator.userAgent.toLowerCase().indexOf(
									'mac') != -1 ? 'Cmd' : 'Ctrl')
									+ '+D 키를 눌러 즐겨찾기에 등록하실 수 있습니다.');
							return triggerDefault;
						});
       });
		//버튼 표시 제어
	   $(".btn-toggle").click(function(){
           $(".target").slideToggle();
	});
	
</script>

<body>
	<!-- 문서의 출력 내용을 담는 태그 -->
	<!-- 		<h1>내가 만든 홈페이지</h1> -->
	<!-- 		<a href=""></a> -->
	<!-- 상단(Header) -->
	<div class="container w-1200">
		<c:if test="${sessionScope.createdLevel == null}">
			<div class="row">
				<ul class="menu top-menu">
					<!-- 구분선 -->
				<!--	<li><a style="font-weight: bold;" href="#">고객센터</a></li> -->
					<li><a style="font-weight: bold;" href="localhost:8080" id="favorite"><i class="fa-solid fa-bookmark"></i>즐겨찾기</a></li>
					<li class="right-menu"><a href="/member/login" style="font-weight:bolder;">로그인</a></li>
					<li><a style="font-weight: bold;" href="/member/join" style="font-weight:bolder;">회원가입</a></li>
					<li><a style="font-weight: bold;" href="/qna/list">1:1문의</a></li>
					<!-- <li><a style="font-weight: bold;" href="#">커뮤니티</a> -->
						<ul>
							<li><a href="#">항목1</a></li>
						</ul></li>
					<li><a href="/member/login"><i class="fa-solid fa-cart-shopping"></i></a>
						<!-- 장바구니 --></li>
				</ul>
			</div>
			</c:if>

				<!-- 구분선 -->

			<c:if test="${sessionScope.createdLevel == '일반회원'}">
				<div class="row">
					<ul class="menu top-menu">
						<!-- 구분선 -->
	
						<li><a href="localhost:8080" id="favorite">즐겨찾기</a></li>
						<li class="right-menu"><a style="font-weight: bold;" href="/member/logout">로그아웃</a></li>
						<li><a style="font-weight: bold;" href="/order/list">주문 / 배송조회</a></li>
						<li><a style="font-weight: bold;" href="/qna/list">1:1문의</a></li>
						<li><a style="font-weight: bold;" href="/review/list">상품후기</a></li>

								<!-- 마이페이지 -->
							<li>
								<a href="/member/mypage"><i class="fa-solid fa-user"></i></a>
							</li>
							<!-- 장바구니 -->
							<li>
								<a href="/cart/list"><i class="fa-solid fa-cart-shopping"></i></a>
							</li>
							<!-- 장바구니 -->
					</ul>
				</div>
			</c:if>
			<c:if test="${sessionScope.createdLevel == '우수회원'}">
				<div class="row">
					<ul class="menu top-menu">
						<!-- 구분선 -->
						<li><a style="font-weight: bold;" href="localhost:8080" id="favorite">즐겨찾기</a></li>
						<li class="right-menu"><a style="font-weight: bold;" href="/member/logout">로그아웃</a></li>
						<li><a style="font-weight: bold;" href="#">주문 / 배송조회</a></li>
						<li><a style="font-weight: bold;" href="/qna/list">1:1문의</a></li>
						<li><a style="font-weight: bold;" href="/review/list">상품후기</a></li>
							<!-- 마이페이지 -->
							<li>
								<a href="/member/mypage"><i class="fa-solid fa-user"></i></a>
							</li>
							<!-- 장바구니 -->
							<li>
								<a href="/cart/list"><i class="fa-solid fa-cart-shopping"></i></a>
							</li>
					</ul>
				</div>
			</c:if>
			
			<!-- 구분선 -->
			
			<c:if test="${sessionScope.createdLevel == '관리자'}">
				<div class="row">
					<ul class="menu top-menu">
						<!-- 구분선 -->
						<li><a style="font-weight: bold;" href="localhost:8080" id="favorite">즐겨찾기</a></li>
						<li class="right-menu"><a href="/member/logout">로그아웃</a></li>
					<!--<li><a style="font-weight: bold;" href="#">주문 / 배송조회</a></li>  -->	
						<li><a style="font-weight: bold;" href="/review/list">상품후기</a></li>
						<li><a href="/member/mypage"><i class="fa-solid fa-user"></i></a></li>
						<li><a style="font-weight: bold;" href="#">관리자 메뉴</a>
								<ul>
									<li><a href="/manager/member/list">회원 검색</a></li>
									<li><a href="/qna/list">1:1문의</a></li>	
									<li><a href="/manager/item/list">상품 조회</a></li>
								</ul>
						</li>
					</ul>
				</div>
			</c:if>
			
					<!-- 구분선 -->
			<div class="row center">
				<a href="/"> <img src='https://ifh.cc/g/SbA93J.png' width="300px" height="100px">
				</a>
			</div>

			<!-- 
			메뉴(Navbar) 
			- (중요) 템플릿 페이지의 모든 경호는 전부 다 절대경로로 사용
			- 로그인 상태일 때와 비로그인 상태일 때 다르게 표시
			- 로그인 상태 : sessionScope.createdUser != null
			
			-->


		
			<ul class="menu">
				<!-- 구분선 -->
				<li class="flex-core all-menu" style="font-weight: bold;"><a href="/item/list"><i class="fa-solid fa-bars"></i> 
					&nbsp;전체상품</a></li>
				<li><a href="/item/list/cate?column=1&keyword=11" style="font-weight: bold;">상의</a>
					<ul>
						<li><a href="/item/list/cate?column=2&keyword=10">티셔츠</a>
							<ul>
								<li><a href="/item/list/cate?column=3&keyword=10">7부</a></li>
								<li><a href="/item/list/cate?column=3&keyword=11">민소매</a></li>
								<li><a href="/item/list/cate?column=3&keyword=12">긴팔</a></li>
								<li><a href="/item/list/cate?column=3&keyword=13">반팔</a></li>
								<li><a href="/item/list/cate?column=3&keyword=14">맨투맨</a></li>
								<li><a href="/item/list/cate?column=3&keyword=15">후드</a></li>
								<li><a href="/item/list/cate?column=3&keyword=16">니트/스웨터</a></li>
							</ul>
						</li>
						<li><a href="/item/list/cate?column=2&keyword=11">셔츠</a>
							<ul>
								<li><a href="/item/list/cate?column=3&keyword=17">반팔 셔츠</a></li>
								<li><a href="/item/list/cate?column=3&keyword=18">7부 셔츠</a></li>
								<li><a href="/item/list/cate?column=3&keyword=19">긴팔 셔츠</a></li>
								<li><a href="/item/list/cate?column=3&keyword=20">베이직/심플</a></li>
								<li><a href="/item/list/cate?column=3&keyword=21">스트라이프</a></li>
								<li><a href="/item/list/cate?column=3&keyword=22">체크</a></li>
							</ul>
						</li>
					</ul>
				</li>
				<!-- 구분선 -->
				<li><a href="/item/list/cate?column=1&keyword=33" style="font-weight: bold;">하의</a>
					<ul>
						<li><a href="/item/list/cate?column=2&keyword=30">슬랙스</a>
							<ul>
								<li><a href="/item/list/cate?column=3&keyword=30">스트레이트핏</a></li>
								<li><a href="/item/list/cate?column=3&keyword=31">테이퍼드핏</a></li>
								<li><a href="/item/list/cate?column=3&keyword=32">와이드핏</a></li>
							</ul>
						</li>
						<li><a href="/item/list/cate?column=2&keyword=31">데님</a>
							<ul>
								<li><a href="/item/list/cate?column=3&keyword=35">스트레이트핏</a></li>
								<li><a href="/item/list/cate?column=3&keyword=36">테이퍼드핏</a></li>
								<li><a href="/item/list/cate?column=3&keyword=37">와이드핏</a></li>
							</ul>
						</li>
						<li><a href="/item/list/cate?column=2&keyword=32">트레이닝</a>
							<ul>
								<li><a href="/item/list/cate?column=3&keyword=38">트레이닝</a></li>
								<li><a href="/item/list/cate?column=3&keyword=39">조거팬츠</a></li>
							</ul>
						</li>
						<li><a href="/item/list/cate?column=2&keyword=33">반바지</a>
							<ul>
								<li><a href="/item/list/cate?column=3&keyword=33">일반 반바지</a></li>
								<li><a href="/item/list/cate?column=3&keyword=34">데님 반바지</a></li>
							</ul>
						</li>
					</ul>
				</li>
				<!-- 구분선 -->
				<li><a href="/item/list/cate?column=1&keyword=55" style="font-weight: bold;">슈즈</a>
					<ul>
						<li><a href="/item/list/cate?column=2&keyword=50">스니커즈</a>
						<li><a href="/item/list/cate?column=2&keyword=51">로퍼/슬립온</a>
						<li><a href="/item/list/cate?column=2&keyword=52">구두</a>
						<li><a href="/item/list/cate?column=2&keyword=53">워커/부츠</a>
						<li><a href="/item/list/cate?column=2&keyword=54">샌들/슬리퍼</a>
						<li><a href="/item/list/cate?column=2&keyword=55">깔창/기타</a>
					</ul>
				</li>
				<li><a href="/item/list/cate?column=1&keyword=77" style="font-weight: bold;">아우터</a>
					<ul>
						<li><a href="/item/list/cate?column=2&keyword=70">가디건</a>
						<li><a href="/item/list/cate?column=2&keyword=71">블루종</a>
						<li><a href="/item/list/cate?column=2&keyword=72">집업</a>
						<li><a href="/item/list/cate?column=2&keyword=73">바람막이</a>
						<li><a href="/item/list/cate?column=2&keyword=74">블레이저</a>
						<li><a href="/item/list/cate?column=2&keyword=75">청재킷</a>
					</ul>
				</li>
				<!-- 구분선 -->
				<li class="right-menu">
        			<button class="btn btn-open-modal btn-positive"><i class="fa-solid fa-magnifying-glass"></i></button></li>
				
				<!-- 구분선 -->
			</ul>
			
	</div>
	 <div class="modal">
            <div class="modal-body">
                <div class="row right" style="margin-top : 5px;"><button class="btn btn-negative btn-close-modal"><i class="fa-solid fa-xmark"></i></button></div>
            	<h4 style="margin-bottom: 10px;">상품명 검색</h4>
	<form action="/item/list"  method="get">
                <input type="hidden" name="column" value="item_name">
                <input type="text" name="keyword" class="field">
                <button type="submit" class="btn btn-positive"><i class="fa-solid fa-magnifying-glass"></i></button>
	</form>
                
            </div>
        </div>
    <script>
        var modal = document.querySelector('.modal');
        var btnOpenModal=document.querySelector('.btn-open-modal');
        var btnCloseModal=document.querySelector('.btn-close-modal');
        var body = document.body;

        function preventScroll(event) {
            event.preventDefault();
            event.stopPropagation();
        }
        
        btnOpenModal.addEventListener("click", ()=>{
            modal.style.display="flex";
            swiper.style.visibility = "hidden";
            body.style.overflow = 'hidden';
            body.addEventListener('wheel', preventScroll, { passive: false });
        });
        btnCloseModal.addEventListener("click", ()=>{
        	modal.style.display="none";
        	body.style.overflow = '';
        	body.removeEventListener('wheel', preventScroll, { passive: false });
        });
    </script>
	<!-- 중단(Container) -->