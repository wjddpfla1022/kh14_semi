<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    
    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

    <style>
        .test-score {
            font-size: 25px; /* 별점 크기 조정 */
        }
        .content-box {
        	width : 600px;
        	background-color : #f6f7f8;
        	font-size : 20px;
        	font-weight: 200 !important;
        	padding : 10px 20px;
	        word-wrap: break-word; /* 긴 단어를 줄바꿈 */
	        overflow-wrap: break-word; /* 박스 범위를 넘는 단어 줄바꿈 */
	        white-space: normal; /* 기본 줄바꿈 설정 */
        	
        }
        .image-location {
        	justify-content :space-between;
        	padding : 10px 20px;
        }
        .writer-box {
        	font-size : 20px;
        }
        .reviewContantBox {
        	hite-space: pre-wrap;
        }
    </style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.min.js"></script>

    <!-- 자바스크립트 코드 작성 영역 -->
    <script type="text/javascript">
        $(document).ready(function(){
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
                }
            });
        });
    </script>

	<body>
		<form action="write" method="post" enctype="multipart/form-data" autocomplete="off">
		    <div class="container w-1200">
			    <div class="flex-box image-location">
		           	<div class="center">
		                <img src="/review/image?reviewNo=${reviewDto.reviewNo}" width="400" height="400">
		            </div>

				        <div class="row center">
				        	<%-- 리뷰 별점 표시  --%>
				            <div class="left">
				                <div class="test-score" data-rate="${reviewDto.reviewScore}"></div>
				            </div>
				        	<%-- 작성자를 표시(3글자만 표시 후 나머지 아이디는 * 표시)  --%>
				            <div class="left writer-box mt-30">
								<c:choose>
									<c:when test="${fn:length(reviewDto.reviewWriter) > 3}">
										<%-- 작성자의 아이디를 3글자 추출 후 표시 --%>
										<c:out value="${fn:substring(reviewDto.reviewWriter, 0, 3)}" />
										<%-- 이후 아이디를 * 처리 --%>
										<c:out value="***" />
										<span>님의 리뷰입니다.</span>
									</c:when>
									<c:otherwise>
										<%-- 아이디의 길이가 3글자 이하인 경우를 처리 --%>
										<c:out value="${reviewDto.reviewWriterString}" />
										<span>님의 리뷰입니다.</span>
									</c:otherwise>
								</c:choose>				
				            </div>
				            <%-- 리뷰 내용 표시  --%>
				            <div class="row">
					            <div class="content-box left">
					                <pre class="reviewContentBox">${reviewDto.reviewContent}</pre>
					            </div>
				            </div>

			        </div>
		        </div>
		    </div>
		</form>
	</body>
