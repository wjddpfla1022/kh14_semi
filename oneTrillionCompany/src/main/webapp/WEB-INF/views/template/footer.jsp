<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <style>
	    .custom-menu {
		    display: inline-block; /* li를 인라인 블록으로 설정하여 가로로 배치 */
		    padding: 20px; /* 여백 설정 */
		    border: 1px solid #e9e9e9;
		    width: 100%;
		}
		.shop-box {
			padding : 40px 30px;
		}
	
	    	/* 상단부 텍스트 */
		#top-location {
		    font-size: 18px;
		   	font-weight: bolder;
		   	color : black;
		}
		/* 하단부 텍스트 */
		#bottom-location {	
		font-size: 12px;
		}
	
		
		/* flex-box 안에 모든 a태그 */
		.flex-box a {
		    text-decoration: none;
		}
	    .head {
	        font-size: 17px;
	        font-weight: bold;
	        margin-bottom: 0.5em;
	    }	
	    .phone {
	        font-size: 25px;
	        font-weight: bolder;
	        margin-bottom: 0.5em;
	    }
	    /* 쇼핑 가이드 항목의 a태그*/
	    .aTag {
		    display: flex;
   		    flex-direction: column; /* 세로 방향으로 정렬 */
		    align-items: center;    /* 가로 방향으로 가운데 정렬 */
		    color: #7f8c8d;
		}
		.aTag:hover {
			color : black;
			
		}
	    .aTag  i{
		    margin-bottom : 10px;
		}
    </style>

</head>
<body>
<hr>
    <div class="container w-1200">
        <div class="flex-box row">

			<div class=custom-menu>
                <div class="head">
                    고객센터
                </div>
                <div class="phone">
                    8282-8282
                </div>
                <div class="runtime">
                    월요일 - 금요일 09:30 - 18:30
                    <p>점심시간 11:30~12:30</p>                    
                    <p>[주말/공휴일휴무]</p>                    
                </div>
			</div>


			<div class=custom-menu>
                <div class="head">
                    무통장 안내
                </div>
                <div class="bankinfo">
                    <p>
                        정현은행 1111-111-111111
                    </p>
                    <p>
                        예금주    일조 컴퍼니
                    </p>
                    <p>
                        <span style="color:red;">
                           *입금 시 입금자명과 금액을 꼭 확인해주세요.
                        </span>
                    </p>                    
              
                </div>
			</div>
            
            
			<div class=custom-menu>
                <div class="head">
                    환불안내
                </div>
                <div class="delivery">
                    택배업체: 일조택배 1234-5678
                    <p style="color:red">※반품 시 반드시 하단의 주소지에 맞게 발송해주셔야 합니다.</p>
                </div>
			</div>
            
            
			<div class=custom-menu>
                <div class="head">
                    쇼핑 · 가이드
                </div>
                <div class="row">
                    <div class="flex-box">
                        <div class="custom-menu shop-box">
                            <a href="/review/list"  class="aTag">
                                <i class="fa-solid fa-camera"></i>
                                <span>리뷰후기</span>
                            </a>
                        </div>
                        <div class="custom-menu shop-box">
                            <a href="/qna/list" class="aTag">
                                <i class="fa-solid fa-comment-dots"></i>
                                <span>1:1문의</span>
                            </a>
                        </div>
                    </div>
                </div>
			</div>

	    </div>
  </div>

</body>
</html>