<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<div class="container w-700 my-50">
	<div class = "row center">
		<h1>${memberDto.memberId} 님의 개인 정보</h1>
	</div>
	
	<div class = "row center"> 
		<table class="table table-border">
		<tr>
			<td>이름</td>
			<td>${memberDto.memberName}</td>
		</tr>
		<tr>
			<th width="25%">닉네임</th>
			<td>${memberDto.memberNickname}</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>${memberDto.memberEmail}</td>
		</tr>
		<tr>
				<td>주소</td>
					<c:choose>
						<c:when test="${memberDto.memberPost==null && memberDto.memberAddress1==null && memberAddress2==null}">
							<td></td>
						</c:when>
						<c:otherwise>
							<td>[${memberDto.memberPost}] ${memberDto.memberAddress1}, ${memberDto.memberAddress2}</td>
						</c:otherwise>						
					</c:choose>				
			</tr>
			<tr>
				<td>등급</td>
				<td>${memberDto.memberRank}</td>
			</tr>
			<tr>
				<td>포인트</td>
				<td>${memberDto.memberPoint}p</td>
			</tr>
			<tr>
				<td>가입일</td>
				<td>
					<fmt:formatDate value="${memberDto.memberJoin}" pattern="y년 M월 d일"/>
				</td>
			</tr>
			<tr>
				<td>최종 로그인</td>
				<td>
					<fmt:formatDate value="${memberDto.memberLogin}" pattern="y년 M월 d일 E H시 m분"/>
				</td>
			</tr>
	</table>
</div>
				<!-- 개인정보 변경 버튼 -->
			<div class="flex-box flex-core mt-20 mb-30">
				<a href="/member/resetPw?memberId=${memberDto.memberId}" class = "btn change-password" style="margin-right:5px;">비밀번호 변경하기</a>
				<a href="#" class = "btn change-info" style="margin-right:5px;">개인정보 변경하기</a>
				<a href="#" class = "btn btn-negative member-delete">회원 탈퇴</a>
			</div>

				<!-- 회원의 차단 이력을 출력 -->
				<hr>
				<div class = "row center">
					<div>
						<h1>차단/해제 이력</h1>
					</div>
				<c:choose>
					<c:when test="${blockList.isEmpty()}">
						<h3 style= "color:red">차단 이력이 존재하지 않습니다</h3>
					</c:when>
					<c:otherwise>
						<table class="table table-border">
							<thead>
								<tr>
									<th width="35%">일시</th>
									<th width="15%">구분</th>
									<th>사유</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="blockDto" items="${blockList}">
								<tr>
									<td>
										<fmt:formatDate value="${blockDto.blockTime}"	pattern="y년 M월 d일 E H시 m분"/>
									</td>
									<td>${blockDto.blockType}</td> <!--구분 -->
									<td>${blockDto.blockMemo}</td> <!-- 사유 --> 
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:otherwise>
				</c:choose>
			</div>
		</div>


	








