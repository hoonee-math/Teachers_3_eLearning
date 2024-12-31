package com.ttt.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

@WebServlet("/admin/dday")
public class AdminDdayServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Gson gson = new Gson();
       
    public AdminDdayServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

        Map<String, Object> result = new HashMap<>();
        
        try {
            // 임시 데이터를 Map으로 생성
            Map<String, String> dday = new HashMap<>();
            dday.put("ddayName", "전국연합학력평가");
            dday.put("ddayDate", "2024-03-20");
            
            result.put("success", true);
            result.put("data", dday);
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "D-day 정보를 불러올 수 없습니다.");
        }
        
        response.getWriter().write(gson.toJson(result));
    
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
