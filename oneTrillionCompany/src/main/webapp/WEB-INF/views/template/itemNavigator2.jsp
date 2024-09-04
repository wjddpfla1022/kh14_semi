<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--   아이템 카테고리용 네비게이터 -->
<style>
/* 페이지 네비게이터 디자인 */
.pagenation {
	text-align: center;
}

.pagenation>a {
	color: gray;
	text-decoration: none;
	display: inline-block;
	padding: 0.5em;
	min-width: 2.5em;
	font-size: inherit; /* 글자 크기를 외부의 설정을 따른다*/
}

.pagenation>a:hover, .pagenation>a.on {
	box-shadow: 0px 0px 0px 1px gray;
	color: red;
	font-weight: bold;
}
</style>

<div class="container w-800 my-50">
	<div class="row center"></div>
	<div class="row">
		<div class="pagenation">

			<%-- 이전 버튼은 첫번째 구간이 아닐 때(pageVO 참고) 일때 나온다  --%>
			<c:if test="${itemPageVO.hasPrev()}">
				<c:when test="${itemPageVO.hasSorting()}">
					<a
						href="cate?column=${itemPageVO.column}&keyword=${itemPageVO.keyword}&page=${itemPageVO.getPrevBlock()}&sorting=${itemPageVO.sorting}">Prev</a>
				</c:when>
				<c:otherwise>
					<a
						href="cate?column=${itemPageVO.column}&keyword=${itemPageVO.keyword}&page=${itemPageVO.getPrevBlock()}">Prev</a>
				</c:otherwise>
			</c:if>
			<%-- count = ${itemPageVO.getCount()} --%>
			<%-- size = ${itemPageVO.getSize()} --%>
			<%-- start = ${itemPageVO.getStartBlock()} --%>
			<%-- finish = ${itemPageVO.getFinishBlock()} --%>
			<%-- last = ${itemPageVO.getLastBlock()} --%>
			<%-- next = ${itemPageVO.getNextBlock()} --%>
			<%-- n = ${n} --%>
			<c:forEach var="n" begin="${itemPageVO.getStartBlock()}"
				end="${itemPageVO.getFinishBlock()}" step="1">
				<c:choose>
					<c:when test="${itemPageVO.page == n}">
						<a class="on">${n}</a>
					</c:when>
					<c:otherwise>
						<a
							href="cate?column=${itemPageVO.column}&keyword=${itemPageVO.keyword}&page=${n}&sorting=${itemPageVO.sorting}">${n}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<c:if test="${itemPageVO.hasNext()}">
				<a
					href="cate?column=${itemPageVO.column}&keyword=${itemPageVO.keyword}&page=${itemPageVO.getNextBlock()}&sorting=${itemPageVO.sorting}">
					<i class="fa-solid fa-chevron-right"></i>
				</a>
			</c:if>
		</div>
	</div>
</div>