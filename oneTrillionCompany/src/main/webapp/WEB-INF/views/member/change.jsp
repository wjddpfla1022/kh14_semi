<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<style>
	/* 입력창 td 태그 스타일 설정 */
	.input-box-table {
		text-align: start !important;
		margin-left : 10px;
	}
	/* 닉네임의 td 태그 스타일 설정 */
	.nickname-line {
		display : flex;
		align-items: center;
		text-align: start !important;
	}
	.nickname-line input {
		border: 1px solid #e6e6e6;
		padding: 3px 4px;
	}
	.nickname-line p {
	    margin-left: 5px; 
	}

	/* 입력창 스타일 설정 */
	.input-box-table input {
		border: 1px solid #e6e6e6;
		padding: 3px 4px;
	} 
	.table-border-center {
		font-size : 14px;
		background-color : #fbfafa;
	}
	/* 상단 텍스트(기본정보) 스타일 설정 */
	.text-line {
		margin-bottom : -16px;
		justify-content: space-between;
	}
</style>

<script>
	
</script>
	<form action="change" method="post" autocomplete="off">
		<div class="container w-700 my-50">
			<div class = "flex-box text-line">
				<h3>기본정보</h3>
				<h5 class="text-pTag">
					<i class="fa-solid fa-asterisk red"></i>
					필수입력사항
				</h5>
			</div>
			
			<div class = "row center mt-0"> 
				<table class="table table-border-top">
				<%--  아이디 입력 창 --%>
				<tr  class="table-border-middle">
					<th class="table-border-center">
						<div class="row left ps-30">
							<span>아이디
								<i class="fa-solid fa-asterisk red"></i>
							</span>
						</div>
					</th>
					<td class="input-box-table">
							<input type="text" name="memberId" value="${memberDto.memberId}"  size="30" readonly>
					</td>		
				</tr>
				<%--  닉네임 입력 창 --%>
				<tr class="table-border-middle">
					<th class="table-border-center">
						<div class="row left ps-30">
							<span>닉네임
								<i class="fa-solid fa-asterisk red"></i>
							</span>
						</div>
					</th>
					<td class="nickname-line">		
						<input type="text" name="memberNickname" value="${memberDto.memberNickname}"  size="30" required>
						<p style="font-size : 12px;">(한글,숫자 2~10자)</p>
					</td>
				</tr>
				<%--  이메일 입력 창 --%>
				<tr class="table-border-middle">
					<th class="table-border-center">
						<div class="row left ps-30">
							<span>이메일
								<i class="fa-solid fa-asterisk red"></i>
							</span>
						</div>				
					</th>
					<td class="input-box-table">				
						<input type="text" name="memberEmail" value="${memberDto.memberEmail}"  size="30" required>
					</td>
				</tr>
				<%--  이름 입력 창 --%>
				<tr  class="table-border-middle">
					<th class="table-border-center">
						<div class="row left ps-30">
							<span>이름
								<i class="fa-solid fa-asterisk red"></i>
							</span>
						</div>
					</th>
					<td class="input-box-table">
							<input type="text" name="memberName" value="${memberDto.memberName}"  size="30" readonly required>
					</td>		
				</tr>		
				<%--  연락처 입력 창 --%>
				<tr class="table-border-middle">
					<th class="table-border-center">
						<div class="row left ps-30">
							<span>연락처</span>
						</div>				
					</th>
					<td class="input-box-table">
						<input type="tel" name="memberContact" value="${memberDto.memberContact}" maxlength="11">
					</td>
				</tr>
				<%--  생년월일 입력 창 --%>
				<tr class="table-border-middle">
					<th class="table-border-center">
						<div class="row left ps-30">
							<span>생년월일</span>
						</div>				
					</th>
					<td class="input-box-table">
						<input type="date" name="memberBirth" value="${memberDto.memberBirth}" >
					</td>
				</tr>				
				<%--  주소 입력 창 --%>
				<tr class="table-border-middle">
					<th class="table-border-center">
						<div class="row left ps-30">
							주소 <i class="fa-solid fa-asterisk red"></i>
						</div>				
					</th>
						<c:choose>
							<c:when test="${memberDto.memberPost==null && memberDto.memberAddress1==null && memberDto.memberAddress2==null}">
								<td class="input-box-table">
										<input type="text" name="memberPost" value="${memberDto.memberPost}" size="6" style="margin-bottom:0.5em;" required> <br>
										<input type="text" name="memberAddress1" value="${memberDto.memberAddress1}" size="60" style="margin-bottom:0.5em;" required> <br>
										<input type="text" name="memberAddress2" value="${memberDto.memberAddress2}" size="60" required>
								</td>
							</c:when>
							<c:otherwise>
								<td class="input-box-table">
										<input type="text" name="memberPost" value="${memberDto.memberPost}" size="6" required> <br>
										<input type="text" name="memberAddress1" value="${memberDto.memberAddress1}" size="60" required> <br>
										<input type="text" name="memberAddress2" value="${memberDto.memberAddress2}" size="60" required>
								</td>
							</c:otherwise>						
						</c:choose>				
					</tr>
				</table>
			</div>
				<%--  개인정보 변경 버튼 --%>
				<div class="flex-box flex-core mt-20 mb-30">
					<button type="submit" class = "btn btn-positive" style="margin-right:5px;">개인정보 변경</button>
					<a href="mypage" class = "btn btn-neutral">취소</a>
				</div>
		</div>
	</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>