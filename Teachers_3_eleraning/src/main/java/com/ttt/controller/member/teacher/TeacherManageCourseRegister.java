package com.ttt.controller.member.teacher;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Course3;
import com.ttt.dto.Member3;
import com.ttt.service.CourseService;

@WebServlet("/member/teacher/course/register")
public class TeacherManageCourseRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
	   	
	public TeacherManageCourseRegister() {
		super();	
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 페이징 및 필터 파라미터 처리
		int cpage = 1;
		int numPerPage = 10; // 기본값
		String status = "all"; // 기본값
		
		try {
			if(request.getParameter("cpage") != null) {
				cpage = Integer.parseInt(request.getParameter("cpage"));
			}
			if(request.getParameter("numPerPage") != null) {
				numPerPage = Integer.parseInt(request.getParameter("numPerPage"));
			}
			if(request.getParameter("status") != null) {
				status = request.getParameter("status");
			}
		} catch (NumberFormatException e) {}
		
		// 세션에서 교사 정보 가져오기
		HttpSession session = request.getSession();
		Member3 loginMember = (Member3)session.getAttribute("loginMember");
		
		// 상태별 카운트 조회
		Map<String,Integer> counts = new CourseService().getCourseCountsByStatus(loginMember.getMemberNo());
		request.setAttribute("totalCount", counts.get("total"));
		request.setAttribute("inProgressCount", counts.get("inProgress"));
		request.setAttribute("preparingCount", counts.get("preparing"));
		request.setAttribute("completedCount", counts.get("completed"));
		
		// 상태에 따른 강좌 목록 조회
		List<Course3> courses = new CourseService()
				.getTeacherCoursesByStatus(loginMember.getMemberNo(), status, cpage, numPerPage);
		int totalData = counts.get(status.equals("all") ? "total" : status);
		
		// 페이징 처리 계산
		int totalPage = (int)Math.ceil((double)totalData/numPerPage);
		int pageBarSize = 5;
		int pageStart = ((cpage-1)/pageBarSize) * pageBarSize + 1;
		int pageEnd = pageStart + pageBarSize - 1;
		if(pageEnd > totalPage) {
			pageEnd = totalPage;
		}
		
		// request에 데이터 저장
		request.setAttribute("courses", courses);
		request.setAttribute("pageStart", pageStart);
		request.setAttribute("pageEnd", pageEnd);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("cpage", cpage);
		request.setAttribute("numPerPage", numPerPage);
		request.setAttribute("currentStatus", status);
		
		request.getRequestDispatcher("/WEB-INF/views/member/teacherManageCourse.jsp")
			   .forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
