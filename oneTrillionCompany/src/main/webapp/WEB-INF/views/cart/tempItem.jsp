<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- jquery cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>


<script type="text/javascript">

$(function(){
	//장바구니에 담기 -비동기
	$(".btn-cart-add").click(function(){
		//이 페이지의 파라미터 중 boardNo의 값을 알아내는 코드
		var params = new URLSearchParams(location.search);
		var buyerItemNoValue = param.get("itemNo");
		
		 // 파라미터가 없는 경우 경고
        if (!buyerItemNoValue) {
            alert("상품 번호가 URL에 존재하지 않습니다.");
            return;
        }
		
		var buyerItemColorValue = ${itemdto.itemNo};
		var buyerItemSizeValue = ${itemdto.itemSize};
		var buyerItemCnt = ${itemdto.itemCnt};
		$.ajax({
			url: "/rest/cart/itemInsertCart",
			method: 'post',
			data:{
				buyerItemNo : buyerItemNoValue,
				buyerItemColor : buyerItemColorValue,
				buyerItemSize : buyerItemSizeValue,
				buyerItemCnt : buyerItemCntValue,
			},
			success:function(response){
				alert("장바구니에 등록 되었습니다.");
			}
		});
	});
	
});

</script>

<!-- 임시라서 나중에 필요없는 부분 -->       
<h1>장바구니 담기 구현 임시 페이지-상품 상세페이지에 들어가게됨</h1>
		
		<div class="row">
            <span>${itemdto.itemNo} 상품고유번호</span>
        </div>
        <div class="row">
            <span>${itemdto.itemColor} 색상</span>
        </div>
        <div class="row">
        	<span>${itemdto.itemSize} 사이즈</span>
        </div>
         <div class="row">
        	<span>${itemdto.itemCnt} 수량</span>
        </div>


    
<div class="row">
	<button type="button" class="btn btn-cart-add btn-positive">장바구니 담기</button>
</div>