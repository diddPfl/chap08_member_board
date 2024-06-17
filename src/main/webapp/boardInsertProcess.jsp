<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*, java.util.*, com.javalab.vo.*" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%
	// message body 파라미터 인코딩
	request.setCharacterEncoding("utf-8");

	// 게시물 데이터 받기
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    
    // 세션에서 사용자 정보(아이디) 갖고오기
    HttpSession ses = request.getSession();
    MemberVO memberVO = (MemberVO)ses.getAttribute("member");
    String memberId = memberVO.getMemberId();
    
    String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
    String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
    String DB_USER = "mboard";
    String DB_PASSWORD = "1234";
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        Class.forName(JDBC_DRIVER);
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        // 쿼리문작성
        String sql = "INSERT INTO board (bno, title, content, member_id, reg_date) VALUES (seq_board.nextval, ?, ?, ?, SYSDATE)";
        // PreparedStatement 객체 얻기(쿼리문제공)
        pstmt = conn.prepareStatement(sql);
        // 쿼리문 파라미터 세티
        pstmt.setString(1, title);
        pstmt.setString(2, content);
        pstmt.setString(3, memberId);
        
        int rows = pstmt.executeUpdate();
        if (rows > 0) {
        	System.out.println("게시물 작성 성공");
        	// 컨텍스트 패스 얻기
        	String contextPath = request.getContextPath();
        	// 게시물 목록 페이지로 이동
            response.sendRedirect(contextPath + "/boardlist.jsp");
        } else {
        	 out.println("<script>");
             out.println("alert('게시물 등록에 실패했습니다.');");
             out.println("history.back();");
             out.println("</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
