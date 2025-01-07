package com.ttt.controller.member.teacher;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/member/teacher/mypage/*")
public class TeacherMypageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public TeacherMypageServlet() {
        super();
    }

    // "/student/mypage/*" 으로 들어오는 모든 요청을 분기처리하여 각 페이지로 응답하기
    // 각 페이지에서의 내용은 ajax 요청으로 처리하기 위한 서블릿 만들기
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
        String path = uri.substring(request.getContextPath().length());

        switch(path) {
        case "/member/teacher/mypage/menu":
            request.getRequestDispatcher("/WEB-INF/views/member/teacherMypage.jsp").forward(request, response);
            break;
        }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
