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
        .link {
        text-decoration: none;
        color: gray;
    	}

	    .link:hover {
	        color: black;
	    }
    </style>
    <!-- 자바스크립트 코드 작성 영역 -->
     <script type="text/javascript">
        
     </script>
</head>
<body>
    <div class="container w-1200 my-50" style="min-height:620px">
      <div class="row center">
         <h1>${memberId}님 주문 목록</h1>
      </div>
      <div class="row w-100 mb-50">
         <table style="width:100%">
         	<thead>
         		<tr class="tr-table-top">
         			<th width=20%; class="th-table-top">상품</th>
         			<th width=10%; class="th-table-top">수량</th>
         			<th width=20%; class="th-table-top">결제금액</th>
         			<th width=25%; class="th-table-top">상태</th>
         			<th width=25%; class="th-table-top">상세</th>
         		</tr>
         	</thead>
         	<tbody>
         		<c:forEach var="orderDetailDto" items="${detailList}">
	        		<tr class="tr-table-bottom center">
	        			<td class="td-table-bottom">${orderDetailDto.orderDetailItemName}</td>
	        			<td class="td-table-bottom">${orderDetailDto.orderDetailCnt}</td>
	        			<td class="td-table-bottom">${orderDetailDto.orderDetailPrice*orderDetailDto.orderDetailCnt}</td>
	        			<td class="td-table-bottom">${orderDetailDto.orderDetailStatus}</td>
	        			<td class="td-table-bottom">
	        				<a href="/order/detail?orderNo=${orderDetailDto.orderDetailOrderNo}" class="link">결제상세</a>
	        				<a href="/review/write?orderDetailNo=${orderDetailDto.orderDetailNo}" class="link">리뷰작성</a>
	        				<a href="/refund/insert?refundOrderDetailNo=${orderDetailDto.orderDetailNo}" class="link">환불신청</a>
	        			</td>	        			
         		</c:forEach>
         	</tbody>
         </table>
      </div>
     <hr>
      <div class="row center mt-50">
         <h1>환불 목록</h1>
      </div>
      <div class="row w-100">
         <table style="width:100%">
         	<thead>
         		<tr class="tr-table-top">
         			<th width=20%; class="th-table-top">상품</th>
         			<th width=10%; class="th-table-top">수량</th>
         			<th width=20%; class="th-table-top">결제금액</th>
         			<th width=25%; class="th-table-top">상태</th>        			
         		</tr>
         	</thead>
         	<tbody>
         		<c:forEach var="orderDetailDto" items="${refundList}">
	        		<tr class="tr-table-bottom center">
	        			<td class="td-table-bottom">${orderDetailDto.orderDetailItemName}</td>
	        			<td class="td-table-bottom">${orderDetailDto.orderDetailCnt}</td>
	        			<td class="td-table-bottom">${orderDetailDto.orderDetailPrice*orderDetailDto.orderDetailCnt}</td>
	        			<td class="td-table-bottom">${orderDetailDto.orderDetailStatus}</td>
	        		</tr>
         		</c:forEach>
         	</tbody>
         </table>
         <!-- 장바구니 제거될 수량 정보 -->
         <c:forEach var="connectionOCDto" items="${connectionList}">
         	<input type="hidden" name="cartNoByConnection" value="${connectionOCDto.cartNo}">
         	<input type="hidden" name="buyerByConnection" value="${connectionOCDto.buyer}">
         	<input type="hidden" name="cntByConnection" value="${connectionOCDto.cntPayment}">
         </c:forEach>
      </div>
    </div>
</body>
</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>