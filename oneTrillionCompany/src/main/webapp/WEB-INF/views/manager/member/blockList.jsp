<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
<div class="container w-1200">
	<div class="row center">
		<h1>회원 차단 내역</h1>
	</div>
	<!-- 검색창 -->
		<form action="blockList" method="get" autocomplete="off" >
			<div class="row center">
				<select name="column" class="field-column">
					<option value="block_member_id" <c:if test="${param.column=='block_member_id'}">selected</c:if>>아이디</option>
					<option value="block_type" <c:if test="${param.column=='block_type'}">selected</c:if>>상태</option>
				</select>
					<input class="field" type="text" name="keyword" value="${param.keyword}">
				<button class="btn btn-positive" type="submit">
					<i class="fa-solid fa-magnifying-glass"></i> 검색
				</button>
			</div>
		</form>
	<!-- 검색 결과 -->
	<div class="row center">
		<c:choose>
			<c:when test="${list.size() > 0}">
				<table class="table table-top mt-30">
					<thead>
						<tr tr-table-top>
							<td class="th-table-top">아이디</td>
							<td class="th-table-top">상태</td>
							<td class="th-table-top">사유</td>
							<td class="th-table-top">일시</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="blockDto" items="${list}">
							<tr class="tr-table-bottom">
								<td class="td-table-bottom">${blockDto.blockMemberId}</td>
					            <td class="td-table-bottom" 
					                style="<c:if test='${blockDto.blockType == "차단"}'>color: red; font-weight: bold;</c:if>">
					                ${blockDto.blockType}
					            </td>
								<td class="td-table-bottom">${blockDto.blockMemo}</td>
								<td class="td-table-bottom">
									<fmt:formatDate value="${blockDto.blockTime}" pattern="yyyy/MM/dd HH:mm" />
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:when>
			<c:otherwise>
				<h3 style="color: red">차단 이력이 존재하지 않습니다.</h3>
			</c:otherwise>
		</c:choose>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>