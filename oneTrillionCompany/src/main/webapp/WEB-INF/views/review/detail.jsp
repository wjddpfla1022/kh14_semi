<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/locale/ko.min.js"></script>

<form action="write" method="post" enctype="multipart/form-data" autocomplete="off">
	<div class="container w-1200">
		<div class="row center">
		
			<div class="left">
				<span>작성자 : ${sessionScope.createdUser}</span>
			</div>
			
			<div class="left">
				<span>별정:${reviewDto.reviewScore}</span>
			</div>
			
			<div class="row">
				<span>${reviewDto.reviewContent}</span>
			</div>
			
			<div>
				<span style="color: white">${reviewDto.reviewNo}</span>
				<span style="color: white">${reviewDto.reviewItemNo}</span>
			</div>
		</div>
	</div>
</form>