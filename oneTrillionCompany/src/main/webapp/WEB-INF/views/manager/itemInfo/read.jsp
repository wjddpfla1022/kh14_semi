<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> --%>

<div class="container w-1000">
	<h3>정보 번호 : ${infoDto.infoNo}</h3>
	<h3>상품 번호 : ${infoDto.infoItemNo}</h3>
	<div class="row center">
		<h3>${infoDto.infoContent}</h3>
	</div>
</div>

<%-- <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> --%>