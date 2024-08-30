<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- Score.js 라이브러리 및 Summernote CDN -->
<script src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>

<!-- 자바스크립트 코드 작성 영역 -->
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
                showNumber: true, // 설정된 숫자 표시 가능 여부
                placeLimit: 0, // 소수점 자리수 표시 길이
                textColor: "#0984e3", // 텍스트 색상
            },
            point: {
                max: 5, // 최대 점수
                rate: 5, // 기본 점수
            },
            onChange: function(score) {
                // 별점이 변경될 때마다 input 필드의 값을 업데이트
                console.log("score : " + score);
                $('input[name="reviewScore"]').val(score);
//                 $(this).parent().find(".display-panel").text(getPointFromPercent(data.max, percent)
            }
        });

        // 페이지 로드 시 초기 별점 값을 input에 반영
//         $('input[name="reviewScore"]').val(score).score("rate"));
    });
</script>
<form action="write" method="post" enctype="multipart/form-data" autocomplete="off">
    <div class="container w-800">

        <div class="row center">
            <input type="text" name="reviewWriter" class="field w-100" value="${memberId}">
         <div class="row">
            <label>내용</label>
            <textarea name="reviewContent" rows="10" class="field w-100"></textarea>
        </div>
        <div class="row">
            <label>결제상세넘버</label>
            <input type="text" name="reviewItemNo" class="field w-100">
        </div>
            <div class="row">
                <!-- 별점 선택 값을 저장하는 input 필드 -->
                <label>별점</label>
                <div class="test-score"></div>
                <input type="text" name="reviewScore" class="field w-100">
            </div>
        <div class="row">
            <label>이미지</label>
             <input type="file" name="attach" class="field w-100" accept="image/*">
        </div>
        <div class="row right">
            <button type="submit" class="btn btn-positive">작성하기</button>
        </div>
    	</div>
	</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>