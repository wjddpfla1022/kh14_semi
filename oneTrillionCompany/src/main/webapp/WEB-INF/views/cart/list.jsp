<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page= "/WEB-INF/views/template/header.jsp"></jsp:include>

 <!-- font awesome icon cdn -->

<style>
	/*장바구니 제목 스타일 */
	.cart-title{
		font-weight: 700;
	    font-size: 36px;
	    line-height: 40px;
	    margin-bottom: 20px;
	    padding-top: 10px;
	}
	/*테이블 스타일*/
	table{
		width: 100%;
	    border: 0;
	    border-collapse: collapse;
	}
	th {
		background: #fbfafa;
	    font-weight: bold;
	}
	tfoot{
		background: #fbfafa;
	}
	tfoot td{
		padding: 0.5em;
	}	
	td{
    border-bottom: 1px solid #ddd !important;
	}
	
	/* 주문 삭제 버튼 스타일 */
	.link-box {
		width: 100%;
		border: none;
	}
	.link-box a {
		width: 150px;
		text-align: center; 
	}
	
	/* 재고, 수량을 숨김 */
	.itemCnt-data{ 		
		display: none !important; 
	}
	.cartCnt-data{
		display: none !important;
	}
	/*주문 요약서 스타일*/
	.cart-payment-Title{
		color: #000;
	    margin-bottom: 24px;
	    font-size: 20px;
	    line-height: 28px;
	    text-transform: uppercase;
	    font-weight: 700
	}
	/*장바구니 주문서*/
	.cart-order{
		border: 1px solid #000;
	}
	.cart-orderTitle{
		color: #000;
		font-size: 20px;
		margin-bottom: 24px;
   		line-height: 28px;
    	text-transform: uppercase;
		font-weight: 700;
	}
	.displayNone{
		display: none;
	}
</style>

<!-- jquery cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script type="text/javascript">
	//전체선택//
	$(function(){
		//전체선택
        $('.all-checkbox').click(function() {//상태가 변경되면
            var checked = $(this).prop("checked");
            if(checked){
            	$(".check-item").prop("checked",true);
            }
            else{
            	$(".check-item").prop("checked", false);
            }      
         });
		$(".check-item").click(function(){
			//체크된 체크박스 개수
			var checked_length = $(".check-item").prop("checked").length;
			//전체 체크박수 개수
			var checkbox_length = $(".check-item").length;
			
			if(checked_length == checkbox_length) {
				$(".all-checkbox").prop("checked", true);
			}
			else{
				$(".all-checkbox").prop("checked",false);
			}
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

            var cartCntValue = parseInt($cartCntInput.val());
            var itemCntValue = parseInt(row.find(".itemCnt-data").text());

            // 버튼에 따른 수량 조절
            if ($(this).hasClass('btn-up')) { 
            	// 장바구니 최대 수량(재고기준)
                if (cartCntValue < itemCntValue) {
                    cartCntValue += 1;
                } 
                else {
                    alert("최대 수량에 도달했습니다");
                }
            }
           	else if ($(this).hasClass('btn-down')) {
           		 // 장바구니 최소 수량
           		if (cartCntValue> 1) {
                   	cartCntValue -= 1;
               	} 
           		else {
                   alert("최소 수량에 도달했습니다");
              	}
           	}
            $cartCntInput.val(cartCntValue);
			
	        //수량 서버에 업데이트-ajax통신
            var cartNo = parseInt(row.find(".cartCnt-data").text());
	        $.ajax({
	        	url: "/rest/cart/cartCntUpdate",
	        	method: 'post',
	        	data:{
	        		cartNo: cartNo,
	        		cartCnt: cartCntValue
	        	},
	        	success:function(response){
	        		console.log('장바구니 업데이트 성공'); //나중에 지우기
	        		updateCartTotalPrice(); //수량을 업데이트 하면서 같이 ajax통신
	        	}
	        });
        });
        
        //수량 변경 시-ajax통신 
        //-상품 총구매금액 - ajax통신
        function updateCartTotalPrice() {
	        $.ajax({
	        	url: "/rest/cart/cartTotalPriceUpdate",
	        	method: 'post',
	        	success:function(response){
	        		$(".cart-total-price").text(response);
	        	}
	        });
        }
	});


</script>
<form action="list" method="post">
<div class="container w-1200 my-50">
	<div class="row center mb-50 cart-title">
		장바구니
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
	<div class="row cart-item-cnt">
		<h3>담긴 상품(${cartItemCnt})</h3>
	</div>
	<!-- 장바구니 목록 -->
<!-- 	<form action="delete" method="post"> -->
		<table border="1" width="1200">
			<thead>
				<tr>
					<th>
						<input type="checkbox" class="all-checkbox">
					</th>
					<th>이미지</th>
					<th>상품정보</th>
					<th>가격</th>
					<th>수량</th>
					<th>배송구분</th>
					<th>선택</th>
				</tr>
			</thead>
			
			<!-- cartList 반복문 -->
			<tbody class="center">
			<c:forEach var="cart" items="${cartList}">
				<tr>
					<td>
						<span class="cartCnt-data">${cart.cartNo}</span><!-- 장바구니 수량을 el로 받아 제이쿼리에 적용 -->
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
							<input type="text"  name="cartItemCnt"  value="${cart.cartCnt}" size="2">
							<button type="button" class="btn-cnt btn-up"><i class="fa-solid fa-angle-up Icon_carCnt"></i></button>
							<button type="button" class="btn-cnt btn-down"><i class="fa-solid fa-angle-down Icon_carCnt"></i></button>
						</span>
					</td>
					<td>기본배송</td>
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
					상품구매금액: <span class="cart-total-price">${cartTotalPrice}</span>원
				</td>
			</tr>
		</tfoot>	
		</table>
	</form>
	
	<!-- 버튼 -->
	<div class="float-box" >
<!-- 		<form action="deleteAll" method="post" class="float-right"> form 블록요소 여기에 float 적용시킴 -->
			<button type="button" class="btn btn-empty btn-delete"><i class="fa-solid fa-trash-can"></i> 장바구니 비우기</button>
<!-- 		</form> -->
		<!-- 주문 form 넣으면 됩니다 -->
			<button type="submit" class="btn float-left">선택상품 주문하기</button>
			<button type="submit"  class="btn float-left">전체 주문하기</button>
	</div>
	
	<!-- 장바구니 주문 미리보기 -->
	<div class="row cart-payment-Title center mt-50">
		주문 요약서
	</div>
	<table border="1" class="w-100  mt-20" >
		<colgroup>
			<col style="width:200px;">
			<col style="width:200px;" class="displayNone">
			<col style="width:200px;">
			<col style="width:200px;" class="displayNone">
			<col style="width:auto;">
		</colgroup>
		<thead>
			<tr>
				<th>
					<strong>총 상품금액</strong>
				</th>
				<th>
					<strong>총 배송비</strong>
				</th>
				<th>
					<strong>결제예정금액</strong>
				</th>
			</tr>
		</thead>
		<tbody class="center">
			<tr>
				<td>
					<div class="row">
						<strong>
							<span class="cart-total-price"> <!-- 배송비 가격 미포 -->
								${cartTotalPrice}
							</span>
								원
						</strong>
					</div>
				</td>
				<td>
					<div class="row">
						<strong>
							<span>
								무료 배송
							</span>
						</strong>
					</div>
				</td>
				<td>
					<div class="row">
						<strong>
							<span class="cart-total-price">
								 ${cartTotalPrice}
							</span>
						</strong>
					</div>
				</td>
			</tr> 
		</tbody>
	</table>
	</c:otherwise>
</c:choose>	
	
</div>
</form>
<jsp:include page= "/WEB-INF/views/template/footer.jsp"></jsp:include>