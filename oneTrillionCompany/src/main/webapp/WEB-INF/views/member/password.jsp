<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form action="password" method="post" autocomplete="off">
	<div class="container w-350 my-50">
		<div class="row center">
			<h1>비밀번호 변경</h1>		
		</div>
		<div class="row">
			<input type="password" name="currentPw" placeholder="현재 비밀번호" class="field w-100">
		</div>
		<div class="row">
			<input type="password" name="changePw" placeholder="바꿀 비밀번호" class="field w-100">
		</div>
		<div class="row">
			<button class="btn btn-positive w-100">변경하기</button>
		</div>
		<c:if test="${param.error != null}">
		<div class="row center">
			<h3 style="color:red">비밀번호가 일치하지 않습니다</h3>
		</div>
		</c:if>
	</div>

</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>



