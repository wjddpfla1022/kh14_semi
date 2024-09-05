<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>일조 쇼핑몰</title>

    
    <style>
        
    </style>
    <!-- 자바스크립트 코드 작성 영역 -->
     <script type="text/javascript">
        
     </script>
</head>
<body>
    <div class="container w-1200 my-50">
      <div class="row center">
         <h1>구매가 완료되었습니다!</h1>
      </div>
<!--       주문서 정보 -->
      <div class="container center" style="padding:0 0 200px 0">
         <h2>주문 번호 : ${ordersDto.orderNo}</h2>
         <div class="row">결제금액 : ${ordersDto.orderPrice}</div>
         <div class="row">주문날짜 : <fmt:formatDate value="${ordersDto.orderDate}" pattern="y년 MM월 dd일 E H시 mm분"/></div>
         <div class="row">배송 요청사항 : ${ordersDto.orderMemo}</div>
      </div>
      <div class="container center">
	      <table class="w-80" style="margin: 0 auto;text-align: center;">
			 <tbody class="left ">
					<c:forEach var="orderDetailDto" items="${detailList}">
						<tr style="padding:100px">
							<td>상세 주문 번호 : ${orderDetailDto.orderDetailNo}</td>
							<td>상품 이름 : ${orderDetailDto.orderDetailItemName}</td>
							<td>상품 가격 : ${orderDetailDto.orderDetailPrice}</td>
							<td>수량 : ${orderDetailDto.orderDetailCnt}</td>
							<td>상태 : ${orderDetailDto.orderDetailStatus}</td>
						</tr>
					</c:forEach>
				</tbody>
	      </table>
      </div>
    </div>
</body>
</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>