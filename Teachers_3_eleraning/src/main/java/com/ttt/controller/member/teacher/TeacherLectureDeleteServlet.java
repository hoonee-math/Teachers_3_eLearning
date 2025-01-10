package com.ttt.controller.member.teacher;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Member3;
import com.ttt.service.LectureService;

@WebServlet("/member/teacher/mypage/lecture/delete/*")
public class TeacherLectureDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private LectureService lectureService = new LectureService();
       
    public TeacherLectureDeleteServlet() {
        super();
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

            // 2. URL에서 강의 번호 추출 및 파싱
            String pathInfo = request.getPathInfo();
            if(pathInfo == null || pathInfo.equals("/")) {
                throw new Exception("강의 번호가 필요합니다.");
            }
            
            int lectureNo;
            try {
                lectureNo = Integer.parseInt(pathInfo.substring(1)); // '/' 이후의 숫자
            } catch (NumberFormatException e) {
                throw new Exception("유효하지 않은 강의 번호입니다.");
            }

            // 3. 서비스 호출하여 삭제(상태 변경) 처리
            int result = lectureService.updateDeleteLecture(lectureNo);

            // 4. 결과 응답
            StringBuilder jsonResponse = new StringBuilder();
            jsonResponse.append("{")
                       .append("\"success\":" + (result > 0) + ",")
                       .append("\"message\":\"" + (result > 0 ? "강의가 삭제되었습니다." : "강의 삭제에 실패했습니다.") + "\"")
                       .append("}");
            
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
