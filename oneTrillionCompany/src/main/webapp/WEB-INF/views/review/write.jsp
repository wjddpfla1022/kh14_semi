<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- Score.js 라이브러리 및 Summernote CDN -->
<script src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>

<style>
        .container {
            display: flex;
            flex-direction: column;
        }

        .image-upload {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .buttonBox {
            display: flex;
            justify-content: center;
            border : 1px solid #f0f0f0;
            width : 350px;
            font-size : 20px;
            padding : 10px 20px;
        }

        .buttonBox > label{
            cursor: pointer;
            font-size: 1em;
        }
		/* 파일 선택창과 파일명을 안보이게 설정 */
        .chooseFile , 
        #fileName { 
            visibility: hidden;
        }

        .fileContainer {
            display: flex;
            align-items: center;
        }

        .fileInput {
            display: flex;
            align-items: center;
            width: 60%;
            height: 30px;
        }

        #fileName {
            margin-left: 5px;
        }
        .contantField > textarea {
        	resize : none;
        	min-height: 250px;
        	padding : 5px 10px;
        	margin-top : 0.5em;
        }
     	.reviewScore{
        	border : none;
        }
        .test-score {
            font-size: 35px; 
        }
        
</style>

<script type="text/javascript">
    $(function() {
        // 별점 초기화 및 설정
        $(".test-score").score({
            starColor: "orange", // 별 색상
            editable: true, // 점수 변경 가능 여부
            integerOnly: true, // 정수만 설정 가능 여부
            send: {
                sendable: true, // 전송 가능 여부
                name: "reviewScore", // 전송될 이름
            },
            display: {
                placeLimit: 0, // 소수점 자리수 표시 길이
            },
            point: {
                max: 5, // 최대 점수
                rate: 0, // 기본값을 0으로 설정
            },
            onChange: function(score) {
                // 별점이 변경될 때마다 input 필드의 값을 업데이트
                console.log("score : " + score);
                $('input[name="reviewScore"]').val(score);
            }
        });
    });

    function loadFile(input) {
        var file = input.files[0];

        var name = document.getElementById('fileName');
        name.textContent = file.name;

        var newImage = document.createElement("img");
        newImage.setAttribute("class", 'img');
        newImage.src = URL.createObjectURL(file);

        newImage.style.width = "300px";
        newImage.style.height = "300px";
        newImage.style.objectFit = "contain";

        // 이미지를 삽입할 요소를 선택하여 추가합니다.
        var imageUploadDiv = document.querySelector('.image-upload');
        imageUploadDiv.appendChild(newImage);
    }
    
    $(function(){
		$(".review-regi").click(function(e){
			e.preventDefault();
			

			/* 작성된 내용이 없는경우 메시지 출력 */
			var noText = $("textarea[name=reviewContent]").val().trim();
			if(noText.length == 0) {
				window.alert("리뷰 내용을 작성해주세요.");
				return;
			}
			
			var regi = window.confirm("등록하시겠습니까?");
            if (regi) {
                // 확인을 클릭한 경우 폼 제출
                $("#regi-form").submit();
            }
            // 취소 버튼을 누를 경우 동작X
		});
	});
</script>

<form action="write" method="post" enctype="multipart/form-data" autocomplete="off" id="regi-form">
    <div class="container w-800">
    	<%-- 작성자 아이디는 안보이게 처리 --%>
        <div class="row">
            <input type="hidden" name="reviewWriter" class="field w-100" value="${memberId}" readonly>
        </div>   
        <%-- 별점 작성란  --%>  
         <div class="row">
        	<label>상품은 만족하셨나요?</label>
            <!-- 별점 선택 값을 저장하는 input 필드 -->
            <div class="test-score w-100"></div>
            <input type="text" name="reviewScore" class="reviewScore">
        </div>
        <%-- 리뷰내용 작성란  --%>  
        <div class="contantField mt-20">
            <label>어떤 점이 좋았나요?</label>
            <textarea name="reviewContent" rows="10" class="w-100" placeholder="상품에 대한 의견을 자세히 공유해주세요."></textarea>
        </div>
        <%-- reviewItemNo 의 값은 안보이게 처리 --%>
        <div class="row">
            <input type="hidden" name="reviewItemNo" class="w-100" value="${orderDetailDto.orderDetailItemNo}" readonly>
        </div>
        
		<%-- 이미지 관련 설정 --%>
        <div class="image-upload mt-30">
            <div class="buttonBox">
                <label class="choiceImage" for="attachFile">
               		 <i class="fa-solid fa-camera-retro"></i>사진 첨부
                </label>
            </div>
            <input id="attachFile" type="file" name="attach" class="chooseFile w-100" accept="image/*" onchange="loadFile(this)">
        </div>
        <div class="fileContainer left">
            <div class="fileInput">
                <p id="fileName" ></p>
            </div>
        </div>
        <%-- 버튼란 --%>
        <div class="row right mt-30">
            <button type="submit" class="btn btn-positive review-regi">작성하기</button>
        </div>
    </div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
