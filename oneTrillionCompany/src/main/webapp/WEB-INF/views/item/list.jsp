<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

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

  <div class="container w-1200 my-50">
	<div class="row center">
		<h1>상품 목록 페이지</h1><!-- 나중에 삭제 할곳  -->
	</div>
</div>
		
	<div class="row center">
		<!-- 검색창 -->
			 <div class="container w-1000">
        <div class="row center">
		</div>
		<h3>데이터 개수 : ${itemList.size()}</h3>
		<div class="row image-align">
		<c:forEach var= "itemDto" items= "${list}">
            <a href="/item/detail2?itemNo=${itemDto.itemNo}">
            <img src = "/item/image?itemNo=${itemDto.itemNo}" width="200px" height="200px">
            <h4>${itemDto.itemName}</h4>
            <h4>${itemDto.itemPrice}원</h4>
            </a>
        </c:forEach>

        </div>
            <div class="row center">
<!--                 <button class="btn btn-more">더보기<i class="fa-solid fa-caret-down"></i></button> -->
            </div>
        </div>
    </div>
</div>
		</form>
	</div>
</body>
</html>