package com.ttt.controller.enroll;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Member3;
import com.ttt.service.MemberService;

@WebServlet("/enroll/idduplicate.do")
public class IdDuplicateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public IdDuplicateServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String memberId = request.getParameter("memberId");
		request.setAttribute("memberId", memberId);
		
		//DB member 테이블에 일치하는 값이 있는지 확인
		Member3 m=new MemberService().selectMemberById(memberId);
		
		request.setAttribute("result", m==null); // 일회용 데이터이기 때문에 request 
		
		request.getRequestDispatcher("/WEB-INF/views/enroll/idDuplicate.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
