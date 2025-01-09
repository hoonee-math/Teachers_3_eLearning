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
		
		HttpSession session = request.getSession(false);
		Member3 loginMember = (Member3)session.getAttribute("loginMember");
		if(loginMember != null) {
			String memberPw = request.getParameter("memberPw");
			String phone = request.getParameter("phone");
			
			String addressNo = request.getParameter("addressNo");
			String addressRoad = request.getParameter("addressRoad");
			String addressDetail = request.getParameter("addressDetail");
			
			String address = addressNo+":"+addressRoad+":"+addressDetail;
	
			String schoolNo = request.getParameter("schoolNo");
			System.out.println(schoolNo);
			
			//Member 객체 업데이트 
			Member3 m = new Member3();
			
			// 로그인된 회원의 기본 정보 설정
			m.setMemberNo(loginMember.getMemberNo());
			m.setMemberId(loginMember.getMemberId());
			m.setMemberName(loginMember.getMemberName());
			m.setEmail(loginMember.getEmail());
			m.setMemberType(loginMember.getMemberType());  // 중요! memberType 설정
			m.setEnrollDate(loginMember.getEnrollDate());
			
			// 입력받은 정보들 중 null이 있을 수 있으니까, 모든 정보를 기본 정보로 설정
			m.setMemberPw(loginMember.getMemberPw());
			m.setPhone(loginMember.getPhone());
			m.setAddress(loginMember.getAddress());
			m.setSchoolNo(loginMember.getSchoolNo());
			
			//업데이트 완료(1)또는 실패(0)을 받는 함수
			int updateCount = 0;
			
			//새로 들어온 정보와 세션 정보가 일치하지 않으면 새정보 저장
			if(!memberPw.equals(m.getMemberPw()) && memberPw != null ) {
				m.setMemberPw(memberPw);
			}
			if(!phone.equals(m.getPhone()) && phone != null) {
				m.setPhone(phone);
			}
			if(!address.equals(m.getAddress()) && address != null) {
				m.setAddress(address);
			}
			
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
			}catch(Exception e) {
				System.out.println("학교 번호파싱 오류");
			}
			
			String msg, loc = "/";
			
			updateCount = new MemberService().updateMember(m);
			if(updateCount > 0) {
//					MemberService service = new MemberService();
				session.setAttribute("loginMember", m);
				msg = "회원정보 수정이 성공적으로 수정되었습니다.";
				loc = "/";
			}else {
				msg = "변경된 내용이 없거나 저장에 실패하였습니다. 다시 시도해주세요.";
				loc = "/student/myinfo";
			}
			
			
			request.setAttribute("msg", msg);
			request.setAttribute("loc", loc);
			
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
			
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
