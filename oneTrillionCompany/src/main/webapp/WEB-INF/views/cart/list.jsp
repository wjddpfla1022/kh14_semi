<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page= "/WEB-INF/views/template/header.jsp"></jsp:include>

 <!-- font awesome icon cdn -->

<style>
	/* 주문 삭제버튼 스타일 */
	.link-box {
		width: 100%;
	}
	.link-box a {
		width: 150px;
		text-align: center; 
	}
	/* 재고 수량을 숨김 */
	.itemCnt-data { 		
		display: none !important; 
	}
	
</style>

<!-- jquery cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script type="text/javascript">
	//전체선택//
	$(function(){
		// 전체선택
        $('.all-checkbox').change(function() {
            var checked = $(this).prop("checked");
            $(".check-item").prop("checked", checked);
            $(".check-item").trigger("change");
        });

        // 삭제 버튼 누를 때 알림창
        $(".btn-delete").click(function(event) {
            var choice = confirm("장바구니를 비우시겠습니까?");
            if (!choice) {
                event.preventDefault();
            }
        });

        // 수량 증가 및 감소
        $(".btn-up, .btn-down").click(function() {
            // 현재 버튼이 속한 행의 수량 및 재고 값 가져오기
            var row = $(this).closest('tr');
            var $cartCntInput = row.find("[name=cartCnt]");
            var cartCnt = parseInt($cartCntInput.val());
            var itemCnt = parseInt(row.find(".itemCnt-data").text());

            // 버튼에 따른 수량 조절
            if ($(this).hasClass('btn-up')) {
                if (cartCnt < itemCnt) {
                    cartCnt += 1;
                    $cartCntInput.val(cartCnt);
                } else {
                    alert("최대 수량에 도달했습니다");
                }
            } else if ($(this).hasClass('btn-down')) {
                if (cartCnt > 1) {
                    cartCnt -= 1;
                    $cartCntInput.val(cartCnt);
                } else {
                    alert("최소 수량에 도달했습니다");
                }
            }
        });
	});
</script>
<div class="container w-1200 my-50">
	<div class="row center mb-50">
		<h1>장바구니</h1>
	</div>

<!-- 장바구니가 비어있다면(회원, 비회원)  -->
<c:choose>
	<c:when test="${cartList.isEmpty()}">
		<!-- 결과가 없을때  -->
		<div class="row center">
			<i class="fas fa-thin fa-cart-shopping fa-2x"></i><p>장바구니가 비어있습니다</p>
		</div>
	</c:when>	
	<c:otherwise>
	<!-- 결과가 있을때  -->
	<!-- 장바구니 목록 -->
	<form action="delete" method="post">
		<table border="1" width="1200">
			<thead>
				<tr>
					<th>
						<input type="checkbox" class="all-checkbox">
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
			
			<!-- cartList 반복문 -->
			<tbody class="center">
			<c:forEach var="cart" items="${cartList}">
				<tr>
					<td>
						<input type="checkbox" class="check-item" name="cartNo" value="${cart.cartNo}">
					</td>
					<td>
						<a href="#"><img src="https://via.placeholder.com/20"></a> <!-- 임시 이미지 -->
					</td>
					<!--itemList 반복문 -->
					<c:forEach var="item" items="${itemList}">
			            <c:if test="${item.itemNo == cart.cartItemNo}">
			                <td>${item.itemName}</td> 
			                <td>${item.itemPrice}원 <span class="itemCnt-data">${item.itemCnt}</span></td><!-- 재고값을 el로 받아 제이쿼리에 적용 -->
			            </c:if>
			        </c:forEach>
					<td>
						<span class="input_cartCnt">
							<input type="text"  name="cartCnt"  value="${cart.cartCnt}" size="2">
							<button type="button" class="btn-cnt btn-up"><i class="fa-solid fa-angle-up Icon_carCnt"></i></button>
							<button type="button" class="btn-cnt btn-down"><i class="fa-solid fa-angle-down Icon_carCnt"></i></button>
						</span>
					</td>
					<td>기본배송</td>
					<td>2500원</td>
					<td>${cart.cartTotalPrice}원</td> <!-- 배송비 미포함 -->
			 		<td class="link-box flex-box"  style="flex-direction: column; align-items:center;">
						<button type="submit" class="btn btn-positive">주문하기</button>
						<button type="submit" class="btn btn-negative btn-delete">삭제하기</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
			
		<tfoot class="right">
			<tr>
				<td colspan="10" >
					상품구매금액: ${cartTotalPrice}원
				</td>
			</tr>
		</tfoot>
			
		</table>
	</form>
	<div class="float-box" >
		<form action="deleteAll" method="post" class="float-right"> <!-- form 블록요소 여기에 float 적용시킴 -->
			<button type="submit" class="btn btn-empty btn-delete"><i class="fa-solid fa-trash-can"></i> 장바구니 비우기</button>
		</form>
	<!-- 주문 form 넣으면 됩니다 -->
			<button type="submit" class="btn float-left">선택상품 주문하기</button>
			<button type="submit"  class="btn float-left">전체 주문하기</button>
	</div>
	</c:otherwise>
</c:choose>
</div>
<jsp:include page= "/WEB-INF/views/template/footer.jsp"></jsp:include>