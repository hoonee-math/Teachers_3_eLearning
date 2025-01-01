package com.ttt.controller.course;

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

@WebServlet("/course/list")
public class ToCourseSevlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ToCourseSevlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 페이징 처리를 위한 현재 페이지 정보
		int cpage = 1;
		try {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		} catch (NumberFormatException e) {
		}

		int numPerPage = 2; // 한 페이지당 데이터 수

		// 더미 데이터 생성
		List<Map<String, Object>> courses = new ArrayList<>();

		// 더미 데이터 10개 추가
		for (int i = 1; i <= 10; i++) {
			Map<String, Object> course = new HashMap<>();
			course.put("courseNo", i);
			course.put("courseTitle", "2024 수능대비 " + i + "번 강좌");
			course.put("courseDesc", i + "번 강좌에 대한 상세 설명입니다.");
			course.put("coursePrice", 150000 + (i * 10000));
			course.put("coursePriceSale", 10); // 10% 할인
			course.put("memberNo", i);
			course.put("memberName", "강기동" + i);
			course.put("teacherSubject", "국어");
			course.put("teacherInfoTitle", "개념과 지독한 연습이 만점을 만듭니다!");
			course.put("imageNo", i);
			courses.add(course);
		}

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

		// 현재 페이지에 해당하는 데이터만 추출
		int start = (cpage - 1) * numPerPage;
		int end = Math.min(start + numPerPage, totalData);
		List<Map<String, Object>> currentPageData = courses.subList(start, end);

		// request에 데이터 저장
		request.setAttribute("courses", currentPageData);
		request.setAttribute("pageStart", pageStart);
		request.setAttribute("pageEnd", pageEnd);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("cpage", cpage);

		request.getRequestDispatcher("/WEB-INF/views/course/courseListBySubject.jsp").forward(request, response);
	}

}
