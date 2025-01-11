package com.ttt.controller.member.teacher;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.ttt.dto.Lecture3;
import com.ttt.dto.Member3;
import com.ttt.dto.ScheduleEvent3;
import com.ttt.service.LectureService;

/**
 * Servlet implementation class TeacherLectureSaveServlet
 */
@WebServlet("/member/teacher/mypage/lecture/save")
public class TeacherLectureSaveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private LectureService lectureService = new LectureService();

	// formatter 선언 추가
	private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

	public TeacherLectureSaveServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("application/json;charset=utf-8");
		PrintWriter out = response.getWriter();

		try {
			// 1. 로그인 체크
			HttpSession session = request.getSession();
			Member3 loginMember = (Member3) session.getAttribute("loginMember");
			if (loginMember == null || loginMember.getMemberType() != 2) {
				throw new Exception("권한이 없습니다.");
			}

			// 2. JSON 데이터 읽기 및 파싱
			BufferedReader reader = request.getReader();
			Map<String, Object> data = new Gson().fromJson(reader, Map.class);

			// 3. 필수값 파싱
			int courseNo = ((Number) data.get("courseNo")).intValue();
			int lectureOrder = ((Number) data.get("lectureOrder")).intValue();
			String lectureTitle = (String) data.get("lectureTitle");
			if (lectureTitle == null || lectureTitle.trim().isEmpty()) {
				lectureTitle = lectureOrder + "차시 강의"; // 기본값 설정
			}

			// 4. Lecture3 객체 생성
			Lecture3 lecture = Lecture3.builder().courseNo(courseNo).lectureTitle(lectureTitle)
					.lectureOrder(lectureOrder).lectureStatus('1').build();

			// 5. 일정 데이터가 있는 경우 ScheduleEvent3 객체 생성
			ScheduleEvent3 event = null;
			String eventStart = (String) data.get("eventStart");
			String eventEnd = (String) data.get("eventEnd");

			if (eventStart != null && eventEnd != null && !eventStart.trim().isEmpty() && !eventEnd.trim().isEmpty()) {
				try {
					event = ScheduleEvent3.builder().eventTitle(lectureTitle)
							.eventStart(LocalDateTime.parse(eventStart.trim(), formatter))
							.eventEnd(LocalDateTime.parse(eventEnd.trim(), formatter))
							.videoUrl((String) data.get("videoUrl")).build();
				} catch (DateTimeParseException e) {
					throw new Exception("날짜 형식이 올바르지 않습니다.");
				}
			}
			
//			System.out.println(lecture);
//			System.out.println(event);
			// 6. 서비스 호출하여 저장
			int result = lectureService.insertLectureWithSchedule(lecture, event);

			// 7. 응답 생성
			StringBuilder jsonResponse = new StringBuilder();
			jsonResponse.append("{").append("\"success\":" + (result > 0) + ",")
					.append("\"message\":\"" + (result > 0 ? "강의가 저장되었습니다." : "강의 저장에 실패했습니다.") + "\"");
			if (result > 0) {
				jsonResponse.append(",\"lectureNo\":" + lecture.getLectureNo());
			}
			jsonResponse.append("}");

			out.write(jsonResponse.toString());

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			out.write("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
		} finally {
			out.close();
		}
	}

}
