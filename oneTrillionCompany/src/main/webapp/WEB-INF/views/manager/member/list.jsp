<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

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
			<select name="column" class="field">
				<option value="member_id" <c:if test="${param.column=='member_id'}">selected</c:if>>아이디</option>
				<option value="member_nickname" <c:if test="${param.column=='member_nickname'}">selected</c:if>>닉네임</option>
				<option value="member_rank" <c:if test="${param.column=='member_rank'}">selected</c:if>>등급</option>
			</select>
		<input class="field" type="text" name="keyword" value="${param.keyword}" >	
		<button class="btn btn-neutral" type="submit">검색</button>
		</form>
	</div>
	
	<!-- 검색 결과 -->
	<div class="row center">
		<c:choose>
			<c:when test="${list.size() > 0}">
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
						<c:forEach var="memberBlockVO" items="${list}">
							<tr>
								<td>
									<a href="detail?memberId=${memberBlockVO.memberId}" class="link">${memberBlockVO.memberId}</a>
								</td>
								<td>${memberBlockVO.memberNickname}</td>
								<td>${memberBlockVO.memberRank}</td>
								<td>${memberBlockVO.blockType}</td>
								<td>${memberBlockVO.memberJoin}</td>
								<td>
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
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>