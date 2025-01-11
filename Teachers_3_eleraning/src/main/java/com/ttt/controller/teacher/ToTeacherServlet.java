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

            // 과목 파라미터 처리 - 초기값을 'all'로 설정
            String teacherSubject = request.getParameter("subject");
            // subject 파라미터가 없으면 전체 교사를 보여줌
            
			// 데이터 조회를 위한 파라미터 맵 생성
			Map<String, Object> params = new HashMap<>();
			params.put("start", start);
			params.put("end", end);
			params.put("teacherSubject", teacherSubject); // null이면 전체 조회
            
            List<Member3> teachers = new MemberService().selectAllTeachers(params);

			// 전체 데이터 수
			int totalData = teachers.size();

			// 전체 페이지 수 계산
			int totalPage = (int) Math.ceil((double) totalData / numPerPage);

			// 페이지 바 사이즈
			int pageBarSize = 5;

			// 페이지 바 시작 번호
			int pageStart = (((cpage - 1) / pageBarSize) * pageBarSize) + 1;

			// 페이지 바 종료 번호
			int pageEnd = pageStart + pageBarSize - 1;
			if (pageEnd > totalPage) {
				pageEnd = totalPage;
			}
            
            // 과목 목록
            List<String> subjectData = new MemberService().selectSubjects();

            // request에 데이터 저장
            request.setAttribute("teachers", teachers);
            request.setAttribute("subjectData", subjectData);
            request.setAttribute("pageStart", pageStart);
            request.setAttribute("pageEnd", pageEnd);
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("cpage", cpage);
            request.setAttribute("selectedSubject", teacherSubject);
            
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
