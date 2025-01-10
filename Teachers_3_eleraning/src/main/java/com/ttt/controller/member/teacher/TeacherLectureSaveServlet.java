package com.ttt.controller.member.teacher;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
    private static final DateTimeFormatter formatter =  DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");  
    
    public TeacherLectureSaveServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json;charset=utf-8");
	    PrintWriter out = response.getWriter();
	    
	    try {
	        // 1. 로그인 체크
	        HttpSession session = request.getSession();
	        Member3 loginMember = (Member3)session.getAttribute("loginMember");
	        if(loginMember == null || loginMember.getMemberType() != 2) {
	            throw new Exception("권한이 없습니다.");
	        }

	        // 2. 필수 파라미터 파싱 - NumberFormatException 처리
	        int courseNo;
	        int lectureOrder;
	        try {
	            courseNo = Integer.parseInt(request.getParameter("courseNo"));
	            lectureOrder = Integer.parseInt(request.getParameter("lectureOrder"));
	        } catch (NumberFormatException e) {
	            throw new Exception("강좌번호와 강의순서는 숫자여야 합니다.");
	        }

	        // 3. 필수값 null 체크
	        String lectureTitle = request.getParameter("lectureTitle");
	        if(lectureTitle == null || lectureTitle.trim().isEmpty()) {
	            lectureTitle = lectureOrder + "차시 강의"; // 기본값 설정
	        }

	        // 4. Lecture3 객체 생성
	        Lecture3 lecture = Lecture3.builder()
	            .courseNo(courseNo)
	            .lectureTitle(lectureTitle)
	            .lectureOrder(lectureOrder)
	            .lectureStatus('1')
	            .build();
	            
	        // 5. 선택적 일정 데이터 파싱
	        String eventStart = request.getParameter("eventStart");
	        String eventEnd = request.getParameter("eventEnd");
	        String videoUrl = request.getParameter("videoUrl");
	        
	        ScheduleEvent3 event = null;
	        if(eventStart != null && eventEnd != null && 
	           !eventStart.trim().isEmpty() && !eventEnd.trim().isEmpty()) {
	            try {
	                event = ScheduleEvent3.builder()
	                    .eventTitle(lectureTitle)
	                    .eventStart(LocalDateTime.parse(eventStart.trim(), formatter))
	                    .eventEnd(LocalDateTime.parse(eventEnd.trim(), formatter))
	                    .videoUrl(videoUrl != null && !videoUrl.trim().isEmpty() ? videoUrl : null)
	                    .build();
	            } catch (DateTimeParseException e) {
	                throw new Exception("날짜 형식이 올바르지 않습니다. (yyyy-MM-dd HH:mm:ss 형식이어야 합니다)");
	            }
	        }
	        
	        // 6. 서비스 호출하여 저장
	        int result = lectureService.insertLectureWithSchedule(lecture, event);
	        
	        // 7. 응답 생성
	        StringBuilder jsonResponse = new StringBuilder();
	        jsonResponse.append("{")
	                   .append("\"success\":" + (result > 0) + ",")
	                   .append("\"message\":\"" + (result > 0 ? "강의가 저장되었습니다." : "강의 저장에 실패했습니다.") + "\"");
	        if(result > 0) {
	            jsonResponse.append(",\"lectureNo\":" + lecture.getLectureNo());
	        }
	        jsonResponse.append("}");
	        
	        out.write(jsonResponse.toString());
	        
	    } catch(Exception e) {
	        e.printStackTrace();
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        out.write("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
	    } finally {
	        out.close();
	    }
	}

}
