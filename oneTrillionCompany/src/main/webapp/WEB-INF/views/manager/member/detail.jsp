<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	.custom-menu {
	    display: inline-block; /* li를 인라인 블록으로 설정하여 가로로 배치 */
	    padding: 30px; /* 여백 설정 */
	    border: 1px solid #e9e9e9;
	    border-right : none;
	    list-style-type: none; /* 목록 스타일 제거 */
	    width: 100%;
	}
	.custom-last-menu {
	    display: inline-block; /* li를 인라인 블록으로 설정하여 가로로 배치 */
	    padding: 30px; /* 여백 설정 */
	    border: 1px solid #e9e9e9;
/* 	    border-left : none; */
	    list-style-type: none; /* 목록 스타일 제거 */
	    width: 100%;
	}
	/* flex-box의 ul  */
	.flex-box ul {
	    text-align: center; 
	}
	/* 상단부 텍스트 */
	#top-location {
	    font-size: 18px;
	   	font-weight: bolder;
	   	color : black;
	}
	/* 하단부 텍스트 */
	#bottom-location {	
	font-size: 12px;
	}
	/* flex-box 안에 모든 span 태그 */
	.flex-box span {
	    display: block;
  	   	color : black;
  	   	text-align: center;
	}
	/* flex-box 안에 모든 a태그 */
	.flex-box a {
	    text-decoration: none;
	}	
	.custom-menu a:hover {
	    color : red;
	}
	.table-border-top{
		background-color: transparent;
		border: 2px solid black;
		border-left: none;
		border-right: none;
		border-bottom: 1px solid #e9e9e9;
	}
	.table-border-middle{
		background-color: transparent;
		border-top: none;
		border-left: none;
		border-right: none;
		border-bottom: 1px solid #e9e9e9;
	}
	.table-border-center{
		background-color: transparent;
		border-top: none;
		border-left: none;
		border-right: 1px solid #e9e9e9;
		border-bottom: none;
	}
	.table-border-side{
		background-color: transparent;
		border-top: none;
		border-left: 1px solid #e9e9e9;
		border-right: 1px solid #e9e9e9;
		border-bottom: none;
	}
</style>

<div class="container w-700">
	<div class="row center">
		<h1>${memberDto.memberId}님의 정보</h1>
	</div>
	<div class="row center">
		<table class="table table-border-top">
			<tr class="table-border-middle">
				<td class="table-border-center">이름</td>
				<td>${memberDto.memberName}</td>
			</tr>
			<tr class="table-border-middle">
				<td class="table-border-center">닉네임</td>
				<td>${memberDto.memberNickname}</td>
			</tr>
			<tr class="table-border-middle">
				<td class="table-border-center">이메일</td>
				<td>${memberDto.memberEmail}</td>
			</tr>
			<tr class="table-border-middle">
				<td class="table-border-center">주소</td>
					<c:choose>
						<c:when test="${memberDto.memberPost==null && memberDto.memberAddress1==null && memberAddress2==null}">
							<td></td>
						</c:when>
						<c:otherwise>
							<td>[${memberDto.memberPost}] ${memberDto.memberAddress1}, ${memberDto.memberAddress2}</td>
						</c:otherwise>						
					</c:choose>				
			</tr>
			<tr class="table-border-middle">
				<td class="table-border-center">등급</td>
				<td>${memberDto.memberRank}</td>
			</tr>
			<tr class="table-border-middle">
				<td class="table-border-center">포인트</td>
				<td>${memberDto.memberPoint}p</td>
			</tr>
			<tr class="table-border-middle">
				<td class="table-border-center">가입일</td>
				<td>
					<fmt:formatDate value="${memberDto.memberJoin}" pattern="y년 M월 d일"/>
				</td>
			</tr>
			<tr class="table-border-middle">
				<td class="table-border-center">최종 로그인</td>
				<td>
					<fmt:formatDate value="${memberDto.memberLogin}" pattern="y년 M월 d일 E H시 m분"/>
				</td>
			</tr>
			<tr class="table-border-middle">
				<td class="table-border-center">차단 여부</td>
				<td>
					<c:choose>
						<c:when test="${blockDto.blockType=='차단'}">
							${blockDto.blockType}							
						</c:when>
						<c:when test="${blockDto.blockType=='해제'}">
							${blockDto.blockType}	
						</c:when>
						<c:otherwise>
							차단 이력 없음
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</table>
	</div>
	<div class="flex-box row">
<!-- 			<div class=custom-menu> -->
<!-- 					<a href="#"> -->
<!-- 						<span id="top-location">Order</span> -->
<!-- 						<span id="bottom-location">주문내역 조회</span> -->
<!-- 					</a> -->
<!-- 			</div> -->
			<div class=custom-menu>
					<a href="/qna/list?column=qna_writer&keyword=${memberDto.memberId}">
						<span id="top-location">Q&A</span>
						<span id="bottom-location">문의내역 조회</span>
					</a>
			</div>			
			<div class=custom-menu>
					<a href="/review/list?column=review_writer&keyword=${memberDto.memberId}">
						<span id="top-location">Review</span>
						<span id="bottom-location">리뷰내역 조회</span>
					</a>
			</div>			
			<div class=custom-last-menu>
					<a href="/manager/member/blockList?column=block_member_id&keyword=${memberDto.memberId}">
						<span id="top-location">Block</span>
						<span id="bottom-location">차단내역 조회</span>
					</a>
			</div>
	</div>
	
	<div class="float-box">
		<a href="list" class="btn btn-positive">회원 검색</a>
		<a href="update?memberId=${memberDto.memberId}" class="btn btn-positive">회원정보 수정</a>
		
		<%-- 관리자일경우 회원 차단/해제 버튼을 안보이게 함  --%>
			<c:choose>
				<c:when test="${memberDto.memberRank!='관리자'}">
					<c:choose>
							<c:when test="${blockDto.blockType=='차단'}">
								<a href="clear?memberId=${memberDto.memberId}" class="btn btn-negative float-right">회원 차단 해제</a>
							</c:when>
								<c:otherwise>
									<a href="block?memberId=${memberDto.memberId}" class="btn btn-negative float-right">회원 차단</a>
								</c:otherwise>
						</c:choose>
					</c:when>
			</c:choose>
	</div>
</div>