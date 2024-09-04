<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 
    <!-- 정렬 -->
    <style>
    .item-update-line label{
    	display: inline-block;
    	width: 55px;
    	text-align: right;
    }
    </style>
     
    <div class="container w-600 center item-update-line">
        <div class="row center">
            <h2>상품수정</h2>
        </div>
        <form action="update" method="post" autocomplete="off">
            <div class="row">
            	<input type="hidden" name="itemNo" value="${itemDto.getItemNo()}">
                <label>상품명</label>
                <input type="text" name="itemName" class="field" value="${itemDto.getItemName()}">
            </div>
            <div class="row">
                <label>정가</label>
                <input type="number" name="itemPrice" class="field" value="${itemDto.getItemPrice()}">
            </div>
            <div class="row">
                <label>판매가</label>
                <input type="number" name="itemSalePrice" class="field" value="${itemDto.getItemSalePrice()}">
            </div>
            <div class="row">
                <label>재고 수</label>
                <input type="number" name="itemCnt" class="field" value="${itemDto.getItemCnt()}">
            </div>
<!--             <div class="row"> -->
<!--                 <label>사이즈</label> -->
<!--                 <select name="itemSize" class="field" style="width: 10em;"> -->
<!--                 	<option value="S">Small</option> -->
<!--                 	<option value="M">Medium</option> -->
<!--                 	<option value="L">Large</option> -->
<!--                 	<option value="XL">Extra-large</option> -->
<!--                 </select> -->
<!--             </div> -->
<!--             <div class="row"> -->
<!--                 <h3>카테고리</h3> -->
<!--                 <select name="itemCate1" id="cate1-select" class="field" style="width: 10em;"> -->
<%--                     <option value="11" <c:if test="${itemDto.getItemCate1()=='11'}">selected</c:if>>상의</option> --%>
<%--                     <option value="33" <c:if test="${itemDto.getItemCate1()=='33'}">selected</c:if>>하의</option> --%>
<%--                     <option value="55" <c:if test="${itemDto.getItemCate1()=='55'}">selected</c:if>>신발</option> --%>
<%--                     <option value="77" <c:if test="${itemDto.getItemCate1()=='77'}">selected</c:if>>아우터</option> --%>
<!--                 </select> -->
<!--             </div> -->
<!--             <div class="row"> -->
<!--                 <select name="itemCate2" class="field cate2" style="width: 10em;"> -->
<!-- 					<option value="">---상의---</option>                     -->
<%--                     <option value="10" <c:if test="${itemDto.getItemCate2()=='10'}">selected</c:if>>티셔츠</option> --%>
<%--                     <option value="11" <c:if test="${itemDto.getItemCate2()=='11'}">selected</c:if>>셔츠</option> --%>
<!--                     <option value="" >---하의---</option> -->
<%--                     <option value="30" <c:if test="${itemDto.getItemCate2()=='30'}">selected</c:if>>슬랙스</option> --%>
<%--                     <option value="31" <c:if test="${itemDto.getItemCate2()=='31'}">selected</c:if>>데님</option> --%>
<%--                     <option value="32" <c:if test="${itemDto.getItemCate2()=='32'}">selected</c:if>>트레이닝</option> --%>
<%--                     <option value="33" <c:if test="${itemDto.getItemCate2()=='33'}">selected</c:if>>반바지</option> --%>
<!--                     <option value="">---신발---</option> -->
<%--                     <option value="50" <c:if test="${itemDto.getItemCate2()=='50'}">selected</c:if>>스니커즈</option> --%>
<%--                     <option value="51" <c:if test="${itemDto.getItemCate2()=='51'}">selected</c:if>>로퍼/슬립온</option> --%>
<%--                     <option value="52" <c:if test="${itemDto.getItemCate2()=='52'}">selected</c:if>>구두</option> --%>
<%--                     <option value="53" <c:if test="${itemDto.getItemCate2()=='53'}">selected</c:if>>워커/부츠</option> --%>
<%--                     <option value="54" <c:if test="${itemDto.getItemCate2()=='54'}">selected</c:if>>샌들/슬리퍼</option> --%>
<%--                     <option value="55" <c:if test="${itemDto.getItemCate2()=='55'}">selected</c:if>>깔창/기타</option> --%>
<!--                     <option value="">---아우터---</option> -->
<%--                     <option value="70" <c:if test="${itemDto.getItemCate2()=='70'}">selected</c:if>>가디건</option> --%>
<%--                     <option value="71" <c:if test="${itemDto.getItemCate2()=='71'}">selected</c:if>>블루종</option> --%>
<%--                     <option value="72" <c:if test="${itemDto.getItemCate2()=='72'}">selected</c:if>>집업</option> --%>
<%--                     <option value="73" <c:if test="${itemDto.getItemCate2()=='73'}">selected</c:if>>바람막이</option> --%>
<%--                     <option value="74" <c:if test="${itemDto.getItemCate2()=='74'}">selected</c:if>>블레이저</option> --%>
<%--                     <option value="75" <c:if test="${itemDto.getItemCate2()=='75'}">selected</c:if>>청재킷</option> --%>
<!--                 </select> -->
<!--             </div> -->
<!--             <div class="row"> -->
<!--                 <select name="itemCate3"  class="field" style="width: 10em;"> -->
<!--                     <option value="">카테고리 없음</option> -->
<!--                     <option value="">---티셔츠---</option> -->
<%--                     <option value="10" <c:if test="${itemDto.getItemCate3()=='10'}">selected</c:if>>7부</option> --%>
<%--                     <option value="11" <c:if test="${itemDto.getItemCate3()=='11'}">selected</c:if>>민소매</option> --%>
<%--                     <option value="12" <c:if test="${itemDto.getItemCate3()=='12'}">selected</c:if>>긴팔</option> --%>
<%--                     <option value="13" <c:if test="${itemDto.getItemCate3()=='13'}">selected</c:if>>반팔</option> --%>
<%--                     <option value="14" <c:if test="${itemDto.getItemCate3()=='14'}">selected</c:if>>맨투맨</option> --%>
<%--                     <option value="15" <c:if test="${itemDto.getItemCate3()=='15'}">selected</c:if>>후드</option> --%>
<%--                     <option value="16" <c:if test="${itemDto.getItemCate3()=='16'}">selected</c:if>>니트/스웨터</option> --%>
<!--                     <option value="">---셔츠---</option> -->
<%--                     <option value="17" <c:if test="${itemDto.getItemCate3()=='17'}">selected</c:if>>반팔셔츠</option> --%>
<%--                     <option value="18" <c:if test="${itemDto.getItemCate3()=='18'}">selected</c:if>>7부 셔츠</option> --%>
<%--                     <option value="19" <c:if test="${itemDto.getItemCate3()=='19'}">selected</c:if>>긴팔셔츠</option> --%>
<%--                     <option value="20" <c:if test="${itemDto.getItemCate3()=='20'}">selected</c:if>>베이직/심플</option> --%>
<%--                     <option value="21" <c:if test="${itemDto.getItemCate3()=='21'}">selected</c:if>>스트라이프</option> --%>
<%--                     <option value="22" <c:if test="${itemDto.getItemCate3()=='22'}">selected</c:if>>체크</option> --%>
<!--                     <option value="">--슬랙스--</option> -->
<%--                     <option value="30" <c:if test="${itemDto.getItemCate3()=='30'}">selected</c:if>>스트레이트핏</option> --%>
<%--                     <option value="31" <c:if test="${itemDto.getItemCate3()=='31'}">selected</c:if>>테이퍼드핏</option> --%>
<%--                     <option value="32" <c:if test="${itemDto.getItemCate3()=='32'}">selected</c:if>>와이드핏</option> --%>
<!--                     <option value="">---데님---</option> -->
<%--                     <option value="35" <c:if test="${itemDto.getItemCate3()=='35'}">selected</c:if>>스트레이트핏</option> --%>
<%--                     <option value="36" <c:if test="${itemDto.getItemCate3()=='36'}">selected</c:if>>테이퍼드핏</option> --%>
<%--                     <option value="37" <c:if test="${itemDto.getItemCate3()=='37'}">selected</c:if>>와이드핏</option> --%>
<!--                     <option value="">--트레이닝--</option> -->
<%--                     <option value="38" <c:if test="${itemDto.getItemCate3()=='38'}">selected</c:if>>트레이닝</option> --%>
<%--                     <option value="39" <c:if test="${itemDto.getItemCate3()=='39'}">selected</c:if>>조거</option> --%>
<!--                     <option value="">---반바지---</option> -->
<%--                     <option value="33" <c:if test="${itemDto.getItemCate3()=='33'}">selected</c:if>>일반 반바지</option> --%>
<%--                     <option value="34" <c:if test="${itemDto.getItemCate3()=='34'}">selected</c:if>>데님 반바지</option> --%>
<!--                 </select> -->
<!--             </div> -->
        <div class="right">
        <button type="submit" class="btn btn-positive">수정</button>
    </div>
        </form>
           
    </div>
    
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>