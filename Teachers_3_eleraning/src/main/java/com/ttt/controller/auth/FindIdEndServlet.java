package com.ttt.controller.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Member3;

@WebServlet("/auth/findidend")
public class FindIdEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public FindIdEndServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String memberName = request.getParameter("input-name");
		String email = request.getParameter("input-email");
		
		Member3 m = new Member3();
		m = Member3.builder()
				.memberName(memberName)
				.email(email)
				.build();
		
		String memberId = new memberService().selectMemberIdByNameAndEmail(m);
		
		String msg, loc;
		
		if(memberId != null && !memberId.isEmpty()) {
			msg = memberName+"님의 아이디는 "+memberId+" 입니다.";
			loc = "/";
		}else {
			msg = "일치하는 회원 정보가 없습니다.";
			loc = "/auth/find";
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
