<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="/js/checkbox.js"></script>

<script type="text/javascript">
	$(function(){
		$(".btn-item-delete").click(function(e){
			var deleteItem = window.confirm("정말로 삭제 하시겠습니까?");
			if(deleteItem) { 
				window.location.href = $(this).attr("href"); 
			}
		});
	});
</script>

<div class="container w-1200">
	<div class="row center">
		<h1>상품 검색</h1>
	</div>
	<div class="row right">
		<h3>데이터개수 : ${itemList.size()}</h3>
		${pageVO}
		${pageVO.getColumn()}
		${pageVO.isSearch()}
	</div>
	<!-- 검색창 -->
	<div class="row center" style="margin-bottom: 10px;">
		<form action="list" method="get" autocomplete="off" class="field">
			<select class="field" name="column" id="column-select"
				onchange="toggleInputField()">
				<option value="item_no"
					<c:if test="${param.column=='item_no'}">selected</c:if>>상품
					번호</option>
				<option value="item_cate1"
					<c:if test="${param.column=='item_cate1'}">selected</c:if>>카테고리</option>
				<option value="item_name"
					<c:if test="${param.column=='item_name'}">selected</c:if>>상품명</option>
			</select>

			<!-- 상품 번호와 상품명을 위한 텍스트 입력 필드 -->
			<input class="field" type="text" id="text-input" name="keyword"
				style="display: none;" value="${param.keyword}">

			<!-- 카테고리를 위한 셀렉트 박스 -->
			<select class="field" name="keyword" id="category-select"
				style="display: none;">
				<option value="11">상의</option>
				<option value="33">하의</option>
				<option value="55">슈즈</option>
				<option value="77">아우터</option>
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
				} else if (column === 'item_cate1') {
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
	<form action="deleteAll" method="post">
<c:if test= "${sessionScope.createdLevel == '관리자' }">
<div class="row right">
	<button type="submit" class="btn btn-negative btn-item-delete">체크된 항목 삭제</button>
</div>
</c:if>
		<table class="table table-border table-hover">
			<thead>
				<tr>
				<c:if test= "${sessionScope.createdLevel == '관리자' }">
  					<th>
  						<input type="checkbox" class="check-all">
  					</th>
  				</c:if>
					<th>상품번호</th>
					<th>사진</th>
					<th colspan='3'>카테고리</th>
					<th>상품명</th>
					<th>정가</th>
					<th>판매가</th>
					<th>등록일</th>
					<th>수량</th>
					<th>사이즈</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<%--검색 결과가 없을 때 --%>
					<c:when test="${itemList.isEmpty()}">
						<h3>검색 결과가 존재하지 않습니다</h3>
					</c:when>
					<%--검색 결과가 있을 때 --%>
					<c:otherwise>
						<c:forEach var="itemDto" items="${itemList}">
							<tr>
							<c:if test= "${sessionScope.createdLevel == '관리자' }">
  								<td>
  									<input type="checkbox" class="check-item" name="itemNo" value="${itemDto.itemNo}">
  								</td>
  							</c:if>
								<td>${itemDto.itemNo}</td>
								<td><img src = "/item/image?itemNo=${itemDto.itemNo}" width="30px" height="30px"></td>
								<c:choose>
									<c:when test="${itemDto.itemCate1 == '11'}">
										<td>상의</td>
									</c:when>
									<c:when test="${itemDto.itemCate1 == '33'}">
										<td>하의</td>
									</c:when>
									<c:when test="${itemDto.itemCate1 == '55'}">
										<td>신발</td>
									</c:when>
									<c:when test="${itemDto.itemCate1 == '77'}">
										<td>아우터</td>
									</c:when>
									<c:otherwise>
										<td>기타</td>
									</c:otherwise>
								</c:choose>
								
								<c:choose>
									<c:when test="${itemDto.itemCate2 == '10'}">
										<td>티셔츠</td>
									</c:when>
									<c:when test="${itemDto.itemCate2 == '11'}">
										<td>셔츠</td>
									</c:when>
									<c:when test="${itemDto.itemCate2 == '30'}">
										<td>슬랙스</td>
									</c:when>
									<c:when test="${itemDto.itemCate2 == '31'}">
										<td>데님</td>
									</c:when>
									<c:when test="${itemDto.itemCate2 == '32'}">
										<td>트레이닝</td>
									</c:when>
									<c:when test="${itemDto.itemCate2 == '33'}">
										<td>반바지</td>
									</c:when>
									<c:when test="${itemDto.itemCate2 == '50'}">
										<td>스니커즈</td>
									</c:when>
									<c:when test="${itemDto.itemCate2 == '51'}">
										<td>로퍼/슬립온</td>
									</c:when>
									<c:when test="${itemDto.itemCate2 == '52'}">
										<td>구두</td>
									</c:when>
									<c:when test="${itemDto.itemCate2 == '53'}">
										<td>워커/부츠</td>
									</c:when>
									<c:when test="${itemDto.itemCate2 == '54'}">
										<td>샌들/슬리퍼</td>
									</c:when>
									<c:when test="${itemDto.itemCate2 == '55'}">
										<td>깔창/기타</td>
									</c:when>
									<c:when test="${itemDto.itemCate2 == '70'}">
										<td>가디건</td>
									</c:when>
									<c:when test="${itemDto.itemCate2 == '71'}">
										<td>블루종</td>
									</c:when>
									<c:when test="${itemDto.itemCate2 == '72'}">
										<td>집업</td>
									</c:when>
									<c:when test="${itemDto.itemCate2 == '73'}">
										<td>바람막이</td>
									</c:when>
									<c:when test="${itemDto.itemCate2 == '74'}">
										<td>블레이저</td>
									</c:when>
									<c:when test="${itemDto.itemCate2 == '75'}">
										<td>청재킷</td>
									</c:when>
									<c:otherwise>
										<td>기타</td>
									</c:otherwise>
								</c:choose>	
									
								<c:choose>
									<c:when test="${itemDto.itemCate3 == '10'}">
										<td>7부</td>
									</c:when>
									<c:when test="${itemDto.itemCate3 == '11'}">
										<td>민소매</td>
									</c:when>
									<c:when test="${itemDto.itemCate3 == '12'}">
										<td>긴팔</td>
									</c:when>
									<c:when test="${itemDto.itemCate3 == '13'}">
										<td>반팔</td>
									</c:when>
									<c:when test="${itemDto.itemCate3 == '14'}">
										<td>맨투맨</td>
									</c:when>
									<c:when test="${itemDto.itemCate3 == '15'}">
										<td>후드</td>
									</c:when>
									<c:when test="${itemDto.itemCate3 == '16'}">
										<td>니트/스웨터</td>
									</c:when>
									<c:when test="${itemDto.itemCate3 == '17'}">
										<td>반팔셔츠</td>
									</c:when>
									<c:when test="${itemDto.itemCate3 == '18'}">
										<td>7부 셔츠</td>
									</c:when>
									<c:when test="${itemDto.itemCate3 == '19'}">
										<td>긴팔 셔츠</td>
									</c:when>
									<c:when test="${itemDto.itemCate3 == '20'}">
										<td>베이직/심플</td>
									</c:when>
									<c:when test="${itemDto.itemCate3 == '21'}">
										<td>스트라이프</td>
									</c:when>
									<c:when test="${itemDto.itemCate3 == '22'}">
										<td>체크</td>
									</c:when>
									<c:when test="${itemDto.itemCate3 == '30'}">
										<td>스트레이트핏</td>
									</c:when>
									<c:when test="${itemDto.itemCate3 == '31'}">
										<td>테이퍼드핏</td>
									</c:when>
									<c:when test="${itemDto.itemCate3 == '32'}">
										<td>와이드핏</td>
									</c:when>
									<c:when test="${itemDto.itemCate3 == '33'}">
										<td>일반 반바지</td>
									</c:when>
									<c:when test="${itemDto.itemCate3 == '34'}">
										<td>데님 반바지</td>
									</c:when>
									<c:when test="${itemDto.itemCate3 == '35'}">
										<td>스트레이트핏</td>
									</c:when>
									<c:when test="${itemDto.itemCate3 == '36'}">
										<td>테이퍼드핏</td>
									</c:when>
									<c:when test="${itemDto.itemCate3 == '37'}">
										<td>와이드핏</td>
									</c:when>
									<c:when test="${itemDto.itemCate3 == '38'}">
										<td>트레이닝</td>
									</c:when>
									<c:when test="${itemDto.itemCate3 == '39'}">
										<td>조거</td>
									</c:when>
									<c:otherwise>
										<td></td>
									</c:otherwise>
								</c:choose>
								<td><a href="/manager/item/info/read?itemNo=${itemDto.itemNo}" class="link">${itemDto.itemName}</a>
								</td>
								<td>${itemDto.itemPrice}</td>
								<td>${itemDto.itemSalePrice}</td>
								<td>${itemDto.itemDate}</td>
								<td>${itemDto.itemCnt}</td>
								<td>${itemDto.itemSize}</td>
								<td><a href="info/write?itemNo=${itemDto.itemNo}"
									class="btn btn-positive">정보 입력</a>
									<a href="info/edit?itemNo=${itemDto.itemNo}"
									class="btn btn-positive">정보 수정</a></td>
								<td><a href="update?itemNo=${itemDto.itemNo}"
									class="btn btn-positive">수정</a></td>
								<td><a href="delete?itemNo=${itemDto.itemNo}"
									class="btn btn-negative btn-item-delete">삭제</a></td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
</form>
<jsp:include page= "/WEB-INF/views/template/navigator.jsp"></jsp:include>

	</div>
	<div class="row right">
		<a href="/manager/item/insert" class="link link-animation"><h3
				style="margin-right: 1em;">상품 추가</h3></a>
	</div>
	
	
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>