<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	<style>
		.table-title {
			text-decoration: none;
			color: gray;
		}	
		.table-title:hover {
			color: black;
		}
		/* tr 테이블 상단 (번호 ,작성일 , 제목 , 작성자) */
		.tr-table-top {
			background-color: #f0f0f0 !important;
		}
		/* th 테이블 상단 (번호 ,작성일 , 제목 , 작성자) */
		.th-table-top {
			padding: 10px !important;
			font-weight: bolder;
		}
		/* tr 테이블 하단(게시글 , 제목 , 작성자 ,작성일자) */
		.tr-table-bottom {
			border: 1px solid #e9e9e9;
		}
		/* td 테이블 하단(게시글 , 제목 , 작성자 ,작성일자) */
		.td-table-bottom {
			padding: 10px !important;
			font-size: 14px;
		}	
		.table {
			border: 1px solid #e9e9e9;
		}	
		.login-msg,
		.noList-msg  {
			text-align: center;
			padding: 60px !important;
			font-size: 25px;
		}	
		.field-column {
			padding: 0.5em 0.5em 0.7em 0.5em;
		}
		/* 테이블 디자인 */
		.table tr {
			border: 1px solid #e9e9e9;
			border-bottom: none;
		}	
		.tr-table-top {
			background-color: #dcdde1;
		}
	</style>

<div class="container w-1000 my-30">
	<div class="row center">
		<h1>REVIEW</h1>
	</div>
	<hr>
	
		<%-- 비회원일 때와 회원일 때 다르게 보이도록 처리  --%>
	<c:choose>
		<c:when test="${sessionScope.createdUser != null}">
<!--	<div class="row right mt-30">
				<a href="write" class="btn btn-positive" style="text-decoration: none">리뷰 등록</a>
			</div>  -->
		</c:when>
		<c:otherwise>
			<div class="row right">
				<a title="로그인 후 이용하실 수 있습니다" class="btn btn-positive">리뷰 등록</a>
			</div>
		</c:otherwise>
	</c:choose>
	
	<!-- 검색 결과 -->
	<div class="row center">
		<c:choose>
			<c:when test="${list.size() > 0}">
				<table class="table table-top">
					<thead>
						<tr class="tr-table-top">
							<td width=10%>상품번호</td>
							<td width=10%>아이디</td>
							<td width=60%>리뷰내용</td>
							<td width=10%>별점</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="reviewDto" items="${list}">
							<tr class="tr-table-bottom">
								<td class="td-table-bottom">${reviewDto.reviewItemNo}</td>
								<td class="td-table-bottom">${reviewDto.reviewWriter}</td>
								<td class="td-table-bottom">
								<a href="detail?reviewNo=${reviewDto.reviewNo}" class="table-title">${reviewDto.reviewContent}</a>
								</td>
								<td class="td-table-bottom">${reviewDto.reviewScore}</td>
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
	
		<!-- 검색창 -->
	<form action="list" method="get" autocomplete="off" >
		<div class="row center mt-30">
			<select name="column" class="field-column">
				<option value="review_writer"<c:if test="${param.column=='review_writer'}">selected</c:if>>아이디</option>
				<option value="review_item_no"<c:if test="${param.column=='review_item_no'}">selected</c:if>>상품번호</option>
				<option value="review_score"<c:if test="${param.column=='review_score'}">selected</c:if>>별점</option>
			</select>
			<input class="field" type="text" name="keyword">
			<button class="btn btn-neutral" type="submit">
				<i class="fa-solid fa-magnifying-glass"></i> 검색
			</button>
		</div>
	</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
