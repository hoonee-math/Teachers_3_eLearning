package com.ttt.controller.course;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Course3;
import com.ttt.service.CourseService;

@WebServlet("/course/list")
public class ToCourseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ToCourseServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 파라미터 처리
		String subjectName = request.getParameter("subjectName");
		if(subjectName == null) subjectName = "국어";
		
		
		// 페이징 처리를 위한 현재 페이지 정보
		int cpage = 1;
		try {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		} catch (NumberFormatException e) {
		}
		
		int numPerPage = 2; // 한 페이지당 데이터 수
		
		// 현재 페이지에 해당하는 데이터만 추출
		int start = (cpage - 1) * numPerPage;
		int end = start + numPerPage;
		
		Map<String, Object> param = Map.of(
					"start", start,
					"end", end,
					"subjectName", subjectName);
		
		List<Course3> courses = new CourseService().selectCourseBySubjectNo(param);
		
		// 전체 데이터 수
		int totalData = courses.size();

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

		// request에 데이터 저장
		request.setAttribute("courses", courses);
		request.setAttribute("pageStart", pageStart);
		request.setAttribute("pageEnd", pageEnd);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("cpage", cpage);

		request.getRequestDispatcher("/WEB-INF/views/course/courseListBySubject.jsp").forward(request, response);
	}

}
