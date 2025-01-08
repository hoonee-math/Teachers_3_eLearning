package com.ttt.controller.calendar;

import java.io.IOException;
import java.util.ArrayList;
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
		try {
			// 현재 로그인한 회원 정보 가져오기
			HttpSession session = request.getSession();
			Member3 loginMember = (Member3) session.getAttribute("loginMember");

			// 응답할 이벤트 목록
			List<Map<String, Object>> events = new ArrayList<>();

			// 회원 유형에 따라 다른 일정 조회
			if (loginMember != null) {
				if (loginMember.getMemberType() == 1) { // 학생
					// 수강 중인 강좌의 일정 조회
					events = lectureService.selectEventsByStudentNo(loginMember.getMemberNo());
				} else if (loginMember.getMemberType() == 2) { // 교사
					// 본인 강좌의 일정 조회
					events = lectureService.selectEventsByTeacherNo(loginMember.getMemberNo());
				}
			}

			// JSON 응답 설정
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(gson.toJson(events));

		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
