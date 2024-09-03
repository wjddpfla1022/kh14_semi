<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>일조 쇼핑몰</title>

    
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
		.table-title {
			text-decoration: none;
			color: gray;
		}	
			/* tr 테이블 상단 (번호 ,작성일 , 제목 , 작성자) */
		.tr-table-top {
			background-color: #f0f0f0 !important;
		}
		/* th 테이블 상단 (번호 ,작성일 , 제목 , 작성자) */
		.th-table-top {
			padding: 10px !important;
			font-weight: bolder;
		}
		/* tr 테이블 하단(게시글 , 제목 , 작성자 ,작성일자) */
		.tr-table-bottom {
			border: 1px solid #e9e9e9;
		}
		/* td 테이블 하단(게시글 , 제목 , 작성자 ,작성일자) */
		.td-table-bottom {
			padding: 10px !important;
			font-size: 14px;
		}	
		.table {
			border: 1px solid #e9e9e9;
		}	
		/* 테이블 디자인 */
		.table tr {
			border: 1px solid #e9e9e9;
			border-bottom: none;
		}	
		.tr-table-top {
			background-color: #dcdde1;
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
         		<tr class="tr-table-top">
	         		<th width="15%" class="th-table-top">상품이름</th>
	         		<th width="10%" class="th-table-top">사이즈</th>
         			<th width="10%" class="th-table-top">수량</th>
         			<th width="10%" class="th-table-top">결제금액</th>
         			<th width="25%" class="th-table-top">결제 시간</th>
         			<th width="30%" class="th-table-top">배송원 참고사항</th>
         		</tr>
         	</thead>
         	<tbody>
         		<tr class="tr-table-bottom center">
	       			<td class="td-table-bottom">${orderDetailDto.orderDetailItemName}</td>
	       			<td class="td-table-bottom">${orderDetailDto.orderDetailCnt}</td>
	       			<td class="td-table-bottom"></td>
	       			<td class="td-table-bottom">${ordersDto.orderPrice}</td>
	       			<td class="td-table-bottom">
	       				<fmt:formatDate value="${ordersDto.orderDate}" pattern="y년 MM월 dd일 E H시 mm분"/>
	       			</td>
	       			<td >${ordersDto.orderMemo}</td>
       			</tr>
         	</tbody>
         </table>
      </div>
    </div>
</body>
</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>