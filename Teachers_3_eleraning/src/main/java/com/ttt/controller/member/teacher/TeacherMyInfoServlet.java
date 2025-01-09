package com.ttt.controller.member.teacher;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Member3;

@WebServlet("/member/teacher/profile")
public class TeacherMyInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	public TeacherMyInfoServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false); //로그인 세션 가져오기(없으면 생성 하지않음)
		Member3 m = new Member3();
		if(session != null) {
			m = (Member3)session.getAttribute("loginMember");
			
			String address = m.getAddress();
			
			if(address != null) {
				String[] addressParts = address.split(":");
				String addressNo = addressParts[0];
				String addressRoad = addressParts[1];
				String addressDetail = "";
				
				// 상세 주소가 입력되었을 경우에만 상세 주소 가져오기
				if(addressParts.length > 2) {
					addressDetail = addressParts[2];
				}
				
				request.setAttribute("addressNo", addressNo);
				request.setAttribute("addressRoad", addressRoad);
				request.setAttribute("addressDetail", addressDetail);
				
			}
			
			request.getRequestDispatcher("/WEB-INF/views/member/teacherMyInfo.jsp").forward(request, response);
		}
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
