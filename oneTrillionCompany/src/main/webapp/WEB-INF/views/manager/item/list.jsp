<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="/js/checkbox.js"></script>

<style>
	.th-table-top{
		font-size: 13px;
	}
</style>

<script type="text/javascript">
	$(function() {
		$(".btn-item-delete").click(function(e) {
			e.preventDefault();
			var deleteItem = window.confirm("정말로 삭제 하시겠습니까?");
			if (deleteItem) {
				window.location.href = $(this).attr("href");
			}
		});
	});
	$(function() {
	    $(".confirm-link").click(function(e) {
	        e.preventDefault(); // 기본 동작(폼 제출)을 막음
	        var confirmation = window.confirm("선택한 항목을 삭제하시겠습니까?"); // 안내 메시지 표시
	        if (confirmation) {
	            $(this).closest('form').submit(); // 확인을 누르면 폼을 제출
	        }
	    });
	});
</script>

<div class="container w-1200">
	<div class="row center">
		<h1>상품 검색</h1>
	</div>

	<!-- 	<div class="row right"> -->
	<%-- 		<h3>데이터개수 : ${itemList.size()}</h3> --%>
	<%-- 		${pageVO} --%>
	<%-- 		${pageVO.getColumn()} --%>
	<%-- 		${pageVO.isSearch()} --%>
	<!-- 	</div> -->

	<!-- 검색창 -->
	<div class="row center">
		<form action="list" method="get" autocomplete="off">
			<select class="field-column" name="column" id="column-select"
				onchange="toggleInputField()">
				<option value="item_name"
					<c:if test="${param.column=='item_name'}">selected</c:if>>상품명</option>
				<option value="item_no"
					<c:if test="${param.column=='item_no'}">selected</c:if>>상품
					번호</option>
				<option value="item_cate1"
					<c:if test="${param.column=='item_cate1'}">selected</c:if>>카테고리</option>
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

			<button class="btn btn-positive" type="submit">
				<i class="fa-solid fa-magnifying-glass"></i> 검색
			</button>
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
			<c:if test="${sessionScope.createdLevel == '관리자' }">
				<div class="float-box">
					<div class="float-right">
						<button type="button" class="btn btn-negative confirm-link">체크된 항목 삭제</button>
					</div>
					<div class="float-left">
						<a href="/manager/item/insert" class="btn btn-positive" style="margin-right: 1em;">상품 추가</a>
					</div>
				</div>
			</c:if>
			<table  class="table table-top mt-30 table-hover">
				<thead>
					<tr class="tr-table-top">
						<c:if test="${sessionScope.createdLevel == '관리자' }">
							<th class="th-table-top"><input type="checkbox" class="check-all"></th>
						</c:if>
							<th class="th-table-top" width="5%">번호</th>
							<th class="th-table-top"  width="5%">사진</th>
							<th colspan='3' class="th-table-top"  width="20%">카테고리</th>
							<th class="th-table-top"  width="10%">상품명</th>
							<th class="th-table-top"  width="5%">정가</th>
							<th class="th-table-top"  width="5%">판매가</th>
							<th class="th-table-top"  width="10%">등록일</th>
							<th class="th-table-top"  width="5%">수량</th>
							<th class="th-table-top"  width="15%">사이즈 / 색상</th>
							<th width="15%"></th>
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
								<tr class="tr-table-bottom">
									<c:if test="${sessionScope.createdLevel == '관리자' }">
										<td class="td-table-bottom"><input type="checkbox" class="check-item"
											name="itemNo" value="${itemDto.itemNo}"></td>
									</c:if>
									<td class="td-table-bottom">${itemDto.itemNo}</td>
									<td class="td-table-bottom"><img src="/item/image?itemNo=${itemDto.itemNo}"
										width="30px" height="30px"></td>
									<c:choose>
										<c:when test="${itemDto.itemCate1 == '11'}">
											<td class="td-table-bottom">상의</td>
										</c:when>
										<c:when test="${itemDto.itemCate1 == '33'}">
											<td class="td-table-bottom">하의</td>
										</c:when>
										<c:when test="${itemDto.itemCate1 == '55'}">
											<td class="td-table-bottom">신발</td>
										</c:when>
										<c:when test="${itemDto.itemCate1 == '77'}">
											<td class="td-table-bottom">아우터</td>
										</c:when>
										<c:otherwise>
											<td class="td-table-bottom">기타</td>
										</c:otherwise>
									</c:choose>

									<c:choose>
										<c:when test="${itemDto.itemCate2 == '10'}">
											<td class="td-table-bottom">티셔츠</td>
										</c:when>
										<c:when test="${itemDto.itemCate2 == '11'}">
											<td class="td-table-bottom">셔츠</td>
										</c:when>
										<c:when test="${itemDto.itemCate2 == '30'}">
											<td class="td-table-bottom">슬랙스</td>
										</c:when>
										<c:when test="${itemDto.itemCate2 == '31'}">
											<td class="td-table-bottom">데님</td>
										</c:when>
										<c:when test="${itemDto.itemCate2 == '32'}">
											<td class="td-table-bottom">트레이닝</td>
										</c:when>
										<c:when test="${itemDto.itemCate2 == '33'}">
											<td class="td-table-bottom">반바지</td>
										</c:when>
										<c:when test="${itemDto.itemCate2 == '50'}">
											<td class="td-table-bottom">스니커즈</td>
										</c:when>
										<c:when test="${itemDto.itemCate2 == '51'}">
											<td class="td-table-bottom">로퍼/슬립온</td>
										</c:when>
										<c:when test="${itemDto.itemCate2 == '52'}">
											<td class="td-table-bottom">구두</td>
										</c:when>
										<c:when test="${itemDto.itemCate2 == '53'}">
											<td class="td-table-bottom">워커/부츠</td>
										</c:when>
										<c:when test="${itemDto.itemCate2 == '54'}">
											<td class="td-table-bottom">샌들/슬리퍼</td>
										</c:when>
										<c:when test="${itemDto.itemCate2 == '55'}">
											<td class="td-table-bottom">깔창/기타</td>
										</c:when>
										<c:when test="${itemDto.itemCate2 == '70'}">
											<td class="td-table-bottom">가디건</td>
										</c:when>
										<c:when test="${itemDto.itemCate2 == '71'}">
											<td class="td-table-bottom">블루종</td>
										</c:when>
										<c:when test="${itemDto.itemCate2 == '72'}">
											<td class="td-table-bottom">집업</td>
										</c:when>
										<c:when test="${itemDto.itemCate2 == '73'}">
											<td class="td-table-bottom">바람막이</td>
										</c:when>
										<c:when test="${itemDto.itemCate2 == '74'}">
											<td class="td-table-bottom">블레이저</td>
										</c:when>
										<c:when test="${itemDto.itemCate2 == '75'}">
											<td class="td-table-bottom">청재킷</td>
										</c:when>
										<c:otherwise>
											<td class="td-table-bottom">기타</td>
										</c:otherwise>
									</c:choose>

									<c:choose>
										<c:when test="${itemDto.itemCate3 == '10'}">
											<td class="td-table-bottom">7부</td>
										</c:when>
										<c:when test="${itemDto.itemCate3 == '11'}">
											<td class="td-table-bottom">민소매</td>
										</c:when>
										<c:when test="${itemDto.itemCate3 == '12'}">
											<td class="td-table-bottom">긴팔</td>
										</c:when>
										<c:when test="${itemDto.itemCate3 == '13'}">
											<td class="td-table-bottom">반팔</td>
										</c:when>
										<c:when test="${itemDto.itemCate3 == '14'}">
											<td class="td-table-bottom">맨투맨</td>
										</c:when>
										<c:when test="${itemDto.itemCate3 == '15'}">
											<td class="td-table-bottom">후드</td>
										</c:when>
										<c:when test="${itemDto.itemCate3 == '16'}">
											<td class="td-table-bottom">니트/스웨터</td>
										</c:when>
										<c:when test="${itemDto.itemCate3 == '17'}">
											<td class="td-table-bottom">반팔셔츠</td>
										</c:when>
										<c:when test="${itemDto.itemCate3 == '18'}">
											<td class="td-table-bottom">7부 셔츠</td>
										</c:when>
										<c:when test="${itemDto.itemCate3 == '19'}">
											<td class="td-table-bottom">긴팔 셔츠</td>
										</c:when>
										<c:when test="${itemDto.itemCate3 == '20'}">
											<td class="td-table-bottom">베이직/심플</td>
										</c:when>
										<c:when test="${itemDto.itemCate3 == '21'}">
											<td class="td-table-bottom">스트라이프</td>
										</c:when>
										<c:when test="${itemDto.itemCate3 == '22'}">
											<td class="td-table-bottom">체크</td>
										</c:when>
										<c:when test="${itemDto.itemCate3 == '30'}">
											<td class="td-table-bottom">스트레이트핏</td>
										</c:when>
										<c:when test="${itemDto.itemCate3 == '31'}">
											<td class="td-table-bottom">테이퍼드핏</td>
										</c:when>
										<c:when test="${itemDto.itemCate3 == '32'}">
											<td class="td-table-bottom">와이드핏</td>
										</c:when>
										<c:when test="${itemDto.itemCate3 == '33'}">
											<td class="td-table-bottom">일반 반바지</td>
										</c:when>
										<c:when test="${itemDto.itemCate3 == '34'}">
											<td class="td-table-bottom">데님 반바지</td>
										</c:when>
										<c:when test="${itemDto.itemCate3 == '35'}">
											<td class="td-table-bottom">스트레이트핏</td>
										</c:when>
										<c:when test="${itemDto.itemCate3 == '36'}">
											<td class="td-table-bottom">테이퍼드핏</td>
										</c:when>
										<c:when test="${itemDto.itemCate3 == '37'}">
											<td class="td-table-bottom">와이드핏</td>
										</c:when>
										<c:when test="${itemDto.itemCate3 == '38'}">
											<td class="td-table-bottom">트레이닝</td>
										</c:when>
										<c:when test="${itemDto.itemCate3 == '39'}">
											<td class="td-table-bottom">조거</td>
										</c:when>
										<c:otherwise>
											<td class="td-table-bottom"></td>
										</c:otherwise>
									</c:choose>
									<td class="td-table-bottom"><a
										href="/manager/item/info/read?itemNo=${itemDto.itemNo}"
										class="link">${itemDto.itemName} / ${itemDto.itemMain}</a></td>
									<td class="td-table-bottom">${itemDto.itemPrice}</td>
									<td class="td-table-bottom">${itemDto.itemSalePrice}</td>
									<td class="td-table-bottom">${itemDto.itemDate}</td>
									<td class="td-table-bottom">${itemDto.itemCnt}</td>
									<td class="td-table-bottom">${itemDto.itemSize} / ${itemDto.itemColor}</td>
									
									<td class="td-table-bottom">
									<div class="row">
										<a href="info/write?itemNo=${itemDto.itemNo}"class="btn btn-positive">정보 입력</a> 
									</div>
									<div class="row">
										<a href="info/edit?itemNo=${itemDto.itemNo}" class="btn btn-positive">정보 수정</a>
									</div>
									<div class="row">
										<a href="update?itemNo=${itemDto.itemNo}" class="btn btn-positive">수정</a>
										<a href="delete?itemNo=${itemDto.itemNo}" class="btn btn-negative btn-item-delete">삭제</a>
									</div>
									</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</form>
		<jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include>

	</div>
<!-- 	<div class="row right"> -->
<!-- 		<a href="/manager/item/insert" class="link link-animation" style="margin-right: 1em;">상품 추가</a> -->
<!-- 	</div> -->
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>