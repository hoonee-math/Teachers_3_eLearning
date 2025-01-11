package com.ttt.controller.teacher;

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

import com.google.gson.Gson;

// 선생님 탭에서 과목별 각 선생님을 선택하면 나타나는 선생님 프로필 출력
@WebServlet("/api/teachers")
public class ApiTeacherProfileServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
    private Gson gson = new Gson();
       
    public ApiTeacherProfileServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        // memberNo 파라미터 받기
        String memberNo = request.getParameter("memberNo");
        System.out.println("Requested memberNo: ");
		
		// 실제 DB 연동 코드 (추후 구현)
        /*
        String teacherId = request.getParameter("teacherId");
        TeacherDAO teacherDAO = new TeacherDAO();
        Teacher teacher = teacherDAO.getTeacherById(Integer.parseInt(teacherId));
        */

        // 임시 데이터를 Map으로 생성
        Map<String, Object> teacher = new HashMap<>();
        teacher.put("id", memberNo);
        teacher.put("name", "정승제");
        teacher.put("imageUrl", "https://i.namu.wiki/i/W-LhGCCNTAE3F7AJ81_DQpGg7XQbQolN76WcFDjbYgkSoOp8NnGgEj8PyGblftQNMKTTv_NJ8lfBz9XzpMlggQ.webp");
        teacher.put("title", "개념과 지독한 연습이 만점을 만듭니다!");

        List<String> tags = new ArrayList<>();
        tags.add("개념");
        tags.add("학력과 통계");
        tags.add("수능 대비");
        teacher.put("tags",tags);

        // CORS 헤더 설정
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        
        // 응답 설정
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(gson.toJson(teacher));
	}

}
