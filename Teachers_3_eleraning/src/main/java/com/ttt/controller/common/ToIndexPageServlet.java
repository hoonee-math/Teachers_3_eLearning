package com.ttt.controller.common;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"","/home"})
public class ToIndexPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ToIndexPageServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 세션 체크 
        HttpSession session = request.getSession();
        
        // (더미데이터) 세션에 로그인 정보가 없을 경우에만 테스트 데이터 생성
        if(session.getAttribute("loginMember") == null) {
            // 테스트용 회원 데이터 Map 생성 (SQL의 USERS, STUDENTS 테이블 구조 참고)
            Map<String, Object> memberMap = new HashMap<>();
            memberMap.put("memberNo", 1);
            memberMap.put("memberId", "testuser");
            memberMap.put("memberName", "테스트유저");
            memberMap.put("email", "test@test.com");
            memberMap.put("memberPhone", "010-1234-5678");
            memberMap.put("memberType", 1); // 1: 학생
            memberMap.put("enrollDate", new Date());
            memberMap.put("memberAddress", "서울시 강남구");
            memberMap.put("grade", 1); // 고1
            memberMap.put("schoolNo", 1234);
            
            // 세션에 저장
            session.setAttribute("loginMember", memberMap);
        }
        
		request.getRequestDispatcher("/index.jsp").forward(request, response);
	}

}
