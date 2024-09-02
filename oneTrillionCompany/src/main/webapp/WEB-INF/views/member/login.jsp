<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!DOCTYPE html>
<html lang="ko">



<script type="text/javascript">
$(function() {
    var status = {
        memberIdCheck: false,
        memberPwCheck: false,
        ok: function() {
            return this.memberIdCheck && this.memberPwCheck;
        }
    };

    $("[name=memberId]").blur(function() {
        var target = $(this).val();
        var isValid = target.length > 0;
        $(this).removeClass("success fail");
        status.memberIdCheck = isValid;
        if (!isValid) {
            $(this).addClass("fail");
        } else {
            $(this).addClass("success");
        }
    });

    $("[name=memberPw]").blur(function() {
        var target = $(this).val();
        var isValid = target.length > 0;
        $(this).removeClass("success fail");
        status.memberPwCheck = isValid; // 오타 수정
        if (!isValid) {
            $(this).addClass("fail");
        } else {
            $(this).addClass("success");
        }
    });

    $(".btn-submit").click(function(event) { // event 객체를 추가
        if (!status.ok()) {
            event.preventDefault(); // Prevent form submission
            $(".fail-feedback").show();
        } else {
            $("form").submit(); // Submit the form if all checks pass
        }
        return status.ok();
    });
});
</script>
<style>
 		.success-feedback{
            color: black;
        }
        .success {
            border-color: black;
        }  
</style>

<body>
<form action="login" method="post">
	<div class="container w-350 my-50 center">
		<div class="row">
			<h1>로그인</h1>
		</div>
		<div class="row w-100 left">
			<label>아이디</label>

			<input type="text" name="memberId" class="w-100 field"> 			
			<div class="success-feedback"></div>
			<div class="fail-feedback">아이디를 입력해주세요</div>

		</div>
		<div class="row w-100 left">
			<label>비밀번호</label>
			<input type="password" name="memberPw" class="w-100 field">
			<div class="success-feedback"></div>
			<div class="fail-feedback">비밀번호를 입력해주세요</div> 
		</div>
		<div class="row center"> 
			<c:if test= "${param.error != null}">
				<h3 style = "color:red">아이디 또는 비밀번호가 잘못되었습니다.</h3>
			</c:if>
		</div>
		
			<%--아이디 쿠키 만들기 체크박스--%>
<!-- 		<div class="row left"> -->
<!-- 			<label> -->
<!-- 				<input type="checkbox" name="remember" -->
<%-- 				<c:if test="${cookie.saveId != null}">checked</c:if>> --%>
<!-- 					<span>아이디 저장</span> -->
<!-- 			</label> -->
<!-- 		</div> -->
		
		<div class="row">
			<button type="submit" class="btn btn-positive btn-submit">로그인</button>
			<div class="fail-feedback"></div>
		</div>
		<div class="row">
			<a href="/member/join" class="btn btn-neutral">회원가입</a>
		</div>
	</div>
</form>

</body>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>