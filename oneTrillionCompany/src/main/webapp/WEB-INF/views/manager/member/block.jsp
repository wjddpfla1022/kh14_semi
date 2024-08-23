<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
      
    <style>
        /* 모달 스타일 */
        .blockModal {
            position: fixed;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -95%);
            background-color: white;
            padding: 10px 20px;
        }
        .modal-content {
            background-color: #fff;
            border-radius: 0.75em;
            padding: 10px 10px;
            border: 1px solid #888;
            font-size: 15px;
            width: 400px;
            text-align: center;
            margin: auto;
            position: relative;
        }
        .btn-confirm {
            display: inline-block;
            padding: 10px 13px;
            font-size: 17px;
            color: #fff;
            background-color: #007bff; 
            border: none;
            border-radius: 5px; 
            text-decoration: none;
            cursor: pointer;
        }
        .btn-cancel {
            position: absolute;
            top: 10px;
            right: 10px;
            color: #888;
            text-decoration: none;
            font-size: 10px;
            cursor: pointer;
        }
        .btn-cancel:hover {
            color: black;
        }
        .row > textarea {
            resize: none;
            min-height: 200px;
            font-size : 17px;
            min-width : 100%;
        }
        .member_block {
        	font-size : 17px;
        	padding : 10px 20px
        }
    </style>

    <!--jquery cdn-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    
    <script type="text/javascript">
        $(function(){
            var memberId;

            $(".member_block").click(function(){
            	memberId = $('#idValue').val();   //클릭된 버튼의 memberId 값을 가져옴
            	console.log(memberId);
                $("#blockModal").show();
                $("#modalMessage").text(memberId + "을(를) 차단하시겠습니까?"); //모달 메시지 설정
            });
          //확인 버튼을 누르면 form 제출
            $(".btn-confirm").click(function(){ 
                $("#blockForm").submit();
            });
            // X 버튼 클릭 시 모달창을 닫음
            $(".btn-cancel").click(function(e){ 
                e.preventDefault();
                $("#blockModal").hide();
            });
        });
    </script>

</head>
<body>
    <form action="block" method="post" id="blockForm">
        <div class="container w-600 my-30">
   	        <div class="row center">
	        	<h1>${param.memberId}에 대한 차단 해제 설정</h1>
	        </div>
        	<div class="row center">
	            <input type="text" id="idValue" name="blockMemberId" value="${param.memberId}">
	            <textarea name="blockMemo" placeholder="차단 사유를 입력하세요" rows="10" cols="60"></textarea>
	            <div>
	                <button type="button" class="member_block">차단</button>
	            </div>
            </div>
        </div>

        <!-- Modal 코드 작성-->
        <div class="blockModal" id="blockModal" style="display:none;">
            <div class="modal-content">
                <a href="#" class="btn-cancel">
                    <i class="fa-solid fa-xmark"></i>
                </a>
                <p id="modalMessage"></p>
                <div class="modal-buttons center">
                    <a href="#" class="block btn-confirm">확인</a>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
