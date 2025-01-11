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
    		// 페이징 처리를 위한 현재 페이지 정보
			int cpage = 1;
			try {
				cpage = Integer.parseInt(request.getParameter("cpage"));
			} catch (NumberFormatException e) { }

			int numPerPage = 2; // 한 페이지당 데이터 수

			// 현재 페이지에 해당하는 데이터만 추출
			int start = (cpage - 1) * numPerPage;
			int end = start + numPerPage;
    		
            String teacherSubjectName = request.getParameter("subject");
            if (teacherSubjectName==null) {
            	teacherSubjectName="국어";
            }
            
            List<Member3> allTeachers = new MemberService().selectAllTeachers();
            //System.out.println("선생님 목록"+ allTeachers.toString());
            
            // 과목 목록
            List<String> subjectData = new MemberService().selectSubjects();
            int i=0;
            for(Member3 m : allTeachers) {
            	++i;
            	System.out.println("memberName: "+m.getMemberName());
            	System.out.println("image renamed[i]: "+m.getImage().getRenamed());
            }
            //request.setAttribute("teachers", allTeachers);
            //request.setAttribute("subjectData", subjectData);
            
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
