<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page= "/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	.link-box {
		width: 100%;
	}
	.link-box a {
		width: 150px;
		text-align: center; 
	}
</style>

<div class="container w-1200 my-50">
	<div class="row center">
		<h1>장바구니</h1>
	</div>
	
	<!-- 장바구니 목록 -->
	<table border="1" width="1200">
		<thead>
			<tr>
				<th>
					<input type="checkbox">
				</th>
				<th>이미지</th>
				<th>상품정보</th>
				<th>판매가</th>
				<th>수량</th>
				<th>배송구분</th>
				<th>배송비</th>
				<th>합계</th>
				<th>선택</th>
			</tr>
		</thead>
			
		<tbody class="center">
			<!-- cartList 반복문 -->
			<c:forEach var="cart"  items="${cartList}">
				<tr>
					<td>
						<input type="checkbox"  name="cartNo" value="${cart.cartItemNo}">
					</td>
					<td>
						<a href="#"> <img src="https://via.placeholder.com/20"></a> <!-- 임시 이미지 -->
					</td>
					<!-- itemList 반복문 -->
					<c:forEach var="item"  items="${itemList}">
						<c:if test="${item.itemNo == cart.cartItemNo}"> <!-- item과 cart 일치한지 확인 -->
							<td>${item.itemName}</td> 
							<td>${item.itemPrice}</td>
						</c:if>
					</c:forEach>
					<td>${cart.cartCnt}</td>
					<td>기본배송</td>
					<td>2500원</td>
					<td>${cart.cartTotalPrice}원</td> <!-- 배송비 미포함 -->
			 <!-- <td class="flex-box"  style="flex-direction: column; align-items: center";>-->
			 		<td class="link-box flex-box"  style="flex-direction: column; align-items: center;">
						<a href="#"  style=" border: 1px solid;">주문하기</a>
						<a href="#"  style=" border: 1px solid;">삭제</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
		
		<tfoot class="right">
			<tr>
				<td colspan="10">
					상품구매금액:
				</td>
			</tr>
		</tfoot>
	</table>
	<button type="submit"  class="btn">전체 주문하기</button>
</div>

<jsp:include page= "/WEB-INF/views/template/footer.jsp"></jsp:include>