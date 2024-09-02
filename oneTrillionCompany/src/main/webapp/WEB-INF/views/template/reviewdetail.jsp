<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script
	src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/commons.css">

<style>

/*프로그레스바(progressbar)디자인*/
.progressbar>.guage {
	background: rgb(4, 1, 56);
	background: radial-gradient(circle, rgba(4, 1, 56, 1) 0%,
		rgba(15, 163, 223, 1) 46%, rgba(0, 212, 255, 1) 79%, rgba(2, 0, 36, 1)
		82%, rgba(24, 12, 237, 1) 99%);
	width: 0%;
	height: 5px;
	transition: width 0.2s linear;
}
</style>



<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<!-- 자바스크립트 코드 작성 영역 -->
<script type="text/javascript">
	
</script>
<div class="container w-900">
	<div class="row center">
		<div class="row flex-box column-2">
			<div class="left">
				<span style="font-size: 40px; margin-left: 30px; color: orange"><i
					class="fa-solid fa-star"></i>&nbsp;<b
					style="font-weight: bolder; color: black">3.2</b></span>
				<!-- 나중에 평균 값으로 바꿀거 -->
			</div>
			<div class="center">
				<div class="progressbar">
					<div class="guage"></div>
				</div>
			</div>
		</div>
	</div>
</div>



<div class="container w-900">
	<div class="row center">
		<c:choose>
			<c:when test="${list.size() > 0}">
				<c:forEach var="reviewDto" items="${list}">
					<hr>
					<div class="left">
						<sapn>
						<i class="fa-regular fa-user"></i> : ${reviewDto.reviewWriter}</sapn>
					</div>

					<div class="left">
						<span><i class="fa-solid fa-tape"></i>SIZE : <b style="font-weight: bolder;">${itemDto.itemSize}</b></span>
					</div>
					
					<div class="left">
						<span>${reviewDto.reviewScore}</span>
					</div>

					<div class="left">
						<div style="height: 200px; box-shadow: 0 0 3px  black; border-radius: 15px">
							<div style="">
								<span>${reviewDto.reviewContent}</span>
							</div>
						</div>

					</div>
				</c:forEach>
			</c:when>

			<c:otherwise>
				<h3>검색 결과가 존재하지 않습니다</h3>
			</c:otherwise>

		</c:choose>

	</div>
</div>

