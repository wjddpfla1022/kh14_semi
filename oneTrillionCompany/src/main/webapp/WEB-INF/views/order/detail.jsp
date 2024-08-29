<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>일조 쇼핑몰</title>

    
    <style>
        h1 {
            font-size: 28px;
            margin-bottom: 20px;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        thead {
            background-color: #ddd;
            color: white;
        }
        th, td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        th {
            font-size: 18px;
        }
        td {
            font-size: 16px;
            color: #555;
        }
    </style>
    <!-- 자바스크립트 코드 작성 영역 -->
     <script type="text/javascript">
        
     </script>
</head>
<body>
    <div class="container w-1200 my-50" style="min-height:620px">
      <div class="row center">
         <h1>결제 내역 상세</h1>
      </div>
      <div class="flex-box  w-100 flex-core">
         <table >
         	<thead>
         		<tr>
         			<th>결제시간</th>
         			<th>총 결제금액</th>
         			<th>배송원 참고사항</th>
         		</tr>
         	</thead>
         	<tbody>
         		<tr>
	       			<td>${ordersDto.orderDate}</td>
	       			<td>${ordersDto.orderPrice}</td>
	       			<td>${ordersDto.orderMemo}</td>
       			</tr>
         	</tbody>
         </table>
      </div>
    </div>
</body>
</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>