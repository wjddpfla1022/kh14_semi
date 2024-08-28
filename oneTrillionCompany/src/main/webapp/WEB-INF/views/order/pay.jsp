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
      <link rel="stylesheet" type="text/css" href="/css/commons.css">
      <!-- <link rel="stylesheet" type="text/css" href="./test.css"> -->
      <!--  font awesome cdn -->
      <link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <style>
    	.orderpage{
    		display:flex;
    		flex-direction:column;
    		min-width:1152px;
    		min-height:100%;
    		background-color:#f3f5f7;
    	}
    	.area-address{
    	    font-size: 16px;
		    line-height: 22px;
		    letter-spacing: -0.3px;
		    margin-top: 8px;
		    color: #404048;
		    font-weight: 500;
		    word-wrap: break-word;
    	}
    	.container{
		    margin-top: 12px;
		    padding: 20px 16px;
		    border-radius: 12px;    
		    background-color:white;
		    	
    	}
    </style>
	<!-- jquery cdn -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- 자바스크립트 코드 작성 영역 -->
     <script type="text/javascript">
        $(function(){
                var selectedValue = $("select[name='requestMemo']").val();
                var memoContainer = $(".memo");
                
                if (selectedValue === 'lookAtThis') {
                    memoContainer.html('<input type="text" class="field w-100" style="border-top:1px solid #636e72" placeholder="직접 입력하세요">');
                } 
                else {
                    var selectedText = $("select[name='requestMemo'] option:selected").text();
                    memoContainer.text(selectedText);
                }
        });
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
	            <div class="flex-box loca-now px-50">
	                장바구니 > <div style="font-weight:bold">주문/결제</div> > 완료
	            </div>
	        </div>
        <form action="pay" method="post">
	        <div class="flex-box w-100">
	            <div class="container w-500 my-20">
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
	                    <div class="area-address">
	                    <c:choose>
							<c:when test="${memberDto.memberAddress1!=null}">
	                        	${memberDto.memberAddress1} ${memberDto.memberAddress2} (${memberDto.memberPost})
							</c:when>
							<c:otherwise>
								아래에 주소를 입력해주세요
							</c:otherwise>	                    
	                    </c:choose>
	                    
	                    </div>
	                    <hr>
	                    <div class="row">
	                        <input class="field" type="checkbox"> 배송메모 개별 입력
	                    </div>
	                    <div class="row">
	                        <div class="container request-detail">
	                                <select class="field w-100" name="order_memo">
	                                    <option value="noSelect">선택 안 함</option>
	                                    <option value="lookAtThis">직접 입력하기</option>
	                                    <option value="door">부재시 문앞에 두고 가주세요</option>
	                                    <option value="home">부재시 집앞에 두고 가주세요</option>
	                                    <option value="contact">부재시 연락 부탁드려요</option>
	                                    <option value="beforeTaegbae">배송시 연락주세요</option>
	                                </select>
	                                <c:choose>
	                                    <c:when test="${param.order_memo =='lookAtThis'}">
	                                        <input type="text" class="field w-100" style="border-top:1px border #636e72">
	                                    </c:when>
	                                    <c:otherwise>
	                                        <input type="text" class="memo field w-100" readonly style="border-top:1px border #636e72">
	                                    </c:otherwise>
	                                </c:choose>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	            <div class="row">
	                <div class="container" style="width:350px;height:2000px">
	                	<div class="row title">
	                		결제상세
	                		<div class="container">
	                			<div class="row w-100">
		                		<div class="flex-box column-2 w-100" style="font-size:18px">
		                			<div class="row">
			                			포인트 결제
		                			</div>
		                			<div class="row right">
		                				${memberDto.memberPoint} <i class="fa-solid fa-coins"></i>
		                			</div>
		                			</div>
		                		</div>
	                		</div>
	                	</div>
	                </div>
	            </div>
        </form>
    </div>
    </body>
    </html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>