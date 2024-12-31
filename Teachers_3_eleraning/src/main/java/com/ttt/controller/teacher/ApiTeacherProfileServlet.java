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
		
		// 실제 DB 연동 코드 (추후 구현)
        /*
        String teacherId = request.getParameter("teacherId");
        TeacherDAO teacherDAO = new TeacherDAO();
        Teacher teacher = teacherDAO.getTeacherById(Integer.parseInt(teacherId));
        */

        // 임시 데이터를 Map으로 생성
        Map<String, Object> teacher = new HashMap<>();

        // 더미 데이터
        teacher.put("id", 1);
        teacher.put("name", "정승제");
        teacher.put("imageUrl", "/images/teachers/jung.jpg");
        teacher.put("title", "개념과 지독한 연습이 만점을 만듭니다!");

        List<String> tags = new ArrayList<>();
        tags.add("개념");
        tags.add("학력과 통계");
        tags.add("수능 대비");
        teacher.put("tags",tags);
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(gson.toJson(teacher));
	}

}
