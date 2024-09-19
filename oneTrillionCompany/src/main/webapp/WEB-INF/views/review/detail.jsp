<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    
    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.min.js"></script>
    
    <style>
        .test-score {
            font-size: 25px; /* 별점 크기 조정 */
        }
        .content-box {
        	width : 600px;
        	background-color : #f6f7f8;
        	font-size : 15px;
        	font-weight: 200 !important;
        	min-width : 600px;
        	padding : 10px 20px;
			white-space: pre-wrap;
        	
        }
        .image-location {
        	justify-content :space-between;
        	padding : 10px 20px;
        }
        .writer-box {
        	font-size : 20px;
        }
        .reviewContantBox {
   	        word-wrap: break-word; /* 긴 단어를 줄바꿈 */
	        overflow-wrap: break-word; /* 박스 범위를 넘는 단어 줄바꿈 */
	        white-space: normal; /* 기본 줄바꿈 설정 */
	        white-space: no-wrap;
        }
        
        
		.button-list {
		    display: grid;
		    grid-template-columns: 1fr auto;
		    padding: 10px 20px;
		}
		
		.button-list .left {
		    align-items: center;
		}
		
		.button-list .right {
		    align-items: center;
		    justify-content: flex-end;
		}
		
		.button-list .row {
		    margin: 0;
		}
    </style>

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
        
        
        $(function(){
        	$(".btn-delete").click(function(e){
        		e.preventDefault();
        		var del = window.confirm("게시글을 삭제 하시겠습니까?");
        			if(del) {
        				$("#delete-form").submit();
       			}
        	})
        });
    </script>

	<body>
		<form action="write" method="post" enctype="multipart/form-data" autocomplete="off">
		    <div class="container w-1200">
		    
		    <c:choose>
		    	<%-- 회원/비회원이 보여지는 화면  --%>
		    		<c:when test="${sessionScope.createdLevel != '관리자' || sessionScope.createdUser == null}">
					    <div class="flex-box image-location">
				           	<div class="center">
				                <img src="${pageContext.request.contextPath}/review/image?reviewNo=${reviewDto.reviewNo}" width="400" height="400">
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
							                <div class="reviewContentBox">${reviewDto.reviewContent}</div>
							            </div>
						            </div>
					        </div>
				        </div>
		        	</c:when>
		        	
		    	<%-- 관리자가 보여지는 화면  --%>
		    	<c:when test="${sessionScope.createdLevel == '관리자' }">
					    <div class="flex-box image-location">
				           	<div class="center">
				                <img src="${pageContext.request.contextPath}/review/image?reviewNo=${reviewDto.reviewNo}" width="400" height="400">
				            </div>
		
						        <div class="row center">
						        	<%-- 리뷰 별점 표시  --%>
						            <div class="left">
						                <div class="test-score" data-rate="${reviewDto.reviewScore}"></div>
						            </div>
							            <div class="left writer-box mt-30">
												${reviewDto.reviewWriterString}
												<span>님의 리뷰입니다.</span>
							            </div>
				            
						            <%-- 리뷰 내용 표시  --%>
						            <div class="row">
							            <div class="content-box left">
							                <div class="reviewContentBox">${reviewDto.reviewContent}</div>
							            </div>
						            </div>
					        </div>
				        </div>		        
			        </c:when>
		    	 </c:choose>   
		    </div>
		</form>
		
		  <%-- 수정 삭제 버튼 --%>
			<form action="delete?reviewNo=${reviewDto.reviewNo}" method="post" enctype="multipart/form-data" autocomplete="off" id="delete-form">
   				<div class="container w-1200">
					<div class= " flex-box button-list ">
					
				          <div class="row left">
								<a href="${pageContext.request.contextPath}/review/list"  class="btn btn-positive btn-list ">
									<i class="fa-solid fa-list"></i> 목록
								</a>
							</div>				
								
						<div class="row right">
				            <c:if test="${sessionScope.createdLevel == '관리자'}">
									<a href="${pageContext.request.contextPath}/manager/member/detail?memberId=${reviewDto.reviewWriter}"  class="btn btn-positive  btn-list">
										<i class="fa-solid fa-user"></i> 회원정보
									</a>
				            </c:if>	
	   				            <c:if test="${sessionScope.createdUser == reviewDto.reviewWriter || sessionScope.createdLevel == '관리자'}">
						            <button type="submit" class="btn  btn-negative btn-delete">
						            	<i class="fa-solid fa-trash"></i> 삭제
						            </button>
					            </c:if>	
				          </div>
					</div>
			 </div>
		</form>
	</body>

	
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>