<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

  <div class="container w-1200 my-50">
	<div class="row center">
		<h1>상품 목록 페이지</h1><!-- 나중에 삭제 할곳  -->
	</div>
		
	<div class="row center">
		<!-- 검색창 -->
			 <div class="container w-700">
        <div class="row center">
            <h2>Best Item</h2>
        </div>
            <div class="row" style="display: flex; justify-content: space-between;">
                <a href="detail?itemNo=${itemDto.itemName}"><img src="http://via.placeholder.com/200.png"></a>
                <a href="detail?itemNo=${itemDto.itemName}"><img src="http://via.placeholder.com/200.png"></a>
                <a href="detail?itemNo=${itemDto.itemName}"><img src="http://via.placeholder.com/200.png"></a>
            </div>
            <div class="row" style="display: flex; justify-content: space-between;">
                <a href="detail?itemNo=${itemDto.itemName}"><img src="http://via.placeholder.com/200.png"></a>
                <a href="detail?itemNo=${itemDto.itemName}"><img src="http://via.placeholder.com/200.png"></a>
                <a href="detail?itemNo=${itemDto.itemName}"><img src="http://via.placeholder.com/200.png"></a>
            </div>
            <div class="row" style="display: flex; justify-content: space-between;">
                <a href="detail?itemNo=${itemDto.itemName}"><img src="http://via.placeholder.com/200.png"></a>
                <a href="detail?itemNo=${itemDto.itemName}"><img src="http://via.placeholder.com/200.png"></a>
                <a href="detail?itemNo=${itemDto.itemName}"><img src="http://via.placeholder.com/200.png"></a>
            </div>
            <div class="row center">
                <button class="btn btn-more">더보기<i class="fa-solid fa-caret-down"></i></button>
            </div>
        </div>
    </div>
</div>
		</form>
	</div>
</div>
</body>
</html>