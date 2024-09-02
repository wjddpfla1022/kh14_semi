<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	.refund-write > textarea{
		resize: none;
        min-width: 500px;
        min-height: 150px;
        width: 100%;
        padding-top: 0.5em;
	}
</style>

<script type="text/javascript">
	$(function(){
		$(".btn-refund").click(function(e){
			e.preventDefault();
			var refund = window.confirm("등록하시겠습니까?");
			if(refund){
				$("#refund-form").submit();
			}
		});
	});
</script>

<form action="insert" method="post" id="refund-form">
	<div class="container w-700">
		<div class="row center">
			<h1>환불 신청</h1>
		</div>
		<div class="row">
			<select class="row field w-100" name="refundType">
				<option value="">환불 사유를 선택해주세요</option>
				<option value="단순 변심">단순 변심</option>
				<option value="상품 불량">상품 불량</option>
				<option value="상품 오배송">상품 오배송</option>
				<option value="상품 상세정보와 상이">상품 상세정보와 상이</option>
				<option value="배송 지연">배송 지연</option>
			</select>
		</div>
		<div class="row refund-write">		
			<input type="hidden" class="field" value="${orderDetailDto.orderDetailNo}" name="refundOrderDetailNo">
			<input type="hidden" class="field" value="${orderDetailDto.orderDetailStatus}" name="orderDetailStatus">
			<textarea placeholder="내용을 입력하세요" name="refundMemo"></textarea>
		</div>
		<div class="row right">
			<button type="button" class="btn btn-positive btn-refund">등록</button>
			<a href="/order/list" class="btn btn-neutral">취소</a>
		</div>
	</div>
</form>
