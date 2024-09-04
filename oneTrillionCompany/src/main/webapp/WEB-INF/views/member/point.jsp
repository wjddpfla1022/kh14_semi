<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<style>
	.table-border-top{
		background-color: transparent;
		border: 2px solid black;
		border-left: none;
		border-right: none;
		border-bottom: 1px solid #e9e9e9;
	}
	.table-border-middle{
		background-color: transparent;
		border-top: none;
		border-left: none;
		border-right: none;
		border-bottom: 1px solid #e9e9e9;
	}
	.table-border-center{
		background-color: #fbfafa;
		border-top: none;
		border-left: none;
		border-right: 1px solid #e9e9e9;
		border-bottom: none;
		font-size : 14px;
	}
	.table-border-side{
		background-color: transparent;
		border-top: none;
		border-left: 1px solid #e9e9e9;
		border-right: 1px solid #e9e9e9;
		border-bottom: none;
	}
</style>

<script type="text/javascript">
	$(function(){
		$(".member-delete").click(function(e){
			e.preventDefault();
			var out = window.confirm("탈퇴하시겠습니까?");
            if (out) {
                $("#checkForm").submit();
            }
			// 취소 버튼을 누를 경우 동작X
		});
	});
</script>

<div class="container w-500 my-50">
	<div class = "row center">
		<h1>포인트 충전 문의</h1>
	</div>
	
	<div class = "row center"> 
		<table class="table table-border-top">
		
		<tr  class="table-border-middle">
			<th class="table-border-center">
				<div class="row left ps-30">
					<span>담당자</span>
				</div>
			</th>
			<td>
				<div class="row center">
					<span>이재욱</span>
				</div>
			</td>		
		</tr>		
		<tr  class="table-border-middle">
			<th class="table-border-center">
				<div class="row left ps-30">
					<span>전화번호</span>
				</div>
			</th>
			<td>
				<div class="row center">
					<span>010-6686-4594</span>
				</div>
			</td>		
		</tr>
		<tr class="table-border-middle">
			<th class="table-border-center">
				<div class="row left ps-30">
					<span>이메일</span>
				</div>				
			</th>
			<td>
				<span>vjaewook@gmail.com</span>
			</td>
		</tr>
		<tr class="table-border-middle">
			<th class="table-border-center">
				<div class="row left ps-30">
					<span>문의방법</span>
				</div>				
			</th>
			<td>
				<span>전화, 메세지, 이메일</span>
			</td>
		</tr>
		<tr class="table-border-middle">
			<th class="table-border-center">
				<div class="row left ps-30">
					<span>예금주</span>
				</div>				
			</th>
			<td>
				<span>일조 컴퍼니</span>
			</td>
		</tr>
		<tr class="table-border-middle">
			<th class="table-border-center">
				<div class="row left ps-30">
					<span>입금계좌</span>
				</div>				
			</th>
			<td>
				<span>1111-111-111111 정현은행</span>
			</td>
		</tr>
		</table>
	</div>


</div>
		
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

	








