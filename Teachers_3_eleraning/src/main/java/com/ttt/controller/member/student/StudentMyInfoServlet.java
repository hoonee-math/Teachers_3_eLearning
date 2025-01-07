package com.ttt.controller.member.student;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/student/myinfo")
public class StudentMyInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	public StudentMyInfoServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//마이페이지에서 내정보 페이지로 이동
		request.getRequestDispatcher("/WEB-INF/views/member/studentMyInfo.jsp").forward(request, response);
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
