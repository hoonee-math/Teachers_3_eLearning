package com.ttt.controller.teacher;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/teacher/*")
public class ToTeacherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ToTeacherServlet() {
        super();
    }

    // "/Teacher/*" 로 들어오는 모든 요청을 분기처리하여 각 페이지로 응답하기
    // 각 페이지에서의 내용은 ajax(post) 요청으로 다른 servlet 으로 재요청 후 응답하기 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
        String path = uri.substring(request.getContextPath().length());

        switch(path) {
        case "/teacher/list_and_detail":
        	// 예시 Java Controller 코드
        	List<Map<String, Object>> teachers = new ArrayList<>();
        	teachers.add(Map.of("memberName", "강기동", "subject", 1,"memberNo",1));
        	teachers.add(Map.of("memberName", "김미선", "subject", 1,"memberNo",1));
        	teachers.add(Map.of("memberName", "장재학", "subject", 1,"memberNo",1));
        	teachers.add(Map.of("memberName", "존 스미스", "subject", 2,"memberNo",1)); // 영어

        	request.setAttribute("teachers", teachers);
        	System.out.println(teachers);
        	// JSP에서 사용할 subject 데이터
        	Map<Integer, String> subjectData = Map.of(
        	    1, "국어",
        	    2, "영어",
        	    3, "수학",
        	    4, "사회",
        	    5, "과학",
        	    6, "기타"
        	);
        	request.setAttribute("subjectData", subjectData);
        	request.getRequestDispatcher("/WEB-INF/views/teacher/teacherListAndDetail.jsp").forward(request, response);
            break;
        }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// https://chatgpt.com/share/6773646f-9694-8008-a797-51f0f057bde9
	}
}
