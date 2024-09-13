<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- 멀티페이지js -->
<script src="${pageContext.request.contextPath}/js/multipage.js"></script>
<!-- 다음 지도 cdn -->
<script src="${pageContext.request.contextPath}//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
	.field{
		margin-bottom:1em;
		border-top:0px;
		border-left:0px;
		border-right:0px;
	}
	.title{
		font-weight: bold;
		margin-bottom:0.5em;
	}
</style>
 <script>
$(function(){
    //상태 객체
    var status = {
        memberIdValid : false, //형식검사
        memberIdCheckValid : false, //중복검사
        memberPwValid : false,
        memberPwCheckValid : false,
        memberNameValid:false,
        memberNicknameValid : false, //형식검사
        memberNicknameCheckValid : false, //중복검사
        memberEmailValid : false,
        memberEmailCheckValid : false,//이메일 인증검사
        memberContactValid : true , //선택항목
        memberBirthValid : true , //선택항목
        memberAddressValid : false , //필수항목
        ok : function(){
            return this.memberIdValid && this.memberIdCheckValid
                && this.memberPwValid && this.memberPwCheckValid 
                && this.memberNicknameValid && this.memberNicknameCheckValid
                && this.memberEmailValid && this.memberEmailCheckValid 
                && this.memberContactValid && this.memberBirthValid 
                && this.memberAddressValid;
        },
    };
    
    //입력창 검사
    $("[name=memberId]").blur(function(){
        //step 1 : 아이디에 대한 형식 검사
        var regex = /^[a-z][a-z0-9]{7,19}$/;
        var memberId = $(this).val();//this.value
        var isValid = regex.test(memberId);
        //step 2 : 아이디 중복 검사(형식이 올바른 경우만)
        if(isValid) {
            //비동기 통신으로 중복 검사 수행
            $.ajax({
                url:"${pageContext.request.contextPath}/rest/member/checkId",
                method:"post",
                data:{ memberId : memberId },
                success: function(response) {
                    //console.log("중복 확인 결과", response);
                    if(response) {//.success - 아이디가 사용가능한 경우
                        status.memberIdCheckValid = true;
                        $("[name=memberId]").removeClass("success fail fail2")
                                                            .addClass("success");
                    }
                    else {//.fail2 - 아이디가 이미 사용중인 경우
                        status.memberIdCheckValid = false;
                        $("[name=memberId]").removeClass("success fail fail2")
                                                            .addClass("fail2");
                    }
                },
            });
        }
        else {//.fail - 아이디가 형식에 맞지 않는 경우
            $("[name=memberId]").removeClass("success fail fail2")
                                                .addClass("fail");
        }
        status.memberIdValid = isValid;
    });
    $("[name=memberPw]").blur(function(){
        var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
        var isValid = regex.test($(this).val());
        $(this).removeClass("success fail")
                    .addClass(isValid ? "success" : "fail");
        status.memberPwValid = isValid;
    });
    $(".pwInput2").blur(function(){
        var isValid = $("[name=memberPw]").val().length
                        && $(this).val() == $("[name=memberPw").val();
        $(this).removeClass("success fail")
                    .addClass(isValid ? "success" : "fail");
        status.memberPwCheckValid = isValid;
    });
    $("[name=memberName]").blur(function() {
        var target = $(this).val();
        var regex = /^[가-힣]{2,7}$/;
        status.memberNameValid = regex.test(target);
        $(this).removeClass("success fail fail2");
        if (status.memberNameValid) {
            $(this).addClass("success");
        } else {
            $(this).addClass("fail");
        }
    });
    
    
    $("[name=memberNickname]").blur(function(){
        //step 1 : 닉네임 형식 검사
        var regex = /^[가-힣0-9]{2,10}$/;
        var memberNickname = $(this).val();
        status.memberNicknameValid = regex.test(memberNickname);
         
        //step 2 : 닉네임 중복 검사(형식이 올바른 경우)
        if(status.memberNicknameValid) {//닉네임이 형식에 맞는 경우
            $.ajax({
                url:"${pageContext.request.contextPath}/rest/member/checkNickname",
                method:"post",
                data: { memberNickname : memberNickname },
                success: function(response) {
                    //if(response == true) {//크게봤을 때 같다면
                    if(response === true) {//정확하게 같다면
                        status.memberNicknameCheckValid = true;
                        $("[name=memberNickname]").removeClass("success fail fail2")
                                                                    .addClass("success");
                    }
                    else {
                        status.memberNicknameCheckValid = false;
                        $("[name=memberNickname]").removeClass("success fail fail2")
                                                                    .addClass("fail2");
                    }
                }
            });
        }
        else {//닉네임이 형식에 맞지 않는 경우
            $("[name=memberNickname]").removeClass("success fail fail2")
                                                        .addClass("fail"); 
        }
        
    });
    
    //이메일 형식 검사
    var certEmail;
    
    $(".btn-cert-send").click(function(){
        //step 1 - 작성한 이메일을 불러온다
        var email = $("[name=memberEmail]").val();
        
        //step 2 - 작성한 이메일이 없으면 중단
        if(email.length == 0) {
			status.memberEmailValid = false;        	
        	return;
        }
        
       	status.memberEmailValid = true;
       	
        //step 3 - 서버로 이메일 발송을 요청(ajax)
        // - 통신 시작과 종료 시점을 찾아 버튼을 비활성화 처리
        $.ajax({
            url:"${pageContext.request.contextPath}/rest/cert/send",
            method:"post",
            data:{ certEmail : email },
            beforeSend: function(){
                //console.log("전송 전");
                $(".email-wrapper").nextAll(".cert-wrapper").remove();
                $(".btn-cert-send").prop("disabled", true);
                $(".btn-cert-send").find(".fa-solid")
                                            .removeClass("fa-paper-plane")
                                            .addClass("fa-spinner fa-spin");
                $(".btn-cert-send").find("span").text("발송중");
            },
            complete:function(){
                //console.log("전송 후");
                $(".btn-cert-send").prop("disabled", false);
                $(".btn-cert-send").find(".fa-solid")
                                            .removeClass("fa-spinner fa-spin")
                                            .addClass("fa-paper-plane");
                $(".btn-cert-send").find("span").text("보내기");
            },
            success:function(response){
                //성공시점의 이메일을 저장
                certEmail = email;

                //인증번호 템플릿을 이메일 입력창 뒤에 추가
                var template = $("#cert-template").text();
                var html = $.parseHTML(template);
                
                $(".email-wrapper").after(html);
            },
        });
    });

    //인증확인 버튼에 대한 이벤트
    //$(".btn-cert-check").click(function(){});//안걸림
    $(document).on("click", ".btn-cert-check", function(){
	    var currentEmail = $("[name=memberEmail]").val();
	    if(certEmail != currentEmail) {
	        window.alert("이메일을 수정하여 다시 인증해야 합니다");
	        $(".cert-wrapper").remove();
	        return;
	    }
	
	    var certNumber = $(".cert-input").val();
	    var regex = /^[0-9]{6}$/;
	    if(regex.test(certNumber) == false) {//인증번호가 형식에 맞지 않으면
	        return;//진행 중지
	    }
	
	    //서버에 검사를 요청
	    $.ajax({
	        url:"${pageContext.request.contextPath}/rest/cert/check",
	        method:"post",
	        data: {
	            certEmail : certEmail,
	            certNumber : certNumber,
	        },3
	        success:function(response) {
	        console.log(response);
	            if(response == true) {//인증 성공 - 화면을 제거 + 인증버튼 제거
	                $(".cert-wrapper").remove();
	                //(선택) 이메일 잠금처리 및 보내기 버튼 삭제
	                $("[name=memberEmail]").prop("readonly", true);
	                $(".btn-cert-send").remove();
	                //상태객체 값을 갱신
	                status.memberEmailCheckValid = true;
	            }
	            else {//인증 실패 - 번호가 틀린거니 화면을 유지시킨다
	                $(".cert-input").removeClass("success fail").addClass("fail");
	                //상태객체 값을 갱신
	                status.memberEmailCheckValid = false;
	            }
	        },
	    });
	});
    
    
    //연락처 형식 검사
    $("[name=memberContact]").blur(function(){
        var regex = /^010[1-9][0-9]{7}$/;
        var isValid = $(this).val().length == 0 || regex.test($(this).val());
        $(this).removeClass("success fail")
                    .addClass(isValid ? "success" : "fail");
        status.memberContactValid = isValid;
    });
    $("[name=memberBirth]").blur(function(){
        var regex = /^([0-9]{4})-(02-(0[1-9]|1[0-9]|2[0-9])|(0[469]|11)-(0[1-9]|1[0-9]|2[0-9]|30)|(0[13578]|1[02])-(0[1-9]|1[0-9]|2[0-9]|3[01]))$/;
        var isValid = $(this).val().length == 0 || regex.test($(this).val());
        $(this).removeClass("success fail")
                    .addClass(isValid ? "success" : "fail");
        status.memberBirthValid = isValid;
    });
    //주소는 모두 없거나 모두 있거나 둘 중 하나면 통과
    $("[name=memberPost],[name=memberAddress1],[name=memberAddress2]").blur(function(){
        var memberPost = $("[name=memberPost]").val();
        var memberAddress1 = $("[name=memberAddress1]").val();
        var memberAddress2 = $("[name=memberAddress2]").val();

        var isValid = memberPost.length > 0
        && memberAddress1.length > 0
        && memberAddress2.length > 0;
        $("[name=memberPost],[name=memberAddress1],[name=memberAddress2]")
                    .removeClass("success fail")
                    .addClass(isValid ? "success" : "fail");
        status.memberAddressValid = isValid;
    });

    //폼 검사
    $(".check-form").submit(function(){
        $("[name], #password-check").trigger("input").trigger("blur");
        return status.ok();
    });

    //부가기능
    $(".field-show").change(function(){
        var checked = $(this).prop("checked");
        $("[name=memberPw] , #password-check")
                    .attr("type", checked ? "text" : "password");
    });
    $(".fa-eye").click(function(){
        var checked = $(this).hasClass("fa-eye");
        if(checked) {
            $(this).removeClass("fa-eye").addClass("fa-eye-slash");
            $("[name=memberPw] , #password-check").attr("type", "text");
        }
        else {
            $(this).removeClass("fa-eye-slash").addClass("fa-eye");
            $("[name=memberPw] , #password-check").attr("type", "password");
        }
    });


    $("[name=memberPost],[name=memberAddress1], .btn-find-address")
    .click(function(){
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = ''; // 주소 변수

                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                document.querySelector("[name=memberPost]").value = data.zonecode;
                document.querySelector("[name=memberAddress1]").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.querySelector("[name=memberAddress2]").focus();
                $("[name=memberPost]").trigger("input");
            }
        }).open();
    });

    $(".btn-clear-address").click(function(){
        $("[name=memberPost]").val("");
        $("[name=memberAddress1]").val("");
        $("[name=memberAddress2]").val("");
    });

    $(".btn-clear-address").hide();
    $("[name=memberPost],[name=memberAddress1],[name=memberAddress2]")
    .on("input", function(){
        var len1 = $("[name=memberPost]").val().length;
        var len2 = $("[name=memberAddress1]").val().length;
        var len3 = $("[name=memberAddress2]").val().length;
        if(len1 + len2 + len3 > 0) {
            $(".btn-clear-address").fadeIn();
        }
        else {
            $(".btn-clear-address").fadeOut();
        }
    });

    //엔터 차단 코드
    $(".check-form").find(".field").keypress(function(e){
        switch(e.keyCode) {
            case 13: return false;
        }
    });

    //생년월일 입력창에 DatePicker 설정
    var picker = new Lightpick({
        field: document.querySelector("[name=memberBirth]"),//설치대상
        format: "YYYY-MM-DD",//날짜의 표시 형식(momentJS 형식)
        firstDay:7,//일요일부터 표시
        maxDate: moment(),//종료일을 오늘로 설정
    });
});
</script>

<!-- 인증번호 템플릿 -->
<script type="text/template" id="cert-template">
	<div class="flex-box mt-10 cert-wrapper">
    	<input type="text" class="field cert-input mb-0" placeholder="인증번호 입력">
        <button type="button" class="btn btn-neutral btn-cert-check">
            <i class="fa-solid fa-key"></i>
            <span>확인</span>
        </button>
        <div class="fail-feedback">인증번호가 일치하지 않습니다</div>
    </div>
</script>


<div class="container w-500 my-50">
    <div class="row center">
        <h1>회원 가입</h1>
    </div>

    <form class="check-form" action="join" method="post"autocomplete="off" enctype="multipart/form-data">
    	<div class="row">
    		<%-- 아이디 설정  --%>
                <div class="page">
                    <div class="row left">
                        <label class="title">아이디 <i class="fa-solid fa-asterisk red"></i></label>
                        <input class="field w-100" name="memberId" type="text" placeholder="8~20자 영문 소문자와 숫자">
                        <div class="success-feedback">멋진 아이디네요!</div>
                        <div class="fail-feedback">아이디는 8~20자 영문 소문자와 숫자로 작성하세요</div>
                        <div class="fail2-feedback">아이디가 이미 사용중입니다</div>
                    </div>
                </div>
            <%-- 비밀번호 설정 --%>
                <div class="page">
                    <div class="row left">
                        <label class="title">비밀번호 <i class="fa-solid fa-asterisk red"></i>
                            <input type="checkbox" class="field-show"><i class="fa-solid fa-eye"></i>
                        </label>
                        <input class="field w-100" name="memberPw" type="password" placeholder="영문대소문자, 숫자, 특수문자를 포함한 8~16자">
                        <div class="success-feedback">올바른 형식의 비밀번호입니다</div>
                        <div class="fail-feedback">비밀번호는 영문대소문자, 숫자, 특수문자를 반드시 포함한 8~16자로 작성하세요</div>
                    </div>
                    <div class="row left">
                        <label class="title">비밀번호 확인 <i class="fa-solid fa-asterisk red"></i></label>
                        <input class="field w-100  pwInput2" type="password" placeholder="비밀번호 재입력">
                        <div class="success-feedback">비밀번호가 일치합니다</div>
                        <div class="fail-feedback">비밀번호가 일치하지 않습니다</div>
                    </div>
                </div>
                <%-- 이름 설정 --%>
                <div class="page">
                	<div class="row">
                		<label class="title">이름<i class="fa-solid fa-asterisk red"></i></label>
                		<input type="text" class="field w-100" name="memberName">
                	</div>
                </div>            
            <%-- 닉네임 설정 --%>
                <div class="page">
                    <div class="row">
                        <label class="title">닉네임<i class="fa-solid fa-asterisk red"></i></label>
                        <input type="text" class="field w-100" name="memberNickname" placeholder="한글과 숫자로 이루어진 2~7글자 ">
                        <div class="success-feedback">멋진 닉네임입니다!</div>
                        <div class="fail-feedback">한글과 숫자로 이루어진 2~7글자여야 합니다</div>
                        <div class="fail2-feedback">사용중인 닉네임입니다</div>
                    </div>
                </div>
                
                <%-- 이메일 설정 --%>
            <div class="page">
	            <div class="row">
		            <label class="title">이메일<i class="fa-solid fa-asterisk red"></i></label>
		            <!-- 입력창 -->
		            <div class="flex-box email-wrapper">
		                <input type="email" name="memberEmail" class="field mb-0" style="flex-grow: 1;">
		                <button type="button" class="btn btn-neutral btn-cert-send mb-0" style="min-width: 120px;">
		                    <i class="fa-solid fa-paper-plane"></i>
		                    <span>보내기</span>
		                </button>
		            </div>
		        </div>
            </div>
            <%-- 연락처 설정 --%>
            <div class="page">
                <div class="row">
                    <label class="title">연락처(선택)</label>
                    <input type="text" name="memberContact" class="field w-100"
                                placeholder="010XXXXXXXX">
                    <div class="fail-feedback">입력한 번호가 형식에 맞지 않습니다</div>
                </div>
				<%-- 생년월일 설정 --%>
                <div class="row">
                    <label class="title">생년월일(선택)</label>
                    <input type="text" name="memberBirth" class="field w-100">
                </div>
            </div>
            <%-- 주소 설정 --%>
            <div class="page">
                    <div class="row">
                    	<label class="title">주소<i class="fa-solid fa-asterisk red"></i></label>
                        <div class="row">
                            <input type="text" class="field w-33 mb-0" name="memberPost" placeholder="우편번호" readonly>
                            <button type="button" class="btn btn-neutral btn-find-address"><i class="fa-solid fa-magnifying-glass"></i></button>
                            <button type="button" class="btn btn-negative btn-clear-address">
                                <i class="fa-solid fa-xmark"></i>
                            </button>
                        </div>
                        <div class="row">
                            <input type="text" class="field w-100 mb-0" name="memberAddress1" placeholder="기본주소" readonly>
                        </div>
                        <div class="row">
                            <input type="text" class="field w-100" name="memberAddress2" placeholder="상세주소">
	                        <div class="fail-feedback">주소는 필수 입력사항 입니다</div>
                        </div>
                    </div>
            </div>
            <%-- 회원가입 버튼 설정 --%>
               <div class="row flex-core">
                       <button type="submit" class="btn btn-positive">회원가입</button>
                       <div class="fail-feedback">모든 필수 항목을 입력해주세요</div>
               </div>
        </div>
	 </form>
</div>
    

</body>
</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>