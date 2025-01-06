package com.ttt.controller.enroll;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/enroll/form")
//학생, 교사 타입 받아서 회원가입 form 에 전달
public class EnrollFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public EnrollFormServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("errorMessage", "잘못된 접근입니다. 회원가입 페이지로 이동합니다.");
		request.getRequestDispatcher("/WEB-INF/views/enroll/termsofservice.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 학생, 교사 타입 받아서 회원가입 form 에 전달
		String memberType = request.getParameter("memberType");
		if(memberType!=null) {
			request.setAttribute("memberType", memberType);
			request.getRequestDispatcher("/WEB-INF/views/enroll/enrollForm.jsp").forward(request, response);
		} else {
			request.setAttribute("errorMessage", "잘못된 접근입니다. 회원가입 페이지로 이동합니다.");
			request.getRequestDispatcher("/WEB-INF/views/enroll/termsofservice.jsp").forward(request, response);
		}
    }

}
