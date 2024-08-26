<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>

</style>

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
		
 		//댓글 목록 처리
		loadList();
		function loadList() {

			//댓글 목록 불러오기
			$.ajax({
				url:"/rest/reply/list",
				method:"post",
				data:{ replyOrigin : qnaNo },
				success: function(response) {
					//기존 내용 삭제
					$(".reply-list-wrapper").empty();
					
				//전달된 댓글 개수만큼 반복하여 화면 생성
				for(var i=0; i < response.length; i++) {
					var template = $("#reply-template").text();
					var html = $.parseHTML(template);
					
					$(html).find(".reply-writer").text(response[i].replyWriter);
	                $(html).find(".reply-content").text(response[i].replyContent);
					$(html).find(".reply-info > .time").text(response[i].replyTime);
					
					//시간형식 지정
					var time = moment(response[i].replyTime).format("YYYY-MM-DD dddd HH:mm:ss");
                    $(html).find(".reply-info > .time ").text(time);
					
					if(response[i].replyWriter == currentUser) { //작성자가 현재 사용자(currentUser)라면
						$(html).find(".reply-edit-btn , .reply-delete-btn").attr("data-reply-no", response[i].replyNo);	// 수정,삭제 버튼을 생성
					}
					else{
						$(html).find(".reply-edit-btn , .reply-delete-btn").remove();	// 수정,삭제 버튼을 삭제
					}
					$(".reply-list-wrapper").append(html);
					}
				}
			});
		} 
		
	});
</script>


<!-- 댓글 템플릿 -->
<script type="text/template" id="reply-template">
	<!-- 댓글 1개 영역 -->
	<div class="reply-wrapper">

		<!-- 내용 영역 -->
		<div class="content-wrapper">
			<div class="reply-writer">댓글 작성자</div>
			<div class="reply-content">댓글 내용</div>
			<div class="reply-info">
				<span class="time">yyyy-MM-dd HH:mm:ss</span>
				<a href="#" class="link link-animation reply-edit-btn">수정</a>
				<a href="#" class="link link-animation reply-delete-btn">삭제</a>
			</div>
		</div>
	</div>
</script>

<div class="container w-1000">
	<div class="row center">
		<h1>${qnaDto.qnaTitle}</h1>
	</div>
	<hr>
	<div class="row">
		<table class="table table-border">
			<tbody>
				<tr>
					<td>
						<div class="row left">
							<span class="write-deco">작성자</span>
							${qnaDto.qnaWriter}
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="row left">
							<span class="write-deco">작성일</span>
							<fmt:formatDate value="${qnaDto.qnaTime}" pattern="y-MM-d H:mm"/>
						</div>
					</td>
				</tr>
				<tr>
					<td>${qnaDto.qnaContent}</td>
				</tr>
				<tr>	
				<!-- 댓글수 -->
					<td>
						<div class="row left">
							<i class="fa-solid fa-eye"></i> <fmt:formatNumber value="${qnaDto.qnaView}" pattern="#,##0"/>
							<i class="fa-regular fa-comment-dots"></i> <fmt:formatNumber value="${qnaDto.qnaReply}" pattern="#,##0"/>
						</div>
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