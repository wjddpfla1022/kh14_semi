<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
      
    <style>
	  .row textarea {
	  	width : 100%;
	  	resize : none;
	  	height : 200px;
	  	font-size : 17px;
	  	padding : 0.5em;
	   }
  
    </style>

    <!--jquery cdn-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    
    <script type="text/javascript">
	$(function(){
		$(".member_clear").click(function(e){
			e.preventDefault();
			var clear = window.confirm("차단을 해제 하시겠습니까?");
            if (clear) {
                // 확인을 클릭한 경우 폼 제출
                $("#clearForm").submit();
            }
            // 취소 버튼을 누를 경우 동작X
		});
	});
    </script>

</head>
<body>
    <form action="clear" method="post" id="clearForm">
        <div class="container w-600 my-30">
	        <div class="row center">
	        	<h1>${param.memberId}에 대한 차단해제 설정</h1>
	        </div>
        	<div class="row center">
	            <input type="hidden" id="idValue" name="blockMemberId" value="${param.memberId}">
	            <textarea name="blockMemo" placeholder="해제 사유를 입력하세요" rows="10" cols="60"></textarea>
	            <div>
	                <button type="button"  class="btn member_clear">차단해제</button>
	            </div>
            </div>
        </div>
    </form>
</body>
</html>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
