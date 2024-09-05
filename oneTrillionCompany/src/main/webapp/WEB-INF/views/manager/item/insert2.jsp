<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 
     <style>
    .item-insert-line label{
    	display: inline-block;
    	width: 94px;
    	text-align: right;
    }
    .category-line{
    	margin-left:53px;
    }
    </style>
    
    <div class="container w-600 center item-insert-line">
        <div class="row center">
            <h2>상품등록</h2>
        </div>
        <form action="insert" method="post" enctype="multipart/form-data" autocomplete="off">
                
                <label>사진 등록</label>
            <div class="row">
            	<input type="file" name="attach" class="field w-50" >
            </div>
            <div class="row">
                <label>상품명</label>
                <input type="text" name="itemName" class="field w-33">
            </div>
            <div class="row">
                <label>정가</label>
                <input type="number" name="itemPrice" class="field w-33">
            </div>
            <div class="row">
                <label>판매가</label>
                <input type="number" name="itemSalePrice" class="field w-33">
            </div>
            <div class="row">
                <label>재고 수</label>
                <input type="number" name="itemCnt" class="field w-33">
            </div>
            <div class="row">
                <label>사이즈</label>
                <select name="itemSize" class="field w-33"  style="font-size: 12px;">
                	<option value="S">Small</option>
                	<option value="M">Medium</option>
                	<option value="L">Large</option>
                	<option value="XL">Extra-large</option>
                </select>
            </div>
            <div class="row">
        
        <hr>
        <div class="row">
        <label>카테고리</label>
        <select name="itemCate1" id="cate1-select" class="field w-33" style="font-size: 12px;">
        	<option value="">상위 카테고리 선택</option>
            <option value="11">상의</option>
            <option value="33">하의</option>
            <option value="55">신발</option>
            <option value="77">아우터</option>
        </select>
        </div>
        <select name="itemCate2" id="cate2-select" class="field w-20 category-line" style="font-size: 12px;">
            <option value="">하위 카테고리 선택</option>
        </select>
        <select name="itemCate3" id="cate3-select" class="field w-20 category-line ms-0" style="font-size: 12px;">
            <option value="">세부 카테고리 선택</option>
        </select>
    </div>
<hr>
            <div class="row">
            	<label>색상</label>
            	<select name="itemColor" class="field w-33" >
            		<option value="">선택없음</option>
            		<option value="black">블랙</option>
            		<option value="white">화이트</option>
            	</select>
            </div>
            <div class="row">
            	<select name="itemMain" class="field w-33">
            		<option value="1">메인x</option>
            		<option value="2">메인상품</option>
            	</select>
            </div>
        <div class="right">
        <button type="submit" class="btn btn-positive">등록</button>
    </div>
        </form>
           
    </div>
    <script>
        var cate2Options = {
            11: [
            	{ value: "", text: "카테고리2"},
                { value: "10", text: "티셔츠" },
                { value: "11", text: "셔츠" }
            ],
            33: [
            	{ value: "", text: "카테고리2"},
                { value: "30", text: "슬랙스" },
                { value: "31", text: "데님" },
                { value: "32", text: "트레이닝" },
                { value: "33", text: "반바지" }
            ],
            55: [
                { value: "50", text: "스니커즈" },
                { value: "51", text: "로퍼/슬립온" },
                { value: "52", text: "구두" },
                { value: "54", text: "샌들/슬리퍼" }
            ],
            77: [
                { value: "70", text: "가디건" },
                { value: "72", text: "집업" },
                { value: "74", text: "블레이저" }
            ]
        };

        var cate3Options = {
            10: [
                { value: "12", text: "긴팔" },
                { value: "13", text: "반팔" },
                { value: "14", text: "맨투맨" },
                { value: "15", text: "후드" },
                { value: "16", text: "니트/스웨터" }
            ],
            11: [
                { value: "17", text: "반팔셔츠" },
                { value: "19", text: "긴팔셔츠" }
            ],
            33: [
                { value: "33", text: "일반 반바지" },
                { value: "34", text: "데님 반바지" }
            ]
        };

        document.getElementById('cate1-select').addEventListener('change', function () {
            var cate1Value = this.value;
            var cate2Select = document.getElementById('cate2-select');
            var cate3Select = document.getElementById('cate3-select');
            
            updateSelectOptions(cate2Select, cate2Options[cate1Value] || []);
            updateSelectOptions(cate3Select, []);
        });

        document.getElementById('cate2-select').addEventListener('change', function () {
            var cate2Value = this.value;
            var cate3Select = document.getElementById('cate3-select');
            
            updateSelectOptions(cate3Select, cate3Options[cate2Value] || []);
        });

        function updateSelectOptions(selectElement, options) {
            // Clear existing options
            selectElement.innerHTML = '';
            // Add new options
            options.forEach(option => {
                var opt = document.createElement('option');
                opt.value = option.value;
                opt.text = option.text;
                selectElement.add(opt);
            });
        }
    </script>
    
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>