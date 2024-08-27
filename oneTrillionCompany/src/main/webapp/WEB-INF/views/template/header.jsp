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
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/locale/ko.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>
<!-- 내가 만든 스타일 시트를 불러오는 코드 -->
<link rel="stylesheet" type="text/css" href="/css/commons.css">
<!-- <link rel="stylesheet" type="text/css" href="/css/test.css"> -->
<!-- font awesome-->
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<style>
.menu {
	background-color: antiquewhite;
	font-size: 16px;
}

.menu :hover {
	filter: brightness(100%);
}

.menu ul {
	background-color: beige;
}

.menu ul :hover {
	background-color: antiquewhite;
}

.menu>li>ul ul {
	background-color: beige;
}
.menu>li>ul ul :hover {
	background-color: azure;
}

.top-menu {
	background-color: white;
	font-size: 12px;
}

.top-menu :hover {
	background-color: rgb(184, 184, 184);
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

/* .ul-horizon{

        }
        .li-horizon{
            display: inline-block;
            margin-right: 20px;
        }  */
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
</script>
</head>
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
					<li><a href="#">고객센터</a></li>
					<li><a href="localhost:8080" id="favorite">즐겨찾기</a></li>
					<li class="right-menu"><a href="/member/login">로그인</a></li>
					<li><a href="/member/join">회원가입</a></li>
					<li><a href="#">커뮤니티</a>
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
						<li><a href="#">고객센터</a></li>
						<li><a href="localhost:8080" id="favorite">즐겨찾기</a></li>
						<li class="right-menu"><a href="/member/logout">로그아웃</a></li>
						<li><a href="#">주문 / 배송조회</a></li>
						<li><a href="/qna/list">1:1문의</a></li>
						<li><a href="#">커뮤니티</a>
							<ul>
								<li><a href="#">항목1</a></li>
							</ul></li>
							
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
			<c:if test="${sessionScope.createdLevel == '우수회원'}">
				<div class="row">
					<ul class="menu top-menu">
						<!-- 구분선 -->
						<li><a href="#">고객센터</a></li>
						<li><a href="localhost:8080" id="favorite">즐겨찾기</a></li>
						<li class="right-menu"><a href="/member/logout">로그아웃</a></li>
						<li><a href="#">주문 / 배송조회</a></li>
						<li><a href="/qna/list">1:1문의</a></li>
						<li><a href="#">커뮤니티</a>
							<ul>
								<li><a href="#">항목1</a></li>
							</ul></li>
							<!-- 마이페이지 -->
							<li>
								<a href="/cart/list"><i class="fa-solid fa-user"></i></a>
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
						<li><a href="#">고객센터</a></li>
						<li><a href="localhost:8080" id="favorite">즐겨찾기</a></li>
						<li><a href="#">바로가기</a></li>
						<li class="right-menu"><a href="/member/logout">로그아웃</a></li>
						<li><a href="#">주문 / 배송조회</a></li>
						<li><a href="/manager/item/list">상품 조회</a></li>
						
							<li><a href="#">관리자 메뉴</a>
								<ul>
									<li><a href="/manager/member/list">회원 검색</a></li>
									<li><a href="/qna/list">1:1문의</a></li>	
								</ul>
							</li>
					</ul>


				</div>
			</c:if>
			
					<!-- 구분선 -->
					
			<div class="row center">
				<a href="/"> <img src="http://via.placeholder.com/300x100.png">
				</a>
			</div>

			<!-- 정보 확인용 공간 나중에 삭제 -->
			<!-- <div>
			session id = ${pageContext.session.id} , 
			createdUser = ${sessionScope.createdUser} ,
			createdLevel = ${sessionScope.createdLevel}
		</div> -->

			<!-- 
			메뉴(Navbar) 
			- (중요) 템플릿 페이지의 모든 경호는 전부 다 절대경로로 사용
			- 로그인 상태일 때와 비로그인 상태일 때 다르게 표시
			- 로그인 상태 : sessionScope.createdUser != null
			
			-->


			<ul class="menu">
				<!-- 구분선 -->
				<li class="flex-core all-menu"><i class="fa-solid fa-bars"></i>
					전체메뉴
					<ul class="all-menu-ul ul-horizon">
						d
					</ul>
					<ul class="all-menu-ul ul-horizon">
						<li class="li-horizon"><a href="#">상의 상세항목1</a></li>
						<li class="li-horizon"><a href="#">상의 상세항목1</a></li>
						<li class="li-horizon"><a href="#">상의 상세항목1</a></li>
						<li class="li-horizon"><a href="#">상의 상세항목1</a></li>
					</ul></li>
				<li><a href="/item/list/cate?column=1&keyword=11">상의</a>
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
				<li><a href="/item/list/cate?column=1&keyword=33">하의</a>
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
				<li><a href="/item/list/cate?column=1&keyword=55">슈즈</a>
					<ul>
						<li><a href="/item/list/cate?column=2&keyword=50">스니커즈</a>
						<li><a href="/item/list/cate?column=2&keyword=51">로퍼/슬립온</a>
						<li><a href="/item/list/cate?column=2&keyword=52">구두</a>
						<li><a href="/item/list/cate?column=2&keyword=53">워커/부츠</a>
						<li><a href="/item/list/cate?column=2&keyword=54">샌들/슬리퍼</a>
						<li><a href="/item/list/cate?column=2&keyword=55">깔창/기타</a>
					</ul>
				</li>
				<li><a href="/item/list/cate?column=1&keyword=77">아우터</a>
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
				<li class="right-menu"><a href="#">문의</a>
					<ul>
						<li><a href="#">항목1</a>
							<ul>
								<li><a href="#">상세항목1</a></li>
							</ul>
						</li>
						<li><a href="#">항목2</a>
							<ul>
								<li><a href="#">상세항목1</a></li>
							</ul>
						</li>
						<li><a href="#">항목3</a>
							<ul>
								<li><a href="#">상세항목1</a></li>
							</ul>
						</li>
						<li><a href="#">항목4</a>
							<ul>
								<li><a href="#">상세항목1</a></li>
							</ul>
						</li>
					</ul>
				</li>
				<!-- 구분선 -->
			</ul>
			<div class="row">
				<p>로그인 아이디 : ${sessionScope.createdUser}</p>
				<p>회원 등급 : ${sessionScope.createdLevel}</p>
			</div>
	</div>
	<!-- 중단(Container) -->