package com.ttt.controller.calendar;

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
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.ttt.dto.Member3;
import com.ttt.service.CourseService;
import com.ttt.service.LectureService;

@WebServlet("/api/calendar/events")
public class ApiCalendarEventsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private LectureService lectureService = new LectureService();
	private CourseService courseService = new CourseService();
	private Gson gson = new Gson();
	   
	public ApiCalendarEventsServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("=== Calendar Events API 호출 시작 ===");

		try {
			// 파라미터 받기
			int grade = Integer.parseInt(request.getParameter("grade"));
			
			// 응답 데이터 준비
			Map<String, Object> responseData = new HashMap<>();
			responseData.put("grade", grade);
			
			System.out.println("요청된 학년: " + grade);
			// 1. 해당 학년의 전체 강의 일정 조회
			List<Map<String, Object>> events = lectureService.selectEventsByGrade(responseData);
			responseData.put("events", events);
			
			// 2. 로그인한 경우 수강 중인 강좌 번호 목록 추가
			HttpSession session = request.getSession();
			Member3 loginMember = (Member3) session.getAttribute("loginMember");

			// 회원 유형에 따라 다른 일정 조회
			if(loginMember != null) {
				if (loginMember.getMemberType() == 1) { // 학생
					List<Integer> enrolledCourses = courseService.selectEnrolledCourseNos(loginMember.getMemberNo());
					responseData.put("enrolledCourses", enrolledCourses);
				} else if (loginMember.getMemberType() == 2) { // 교사
					List<Integer> teachingCourses = courseService.selectTeachingCourseNos(loginMember.getMemberNo());
					responseData.put("teachingCourses", teachingCourses);
				}
			}

			// JSON 응답 설정
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			String jsonResponse = gson.toJson(responseData);
			System.out.println("응답 데이터: " + jsonResponse);
			System.out.println("=== Calendar Events API 호출 완료 ===");
			response.getWriter().write(jsonResponse);

		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
