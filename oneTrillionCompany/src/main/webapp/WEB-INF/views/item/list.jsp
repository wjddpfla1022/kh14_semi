<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- 카테고리용 -->
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
.name{
font-size:12px
}
.price{
	font-size:14px
}
</style>

  <div class="container w-1200 my-50">
	<div class="row center">
		<h1>상품 목록 페이지</h1><!-- 나중에 삭제 할곳  -->
		<div class="row right px-30">
			<div class="btn btn-neutral link"><a href="/item/list/cate?column=${itemPageVO.column}&keyword=${itemPageVO.keyword}&sorting=sales" class="link">판매량순</a></div>
			<div class="btn btn-neutral link"><a href="/item/list/cate?column=${itemPageVO.column}&keyword=${itemPageVO.keyword}&sorting=priceDesc" class="link">높은가격순</a></div>
			<div class="btn btn-neutral link"><a href="/item/list/cate?column=${itemPageVO.column}&keyword=${itemPageVO.keyword}&sorting=priceAsc" class="link">낮은가격순</a></div>
			<div class="btn btn-neutral link"><a href="/item/list/cate?column=${itemPageVO.column}&keyword=${itemPageVO.keyword}&sorting=latest" class="link">최신등록순</a></div>
		</div>
	</div>
</div>
		
	<div class="row center">
		<!-- 검색창 -->
			 <div class="container w-1000">
        <div class="row center">
		</div>
<%-- 		<h3>데이터 개수 : ${itemList.size()}</h3> --%>

	<!-- 검색창 -->
	<div class="container w-1000">
		<c:choose>
    		<c:when test="${empty itemList || itemList.size() == 0}">
				<h3>해당 카테고리에 상품이 존재하지 않습니다.</h3>
    		</c:when>
   			 <c:otherwise>
				<div class="row image-align left" id="images">
					<c:forEach var= "item" items= "${itemList}">
            			<a href="/item/detail?itemNo=${item.itemNo}">
	           				 <img src = "/item/image?itemNo=${item.itemNo}" width="200px" height="260px">
	           				 <div class="name">${item.itemName}(${item.itemColor})</div>
							 <div class="price"><span class="gray" style="text-decoration : line-through"> ${item.itemPrice}원 </span> ${item.itemSalePrice}원</div>

            			</a>
        			</c:forEach>
        		</div>
            	<div class="row center">            
            		<jsp:include page= "/WEB-INF/views/template/itemNavigator2.jsp"></jsp:include>
            	</div>
   			</c:otherwise>
		</c:choose>
	</div>
</body>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>