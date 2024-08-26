<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	<div class="row center">
		<h1>상품  Q&A</h1>
	</div>
	<hr>
	
<style>
	.qna-title {
		text-decoration:none;
		color : gray;
	}
	.qna-title:hover	{
		color : black;
	}
</style>

<div class="container w-1000 my-30">
	<%-- 비회원일 때와 회원일 때 다르게 보이도록 처리  --%>
	<c:choose>
		<c:when test="${sessionScope.createdUser != null}">
			<div class="row right">
				<a href="write" class="btn regi-qna" style=text-decoration:none>문의 등록</a>
			</div>	
		</c:when>
		<c:otherwise>
			<div class="row right">
				<a title="로그인 후 이용하실 수 있습니다" class="btn regi-qna">문의 등록</a>
			</div>
		</c:otherwise>
	</c:choose>
	
	<%-- 테이블 작성  --%>
		<table class="table table-border">
			<thead>
				<tr>
					<th width=10%>번호</th>
					<th width=20%>작성일</th>
					<th width =50%>제목</th>
					<th width=20%>작성자</th>
				</tr>
			</thead>
			<tbody align="center">
				<c:forEach var="qnaDto" items="${qnaList}">
						<tr>
							<td>${qnaDto.qnaNo}</td>
							<td>${qnaDto.qnaTime}</td>
							<td>
								<a href="detail?qnaNo=${qnaDto.qnaNo}" class="qna-title">${qnaDto.qnaTitle}</a>
								<!--댓글 숫자 출력(0보다 크면) -->
								<c:if test="${qnaDto.qnaReply >0}">
									[${qnaDto.qnaReply}]
								</c:if>
							</td>
<!-- 							<td>							 -->
<%-- 								<c:choose> --%>
<%-- 									<c:when test="${qnaDto.qnaWriter == null}"> --%>
<!-- 										탈퇴한 사용자 -->
<%-- 									</c:when> --%>
<%-- 									<c:otherwise>${qnaDto.qnaWriter}</c:otherwise> --%>
<%-- 								</c:choose>								 --%>
<!-- 							</td> -->
							<td>${qnaDto.qnaWriter}</td>
						</tr>
				</c:forEach>
			</tbody>
		</table>
</div>


<!-- 검색창 -->
<form action="list" method="get" autocomplete="off">
	<div class="row center">
		<select name="column">
			<option value="qna_title" <c:if test="${param.column == 'qna_title'}">selected</c:if>>제목</option>
			<option value="qna_writer" <c:if test="${param.column == 'qna_writer'}">selected</c:if>>작성자</option>
		</select>
		<input type="text" name="keyword" placeholder="검색어" value="${param.keyword}">
		<button type="submit">검색</button>
	</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>