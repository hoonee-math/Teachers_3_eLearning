package com.ttt.controller.member.teacher;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
import com.ttt.dto.Course3;
import com.ttt.dto.Lecture3;
import com.ttt.dto.Member3;
import com.ttt.dto.ScheduleEvent3;
import com.ttt.service.CourseService;
import com.ttt.service.LectureService;

@WebServlet("/member/teacher/mypage/lecturelist")
public class TeacherManageLectureListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private LectureService lectureService = new LectureService();
	private CourseService courseService = new CourseService();
	   
	public TeacherManageLectureListServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			// 1. 강좌 번호 파라미터 받기
			int courseNo = Integer.parseInt(request.getParameter("courseNo"));
			
			// 2. 세션에서 로그인한 교사 정보 가져오기
			HttpSession session = request.getSession();
			Member3 loginMember = (Member3)session.getAttribute("loginMember");
			
			// 3. 강좌 정보 조회
			Course3 course = courseService.selectCourseByNo(courseNo);
			
			// 4. 권한 체크 (본인 강좌인지 확인)
			if(course != null && course.getMemberNo() == loginMember.getMemberNo()) {
				// 5. 강의 목록 조회
				List<Lecture3> lectures = lectureService.selectLecturesByCourseNo(courseNo);
				
				// 6. request에 데이터 저장
				request.setAttribute("course", course);
				request.setAttribute("lectures", lectures);
				
				// 7. JSP로 포워딩
				request.getRequestDispatcher("/WEB-INF/views/member/teacherManageLectureList.jsp")
					   .forward(request, response);
			} else {
				// 권한이 없는 경우
				response.sendError(HttpServletResponse.SC_FORBIDDEN);
			}
			
		} catch(NumberFormatException e) {
			// courseNo 파라미터가 없거나 잘못된 경우
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		}
		
		//request.getRequestDispatcher("/WEB-INF/views/member/teacherManageLectureList.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Map<String, Object> responseData = new HashMap<>();
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");  // UTF-8 인코딩 명시적 설정
		
		try {
			// 1. 요청 데이터 파싱
			BufferedReader reader = request.getReader();
			Gson gson = new Gson();
			Map<String, Object> data = gson.fromJson(reader, Map.class);
			
			// 2. 강의 일정 데이터 변환 및 저장
			List<Map<String, Object>> lectureDataList = (List<Map<String, Object>>)data.get("lectures");
			int courseNo = ((Double)data.get("courseNo")).intValue();
			
			List<Lecture3> lectures = new ArrayList<>();
			List<ScheduleEvent3> events = new ArrayList<>();
			
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			
			// 3. 각 강의 데이터를 DTO로 변환
			for(Map<String, Object> lectureData : lectureDataList) {
				Lecture3 lecture = Lecture3.builder()
					.courseNo(courseNo)
					.lectureTitle((String)lectureData.get("lectureTitle"))
					.lectureOrder(((Double)lectureData.get("lectureOrder")).intValue())
					.lectureStatus('1')
					.build();
				
				// 문자열을 LocalDateTime으로 변환
				LocalDateTime startTime = LocalDateTime.parse(
					(String)lectureData.get("eventStart"), formatter);
				LocalDateTime endTime = LocalDateTime.parse(
					(String)lectureData.get("eventEnd"), formatter);
				
				ScheduleEvent3 event = ScheduleEvent3.builder()
					.eventTitle((String)lectureData.get("lectureTitle"))
					.eventStart(startTime)
					.eventEnd(endTime)
					.videoUrl((String)lectureData.get("videoUrl"))
					.build();
				
				lectures.add(lecture);
				events.add(event);
			}
			
			// 4. 서비스 호출하여 저장
			int result = lectureService.insertLecturesWithSchedules(lectures, events);
			
			// 5. 결과 응답
	        // 성공/실패 여부와 메시지 포함
	        responseData.put("success", result == lectures.size());
	        responseData.put("message", result == lectures.size() ? 
	            "강의 일정이 성공적으로 등록되었습니다." : 
	            "일부 강의 일정 등록에 실패했습니다.");
	        responseData.put("count", result);  // 실제 등록된 개수
			
		} catch(Exception e) {
	        // 에러 발생 시 클라이언트에 의미있는 메시지 전달
	        responseData.put("success", false);
	        responseData.put("message", "강의 일정 등록 중 오류가 발생했습니다.");
	        responseData.put("error", e.getMessage());
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
		
	    response.getWriter().write(new Gson().toJson(responseData));
	}

}
