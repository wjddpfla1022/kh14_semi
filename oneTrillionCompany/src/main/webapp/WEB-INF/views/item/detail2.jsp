<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- 장바구니 테스트 페이지 구현 완료 후 상세로 옮기기 -->

<style>
.price {
	font-size: 13px;
	color: #999;
	font-weight: normal;
	position: relative;
}

.btn-shirt {
	position: relative;
	overflow: hidden;
	display: inline-block;
	margin: 0 5px 3px 0;
	vertical-align: top;
	border: 2px dashed #eaeaea;
	border-radius: 5px;
	background: #fff;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
	font-size: 15px;
	color: #d0d4d5;
	border-radius: 0.3em;
}

.btn-shirt:hover {
	background-color: #dfe6e9 !important;
}

.image-style {
	width: 400px;
	height: 550px;
	display: inline-block;
	text-align: center;
	font-size: 20px;
}

.img-show {
	transition: 0s linear;
	opacity: 1;
}

.img-opacity {
	transition: 0s linear;
	opacity: 0;
}

#bigImage {
	margin-bottom: 10px;
}

.shoppingmal {
	cursor: pointer;
	width: 410px;
	height: 570px;
	background-image:
		url("https://d2u3dcdbebyaiu.cloudfront.net/uploads/atch_img/197/d72693912bf2868da3e848dc5b779d4a_res.jpeg");
}

.shoppingmal:hover {
	background-image:
		url("https://sitem.ssgcdn.com/06/09/87/item/1000183870906_i1_750.jpg");
}

#smallShirts {
	width: 100px;
	height: 100px;
	padding: 0 5px;
	cursor: pointer;
}

a#smallShirts:hover {
	background-image:
		url("https://sitem.ssgcdn.com/06/09/87/item/1000183870906_i1_750.jpg");
}

/* 사용자가 선택한 옵션 창 - 숨기기*/
.hidden, .isColor {
	display: none;
}

/* 재고, 수량을 숨김 */
.itemCnt-data {
	display: none !important;
}
</style>

<!--jquery cdn-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script
	src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.js"></script>

<script type="text/javascript">
	$(function() {
		//버튼에 사진 투명도 조절
		//     $(".btn-opacity").on("click", function(){
		//         $(".image-style").removeClass("img-show");
		//         $(".image-style").addClass("img-opacity");
		//     });
		//     $(".btn-show").on("click", function(){
		//         $(".image-style").removeClass("img-opacity");
		//         $(".image-style").addClass("img-show");
		//     });

		//사진 이동 구현

		//버튼 색 조절

		//상세 페이지 표시 제어
		$(".btn-toggle").click(function() {
			$(".target").slideToggle();
		});

		/*에러나서 잠시 막아뒀습니다*/
		/* //별점
		$(".test-score2").score({
		        editable:true,
		        display:{
		            showNumber:true,
		            placeLimit:2
		        }
		 });
		 */

		//일단 보류-품절 시 버튼 비활성화
		//     //버튼 활성화 조건
		//     $(function(){
		//     	//db에 있는 상품 컬러 값을 가져옴
		// 		var isColorValue = $(".isColor").text();
		//     	//버튼 컬러를 가져옴
		//     	$(".btn-show").each(function(){
		// 		    var btn_colorDataValue = $(this).data("color");
		// 		    var btnColor = $(this);
		// 		    console.log(btn_colorDataValue);
		//     	});
		//     	var btn_colorDataValue = $(".btn-show");
		// 		if(isColorValue != btn_colorDataValue) {
		// 		   		btn_colorDataValue.css("display", "none");
		// 		}
		//     });
		 
		var itemTypeValid = false;

		function checkItemType() {
			var tag = document.querySelector("[name=itemColor]");
			itemTypeValid = tag.value.length > 0;
			tag.classList.remove("success", "fail");//클래스 초기화
			tag.classList.add(itemTypeValid ? "success" : "fail");//클래스 부여
		}
		function checkForm() {
			return itemTypeValid;
		}

		//수량 증가 및 감소
		//기본 1로 설정
		var cartCntInput = $("[name=cartCnt]");
		cartCntInput.val("1");
		$(".btn-up, .btn-down").click(function() {
			// 현재 버튼이 속한 행의 수량 및 재고 값 가져오기
			var cartCntValue = parseInt(cartCntInput.val()); //장바구니 수량을 넣는다
			var itemCntValue = parseInt($(".itemCnt-data").text()); //재고 수량 가져온다

			// 버튼에 따른 수량 조절
			if ($(this).hasClass('btn-up')) {
				// 장바구니 최대 수량(재고기준)
				if (cartCntValue < itemCntValue) {
					cartCntValue += 1;
				} else {
					alert("최대 수량에 도달했습니다");
				}
			} else if ($(this).hasClass('btn-down')) {
				// 장바구니 최소 수량
				if (cartCntValue > 1) {
					cartCntValue -= 1;
				} else {
					alert("최소 수량에 도달했습니다");
				}
			}
			//값을 다시 input에 넣기
			cartCntInput.val(cartCntValue);
		});

		//장바구니 ajax 통신*
		$(function() {
			//전역변수
			var itemColorValue = "";
			//장바구니에 담기 -비동기
			$("[name=itemColor]").change(function() {
				itemColorValue = $(this).val();
			});
			$(".btn-add-cart").click(function() {
				var itemNameValue = $(".itemName").text().trim();//공백제거
				var cartCntValue = $("[name=cartCnt]").val();
				var itemSalePriceValue = $(".itemSalePrice").text();
				var attachNoValue = $(".attachNo-data").text();
				console.log(itemNameValue); //개발 끝나고 삭제*
				console.log(itemSalePriceValue);
				console.log(itemColorValue);
				console.log(attachNoValue);

				$.ajax({
					url : "/rest/cart/insertCart",
					method : 'post',
					data : {
						itemName : itemNameValue,
						itemColor : itemColorValue,
						itemSalePrice : itemSalePriceValue,
						cartCnt : cartCntValue,
						attachNo : attachNoValue
					},
					success : function(response) {
						alert("장바구니에 등록 되었습니다");
					},
					error : function(response) {
						alert("필수 옵션을 선택해주세요");
					}
				});
			});
		});
	});
</script>

<div class="container w-1200 my-50">
	<div class="flex-box column-2">
		<div class="left">
			<div id="bigImage">
				<div id="container">
					<img class="shoppingmal" src="/item/image?itemNo=${itemDto.itemNo}"
						width="100%">
					<!-- attachNo값 가져오기* -->
					<span class="attachNo-data">${attachNo}</span>
				</div>
				<div class="row smallImages">
					<img id="smallShirts"
						src="https://sitem.ssgcdn.com/06/09/87/item/1000183870906_i1_750.jpg"
						width="100%">
				</div>
			</div>
		</div>

		<div class="right">
			<!--상품이름 클래스 추가*-->
			<div class="left">
				<div class="row mt-0 itemName" style="font-size: 30px;">
					${itemDto.itemName}</div>
			</div>
			<div class="row flex-box column-2">
				<div class="left">
					<!-- 상품원가* -->
					<span class="itemPrice"><del style="color: #999;">${itemDto.itemPrice}</del></span>
					<!-- 상품판매가* -->
					<span class="itemSalePrice" style="padding-left: 5px;"><b
						style="font-weight: bolder;">${itemDto.itemSalePrice}</b></span>
				</div>
				<div class="right">
					<!-- 상품할인비율* -->
					<span style="color: red;"><fmt:formatNumber
							value="${itemDto.itemDiscountRate * 100}" type="number"
							maxFractionDigits="0" />%</span> <span>(할인)</span>
				</div>
			</div>
			<div class="row mt-30 mb-20">
				<div class="left">
					<span style="font-size: 13px; color: #999;">미니 라벨 포인트, 데일리로
						입기 좋은 캐주얼 셔츠</span>
				</div>
			</div>

			<hr>

			<div class="row mb-30">
				<div class="row flex-box column-2">
					<div class="left">
						<button type="button" class="btn btn-toggle"
							style="border-color: white; background-color: white; padding: 1px;">상품정보</button>
						<div class="left">
							<h3 class="target left">
								<span style="font-size: 13px; color: #999;">-소비자가</span><br>
								<span style="font-size: 13px; color: #999;">-판매가</span><br>
								<span style="font-size: 13px; color: #999;">-배송비결제</span><br>
							</h3>
						</div>
					</div>
					<div class="right">
						<button type="button" class="btn btn-toggle"
							style="font-size: 13px; border-color: white; background-color: white; padding-left: 6em">
							<i class="fa-solid fa-plus"></i>
						</button>
						<div class="left">
							<h4 class="target left">
								<span style="font-size: 14px; font-weight: bolder; color: black">${itemDto.itemPrice}</span><br>
								<span style="font-size: 14px; font-weight: bolder;">${itemDto.itemSalePrice}</span><br>
								<span style="font-size: 14px; font-weight: bolder;">2,500원
									(60,000원 이상 구매 시 무료)</span><br>
							</h4>
						</div>
					</div>
				</div>
				<hr>

				<div class="row center">
					<div style="font-size: 15px;">색상</div>
				</div>
				<div class="left">
					<span style="font-size: 11px; color: #999;">[필수] 옵션을 선택해 주세요</span>
				</div>
				<div class="row">
					<select name="itemcolor" class="field w-100"
						oninput="checkItemType();">
						<option value="">선택하세요</option>
						<option value="black">검정</option>
						<option value="red">빨강</option>
						<option value="orange">주황</option>
						<option value="yellow">노랑</option>
						<option value="green">초록</option>
						<option value="blue">파랑</option>
						<option value="brown">브라운</option>
						<option value="pink">분홍</option>
					</select>
				</div>
				
				   <!-- 수량 선택추가* -->
	                        <div class="left my-0">
	                        	<span class="input_cartCnt">
									<input type="text"  name="cartCnt" size="2"><span class="itemCnt-data">${itemDto.itemCnt}</span>
									<button type="button" class="btn-cnt btn-up"><i class="fa-solid fa-angle-up Icon_carCnt"></i></button>
									<button type="button" class="btn-cnt btn-down"><i class="fa-solid fa-angle-down Icon_carCnt"></i></button>
								</span>
	                        </div>
	                     </div>
				
				<div class="left">
					<p style="font-size: 11px; color: #999;">
						<i class="fa-regular fa-circle-exclamation"></i>최소주문수량 1개 이상입니다
					</p>
					<p style="font-size: 11px; color: #999;">
						<i class="fa-regular fa-circle-exclamation"></i>옵션선택 박스를 선택하시면 아래에
						상품이 추가됩니다.
					</p>
					<p style="font-size: 11px; color: #999;">
						<i class="fa-regular fa-circle-exclamation"></i>배송비<b>2,500원
							(60,000원 이상 구매 시 무료)</b>
					</p>
				</div>

				<div class="row">
					<button type="submit" class="btn w-100"
						style="color: white; background-color: black;">구매하기</button>
					<!-- 장바구니버튼 -->
					<button type="button" class="btn w-100 btn-add-cart"
						style="color: white; background-color: black;">장바구니</button>
				</div>
			</div>

		</div>




	<div class="row center">
	<div class="row flex-box column-2">
		<div class="center">
			<h3 style="font-weight: bolder;">REVIEW ( ${list.size()} )</h3>
		</div>

		<div class="center">
			<a
				href="/review/list?column=review_item_no&keyword=${itemDto.itemNo}"
				class="btn" style="font-weight: bolder; border-color: white; background-color: white">상품 리뷰 <i class="fa-solid fa-sort-down"></i></a>
		</div>
	</div>
	</div>

<hr>
<div class="left">
	<div class="test-score2" data-max="5" data-rate="3"></div>
</div>

<div class="container w-1000">
	<%-- 	<h3>정보 번호 : ${infoDto.infoNo}</h3> --%>
	<%-- 	<h3>상품 번호 : ${infoDto.infoItemNo}</h3> --%>
	<div class="row center">
		<h3>${infoDto.infoContent}</h3>
	</div>
</div>
	</div>
</body>


<jsp:include page="/WEB-INF/views/template/size.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>