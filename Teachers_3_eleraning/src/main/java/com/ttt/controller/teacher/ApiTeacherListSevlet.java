package com.ttt.controller.teacher;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.ttt.dto.Member3;
import com.ttt.service.MemberService;

@WebServlet("/api/teacher/list")
public class ApiTeacherListSevlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Gson gson = new Gson();
       
    public ApiTeacherListSevlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {String subject = request.getParameter("subject");
    
    	// 과목별 선생님 더미 데이터
	    Map<String, List<Map<String, Object>>> teachersBySubject = new HashMap<>();
	    teachersBySubject.put("1", Arrays.asList(
	        Map.of("memberName", "강기동", "subject", 1, "memberNo", 1, "badge", "신규", 
	               "description", "국어의 달인이 되는 핵심 노하우 대공개!"),
	        Map.of("memberName", "김미선", "subject", 1, "memberNo", 2, "badge", "인기",
	               "description", "문학의 감동을 전달하는 맛있는 강의!")
	    ));
        teachersBySubject.put("2", Arrays.asList(
            Map.of("memberName", "박정은", "subject", 2, "memberNo", 3, "badge", ""),
            Map.of("memberName", "윤송실", "subject", 2, "memberNo", 4, "badge", "HOT")
        ));
        teachersBySubject.put("3", Arrays.asList(
            Map.of("memberName", "박정은", "subject", 3, "memberNo", 5, "badge", ""),
            Map.of("memberName", "윤송실", "subject", 3, "memberNo", 6, "badge", "HOT")
        ));
	    
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    gson.toJson(teachersBySubject.get(subject), response.getWriter());
	}

}
