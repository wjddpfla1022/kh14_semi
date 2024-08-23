<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-1200">
	<div class="row center">
		<h1>상품 검색</h1>
	</div>
	<div class="row right">	
		<h3>데이터개수 : ${list.size()}</h3>
	</div>
	<!-- 검색창 -->
	<div class="row center" style=" margin-bottom:10px;">
		<form action="list" method="get" autocomplete="off" class="field">
    <select class="field" name="column" id="column-select" onchange="toggleInputField()">
        <option value="item_no" <c:if test="${param.column=='item_no'}">selected</c:if>>상품 번호</option>
        <option value="cate_no" <c:if test="${param.column=='cate_no'}">selected</c:if>>카테고리</option>
        <option value="item_name" <c:if test="${param.column=='item_name'}">selected</c:if>>상품명</option>
    </select>

    <!-- 상품 번호와 상품명을 위한 텍스트 입력 필드 -->
    <input class="field" type="text" id="text-input" name="keyword" style="display: none;" value="${param.keyword}">

    <!-- 카테고리를 위한 셀렉트 박스 -->
    <select class="field" name="keyword" id="category-select" style="display: none;">
        <option value="1">상의</option>
        <option value="2">하의</option>
        <option value="3">슈즈</option>
    </select>

    <button class="btn btn-neutral" type="submit">검색</button>
</form>

<script>
function toggleInputField() {
    var column = document.getElementById('column-select').value;
    var textInput = document.getElementById('text-input');
    var categorySelect = document.getElementById('category-select');
    
 // 필드 초기화
    textInput.style.display = 'none';
    textInput.removeAttribute('name');
    categorySelect.style.display = 'none';
    categorySelect.removeAttribute('name');
    
    if (column === 'item_no' || column === 'item_name') {
        textInput.style.display = 'inline-block';
        textInput.setAttribute('name', 'keyword');
        categorySelect.style.display = 'none';
    } else if (column === 'cate_no') {
        textInput.style.display = 'none';
        categorySelect.setAttribute('name', 'keyword');
        categorySelect.style.display = 'inline-block';
    }
}

// 페이지 로드 시 기본적으로 선택된 옵션에 따라 올바른 필드를 표시
window.onload = toggleInputField;
</script>
	</div>
	
	<!-- 검색 결과 -->
	<div class="row center">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th>상품번호</th>
					<th>카테고리 번호</th>
					<th>상품명</th>
					<th>정가</th>
					<th>판매가</th>
					<th>등록일</th>
					<th>자고</th>
					<th>사이즈</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<%--검색 결과가 없을 때 --%>
					<c:when test="${list.isEmpty()}">
						<h3>검색 결과가 존재하지 않습니다</h3>
					</c:when>
					<%--검색 결과가 있을 때 --%>
					<c:otherwise>
						<c:forEach var="itemDto" items="${list}">
							<tr>
								<td>${itemDto.itemNo}</td>
								<td>${itemDto.cateNo}</td>
								<td>
									<a href="detail?itemNo=${itemDto.itemNo}" class="link">${itemDto.itemName}</a>
								</td>
								<td>${itemDto.itemPrice}</td>
								<td>${itemDto.itemSalePrice}</td>
								<td>${itemDto.itemDate}</td>
								<td>${itemDto.itemCnt}</td>
								<td>${itemDto.itemSize}</td>
								<td>
									<a href="update?itemNo=${itemDto.itemNo}" class="btn btn-positive">수정</a>
								</td>
								<td>
									<a href="delete?itemNo=${itemDto.itemNo}" class="btn btn-positive">삭제</a>
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		
		
	</div>
	<div class="row right">
		<a href="#" class="link link-animation"><h3 style="margin-right: 1em;">상품 추가</h3></a>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>