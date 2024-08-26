<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>일조 쇼핑몰</title>

      <!-- my css -->
      <link rel="stylesheet" type="text/css" href="./commons.css">
      <!-- <link rel="stylesheet" type="text/css" href="./test.css"> -->
      
    <style>
       .orderpage >.container{
            margin: 50px auto;
            background-color: #dfe6e9;
            border-radius:0.5em;
        } 
        .field{
            border-radius:0.5em;
            background-color: transparent;
        }
        .ordersHeader{
            justify-content: center; 
            align-items: center;
        }
        .title{
            font-size:28px;
            font-weight:bold;
        }
        .title2{
            font-size:24px;
        }
        .request-detail{
            border:0.1em solid #b2bec3; 
        }
        .modal{
            margin:0;
            padding:0;
        }
        .modal > .row{
            margin:0 !important;
            padding:0 !important;
        }
    </style>

    <!-- 자바스크립트 코드 작성 영역 -->
     <script type="text/javascript">
         document.getElementById('requestMemo').addEventListener('change', function() {
        var memoContainer = document.getElementById('memoContainer');
        var memoDiv = memoContainer.querySelector('.memo');
        var selectedValue = this.value;

        if (selectedValue === 'lookAtThis') {
            memoDiv.innerHTML = '<input type="text" class="field w-100" style="border-top:1px solid #636e72" placeholder="직접 입력하세요">';
        } else {
            var selectedText = this.options[this.selectedIndex].text;
            memoDiv.textContent = selectedText;
        }
    });
     </script>
</head>
<body>
	<div class="orderpage w-100 my-10 mx-30 float-box">
        <div class="ordersHeader row w-100">
            <div class="logo float-left mx-10">
                <img src="https://picsum.photos/70/70" style="width:50px;height:50px;">
            </div>
            <div class="center float-center title">
                주문/결제            
            </div>
        </div>
        <div class="row right">
            <div class="flex-right px-50">
                장바구니 > <div style="font-weight:bold">주문/결제</div> > 완료
            </div>

        </div>
        <div class="flex-box w-60">
            <div class="container w-600 my-20">
                <div class="row title2 p-20">
                    <label>배송지</label>
                </div>
                <div class="float-box p-10 mx-30">
                    <div class="row">
                        ${memberDto.memberName}
                    </div>
                    <div class="row">
                        ${memberDto.memberContact}
                        <input type="checkbox">
                        안심번호 사용
                    </div>
                    <div class="row">
                        ${memberDto.memberAddress1} ${memberDto.memberAddress2} (${memberDto.memberPost})
                    </div>
                    <hr>
                    <div class="row">
                        <input class="field" type="checkbox"> 배송메모 개별 입력
                    </div>
                    <div class="row">
                        <div class="container request-detail">
                                <select class="field w-100" name="requestMemo">
                                    <option value="noSelect">선택 안 함</option>
                                    <option value="lookAtThis">직접 입력하기</option>
                                    <option value="door">부재시 문앞에 두고 가주세요</option>
                                    <option value="home">부재시 집앞에 두고 가주세요</option>
                                    <option value="contact">부재시 연락 부탁드려요</option>
                                    <option value="beforeTaegbae">배송시 연락주세요</option>
                                </select>
                                <c:choose>
                                    <c:when test="${param.requestMemo =='lookAtThis'}">
                                        <input type="text" class="field w-100" style="border-top:1px border #636e72">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="memo"></div>
                                    </c:otherwise>
                                </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="flex-box modal w-30">
            <div class="row">
                <div class="container w-100" style="min-height:200px"></div>
            </div>
        </div>
    </div>
    </body>
    </html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>