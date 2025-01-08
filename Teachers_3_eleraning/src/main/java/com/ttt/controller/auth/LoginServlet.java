package com.ttt.controller.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Member3;
import com.ttt.service.MemberService;

@WebServlet("/auth/login.do")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String memberId = request.getParameter("memberId");
		String memberPw = request.getParameter("memberPw");
		String saveId = request.getParameter("remember");
		
		Member3 m = new MemberService().selectMemberById(memberId);
		
		System.out.println("MemberLoginServlet.java : " + m);
		
		// 로그인 성공시 처리할 로직 (아이디, 비번 일치)
		if(m!=null && m.getMemberPw().equals(memberPw)) {
			// 로그인 유지를 위한 session 정보 저장
			HttpSession session=request.getSession();
			session.setAttribute("loginMember", m);
			
			// 로그인 유지 체크시 쿠키 생성
			if(saveId != null) {
				Cookie c = new Cookie("saveId", m.getMemberId());
				c.setMaxAge(7*24*60*60);
				c.setPath("/");
				response.addCookie(c);
			} else {
				// 체크 해제시 쿠키 삭제
				Cookie c = new Cookie("saveId","");
				c.setMaxAge(0);
				c.setPath("/");
				response.addCookie(c);
			}
			
			// 메인화면으로 리다이렉트 시킴! 이전 주소 날려버리고 재요청!
			response.sendRedirect(request.getContextPath()); 
		} else {
			// 로그인 실패
			request.setAttribute("msg", "아이디와 패스워드가 일치하지 않습니다."); //실패하면 통상 alert 띄워주기 때문에 사용
			request.setAttribute("loc","/"); 
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
		}
	}

}
