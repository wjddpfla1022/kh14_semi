<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- 전체 메뉴용 -->
<style>
	.btn.btn-more{
	    background-color: rgb(196, 227, 255);
	    font-size: 16px;
	    padding: 1.5em;
	    padding-left: 3em;
	    padding-right: 3em;
	    padding-bottom: 2.5em;
	    margin-bottom: 3px;
	    border: none;
	}
	
	.image-align {
	    display: flex;
	    flex-wrap: wrap;
	    gap: 50px;	                
	}
	.image-align > a {
	    text-decoration: none;
	    color: black;	    
	}
	
	a > h4{
	    margin: 0.3em;
	}
</style>		

	<!-- 검색창 -->
	<div class="container w-1000">
		<div class="row image-align" id="images">
			<c:forEach var= "itemDto" items= "${itemList}">
				<a href="/item/detail?itemNo=${itemDto.itemNo}">
					<img src = "/item/image?itemNo=${itemDto.itemNo}" width="200px" height="200px">
					<h4>${itemDto.itemName}</h4>
					<h4>${itemDto.itemPrice}원</h4>
				</a>
			</c:forEach>
		</div>
		<div class="row center">
			<jsp:include page= "/WEB-INF/views/template/itemNavigator.jsp"/>
		</div>
	</div>
</body>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>