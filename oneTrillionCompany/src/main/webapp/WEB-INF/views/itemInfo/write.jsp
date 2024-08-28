<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


 <!-- summernote cdn -->
  <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>


<!-- 자바스크립트 작성 영역 -->
  <script type="text/javascript">
    $(function () {
      // $(선택자).summernote({옵션객체});
      $("[name=infoContent]").summernote({
        minHeight: 250,
        maxHeight: 1000,

        placeholder: "내용 입력",
        toolbar: [
          // [menu name, [list of button name]]
          ['area', ['style']],
          ['style', ['bold', 'italic', 'underline']],
          ['font', ['fontname', 'fontsize', 'forecolor', 'backcolor']],
          ['tool', ['ul', 'ol', 'table', 'hr', 'fullscreen']],
          ['height', ['height']],
          ['attach', ['picture']]
        ],
        // 콜백 설정
        callbacks: {
          onImageUpload: function (files) {
            console.log(files);
            var form = new FormData();
            form.append("attach", files[0]);

            $.ajax({
              processData: false, /*파일업로드에 꼭 필요한 설정*/
              contentType: false, /*파일업로드에 꼭 필요한 설정*/
              url:"/rest/itemInfo/upload",
              method:"post",
              data: form,
              success:function(response){
                // response에는 파일번호가 있어야 한다.
                console.log(response);
                // 태그를 만들 때는 선택자에 온전한 태그를 넣는다.
                var imgSrc = "/attach/download?attachNo=" + response; // response에 파일 번호가 포함되어야 합니다.
                var imgTag = $("<img>").addClass("info-attach").attr("src", imgSrc);
                $("[name=infoContent]").summernote("insertNode", imgTag[0]);
              },
              error: function (xhr, status, error) {
                  console.error("파일 업로드 실패:", error);
              }
            });
          }
        },
      });
      if ($("[name=infoContent]").summernote("isEmpty")) {
        $("[name=infoContent]").summernote("code", "")
      }
    });
  </script>
<style>
	.container{
		width: 600px;
	}
	.textarea.field {
            resize: vertical;
            min-height: 120px;
        }
    .btn.btn-positive{
    
    }
    .note-editable{
      background-color: white;
    }
    .note-editor{
    	border: 1px solid #636e72 !important;
    }
</style>

	<div class="container w-1000">
		<div class="row center">
			<h2>상품 정보 등록</h2>
		</div>
		<form action="write" method="post" enctype="multipart/form-data" autocomplete="off">
			<input type="text" name="itemNo" >
			<div class="row">
            	<textarea name="infoContent" class="field w-100" draggable="true"></textarea>    
        	</div>
        	<div class="row">
            	<button type="submit" class="btn btn-positive w-100">작성하기</button>
        	</div>
		</form>
	</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>