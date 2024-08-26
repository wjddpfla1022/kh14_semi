<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- 댓글 처리를 위한 JS코드 -->
<script type="text/javascript">
	$(function(){
		//현재 페이지의 파라미터 중 qnaNo 추출
		var param = new URLSearchParams(location.search);
		var qnaNo = param.get("qnaNo");
		
		//현재 로그인한 사용자의 아이디를 변수로 저장
		var currentUser = "${sessionScope.createdUser}";
		
		//댓글 등록
		$(".add-reply-btn").click(function(){
			//작성된 내용 읽기
			var content = $(".reply-input").val();
			if(content.length == 0) return;
			//비동기 통신
			$.ajax({
				url: "/rest/reply/write",
				method: "post",
				data: {
					replyContent: content,
					replyOrigin: qnaNo
				},
				success: function(response){
					$(".reply-input").val("")
					loadList();
				}
			});
		});
		
	});
</script>

<div class="container w-1000">
	<div class="row center">
		<h1>${qnaDto.qnaWriter}님의 Q&A</h1>
	</div>
	<hr>
	<div class="row">
		<table class="table table-border">
			<tbody>
				<tr>
					<td><h1>${qnaDto.qnaTitle}</h1></td>
				</tr>
				<tr>
					<td>${qnaDto.qnaTime}</td>
				</tr>
				<tr>
					<td>${qnaDto.qnaContent}</td>
				</tr>
				<tr>	
				<!-- 댓글수 -->
					<td>
						<i class="fa-solid fa-eye"></i> <fmt:formatNumber value="${qnaDto.qnaView}" pattern="#,##0"/>
						<i class="fa-regular fa-comment-dots"></i> <fmt:formatNumber value="${qnaDto.qnaReply}" pattern="#,##0"/>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!-- 관리자 답변 댓글창 -->
	<div class="row reply-list-wrapper">
	</div>
	<div class="row">
		<textarea class="field w-100 reply-input"></textarea>
		<button type="button" class="btn btn-positive add-reply-btn">
			<i class="fa-solid fa-pen-to-square"></i> 댓글 작성
		</button>
	</div>
</div>