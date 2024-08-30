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
            min-height: 150px;
            width: 100%;
            padding-top: 0.5em;
        }
    </style>
    
	<script type="text/javascript">
    
	$(function(){
		$(".btn-regi").click(function(e){
			e.preventDefault();
			
			/* 문의 유형 선택이 되지 않은경우 메시지 출력 */
			var choice = $("select[name=qnaTitle]").val();
			if(choice=== "") {
				window.alert("문의 유형을 선택해주세요.")
				return;
			}
			/* 작성된 내용이 없는경우 메시지 출력 */
			var noText = $("textarea[name=qnaContent]").val().trim();
			if(noText.length == 0) {
				window.alert("문의 내용을 작성해주세요.");
				return;
			}
			
			var regi = window.confirm("등록하시겠습니까?");
            if (regi) {
                // 확인을 클릭한 경우 폼 제출
                $("#regi-form").submit();
            }
            // 취소 버튼을 누를 경우 동작X
		});
	});
    </script>
    

    <form action="write" method="post" id="regi-form">
       <div class="container w-800 my-30">
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
                <a href="/qna/list" class="btn">취소</a>
            </div>
        </div>
    </form>

