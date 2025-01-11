package com.ttt.controller.member.teacher;

import java.io.BufferedReader;
import java.io.IOException;
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
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
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
			HttpSession session = request.getSession();
			Member3 teacher = (Member3)session.getAttribute("loginMember");
//			System.out.println("선생님 정보 : "+teacher);
						
			// 1. 요청 데이터 읽기
			BufferedReader reader = request.getReader();
			StringBuilder buffer  = new StringBuilder();
			String line;
			while ((line = reader.readLine()) != null) {
				buffer .append(line);
			}
//			System.out.println("받은 JSON 데이터: " + buffer .toString());

			// 2. JSON 파싱
			JsonObject jsonObject = new Gson().fromJson(buffer.toString(), JsonObject.class);
			int courseNo = jsonObject.get("courseNo").getAsInt();
			JsonArray lecturesArray = jsonObject.get("lectures").getAsJsonArray();

//			System.out.println("jsonObject: " + jsonObject);
//			System.out.println("lecturesArray: " + lecturesArray);

			// 3. 데이터 변환 및 저장을 위한 리스트 준비
			List<Lecture3> lectures = new ArrayList<>();
			List<ScheduleEvent3> events = new ArrayList<>();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			
			// 4. 각 강의 데이터 처리
			for (JsonElement element : lecturesArray) {
				JsonObject lecture = element.getAsJsonObject();
				
				// 4-1. Lecture 객체 생성
				Lecture3 lectureObj = Lecture3.builder()
					.courseNo(courseNo)
					.lectureTitle(lecture.get("lectureTitle").getAsString())
					.lectureOrder(lecture.get("lectureOrder").getAsInt())
					.lectureStatus('1')
					.build();

				// 4-2. ScheduleEvent 객체 생성
				ScheduleEvent3 eventObj = ScheduleEvent3.builder()
					.eventTitle(lecture.get("lectureTitle").getAsString())
					.eventStart(LocalDateTime.parse(lecture.get("eventStart").getAsString(), formatter))
					.eventEnd(LocalDateTime.parse(lecture.get("eventEnd").getAsString(), formatter))
					.videoUrl(lecture.get("videoUrl").isJsonNull() 
						? null : lecture.get("videoUrl").getAsString())
					.lecture(lectureObj)
					.member(teacher)
					.build();

	            lectures.add(lectureObj);
	            events.add(eventObj);
			}
//			System.out.println("lectures: "+lectures);
//			System.out.println("events: "+events);
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
			e.printStackTrace();
			// 에러 발생 시 클라이언트에 의미있는 메시지 전달
			responseData.put("success", false);
			responseData.put("message", "강의 일정 등록 중 오류가 발생했습니다.");
			responseData.put("error", e.getMessage());
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
		
		response.getWriter().write(new Gson().toJson(responseData));
	}

}
