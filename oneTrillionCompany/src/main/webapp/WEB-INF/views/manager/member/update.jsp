<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .cancel-btn {
     	display: inline-block; /* 버튼처럼 보이게 하기 위해 블록 수준 요소로 변경 */
        padding: 10px 10px; 
        font-size: 15px; 
        color: black; 
        background-color: white; 
        text-align: center; 
        text-decoration: none; 
        border-radius: 4px; 
        cursor: pointer; 
        border:0.5px solid #ebebeb;
    }

</style>

<form action="update" method="post" autocomplete="off">
	<div class="container w-600">
		<div class="row center">
			<h1>회원 정보 수정</h1>
		</div>
		<div class="row">
			<input value="${memberDto.memberId}" name="memberId"  type="hidden" class="field w-100">
		</div>
		<div class="row">
			<label>닉네임 <i class="fa-solid fa-asterisk red"></i></label>
			<input value="${memberDto.memberNickname}" name="memberNickname"  type="text" class="field w-100" required>
		</div>
		<div class="row">
			<label>등급</label>
			<select name="memberRank" class="field w-100" >
				<option value="일반회원" <c:if test="${memberDto.memberRank=='일반회원'}">selected</c:if>>일반회원</option>
				<option value="우수회원"<c:if test="${memberDto.memberRank=='우수회원'}">selected</c:if>>우수회원</option>
			</select>
		</div>
		<div class="row">
			<label>포인트</label>
			<input value="${memberDto.memberPoint}" name="memberPoint"  type="text" class="field w-100">
		</div>
		<div class="row center">
			<button type="submit" class="btn btn-positive">회원정보수정</button>
			<a href="list" class="btn cancel-btn">취소</a>
		</div>
	</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>