<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

    <style>

    </style>
    <script src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.min.js"></script>

    <!-- 자바스크립트 코드 작성 영역 -->
    <script type="text/javascript">
        $(function(){
            $(".test-score").score({
                starColor: "orange", //별 색상
                // backgroundColor: "black", //배경 색상
                editable: true, //점수 변경 가능 여부
                integerOnly: true, //정수만 설정 가능 여부
                // zeroAvailable:false,//0 설정 가능 여부
                send:{
                    sendable:true,//전송 가능 여부
                    name:"reviewScore",//전송 가능할 경우 전송될 이름
                },
                display: {
                    showNumber: true, //설정된 숫자 표시 가능 여부
                    placeLimit: 1, //소수점 자리수 표시 길이
                    textColor:"#0984e3",//텍스트 색상
                },
                point: {
                    max: 5,//최대 점수(data-max로 대체 가능)
                    rate: 5,//실제 점수(data-rate로 대체 가능)
                }
            });
        });
    </script>

<body>
<form action="write" method="post" enctype="multipart/form-data" autocomplete="off">
    <div class="container w-1200">
      <div class="row center">
         <div class="left">
            <div class="">작성자 : ${reviewDto.reviewWriterString}</div>
        </div>
        <div class="left">
                <div class="test-score">${reviewDto.reviewScore}</div>
        </div>
        <div class="center">
        <img src="image?reviewNo=${reviewDto.reviewNo}" width="150" height="150">
        </div>
            <div class="row">
                <div class="">${reviewDto.reviewContent}</div>
            </div>
   </div>
  </div>
</form>
</body>