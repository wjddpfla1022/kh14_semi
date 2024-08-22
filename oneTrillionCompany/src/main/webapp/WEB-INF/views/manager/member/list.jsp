<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    /* 기본 버튼 스타일 */
    .update-btn {
        display: inline-block; /* 버튼처럼 보이게 하기 위해 블록 수준 요소로 변경 */
        padding: 10px 10px; 
        font-size: 15px; 
        color: white; 
        background-color: #0984e3; 
        text-align: center; 
        text-decoration: none; 
        border-radius: 4px; 
        cursor: pointer; 
    }

    / 버튼 호버 상태 */
    .update-btn:hover {
        background-color: #0056b3; 
        border-color: #004085; 
    }
</style>

<div class="container w-1200">
	<div class="row center">
		<h1>회원 검색</h1>
	</div>
	<div class="row right">	
		<h3>데이터개수 : ${list.size()}</h3>
	</div>
	<!-- 검색창 -->
	<div class="row center" style=" margin-bottom:10px;">
		<form action="list" method="get" autocomplete="off" class="field">
			<select name="column">
				<option value="member_id"<c:if test="${column=='member_id'}">selected</c:if>>아이디</option>
				<option value="member_nickname"<c:if test="${column=='member_nickname'}">selected</c:if>>닉네임</option>
				<option value="member_rank"<c:if test="${column=='member_rank'}">selected</c:if>>등급</option>
			</select>
		<input class="field" type="text" name="keyword" value="${param.keyword}" >	
		<button class="btn btn-neutral" type="button">검색</button>
		</form>
	</div>
	
	<!-- 검색 결과 -->
	<div class="row center">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th>아이디</th>
					<th>닉네임</th>
					<th>등급</th>
					<th>차단 상태</th>
					<th>가입일</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<%--검색 결과가 없을 때 --%>
					<c:when test="${list.isEmpty()}">
						<tr>
							<td>검색 결과가 존재하지 않습니다</td>
						</tr>
					</c:when>
					<%--검색 결과가 있을 때 --%>
					<c:otherwise>
						<c:forEach var="memberBlockVO" items="${list}">
							<tr>
								<td>
									<a href="detail?memberId=${memberBlockVO.memberId}" class="link">${memberBlockVO.memberId}</a>
								</td>
								<td>${memberBlockVO.memberNickname}</td>
								<td>${memberBlockVO.memberRank}</td>
								<td>${memberBlockVO.memberBlock}</td>
								<td>${memberBlockVO.memberJoin}</td>
								<td>
<<<<<<< HEAD
									<a href="update?memberId=${memberBlockVO.memberId}">수정</a>
=======
									<a href="update?memberId=${memberBlockVO.memberId}" class="update-btn">수정</a>
>>>>>>> refs/remotes/origin/master
<%-- 									<c:choose> --%>
<%-- 										<c:when test="${memberBlockVO.blockType=='차단'}"> --%>
<%-- 											<a href="block?blockMemberId=${memberBlockVO.memberId}">해제</a> --%>
<%-- 										</c:when> --%>
<%-- 										<c:otherwise> --%>
<%-- 											<a href="block?blockMemberId=${memberBlockVO.memberId}">차단</a> --%>
<%-- 										</c:otherwise> --%>
<%-- 									</c:choose> --%>
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
</div>