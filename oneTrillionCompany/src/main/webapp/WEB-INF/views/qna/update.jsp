<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    </style>
    
	<script type="text/javascript">
    
    </script>
    

    <form action="update" method="post" id="regi-form">
       <div class="container w-800 my-30">
            <div class="row center">
                <h2>1:1문의 등록</h2>
            </div>
	         <div class="row">
	            <input type="hidden" name="qnaNo" value="${qnaDto.qnaNo}">
	        </div>
            <!-- 문의 유형 선택 창 -->
            <div class="row">
                <select class="row qna-select w-100" name="qnaTitle" >
                	<option value="배송 문의" <c:if test="${qnaDto.qnaTitle == '배송 문의'}">selected</c:if>>배송 문의</option>
                    <option value="주문/결제 문의"  <c:if test="${qnaDto.qnaTitle == '주문/결제 문의'}">selected</c:if>>주문/결제 문의</option>
                    <option value="교환/환불 문의" <c:if test="${qnaDto.qnaTitle == '교환/환불 문의'}">selected</c:if>>교환/환불 문의</option>
                    <option value="기타 문의" <c:if test="${qnaDto.qnaTitle == '기타 문의'}">selected</c:if>>기타 문의</option>
                </select>
            </div>
            <!-- 내용 입력 창 -->
            <div class="row qna-write ">
                <textarea placeholder="내용을 입력하세요." name="qnaContent" >${qnaDto.qnaContent}</textarea>
            </div>
            <div class="row right">
                <button type="submit" class="btn btn-positive btn-regi">수정</button>
                <a href="/qna/detail?qnaNo=${qnaDto.qnaNo}" class="btn">취소</a>
            </div>
        </div>
    </form>
    
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
