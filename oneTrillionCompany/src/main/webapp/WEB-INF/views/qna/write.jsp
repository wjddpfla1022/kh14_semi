<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

  <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

   <style>
        .flex-box {
            display: flex;
            align-items: center; /* 세로 중앙 정렬 */
        }

        /* 제목 */
        .flex-box > .field {
            font-size: 14px; 
            height: 50px; 
            display: flex;
            padding-left: 20px;
            align-items: center; /* 세로 중앙 정렬 */
            border-right: none;
        }
        /* 문의 유형 선택창*/
        .qna-select {
            height: 30px; 
            padding: 5px;
            font-size: 13px; 
        }
        /* textarea 설정 */
        .qna-write > textarea{
            resize: none;
            min-width: 500px;
            min-height: 150px;
            width: 100%;
            padding-top: 0.5em;
        }

         /* 모달 스타일 */
         .regiModal {
            position: fixed;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
        }
        .modal-content {
            background-color: #fff;
            border-radius: 0.75em;
            padding: 10px 10px;
            border: 1px solid #888;
            font-size: 13px;
            width: 300px;
            text-align: center;
            margin: auto;
            position: relative;
        }
        .btn-confirm {
            display: inline-block;
            padding: 10px 13px;
            font-size: 11px;
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
    </style>
    
	<script type="text/javascript">
    
        $(function(){

            $(".btn-regi").click(function(){
                $(".regiModal").show();
                $("#modalMessage").text("등록하시겠습니까?"); //모달 메시지 설정
            });
          //확인 버튼을 누르면 form 제출
            $(".btn-confirm").click(function(){ 
                $("#regi-form").submit();
            });
            // X 버튼 클릭 시 모달창을 닫음
            $(".btn-cancel").click(function(e){ 
                e.preventDefault();
                $(".regiModal").hide();
            });
        });
    </script>
    
</head>
	<body>
	    <form action="write" method="post" id="regi-form">
       <div class="container w-700 my-30">
            <div class="row center">
                <h2>1:1문의 등록</h2>
            </div>
            <!-- 문의 유형 선택 창 -->
            <div class="row">
                <select class="row qna-select w-100" name="qnaTitle" >
                    <option value="">문의 유형을 선택해주세요.</option>
                    <option value="배송 문의">배송 문의</option>
                    <option value="주문/결제 문의">주문/결제 문의</option>
                    <option value="교환/환불 문의">교환/환불 문의</option>
                    <option value="기타 문의">기타 문의</option>
                </select>
            </div>
            <!-- 내용 입력 창 -->
            <div class="row qna-write ">
                <textarea placeholder="내용을 입력하세요." name="qnaContent"></textarea>
            </div>
            <div class="row right">
                <button type="button" class="btn btn-positive btn-regi">등록</button>
            </div>
        </div>

            <!-- Modal 코드 작성-->
            <div class="regiModal" style="display:none;">
                <div class="modal-content">
                    <a href="#" class="btn-cancel">
                        <i class="fa-solid fa-xmark"></i>
                    </a>
                    <p id="modalMessage"></p>
                    <div class="modal-buttons center">
                        <a href="#" class="regi btn-confirm">확인</a>
                    </div>
                </div>
            </div>
	    </form>
	</body>
</html>
