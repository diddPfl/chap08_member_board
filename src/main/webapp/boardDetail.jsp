<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*, com.javalab.vo.*" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardDetail.jsp</title>
<style>
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        border: 1px solid #000;
        padding: 10px;
        text-align: left;
    }
    th {
        background-color: #f8f8f8;
        width: 20%;
    }
    td {
        width: 80%;
    }
</style>
</head>
<body>
    <h3>게시물 상세보기</h3>
    <%
        int bno = Integer.parseInt(request.getParameter("bno"));
        
        String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
        String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
        String DB_USER = "mboard";
        String DB_PASSWORD = "1234";
        
        Connection conn = null;
        PreparedStatement pstmt = null; // prepareStatement -> PreparedStatement
        ResultSet rs = null;
        
        BoardVO board = new BoardVO();
        
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            // 조회수 증가
            String updatHitSql = "UPDATE board SET hit_no = hit_no + 1 WHERE bno=?";
            pstmt = conn.prepareStatement(updatHitSql);
            pstmt.setInt(1, bno);
            pstmt.executeUpdate();
            pstmt.close();
            
            // 게시물 조회
            String sql = "SELECT bno, title, content, member_id, reg_date, hit_no FROM board WHERE bno=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bno);
            rs = pstmt.executeQuery(); // rs = pstmt.executeQuery(sql) -> rs = pstmt.executeQuery();
            
            if (rs.next()) {
                board = new BoardVO();
                board.setBno(rs.getInt("bno"));
                board.setTitle(rs.getString("title"));
                board.setContent(rs.getString("content"));
                board.setMemberId(rs.getString("member_id"));
                board.setRegDate(rs.getDate("reg_date"));
                board.setHit_no(rs.getInt("hit_no"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        pageContext.setAttribute("board", board);
    %>
    
    <table>
        <tr>
            <th>게시물 번호</th>
            <td>${board.bno}</td>
        </tr>
        <tr>
            <th>제목</th>
            <td>${board.title}</td>
        </tr>
        <tr>
            <th>내용</th>
            <td>${board.content}</td>
        </tr>
        <tr>
            <th>작성자</th>
            <td>${board.memberId}</td>
        </tr>
        <tr>
            <th>작성일자</th>
            <td>${board.regDate}</td>
        </tr>
        <tr>
            <th>조회수</th>
            <td>${board.hit_no}</td>
        </tr>
    </table>
    
    <div>
        <a href="${contextPath}/boardlist.jsp">목록으로</a>
        <a href="${contextPath}/boardUpdateForm.jsp?bno=${board.bno}">수정</a>
        <a href="${contextPath}/boardDelete.jsp?bno=${board.bno}">삭제</a>
    </div>
</body>
</html>
