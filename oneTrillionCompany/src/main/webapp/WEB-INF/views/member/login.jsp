<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<script src="/js/checkbox.js"></script>
<script src="/js/confirm-link.js"></script>
<script src="/js/multipage.js"></script>
<!-- font awesome icon cdn -->
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="/css/commons.css">
<script type="text/javascript">
	
</script>
<body>
<form action="login" method="post">
	<div class="container w-350 my-50 center">
		<div class="row">
			<h1>로그인</h1>
		</div>
		<div class="row w-100 left">
			<label>아이디</label>
			<input type="text" name="memberId" class="w-100 field"> 
		</div>
		<div class="row w-100 left">
			<label>비밀번호</label>
			<input type="password" name="memberPw" class="w-100 field"> 
		</div>
		<div class="row">
			<button type="submit" class="btn btn-positive">로그인</button>
		</div>
	</div>
</form> 
</body>