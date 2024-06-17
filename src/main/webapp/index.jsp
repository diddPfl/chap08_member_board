<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!-- 컨텍스트패스(진입점폴더) 변수 설정 -->
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index.jsp</title>
</head>
<body>
	<h3>여기는 index page</h3>
	
	<c:if test="${empty sessionScope.member}">
		<a href="${contextPath }/login">로그인</a>
    </c:if>
    
	<a href="${contextPath }/boardlist.jsp">게시물 목록</a>
	
	<c:if test="${not empty sessionScope.member}">
	<a href="${contextPath }/boardInsertForm.jsp">게시물 등록</a>
		<a href="${contextPath }/logout.jsp">로그아웃</a>
    </c:if>
</body>
</html>