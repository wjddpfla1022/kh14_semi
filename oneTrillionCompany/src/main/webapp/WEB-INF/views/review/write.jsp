<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<form action="write" method="post" autocomplete="off">
	<div class="container w-800">
		<div class="row center">
			<h1>후기글 작성</h1>
		</div>
			<label>작성자</label>
			<input type="hidden" name="reviewWriter" class="field w-100" value="${memberId}">
		<div class="row">
			<label>내용</label>
			<textarea name="reviewContent" rows="10" class="field w-100"></textarea>		
		</div>
		<div class="row">
			<label>결제상세넘버</label>
			<input type="text" name="reviewItemNo" class="field w-100">
		</div>
		<div class="row">
			<label>별점</label>
			<input type="text" name="reviewScore" class="field w-100">
		</div>
		
		<div class="row right">
			<button type="submit" class="btn btn-positive">작성하기</button>
		</div>	
	</div>
</form>
</html>