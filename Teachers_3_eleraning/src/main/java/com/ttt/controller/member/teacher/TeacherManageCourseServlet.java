package com.ttt.controller.member.teacher;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Member3;
import com.ttt.service.CourseService;

@WebServlet("/member/teacher/mypage/course")
public class TeacherManageCourseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public TeacherManageCourseServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 페이징 및 필터 파라미터 처리
		int cpage = 1;
		int numPerPage = 10; // 기본값
		String status = request.getParameter("status"); // status 유형에 따른 totalData 계산
	    if(status == null) status = "all"; // 기본값
//	    System.out.println(status);
		
		try { cpage = Integer.parseInt(request.getParameter("cpage"));
		} catch (NumberFormatException e) {}
		try { numPerPage = Integer.parseInt(request.getParameter("numPerPage"));
		} catch (NumberFormatException e) {}
		
		// 세션에서 교사 정보 가져오기
		HttpSession session = request.getSession();
		Member3 loginMember = (Member3)session.getAttribute("loginMember");

	    // 카테고리 목록 조회
	    List<String> categories = new CourseService().selectAllCategories();
	    request.setAttribute("categories", categories);
		
		// 강좌 목록과 상태별 카운트 조회
		Map<String, Object> result = new CourseService().selectCoursesByTeacher(loginMember.getMemberNo(), status);
		// 페이징 처리
		BigDecimal totalCountDecimal = (BigDecimal)result.get("totalCount"); // 전체 데이터 수
		int totalData = totalCountDecimal.intValue(); // 전체 데이터 수
	    int totalPage = (int)Math.ceil((double)totalData/numPerPage);
	    int pageBarSize = 5;
	    int pageStart = (cpage - 1) / pageBarSize * pageBarSize + 1;
	    int pageEnd = pageStart + pageBarSize - 1;
	    if(pageEnd > totalPage) {
	        pageEnd = totalPage;
	    }

	    // 페이징 관련 데이터도 request에 저장
	    request.setAttribute("pageStart", pageStart);
	    request.setAttribute("pageEnd", pageEnd);
	    request.setAttribute("totalPage", totalPage);
		// request에 데이터 저장
		request.setAttribute("courses", result.get("courses"));
        request.setAttribute("totalCount", result.get("totalCount"));
        request.setAttribute("preparingCount", result.get("preparingCount"));
        request.setAttribute("inProgressCount", result.get("inProgressCount"));
        request.setAttribute("completedCount", result.get("completedCount"));
        request.setAttribute("cpage", cpage);
        request.setAttribute("numPerPage", numPerPage);
        request.setAttribute("currentStatus", status);
		
		request.getRequestDispatcher("/WEB-INF/views/member/teacherManageCourse.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
