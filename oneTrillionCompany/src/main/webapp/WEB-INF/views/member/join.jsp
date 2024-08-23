<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- 멀티페이지js -->
<script src="/js/multipage.js"></script>
<!-- 다음 지도 cdn -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
<script type="text/javascript">
        $(function(){
        	var certEmail;
            var status={
                memberIdValid:false,//형식검사
                memberIdCheckValid:false,//중복검사
                memberPwValid:false,
                memberPwCheck:false,
                memberNicknameValid:false,//닉네임 형식검사
                memberNicknameCheckValid:false,//닉네임 중복검사
                memberEmailValid:false,
                memberEmailCheckValid:false,//이메일 중복 검사
                memberTelValid:true,//선택항목
                memberBirthValid:true,//선택항목
                memberAddressValid:true,//선택항목
                ok:function(){return this.memberIdValid&&this.memberIdCheckValid&&this.memberPwValid&&this.memberPwCheck&&
                    this.memberNicknameValid&&this.memberEmailValid&&this.memberTelValid&&
                    this.memberBirthValid&&this.memberAddressValid&&this.memberEmailCheckValid
                }
            };
            $("[name=memberId]").blur(function(){
                //step1 : 아이디에 대한 형식 검사
                var regex=/^[a-z][a-z0-9]{7,19}$/;
                var target=$(this).val();
                $(this).removeClass("success fail fail2");
                status.memberIdValid=regex.test(target);
                //step2 : 아이디 중복 검사(형식이 올바른 경우만)
                if(status.memberIdValid){
                    // 비동기 통신으로 중복 검사 수행
                    $.ajax({
                        url:"/rest/member/checkId",
                        method:"post",
                        data:{memberId:target},
                        success: function(response){
                            status.memberIdCheckValid=response;
                            console.log("중복 확인 결과 : ",status.memberIdCheckValid);
                            if(status.memberIdCheckValid){
                                $("[name=memberId]").addClass("success")
                            }
                            
                            else
                                $("[name=memberId]").addClass("fail2")
                        }
                    });
                }
                else{
                        $("[name=memberId]").addClass("fail")
                }
            });
            $("[name=memberPw]").blur(function(){
                var regex=/^(?=(.*?)([0-9]))(?=(.*?)([A-Z]))(?=(.*?)([!@#$]))[!-~]{8,16}$/;
                var target=$(this).val();
                $(this).removeClass("success fail");
                status.memberPwValid=regex.test(target);
                if(status.memberPwValid){
                    $(this).addClass("success")
                }
                else{
                    $(this).addClass("fail");
                }
            });
            $(".pwInput2").blur(function(){
                var target1=$(this).val();
                var target2=$("[name=memberPw]").val();
                $(this).removeClass("success fail");
                status.memberPwCheck=target1===target2;
                $(this).addClass(status.memberPwCheck?"success":"fail");
            });
            $("[name=memberNickname]").blur(function(){
                var target=$(this).val();
                var regex=/^[가-힣0-9]{2,7}$/;
                status.memberNicknameValid=regex.test(target);
                $(this).removeClass("success fail fail2");
                if(status.memberNicknameValid){
                    $.ajax({
                        url:"/rest/member/checkNickname",
                        method:"post",
                        data:{memberNickname:target},
                        success:function(response){
                            status.memberNicknameCheckValid=response;
                            if(status.memberNicknameCheckValid){
                                $("[name=memberNickname]").addClass("success")
                            }
                            else{
                                $("[name=memberNickname]").addClass("fail2");
                            }
                        }
                    })
                }
                else{
                    $("[name=memberNickname]").addClass("fail")
                }
                
            });
            $("[name=memberEmail]").blur(function(){
                var target=$(this).val();
                status.memberEmailValid=target.length>0;
                $(this).removeClass("success fail");
                if(memberEmailValid){
                    $(this).addClass("success")
                }
                else{
                    $(this).addClass("fail");
                }
              
            });
          //이메일 인증 관련 처리
            $(".btn-cert-send").click(function(){
                //작성한 이메일을 불러온다
                var email = $("[name=memberEmail]").val();

                //step 2 - 작성한 이메일이 없으면 중단
                if(email.length==0) return;

                //step 3 - 서버로 이메일 발송을 요청(ajax)
                $.ajax({
                    url:"/rest/cert/send",
                    method:"post",
                    data:{
                        certEmail:email
                    },
                    beforeSend:function(){
                        console.log("전송 전");
                        $(".email-wrapper").nextAll(".cert-wrapper").remove();
                        $(".btn-cert-send").prop("disabled",true);
                        $(".btn-cert-send").find(".fa-solid")
                                            .removeClass("fa-paper-plane")
                                            .addClass("fa-spinner fa-spin");
                        $(".btn-cert-send").find("span").text("발송중");
                    },
                    complete:function(){
                       console.log("전송 후");
                       $(".btn-cert-send").prop("disabled",false);
                       $(".btn-cert-send").find(".fa-solid")
                                            .removeClass("fa-spinner fa-spin")
                                            .addClass("fa-paper-plane");
                        $(".btn-cert-send").find("span").text("보내기");
                    },
                    success:function(response){
                        //성공시점의 이메일을 저장
                        certEmail=email;
                        //인증번호 템플릿을 입력창 뒤에 추가
                        var template =$("#cert-template").text();
                        var html=$.parseHTML(template);
                        $(".email-wrapper").nextAll(".cert-wrapper").remove();
                        $(".email-wrapper").after(html);
                    }
                })
            });
            $("[name=telInput]").blur(function(){
                var target=$(this).val();
                var regex=/^010[1-9][0-9]{7}$/;
                status.memberTelValid=target.length==0||regex.test(target);
                $(this).removeClass("success fail");
                if(status.memberTelValid){
                    $(this).addClass("success")
                }
                else{
                    $(this).addClass("fail");
                }
            });
            $("[name=birthInput]").blur(function(){
                var target=$(this).val();
                status.memberBirthValid=target.length==0||target.length>0;
                $(this).removeClass("success fail");
                if(status.memberBirthValid){
                    $(this).addClass("success")
                }
                else{
                    $(this).addClass("fail");
                }
            });
            
            $("[name=memberAddress1],[name=memberAddress2],[name=memberPost]").blur(function(){
                var target1=$("[name=memberAddress1]").val();
                var target2=$("[name=memberAddress2]").val();
                var target3=$("[name=memberPost]").val();
                status.memberAddressValid=(target1.length==0&&target2.length==0&&target3.length==0)||(target1.length>0&&target2.length>0&&target3.length>0);
                $("[name=memberAddress1],[name=memberAddress2],[name=memberPost]").removeClass("success fail");
                if(status.memberAddressValid){
                    $("[name=memberAddress1],[name=memberAddress2],[name=memberPost]").addClass("success")
                }
                else{
                    $("[name=memberAddress1],[name=memberAddress2],[name=memberPost]").addClass("fail");
                }
            });
            $(".check-form").submit(function(){
                $("[name],.pwInputCheck").trigger();
                return status.ok();
            });
            //부가기능
            $(".field-show").change(function(){
                var checked=$(this).prop("checked");
                $("[name=memberPw],.pwInput2").attr("type",checked?"text":"password");
            });
            $(".fa-eye").click(function(){
               var checked=$(this).hasClass("fa-eye");
               if(checked){
                $(this).removeClass("fa-eye").addClass("fa-eye-slash");
               }
               else{
                $(this).removeClass("fa-eye-slash").addClass("fa-eye");
               }
            });
            $("[name=attach]").change(function(){
                //파일 태그에만 존재하는 files라는 항목에는 선택된 파일 정보가 담김
                // - length 가 0이냐 아니냐
                if(this.files.length==0){
                    $(this).parent().next().children("img").attr("src","https://placeholder.co/150?text=NoImage");
                }
                else{
                    var file=this.files[0];
                    var url = window.URL.createObjectURL(file);
                    $(this).parent().next().children("img").attr("src",url);
                }
            });
            $("[name=memberPost],[name=memberAddress1],.btn-find-address").click(function(){
                new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }


                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.querySelector("[name=memberPost]").value = data.zonecode;
                document.querySelector("[name=memberAddress1]").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.querySelector("[name=memberAddress2]").focus();
                $("[name=memberPost]").trigger("input");
            }
        }).open();
            });

            $(".btn-clear-address").click(function(){
                $("[name=memberPost],[name=memberAddress1],[name=memberAddress2]").val("");
            });
            $(".btn-clear-address").hide();
            $("[name=memberPost],[name=memberAddress1],[name=memberAddress2]").on("input",function(){
                var leng1=$("[name=memberAddress1]").val().length;
                var leng2=$("[name=memberAddress2]").val().length;
                var leng3=$("[name=memberPost]").val().length;
                if(leng1+leng2+leng3>0){
                    $(".btn-clear-address").show();
                }
                else
                    $(".btn-clear-address").hide();
            })
            //생년월일 입력창에 DatePicker 설정
            var picker = new Lightpick({
            field:document.querySelector("[name=memberBirth]"),
            firstDay:7,
            format: "yyyy-MM-DD",
            maxDate:moment()
          })
        });
     </script>
</head>
<body>
    <form class="check-form" action="#" method="post" autocomplete="off" enctype="multipart/form-data">
        <div class="container w-400 my-50">
        <div class="row center">
            <h1>회원가입</h1>
        </div>
<!--         <div class="row"> -->
<!--             <div class="progressbar"> -->
<!--                 <div class="guage"></div> -->
<!--             </div> -->
<!--         </div> -->
        <div class="row">
<!--             <div class="multipage"> -->
                <div class="page">
                    <div class="row left">
                        <label class="title">아이디 <i class="fa-solid fa-asterisk red"></i></label>
                        <input class="field w-100" name="memberId" type="text" placeholder="8~20자 영문 소문자와 숫자">
                        <div class="success-feedback">멋진 아이디네요!</div>
                        <div class="fail-feedback">아이디는 8~20자 영문 소문자와 숫자로 작성하세요</div>
                        <div class="fail2-feedback">아이디가 이미 사용중입니다</div>
                    </div>
<!--                     <div class="row float-box "> -->
<!--                         <button type="button" class="btn btn-positive btn-next float-right">다음</button> -->
<!--                     </div> -->
                </div>
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
                        <input class="field w-100  pwInput2" type="password" placeholder="같은 비밀번호를 입력">
                        <div class="success-feedback">비밀번호가 일치합니다</div>
                        <div class="fail-feedback">비밀번호가 일치하지 않습니다</div>
                    </div>
<!--                     <div class="row float-box"> -->
<!--                         <button type="button" class="float-left btn btn-positive btn-prev">이전</button> -->
<!--                         <button type="button" class="float-right btn btn-positive btn-next">다음</button> -->
<!--                     </div> -->
                </div>
                <div class="page">
                    <div class="row">
                        <label class="title">닉네임<i class="fa-solid fa-asterisk red"></i></label>
                        <input type="text" class="field w-100" name="memberNickname" placeholder="한글과 숫자로 이루어진 2~7글자 ">
                        <div class="success-feedback">멋진 닉네임입니다!</div>
                        <div class="fail-feedback">한글과 숫자로 이루어진 2~7글자여야 합니다</div>
                        <div class="fail2-feedback">사용중인 닉네임입니다</div>
                    </div>
<!--                     <div class="row float-box"> -->
<!--                         <button type="button" class="float-left btn btn-positive btn-prev">이전</button> -->
<!--                         <button type="button" class="float-right btn btn-positive btn-next">다음</button> -->
<!--                     </div> -->
                </div>
                	<div class="row title">
                		<h3>------선택 사항 입니다------</h3>
                	</div>
                <div class="page">
                    <div class="row">
				         <label class="title">이메일</label>
				         <!-- 입력창 -->
				         <div class="flex-box email-wrapper">
				             <input type="email" name="memberEmail" class="field w-100" style="flex-grow:1">
				             <button type="button" class="btn btn-neutral btn-cert-send" style="width:120px">
				                <i class="fa-solid fa-paper-plane"></i><span>보내기</span>
			           		 </button>
		         		</div>
	         		</div>
<!--                     <div class="row float-box"> -->
<!--                         <button type="button" class="float-left btn btn-positive btn-prev">이전</button> -->
<!--                         <button type="button" class="float-right btn btn-positive btn-next">다음</button> -->
<!--                     </div> -->
                </div>
                <div class="page">
                    <div class="row">
                        <label class="title">전화번호</label>
                        <input type="tel" class="field w-100" name="telInput" placeholder="숫자만 입력하세요">
                        <div class="fail-feedback">번호의 형식이 올바르지 않습니다</div>
                    </div>
                    <div class="row">
                        <label class="title">생년월일</label>
                        <input type="text" class="field w-100" name="memberBirth">
                    </div>
                    <div class="row">
                        <label class="title">연락처</label>
                        <input type="tel" class="field w-100">
                    </div>
<!--                     <div class="row float-box"> -->
<!--                         <button type="button" class="float-left btn btn-positive btn-prev">이전</button> -->
<!--                         <button type="button" class="float-right btn btn-positive btn-next">다음</button> -->
<!--                     </div> -->
<!--                 </div> -->
                <div class="page">
                    <div class="row">
                    	<label class="title">주소</label>
                        <div class="row">
                            <input type="text" class="field w-33" name="memberPost" placeholder="우편번호" readonly>
                            <button class="btn btn-neutral btn-find-address"><i class="fa-solid fa-magnifying-glass"></i></button>
                            <button class="btn btn-negative btn-clear-address">
                                <i class="fa-solid fa-xmark"></i>
                            </button>
                        </div>
                        <div class="row">
                            <input type="text" class="field w-100" name="memberAddress1" placeholder="기본주소" readonly>
                        </div>
                        <div class="row">
                            <input type="text" class="field w-100" name="memberAddress2" placeholder="상세주소">
                        </div>
                        <div class="fail-feedback">주소는 비워두거나 모두 입력해야 합니다.</div>
                    </div>
<!--                     <div class="row float-box"> -->
<!--                         <button type="button" class="float-left btn btn-positive btn-prev">이전</button> -->
<!--                         <button type="button" class="float-right btn btn-positive btn-next">다음</button> -->
<!--                     </div> -->
                </div>
<!--                 <div class="page"> -->
<!--                     <div class="row"> -->
<!--                         <label>프로필이미지 (선택) -->
<!--                             <input type="file" accept="image/*"name="attach" class="field w-100"> -->
<!--                         </label> -->
<!--                     </div> -->
<!--                     <div class="row"> -->
<!--                         <img src="https://placeholder.co/150?text=NoImage"> -->
<!--                     </div> -->
<!--                     <div class="row float-box"> -->
<!--                         <button type="button" class="float-left btn btn-positive btn-prev">이전</button> -->
<!--                     </div> -->
<!--                 </div> -->
            </div>
        <div class="row flex-core">
            <button type="submit" class="btn btn-positive btn-submit w-100">가입하기</button> 
            <div class="fail-feedback">모든 필수 항목을 입력해주세요</div>
        </div>
        </div>
<!--         </div> 멀티페이지 영역--> 
    </form>
</body>
</html>
<!-- 인증번호 템플릿 -->
	<script type="text/template" id="cert-template">
        <div class="flex-box mt-10 cert-wrapper">
            <input type="text" class="field cert-input w-33" placeholder="6자리 인증번호"></input>
            <button type="button" class="btn btn-neutral btn-cert-check">
                <i class="fa-solid fa-key"></i><span> 확인</span></button>
                <div class="fail-feedback">인증번호가 일치하지 않습니다</div>
        </div>
    </script>
</body>
</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>