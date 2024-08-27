<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 
    
    
    <div class="container w-600 center">
        <div class="row center">
            <h2>상품등록</h2>
        </div>
        <form action="insert" method="post" autocomplete="off">
            <div class="row">
                <label>상품명</label>
                <input type="text" name="itemName" class="field">
            </div>
            <div class="row">
                <label>정가</label>
                <input type="number" name="itemPrice" class="field">
            </div>
            <div class="row">
                <label>판매가</label>
                <input type="number" name="itemSalePrice" class="field">
            </div>
            <div class="row">
                <label>재고 수</label>
                <input type="number" name="itemCnt" class="field">
            </div>
            <div class="row">
                <label>사이즈</label>
                <select name="itemSize" class="field" style="width: 10em;">
                	<option value="S">Small</option>
                	<option value="M">Medium</option>
                	<option value="L">Large</option>
                	<option value="XL">Extra-large</option>
                </select>
            </div>
            <div class="row">
                <h3>카테고리</h3>
                <select name="itemCate1" id="cate1-select" class="field" style="width: 10em;">
                    <option value="11">상의</option>
                    <option value="33">하의</option>
                    <option value="55">신발</option>
                    <option value="77">아우터</option>
                </select>
            </div>
            <div class="row">
                
                <select name="itemCate2" class="field cate2" style="width: 10em;">
					<option value="">---상의---</option>                    
                    <option value="10">티셔츠</option>
                    <option value="11">셔츠</option>
                    <option value="">---하의---</option>
                    <option value="30">슬랙스</option>
                    <option value="31">데님</option>
                    <option value="32">트레이닝</option>
                    <option value="33">반바지</option>
                    <option value="">---신발---</option>
                    <option value="50">스니커즈</option>
                    <option value="51">로퍼/슬립온</option>
                    <option value="52">구두</option>
                    <option value="53">워커/부츠</option>
                    <option value="54">샌들/슬리퍼</option>
                    <option value="55">깔창/기타</option>
                    <option value="">---아우터---</option>
                    <option value="70">가디건</option>
                    <option value="71">블루종</option>
                    <option value="72">집업</option>
                    <option value="73">바람막이</option>
                    <option value="74">블레이저</option>
                    <option value="75">청재킷</option>
                </select>
            </div>
            <div class="row">
                <select name="itemCate3"  class="field" style="width: 10em;">
                    <option value="">카테고리 없음</option>
                    <option value="">---티셔츠---</option>
                    <option value="10">7부</option>
                    <option value="11">민소매</option>
                    <option value="12">긴팔</option>
                    <option value="13">반팔</option>
                    <option value="14">맨투맨</option>
                    <option value="15">후드</option>
                    <option value="16">니트/스웨터</option>
                    <option value="">---셔츠---</option>
                    <option value="17">반팔셔츠</option>
                    <option value="18">7부 셔츠</option>
                    <option value="19">긴팔셔츠</option>
                    <option value="20">베이직/심플</option>
                    <option value="21">스트라이프</option>
                    <option value="22">체크</option>
                    <option value="">--슬랙스--</option>
                    <option value="30">스트레이트핏</option>
                    <option value="31">테이퍼드핏</option>
                    <option value="32">와이드핏</option>
                    <option value="">---데님---</option>
                    <option value="35">스트레이트핏</option>
                    <option value="36">테이퍼드핏</option>
                    <option value="37">와이드핏</option>
                    <option value="">--트레이닝--</option>
                    <option value="38">트레이닝</option>
                    <option value="39">조거</option>
                    <option value="">---반바지---</option>
                    <option value="33">일반 반바지</option>
                    <option value="34">데님 반바지</option>
                </select>
            </div>
            <div class="row">
                <label>할인율</label>
                <input type="number" name="itemDiscountRate" class="field">
            </div>
            <div class="row">
            	<label>색상</label>
            	<select name="itemColor" class="field" style="width: 10em;">
            		<option value="">선택없음</option>
            		<option value="black">검정</option>
            		<option value="red">빨강</option>
            		<option value="orange">주황</option>
            		<option value="yellow">노랑</option>
            		<option value="green">초록</option>
            		<option value="blue">파랑</option>
            		<option value="brown">브라운</option>
            		<option value=" pink">분홍</option>
            	</select>
            </div>
        <div class="right">
        <button type="submit" class="btn btn-positive">등록</button>
    </div>
        </form>
           
    </div>
    
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>