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
	  $(".member_block").click(function(e){
		  e.preventDefault();
		  var block = window.confirm("차단하시겠습니까?");
		  if(block) {
			  $("#blockForm").submit();
		  }
		  //취소 버튼을 누르면 아무 동작도 하지 않음
	  }) ;
   });
    </script>

</head>
<body>
    <form action="block" method="post" id="blockForm">
        <div class="container w-600 my-30">
   	        <div class="row center">
	        	<h1>${param.memberId}에 대한 차단 설정</h1>
	        </div>
        	<div class="row center">
	            <input type="hidden" id="idValue" name="blockMemberId" value="${param.memberId}">
	            <textarea name="blockMemo" placeholder="차단 사유를 입력하세요" rows="10" cols="60"></textarea>
	            <div>
	                <button type="button" class="btn member_block">차단</button>
	            </div>
            </div>
        </div>
    </form>
</body>
</html>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>