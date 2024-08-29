<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/locale/ko.min.js"></script>

<script type="text/javascript">
	$(function(){
		$(".btn-delete").on("click",function(e){
			e.preventDefault();
			var historyDel = window.confirm("리뷰를 삭제 하시겠습니까?");
            if (historyDel) {
                $("#checkForm").submit();
            }
		});
	});
</script>

<form action="delete?reviewNo=${reviewDto.reviewNo}" method="post" enctype="multipart/form-data" autocomplete="off" id="checkForm">
	<div class="container w-1200">
		<div class="row center">
		
			<div class="row left">
				<span>작성자 : ${reviewDto.reviewWriter}</span>
			</div>
			
			<div class="row left">
				<span>별점 : ${reviewDto.reviewScore}</span>
			</div>
			
			<div class="row">
				<span>${reviewDto.reviewContent}</span>
			</div>
			<div class="center">
	        	<img src="image?reviewNo=${reviewDto.reviewNo}" width="150" height="150">
	        </div>			
			<div>
				<span style="color: white">${reviewDto.reviewNo}</span>
				<span style="color: white">${reviewDto.reviewItemNo}</span>
			</div>
		</div>
		<div class="row right">
			<a href="delete?reviewNo=${reviewDto.reviewNo}" class="btn btn-delete">삭제</a>
		</div>
	</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>