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
	
<div class="container w-1200">
	<div class="row center">
		<h1>회원 검색</h1>
	</div>
<!-- 	<div class="row right">	 -->
<%-- 		<h3>데이터개수 : ${list.size()}</h3> --%>
<!-- 	</div> -->
	<!-- 검색창 -->
	<form action="list" method="get" autocomplete="off"  >
		<div class="row center">
			<select name="column" class="field-column" >
				<option value="" >선택</option>
				<option value="member_id" <c:if test="${param.column=='member_id'}">selected</c:if>>아이디</option>
				<option value="member_nickname" <c:if test="${param.column=='member_nickname'}">selected</c:if>>닉네임</option>
				<option value="member_rank" <c:if test="${param.column=='member_rank'}">selected</c:if>>등급</option>
			</select>
		<input class="field" type="text" name="keyword" value="${param.keyword}" class="field" >	
			<button class="btn btn-positive" type="submit">
				<i class="fa-solid fa-magnifying-glass"></i>
				검색
			</button>
		</div>
	</form>
	
	<!-- 검색 결과 -->
	<div class="row center mt-30">
		<c:choose>
			<c:when test="${list.size() > 0}">
				<table  class="table table-top mt-30 table-hover">
					<thead>
						<tr class="tr-table-top">
							<th class="th-table-top">아이디</th>
							<th class="th-table-top">닉네임</th>
							<th class="th-table-top">등급</th>
							<th class="th-table-top">차단 상태</th>
							<th class="th-table-top">가입일</th>
							<th class="th-table-top">관리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="memberBlockVO" items="${list}">
							<tr class="tr-table-bottom">
								<td class="td-table-bottom">
									<a href="detail?memberId=${memberBlockVO.memberId}" class="link">${memberBlockVO.memberId}</a>
								</td>
								<td class="td-table-bottom">${memberBlockVO.memberNickname}</td>
								<td class="td-table-bottom">${memberBlockVO.memberRank}</td>
								<td class="td-table-bottom">${memberBlockVO.blockType}</td>
								<td class="td-table-bottom">${memberBlockVO.memberJoin}</td>
								<td class="td-table-bottom">
									<a href="update?memberId=${memberBlockVO.memberId}" class="btn btn-positive">수정</a>
									<c:choose>
										<c:when test="${memberBlockVO.blockType=='차단'}">
											<a href="clear?memberId=${memberBlockVO.memberId}" class="btn btn-neutral">해제</a>
										</c:when>
										<c:otherwise>
											<a href="block?memberId=${memberBlockVO.memberId}"  class="btn btn-negative">차단</a>
										</c:otherwise>
									</c:choose>
								</td>
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

<jsp:include page="/WEB-INF/views/template/navigator.jsp"/>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>