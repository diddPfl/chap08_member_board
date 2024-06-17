package com.javalab.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		
		// 1. RequestDispatcher  
		//  - 현재 서블릿에서 실행 중인 요청 처리를 중단하고, 지정된 JSP 페이지나 다른 서블릿으로 요청 처리를 넘겨주는 것.
		//  - 서블릿이 요청을 다른 리소스(JSP, 다른 서블릿)로전달하기 위해 사용하는 RequestDispatcher 객체.
		// 2. getRequestDispatcher
		//  - HttpServeltRequest 객체의 getRequestDispatcher() 메소드로 RequestDispatcher 객체를 얻는다.  
		// 3. "loginForm.jsp"는 요청을 전달할 대상 리소스의 경로 
		// 4. dispatcher.forward(request, response) : 현재 요청을 loginForm.jsp로 전달 
		//   클라이언트는 이 요청을 알지 못하며 URL도 변경하지 않는다.
		RequestDispatcher dispatcher = request.getRequestDispatcher("loginForm.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) 
					throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		
		PrintWriter out = response.getWriter();
		out.println("<html>");
		out.println("<head><title>서블릿에서 html 생성</title></head>");
		out.println("<body>");
		out.println("<h3> 사용자 정보</h3>");
		out.println("<p>1. id : " + id + "</p>");
		out.println("<p>2. password : " + password + "</p>");
		out.println("</body>");
		out.println("</html>");	
	}
}
