<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
<div class="container w-1200">
	<div class="row center">
		<h1>회원 차단 내역</h1>
	</div>
	<div class="row right">
		<h3>데이터 개수: ${list.size()}</h3>
	</div>	
	<!-- 검색창 -->
	<div class="row center">
		<form action="blockList" method="get" autocomplete="off" class="field">
			<select name="column" class="field">
				<option value="block_member_id" <c:if test="${param.column=='block_member_id'}">selected</c:if>>아이디</option>
				<option value="block_type" <c:if test="${param.column=='block_type'}">selected</c:if>>상태</option>
			</select>
			<input class="field" type="text" name="keyword" value="${param.keyword}">
			<button class="btn btn-positive" type="submit">검색</button>
		</form>
	</div>
	<!-- 검색 결과 -->
	<div class="row center">
		<c:choose>
			<c:when test="${list.size() > 0}">
				<table class="table table-border table-hover">
					<thead>
						<tr>
							<td>아이디</td>
							<td>상태</td>
							<td>사유</td>
							<td>일시</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="blockDto" items="${list}">
							<tr>
								<td>${blockDto.blockMemberId}</td>
								<td>${blockDto.blockType}</td>
								<td>${blockDto.blockMemo}</td>
								<td>${blockDto.blockTime}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:when>
			<c:otherwise>
				<h3>검색 결과가 없습니다</h3>
			</c:otherwise>
		</c:choose>
	</div>
</div>