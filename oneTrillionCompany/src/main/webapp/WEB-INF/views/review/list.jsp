<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .table-title {
        text-decoration: none;
        color: gray;
    }

    .table-title:hover {
        color: black;
    }
    .tr-table-top {
        background-color: #f0f0f0 !important;
    }
    .th-table-top {
        padding: 10px !important;
        font-weight: bolder;
    }
    .tr-table-bottom {
        border: 1px solid #e9e9e9;
    }
    .td-table-bottom {
        padding: 10px !important;
        font-size: 14px;
    }
    .table {
        border: 1px solid #e9e9e9;
    }
    .login-msg, .noList-msg {
        text-align: center;
        padding: 60px !important;
        font-size: 25px;
    }
    .field-column {
        padding: 0.5em 0.5em 0.7em 0.5em;
    }
    .table tr {
        border: 1px solid #e9e9e9;
        border-bottom: none;
    }
    .tr-table-top {
        background-color: #dcdde1;
    }
    .text-ellipsis {
    display: inline-block; /* 블록 요소로 설정하여 너비 제한 */
    max-width: 200px; /* 필요한 최대 너비를 설정하세요 */
    overflow: hidden; /* 넘치는 텍스트를 숨깁니다 */
    white-space: nowrap; /* 텍스트 줄바꿈을 막습니다 */
    text-overflow: ellipsis; /* 넘치는 텍스트를 "..."으로 표시합니다 */
    vertical-align: middle; /* 세로 정렬을 위해 추가 (선택 사항) */
}
   
    
   
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.min.js"></script>

<script type="text/javascript">
    $(document).ready(function() {
        $(".test-score").score({
            starColor: "orange", // 별 색상
            editable: false, // 점수 변경 불가
            integerOnly: true, // 정수만 허용
            send: {
                sendable: false // 전송 불가
            },
            display: {
                placeLimit: 1, // 소수점 자리수
                textColor: "#0984e3" // 텍스트 색상
            },
            point: {
                max: 5 // 최대 점수
                // rate는 data-rate 속성으로 설정됩니다.
            }
        });
    });
</script>

<div class="container w-1000 my-30">
    <div class="row center">
        <h1>REVIEW</h1>
        
    </div>
    <hr>

	<%-- 회원일 경우  --%>
    <div class="row center mt-30">
        <c:choose>
            <c:when test="${sessionScope.createdUser == null || sessionScope.createdLevel !='관리자'}">
                <table class="table table-top">
                    <thead>
                        <tr class="tr-table-top">
                            <td width=23%>상품이름</td>
                            <td width=53%>리뷰내용</td>
                            <td width=14%>아이디</td>
                            <td width=10%>별점</td>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${fn:length(list) == 0}">
                                <tr>
                                    <td class="noList-msg" colspan="4">
                                        검색 결과가 존재하지 않습니다.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="reviewDto" items="${list}">
                                    <tr class="tr-table-bottom">
                                        <td class="td-table-bottom">${reviewDto.reviewItemName}</td>
                                        <td class="td-table-bottom">
   									 <a href="detail?reviewNo=${reviewDto.reviewNo}" class="table-title text-ellipsis">${reviewDto.reviewContent}</a>
										</td>
                                        <td class="td-table-bottom">
                                            <c:choose>
                                                <c:when test="${reviewDto.reviewWriter == null}">탈퇴한 사용자</c:when>
                                                	<c:otherwise>
														<c:choose>
															<c:when test="${fn:length(reviewDto.reviewWriter) > 3}">
																<%-- 작성자의 아이디를 3글자 추출 후 표시 --%>
																<c:out value="${fn:substring(reviewDto.reviewWriter, 0, 3)}" />
																<%-- 이후 아이디를 * 처리 --%>
																<c:out value="***" />
															</c:when>
															<c:otherwise>
																<%-- 아이디의 길이가 3글자z 이하인 경우를 처리 --%>
																<c:out value="${reviewDto.reviewWriter}" />
															</c:otherwise>
														</c:choose>
                                                	</c:otherwise>
                                            	</c:choose>
                                        </td>
                                        <td class="td-table-bottom">
                                            <div class="test-score" data-rate="${reviewDto.reviewScore}"></div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </c:when>
        </c:choose>
		<%-- 관리자일 경우  --%>
        <c:choose>
            <c:when test="${sessionScope.createdLevel == '관리자'}">
                <table class="table table-top mt-30">
                    <thead>
                        <tr class="tr-table-top">
                            <td width=10%>상품이름</td>
                            <td width=60%>리뷰내용</td>
                            <td width=10%>아이디</td>
                            <td width=10%>별점</td>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${fn:length(list) == 0}">
                                <tr>
                                    <td class="noList-msg" colspan="4">
                                        검색 결과가 존재하지 않습니다.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="reviewDto" items="${list}">
                                    <tr class="tr-table-bottom">
                                        <td class="td-table-bottom">${reviewDto.reviewItemName}</td>
                                        <td class="td-table-bottom">
    									<a href="detail?reviewNo=${reviewDto.reviewNo}" class="table-title text-ellipsis">${reviewDto.reviewContent}</a>
										</td>
                                        <td class="td-table-bottom">${reviewDto.reviewWriterString}</td>
                                        <td class="td-table-bottom">
                                            <div class="test-score" data-rate="${reviewDto.reviewScore}"></div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </c:when>
        </c:choose>
    </div>

    <form action="list" method="get" autocomplete="off">
        <div class="row center mt-30">
            <select name="column" class="field-column">
                <option value="review_writer"
                    <c:if test="${param.column == 'review_writer'}">selected</c:if>>아이디</option>
                <option value="review_content"
                    <c:if test="${param.column == 'review_content'}">selected</c:if>>리뷰 내용</option>
            </select>
            <input class="field" type="text" name="keyword" value="${param.keyword}">
            <button class="btn btn-positive" type="submit">
                <i class="fa-solid fa-magnifying-glass"></i> 검색
            </button>
        </div>
    </form>
</div>

<jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
