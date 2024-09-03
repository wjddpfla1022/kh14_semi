<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
		<h1>1:1 문의 게시판</h1>
	</div>
	<hr>

	<%-- 비회원일 때와 회원일 때 다르게 보이도록 처리  --%>
	<c:choose>
		<c:when test="${sessionScope.createdLevel == '관리자'}">
			
		</c:when>
		<c:when test="${sessionScope.createdUser != null}">
			<div class="row right">
				<a href="write" class="btn btn-positive" style="text-decoration: none">문의 등록</a>
			</div>
		</c:when>
		<c:otherwise>
			<div class="row right">
				<a title="로그인 후 이용하실 수 있습니다" class="btn btn-positive">문의 등록</a>
			</div>
		</c:otherwise>
	</c:choose>
	

	<%-- 비회원일 경우 로그인 후 이용 메시지를 출력  --%>
	<c:if test="${sessionScope.createdUser == null}">
		<table class="table table-top">
			<thead>
				<tr class="tr-table-top">
					<th width="10%" class="th-table-top">번호</th>
					<th width="60%" class="th-table-top">제목</th>
					<th width="15%" class="th-table-top">작성자</th>
					<th width="15%" class="th-table-top">작성일</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<!-- 테이블 셀의 colspan을 사용하여 메시지를 한 줄로 표시 -->
					<td class="login-msg" colspan="4">
						<i class="fa-solid fa-headphones"></i> 로그인 후 이용 가능합니다.
					</td>
				</tr>
			</tbody>
		</table>
	</c:if>

	<%-- 로그인 아이디와 게시글 작성자의 아이디가 일치하는 경우에만 게시글을 출력 --%>
	<c:choose>
		<c:when test="${sessionScope.createdLevel=='관리자' }">
		</c:when>
		<c:when test="${sessionScope.createdUser== null }">
		</c:when>
		
		<c:otherwise>
			<table class="table table-top">
				<thead>
					<tr class="tr-table-top">
						<th width=10% class="th-table-top">번호</th>
						<th width=60% class="th-table-top">제목</th>
						<th width=15% class="th-table-top">작성자</th>
						<th width=15% class="th-table-top">작성일</th>
					</tr>
				</thead>
				<tbody align="center">
					<c:choose>
					    <%-- 검색 결과가 없거나, 작성자의 게시글이 리스트에 없는 경우를 처리 --%> 
					    <c:when test="${fn:length(qnaList) == 0}">
					        <tr>
					            <td class="noList-msg" colspan="4">
					               검색 결과가 존재하지 않습니다.
					            </td>
					        </tr>
					    </c:when>
					    <c:otherwise>
					        <%-- 작성자의 게시글이 리스트에 없는 경우를 처리 --%> 
					        <c:if test="${!fn:contains(qnaList, sessionScope.createdUser)}">
					            <tr>
					                <td class="noList-msg" colspan="4">
					                    <i class="fa-solid fa-headphones"></i> 문의 내역이 존재하지 않습니다.
					                </td>
					            </tr>
					        </c:if>
					    </c:otherwise>
					</c:choose>
				
						<%-- qnaList가 생성 된 경우 --%>		
						<c:forEach var="qnaDto" items="${qnaList}">
							<c:choose>
								<c:when test="${sessionScope.createdUser == qnaDto.qnaWriter}">
									<tr class="tr-table-bottom">
										<td class="td-table-bottom">${qnaDto.qnaNo}</td>
										<td class="td-table-bottom">
											<a href="detail?qnaNo=${qnaDto.qnaNo}" class="table-title">${qnaDto.qnaTitle}</a>
												<!--댓글 숫자 출력(0보다 크면) --> 
												<c:if test="${qnaDto.qnaReply > 0}">
					                                [${qnaDto.qnaReply}]
					                            </c:if>
			                            </td>
											<td class="td-table-bottom">${qnaDto.qnaWriter}</td>
											<td class="td-table-bottom">${qnaDto.qnaTime}</td>
									</tr>
								</c:when>
							</c:choose>
						</c:forEach>
				</tbody>
			</table>
		</c:otherwise>
	</c:choose>


	<%-- 관리자 아이디로 접속 시 문의 리스트를 전부 보여지게 구현  --%>
	<c:choose>
		<c:when test="${sessionScope.createdLevel == '관리자'}">
			<table class="table table-top">
				<thead>
					<tr class="tr-table-top">
						<th width=10% class="th-table-top">번호</th>
						<th width=60% class="th-table-top">제목</th>
						<th width=15% class="th-table-top">작성자</th>
						<th width=15% class="th-table-top">작성일</th>
					</tr>
				</thead>
				<tbody align="center">
					<c:forEach var="qnaDto" items="${qnaList}">
						<tr class="tr-table-bottom">
							<td class="td-table-bottom">${qnaDto.qnaNo}</td>
							<td class="td-table-bottom">
								<a href="detail?qnaNo=${qnaDto.qnaNo}" class="table-title">${qnaDto.qnaTitle}</a>
								<!--댓글 숫자 출력(0보다 크면) -->
									 <c:if test="${qnaDto.qnaReply >0}">
										[${qnaDto.qnaReply}]
									</c:if>
								</td>
	 							 
								<td class="td-table-bottom">
									<c:choose>
										<c:when test="${qnaDto.qnaWriter == null}">
	 										탈퇴한 사용자 
										</c:when>
											<c:otherwise>
												<c:out value="${qnaDto.qnaWriter}" />
											</c:otherwise>
									</c:choose>
								</td>
							<td class="td-table-bottom">${qnaDto.qnaTime}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:when>
	</c:choose>

</div>


<!-- 검색창 -->
<form action="list" method="get" autocomplete="off">
	<div class="row center">
		<select name="column" class="field-column">
			<option value="qna_title"
				<c:if test="${param.column == 'qna_title'}">selected</c:if>>제목</option>
			<option value="qna_writer"
				<c:if test="${param.column == 'qna_writer'}">selected</c:if>>작성자</option>
		</select> <input type="text" name="keyword" placeholder="검색어"
			value="${param.keyword}" class="field">
		<button type="submit" class="btn btn-neutral">
			<i class="fa-solid fa-magnifying-glass"></i> 검색
		</button>
	</div>
</form>

<jsp:include page="/WEB-INF/views/template/navigator.jsp" />
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>