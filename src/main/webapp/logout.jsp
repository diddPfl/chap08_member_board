<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	HttpSession ses = request.getSession();
    // 세션에서 사용자 정보를 제거합니다.
    ses.removeAttribute("member");

    // 세션을 무효화합니다.
    ses.invalidate();

    String contextPath = request.getContextPath();
    // 로그인 페이지로 리다이렉트합니다.
    response.sendRedirect(contextPath + "/loginForm.jsp");
%>
