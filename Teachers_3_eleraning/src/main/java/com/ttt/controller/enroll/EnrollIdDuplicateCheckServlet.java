package com.ttt.controller.enroll;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Member3;
import com.ttt.service.MemberService;


@WebServlet("/enroll/checkid")
public class EnrollIdDuplicateCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public EnrollIdDuplicateCheckServlet() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String memberId = request.getParameter("memberId");
		
		Member3 result = new MemberService().selectMemberById(memberId);
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(String.valueOf(result != null));
		
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
