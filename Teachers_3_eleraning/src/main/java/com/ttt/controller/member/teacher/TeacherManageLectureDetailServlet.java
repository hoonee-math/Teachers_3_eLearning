package com.ttt.controller.member.teacher;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 사용하지 않는 서블릿
@WebServlet("/member/teacher/mypage/lecture")
public class TeacherManageLectureDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public TeacherManageLectureDetailServlet() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 사용하지 않는 페이지
        request.getRequestDispatcher("/WEB-INF/views/member/teacherManageLectureDetail.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
