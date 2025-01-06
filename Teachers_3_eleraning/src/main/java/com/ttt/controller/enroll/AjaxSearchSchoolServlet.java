package com.ttt.controller.enroll;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.ttt.dto.School12;
import com.ttt.service.SchoolService;

@WebServlet("/Ajax/School/Search")
public class AjaxSearchSchoolServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AjaxSearchSchoolServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String district = request.getParameter("district");
		String strSchoolType = request.getParameter("schoolType");
		int schoolType=0;
		switch(strSchoolType) {
			case "초등학교": schoolType=1; break;
			case "중학교": schoolType=2; break;
			case "고등학교": schoolType=3; break;
			case "기타학교": schoolType=4; break;
		}
		
		Map<String, Object> params = new HashMap<>();
		params.put("district", district);
		params.put("schoolType", schoolType);
		
		List<School12> schools = new SchoolService().selectNameAndCode(params);
		
		response.setContentType("application/json;charset=UTF-8");
		new Gson().toJson(schools, response.getWriter());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
