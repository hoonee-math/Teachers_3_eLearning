package com.ttt.controller.teacher;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Member3;
import com.ttt.service.MemberService;

@WebServlet("/teacher/list_and_detail")
public class ToTeacherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ToTeacherServlet() {
        super();
    }

    // "/Teacher/*" 로 들어오는 모든 요청을 분기처리하여 각 페이지로 응답하기
    // 각 페이지에서의 내용은 ajax(post) 요청으로 다른 servlet 으로 재요청 후 응답하기 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
    	try {
            String teacherSubject = request.getParameter("subject");
            if (teacherSubject==null) {
            	teacherSubject="국어";
            }
            
            List<Member3> allTeachers = new MemberService().selectAllTeachers();
            System.out.println("선생님 목록"+ allTeachers.toString());
            
            // 과목 목록
            List<String> subjectData = new MemberService().selectSubjects();
            
            request.setAttribute("teachers", allTeachers);
            request.setAttribute("subjectData", subjectData);
            
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        request.getRequestDispatcher("/WEB-INF/views/teacher/teacherListAndDetail.jsp")
               .forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// https://chatgpt.com/share/6773646f-9694-8008-a797-51f0f057bde9
	}
}
