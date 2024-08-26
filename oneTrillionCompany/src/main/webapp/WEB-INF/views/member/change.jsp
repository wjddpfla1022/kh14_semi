<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form action="change" method="post" autocomplete="off">
	<div class="container w-600">
		<div class="row center">
	닉네임* <input type="text" name="memberNickname" value="${memberDto.memberNickname}" required> <br><br>
	이메일* <input type="email" name="memberEmail" value="${memberDto.memberEmail}" required> <br><br>
	연락처 <input type="tel" name="memberContact" value="${memberDto.memberContact}"> <br><br>
	생년월일 <input type="date" name="memberBirth" value="${memberDto.memberBirth}"> <br><br>
	<input type="text" name="memberPost" value="${memberDto.memberPost}" size="6"> <br>
	<input type="text" name="memberAddress1" value="${memberDto.memberAddress1}" size="60"> <br>
	<input type="text" name="memberAddress2" value="${memberDto.memberAddress2}" size="60"> <br><br>
	비밀번호 확인* <input type="password" name="memberPw"> <br><br>
	<button>변경하기</button>			
		</div>
	</div>
</form>

<c:if test="${param.error != null}">
	<h3 style="color:red">비밀번호가 일치하지 않습니다</h3>
</c:if>    


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>