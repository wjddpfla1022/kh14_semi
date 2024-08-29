<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <div class="container w-100 my-50">
      <div class="row center">
         <h1>주문 목록</h1>
      </div>
      <div class="row w-100">
         <table style ="width:100%" border="1">
         	<thead>
         		<tr>
         			<th width=30%;>상품명</th>
         			<th width=20%;>수량</th>
         			<th width=50%;>결제금액</th>
         		</tr>
         	</thead>
         	<tbody>
         		<c:forEach var="orderDetailDto" items="${detailList}">
	        		<tr>
	        			<td>${orderDetailDto.orderDetail}</td>
	        			<td>${orderDetailDto.orderDetailCnt}</td>
	        			<td>${orderDetailDto.orderDetailPrice*orderDetailDto.orderDetailCnt}</td>
	        		</tr>
         		</c:forEach>
         	</tbody>
         </table>
      </div>
    </div>
</body>
</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>