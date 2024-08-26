<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-1000">
	<div class="row center">
		<h1>${qnaDto.qnaWriter}님의 Q&A</h1>
	</div>
	<hr>
	<div class="row">
		<table class="table table-border">
			<tbody>
				<tr>
					<td><h1>${qnaDto.qnaTitle}</h1></td>
				</tr>
				<tr>
					<td>${qnaDto.qnaTime}</td>
				</tr>
				<tr>
					<td>${qnaDto.qnaContent}</td>
				</tr>
				<tr>	
				<!-- 댓글 -->
					<td>
						<i class="fa-regular fa-comment-dots"></i><fmt:formatNumber value="${qnaDto.qnaReply}" pattern="#,##0"/>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>