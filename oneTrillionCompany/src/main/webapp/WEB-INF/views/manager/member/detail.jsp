<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-600">
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
				<td>${memberBlockVO.memberBlock}</td>
			</tr>
		</table>
	</div>
	<div class="row">
		<h2>주문내역</h2>
		
	</div>
	<div class="row">
		<h2>리뷰</h2>
			<c:choose>
				<c:when test="${reviewWriteList.isEmpty()}">
					<div class="row center">
						리뷰가 존재하지 않습니다
					</div>
				</c:when>
				<c:otherwise>
					<c:forEach var="reviewDto" items="${reviewWriteList}">
						<div class="row">
							<span>별점:${reviewDto.reviewScore}점</span>
							<span>${reviewDto.reviewContent}</span>
						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
	</div>
	<div class="row">
		<h2>문의</h2>
		
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