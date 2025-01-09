package com.ttt.controller.member.student;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Member3;
import com.ttt.dto.School12;
import com.ttt.service.MemberService;

@WebServlet("/member/student/myinfo/save")
public class StudentMyInfoSaveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public StudentMyInfoSaveServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		Member3 loginMember = (Member3)session.getAttribute("loginMember");
		if(loginMember != null) {
			//Member 객체 업데이트 
			Member3 m = new Member3();
			
			// 입력받은 정보들 중 null이 있을 수 있으니까, 모든 정보를 기본 정보로 설정
			m.setMemberNo(loginMember.getMemberNo());
			m.setMemberId(loginMember.getMemberId());
			m.setMemberName(loginMember.getMemberName());
			m.setEmail(loginMember.getEmail());
			m.setMemberType(loginMember.getMemberType());
			m.setEnrollDate(loginMember.getEnrollDate());
			m.setMemberPw(loginMember.getMemberPw());
			m.setPhone(loginMember.getPhone());
			m.setAddress(loginMember.getAddress());
			m.setSchoolNo(loginMember.getSchoolNo());
			
			// 수정된 정보만 업데이트
			String memberPw = request.getParameter("memberPw");
			if(memberPw != null && !memberPw.isEmpty()) {
				m.setMemberPw(memberPw);
				//password 암호화를 위한 설정
				request.setAttribute("encryptPassword", true);

			}
			String phone = request.getParameter("phone");
			if(phone != null && !phone.isEmpty()) {
				m.setPhone(phone);
			}
			
			String addressNo = request.getParameter("addressNo");
			String addressRoad = request.getParameter("addressRoad");
			String addressDetail = request.getParameter("addressDetail");
			if(addressNo != null && addressRoad != null && !addressNo.isEmpty() && !addressRoad.isEmpty()) {
                String address = addressNo+":"+addressRoad+":"+addressDetail;
                m.setAddress(address);
            }
	
			String schoolNo = request.getParameter("schoolNo");
			try {
				if(schoolNo != null && !schoolNo.trim().isEmpty()) {
	                int newSchoolNo = Integer.parseInt(schoolNo);
	                if(m.getSchool() != null) {
	                    if(m.getSchool().getSchoolNo() != newSchoolNo) {
	                        m.getSchool().setSchoolNo(newSchoolNo);
	                    }
	                } else {
	                    School12 school = new School12();
	                    school.setSchoolNo(newSchoolNo);
	                    m.setSchool(school);
	                    System.out.println("학교번호가져옴");
	                }
	            }
			} catch(Exception e) {
				System.out.println("학교 번호파싱 오류");
			}
			
			// 서비스 호출하여 DB 업데이트
			int result = new MemberService().updateMember(m);
			
			String msg, loc = "/";
			
			if(result > 0) {
				session.setAttribute("loginMember", m);
				msg = "회원 정보 수정에 성공하였습니다.";
				loc = "/member/student/myinfo";
			} else {
				msg = "회원 정보 수정에 실패하였습니다.";
				loc = "/member/student/myinfo";
			}
			request.setAttribute("msg", msg);
			request.setAttribute("loc", loc);
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
		}
	}
}
