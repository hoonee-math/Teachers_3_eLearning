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
		try {
            // 파라미터 받기
            int grade = Integer.parseInt(request.getParameter("grade"));
            String view = request.getParameter("view"); // 'all' or 'my'
            
			// 현재 로그인한 회원 정보 가져오기
			HttpSession session = request.getSession();
			Member3 loginMember = (Member3) session.getAttribute("loginMember");

			// 응답할 이벤트 목록
			List<Map<String, Object>> events = new ArrayList<>();
            
			// 파라미터로 맵 생성
			Map<String, Object> params = new HashMap<>();
			params.put("grade", grade);

			// 회원 유형에 따라 다른 일정 조회
			if(loginMember != null && "my".equals(view)) {
                params.put("memberNo", loginMember.getMemberNo());
                params.put("memberType", loginMember.getMemberType());
                
				if (loginMember.getMemberType() == 1) { // 학생
					events = lectureService.selectEventsByStudentNo(params);
				} else if (loginMember.getMemberType() == 2) { // 교사
					events = lectureService.selectEventsByTeacherNo(params);
				} else {
					events = lectureService.selectEventsByGrade(params); // 기본: 학년별 조회
					// 본인 강좌의 일정 조회
					// events = lectureService.selectEventsByTeacherNo(loginMember.getMemberNo());
				}
			} else {
				events = lectureService.selectEventsByGrade(params); // 기본: 학년별 조회
			}

            // 수강신청 여부 추가 - 로그인된 사용자의 강의 데이터 존재 여부 확인
            if(loginMember != null && loginMember.getMemberType() == 1) {
                for(Map<String, Object> event : events) {
                    int courseNo = ((Number)event.get("COURSE_NO")).intValue();
                    boolean isEnrolled = courseService.checkEnrollment(loginMember.getMemberNo(), courseNo);
                    event.put("isEnrolled", isEnrolled);
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
