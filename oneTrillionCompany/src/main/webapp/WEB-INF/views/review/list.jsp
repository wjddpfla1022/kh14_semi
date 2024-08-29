<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-1200">
	<div class="row center">
		<h1>리뷰 검색</h1>
	</div>
	<div class="row right">
		<h3>데이터 개수: ${list.size()}</h3>
	</div>
	<!-- 검색창 -->
	<div class="row center">
		<form action="list" method="get" autocomplete="off" class="field">
			<select name="column" class="field">
				<option value="review_writer"<c:if test="${param.column=='review_writer'}">selected</c:if>>아이디</option>
				<option value="review_item_no"<c:if test="${param.column=='review_item_no'}">selected</c:if>>상품번호</option>
				<option value="review_score"<c:if test="${param.column=='review_score'}">selected</c:if>>별점</option>
			</select>
			<input class="field" type="text" name="keyword">
			<button class="btn btn-poditive" type="submit">검색</button>
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
							<td>상품번호</td>
							<td>리뷰내용</td>
							<td>별점</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="reviewDto" items="${list}">
							<tr>
								<td>${reviewDto.reviewWriter}</td>
								<td>${reviewDto.reviewItemNo}</td>
								<td><a href="detail?reviewNo=${reviewDto.reviewNo}" class="link">${reviewDto.reviewContent}</a></td>
								<td>${reviewDto.reviewScore}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:when>
			<c:otherwise>
				<h3>검색 결과가 존재하지 않습니다</h3>
			</c:otherwise>
		</c:choose>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
