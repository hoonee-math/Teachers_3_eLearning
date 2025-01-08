package com.ttt.controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/member/logout")
public class MemberLogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public MemberLogoutServlet() {
        super();
    }

    // 로그아웃 기능을 통해 쿠키 정보 삭제 로직 구현
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		// 로그인 유지용 쿠키 삭제
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie c : cookies) {
				// saveId 라는 이름의 쿠키 찾기
				if (c.getName().equals("saveId")) {
					// 쿠키 값을 비우고 만료시간을 0으로 설정
					c.setValue("");
					c.setMaxAge(0);
					c.setPath("/"); // 쿠키의 저장 경로도 동일하게 지정
					response.addCookie(c);
					break;
				}
			}
		}

	    // 세션 무효화는 쿠키 삭제 후에 실행
	    if(session != null) {
	        session.invalidate();
	    }
		
		//요청 처리후 주소창의 주소가 /member/logout 인 문제를 해결하기 위해 msg.jsp 로 응답
		String msg="로그아웃 되었습니다.";
		String loc="/";
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
		
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
