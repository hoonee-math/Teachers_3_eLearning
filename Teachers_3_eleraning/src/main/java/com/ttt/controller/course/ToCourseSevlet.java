package com.ttt.controller.course;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/course/*")
public class ToCourseSevlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ToCourseSevlet() {
        super();
    }

    // "/Course/*" 로 들어오는 모든 요청을 분기처리하여 각 페이지로 응답하기
    // 각 페이지에서의 내용은 ajax(post) 요청으로 다른 servlet 으로 재요청 후 응답하기 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
        String path = uri.substring(request.getContextPath().length());

        switch(path) {
        case "/course/list":
        	request.getRequestDispatcher("/WEB-INF/views/course/courseList.jsp").forward(request, response);
            break;
        }
	}

}
