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
		
//    	List<Map<String, Object>> teachers = new ArrayList<>();
//    	teachers.add(Map.of("memberName", "강기동", "subject", 1,"memberNo",1));
//    	teachers.add(Map.of("memberName", "김미선", "subject", 1,"memberNo",1));
//    	teachers.add(Map.of("memberName", "장재학", "subject", 1,"memberNo",1));
//    	teachers.add(Map.of("memberName", "존 스미스", "subject", 2,"memberNo",1)); // 영어

//    	request.setAttribute("teachers", teachers);
//    	System.out.println(teachers);
//    	// JSP에서 사용할 subject 데이터
//    	Map<Integer, String> subjectData = Map.of(
//    	    1, "국어",
//    	    2, "영어",
//    	    3, "수학",
//    	    4, "사회",
//    	    5, "과학",
//    	    6, "기타"
//    	);
//    	request.setAttribute("subjectData", subjectData);
//    	request.getRequestDispatcher("/WEB-INF/views/teacher/teacherListAndDetail.jsp").forward(request, response);
    	
    	
    	try {
            // 페이징 처리를 위한 현재 페이지 정보
            int cpage = 1;
            try {
                cpage = Integer.parseInt(request.getParameter("cpage"));
            } catch (NumberFormatException e) {}
            
            int numPerPage = 6; // 한 페이지당 표시할 선생님 수
            
            // 시작/끝 row 계산
            int start = (cpage - 1) * numPerPage + 1;
            int end = cpage * numPerPage;
            String teacherSubject = request.getParameter("subject");
            if (teacherSubject==null) {
            	teacherSubject="국어";
            }
            
            // 요청 파라미터 설정
            Map<String, Object> param = new HashMap<>();
            param.put("start", start);
            param.put("end", end);
            param.put("teacherSubject", teacherSubject);
            System.out.println(param.get("teacherSubject"));
            
            System.out.println("param값"+param.toString());
            // 선생님 목록 조회
            List<Member3> teachers = new MemberService().selectTeachersBySubject(param);
            System.out.println("선생님 목록"+ teachers.toString());
            int totalData = new MemberService().selectTeachersCount(param); // 전체 선생님 수
            
            // 페이징 바 생성
            int totalPage = (int)Math.ceil((double)totalData/numPerPage);
            int pageBarSize = 5;
            int pageStart = ((cpage-1)/pageBarSize) * pageBarSize + 1;
            int pageEnd = pageStart + pageBarSize - 1;
            if(pageEnd > totalPage) pageEnd = totalPage;
            
            // JSP에서 사용할 데이터 설정
            request.setAttribute("teachers", teachers);
            request.setAttribute("pageStart", pageStart);
            request.setAttribute("pageEnd", pageEnd);
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("cpage", cpage);
            
            System.out.println("1:"+teachers);
            System.out.println("2:"+pageStart);
            System.out.println("3:"+pageEnd);
            System.out.println("4:"+totalPage);
            System.out.println("5:"+cpage);
            System.out.println("6:"+totalData);
            
            // 과목 목록
            List<String> subjectData = new ArrayList<>(Arrays.asList("국어", "수학", "영어", "사회"));
            List<String> subject2 = new MemberService().selectSubjects();
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
