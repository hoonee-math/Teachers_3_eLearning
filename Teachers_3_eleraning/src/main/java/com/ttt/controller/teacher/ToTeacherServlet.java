package com.ttt.controller.teacher;

import java.io.IOException;
import java.util.ArrayList;
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

@WebServlet("/teacher/*")
public class ToTeacherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ToTeacherServlet() {
        super();
    }

    // "/Teacher/*" 로 들어오는 모든 요청을 분기처리하여 각 페이지로 응답하기
    // 각 페이지에서의 내용은 ajax(post) 요청으로 다른 servlet 으로 재요청 후 응답하기 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 페이징 처리를 위한 현재 페이지 정보
	    int cpage = 1;
	    try {
	        cpage = Integer.parseInt(request.getParameter("cpage"));
	    } catch (NumberFormatException e) {}
	
	    int numPerPage = 2; // 한 페이지당 데이터 수
	    
	    // 시작 위치와 끝 위치 계산
	    int start = (cpage - 1) * numPerPage + 1;
	    int end = start + numPerPage - 1;
	    
	    // 페이징 관련 파라미터를 Map에 저장
	    Map<String, Integer> param = new HashMap<>();
	    param.put("start", start);  
	    param.put("end", end);
	
	    /* MemberService를 통해 데이터 조회 
	       - 전체 데이터 수 
	       - 현재 페이지 데이터 
	    */
	    String teacherSubject = request.getParameter("subject");
	    if(teacherSubject==null) {
	    	teacherSubject="국어";
	    }
	    List<Member3> teachersBySubject=new MemberService().selectTeachersBySubject(teacherSubject);
	    int totalData = teachersBySubject.size();

	    
	    // 페이지 바 사이즈
	    int pageBarSize = 5;
	    
	    // 전체 데이터 수를 기준으로 총 페이지 수 계산 
	    int totalPage = (int) Math.ceil((double) totalData / numPerPage);
	
	    // 페이지 바 시작 번호
	    int pageStart = (((cpage - 1) / pageBarSize) * pageBarSize) + 1;
	    
	    // 페이지 바 종료 번호  
	    int pageEnd = pageStart + pageBarSize - 1;
	    if (pageEnd > totalPage) {
	        pageEnd = totalPage;
	    }
	
//	    // request에 데이터 저장
//	    request.setAttribute("courses", currentPageData);
//	    request.setAttribute("pageStart", pageStart);
//	    request.setAttribute("pageEnd", pageEnd);
//	    request.setAttribute("totalPage", totalPage);
//	    request.setAttribute("cpage", cpage);
//	
//	    request.getRequestDispatcher("/WEB-INF/views/course/courseListBySubject.jsp").forward(request, response);
//	
	    
		
		
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
