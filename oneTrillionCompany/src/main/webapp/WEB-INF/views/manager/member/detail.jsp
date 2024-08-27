<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>

	.custom-shop .custom-menu {
	    display: inline-block; /* 블록 요소를 인라인 블록으로 변경 */
	    width: auto; /* 자동 너비로 변경 */
	    margin: 0; /* 여백 초기화 */
	    padding: 30px 30px;
	    border-right: 1px solid #e9e9e9;
	    border-bottom: 1px solid #e9e9e9;
	    box-sizing: border-box;
	    text-align: center;
	    list-style-type: none;
	}

	
	.custom-shop .custom-menu strong {
	    font-size: 18px;
	   	font-weight: bolder;
	   	color : black;
	}
	
	.custom-shop .custom-menu span {
	    display: block;
  	   	color : black;
	}
	
	.custom-shop .custom-menu a {
	    display: block;
	    padding: 0 0 15px;
	    text-decoration: none;
	}
	
	.custom-shop .custom-menu a:hover {
	    text-decoration: none;
	}
</style>

<div class="container w-700">
	<div class="row center">
		<h1>${memberDto.memberId}님의 정보</h1>
	</div>
	<div class="row center">
		<table class="table table-border">
			<tr>
				<td>이름</td>
				<td>${memberDto.memberName}</td>
			</tr>
			<tr>
				<td>닉네임</td>
				<td>${memberDto.memberNickname}</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td>${memberDto.memberEmail}</td>
			</tr>
			<tr>
				<td>주소</td>
					<c:choose>
						<c:when test="${memberDto.memberPost==null && memberDto.memberAddress1==null && memberAddress2==null}">
							<td></td>
						</c:when>
						<c:otherwise>
							<td>[${memberDto.memberPost}] ${memberDto.memberAddress1}, ${memberDto.memberAddress2}</td>
						</c:otherwise>						
					</c:choose>				
			</tr>
			<tr>
				<td>등급</td>
				<td>${memberDto.memberRank}</td>
			</tr>
			<tr>
				<td>포인트</td>
				<td>${memberDto.memberPoint}p</td>
			</tr>
			<tr>
				<td>가입일</td>
				<td>
					<fmt:formatDate value="${memberDto.memberJoin}" pattern="y년 M월 d일"/>
				</td>
			</tr>
			<tr>
				<td>최종 로그인</td>
				<td>
					<fmt:formatDate value="${memberDto.memberLogin}" pattern="y년 M월 d일 E H시 m분"/>
				</td>
			</tr>
			<tr>
				<td>차단 여부</td>
				<td>${memberBlockVO.blockType}</td>
			</tr>
		</table>
	</div>
	<div class="row custom-shop">
		<ul>
			<li class=custom-menu>
					<a href="#">
						<strong>Order</strong>
						<span>주문내역 조회</span>
					</a>
			</li>
		</ul>
	</div>
	
	<div class="float-box">
		<a href="list" class="btn btn-positive">회원 검색</a>
		<a href="update?memberId=${memberDto.memberId}" class="btn btn-positive">회원정보 수정</a>
		<c:choose>
			<c:when test="${memberBlockVO.blockType=='차단'}">
				<a href="block?memberId=${memberDto.memberId}" class="btn btn-negative float-right">회원 차단 해제</a>
			</c:when>
			<c:otherwise>
				<a href="block?memberId=${memberDto.memberId}" class="btn btn-negative float-right">회원 차단</a>
			</c:otherwise>
		</c:choose>
	</div>
</div>