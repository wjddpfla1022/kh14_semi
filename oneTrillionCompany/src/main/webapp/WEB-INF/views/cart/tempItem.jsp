<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- jquery cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>


<script type="text/javascript">
//버튼을 누르면 


$(function(){
	$(".btn-cartAdd").click(function(){
		$.ajax({
			url
		});
	});
	
});

</script>

<!-- 임시라서 나중에 필요없는 부분 -->       
<h1>장바구니 담기 구현 임시 페이지-상품 상세페이지에 들어가게됨</h1>
    
 <div class="container w-600 my-50">
        <div class="row center">
            <h1>상품</h1>
             <div class="row center">
            	<div class="swiper">
                	<div class="swiper-wrapper">
                    	<!-- Slides -->
                   		 <div class="swiper-slide"><a href="#"><img src="http://via.placeholder.com/300.png"></a></div>
  					</div>                  
      			 </div>
      			 <div class="row">
      			 	<textarea></textarea>
      			 </div>
       		 </div>
        </div>
        
        <!--여긴 복붙! 장바구니 버튼 -->
        <form action="addCart">
        <button type="submit" class="btn btn-cartAdd">장바구니담기</button>
        
       <!--  <button type="button" onclick="location.href='write'">글쓰기</button> <br> -->
        </form>
 	</div>