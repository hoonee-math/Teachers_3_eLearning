package com.ttt.controller.enroll;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Member3;
import com.ttt.dto.School12;
import com.ttt.service.MemberService;

@WebServlet(name="memberEnroll", urlPatterns="/enroll/form/submit")
public class EnrollFormSubmitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public EnrollFormSubmitServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String memberId = request.getParameter("memberId");
		String memberPw = request.getParameter("memberPw");
		String memberName = request.getParameter("memberName");
		
		String emailId = request.getParameter("emailId");
		String emailDomain = request.getParameter("emailDomain");
		String email = emailId + "@" + emailDomain;
		
		String phone = request.getParameter("phone");
		
		String addressNo = request.getParameter("addressNo");
		String addressRoad = request.getParameter("addressRoad");
		String addressDetail = request.getParameter("addressDetail");
		String address = addressNo+":"+addressRoad+":"+addressDetail; // 나중에 주소값을 split 해서 처리하기 위한 주소값 처리
		
		int memberType=0;
		int schoolNo=0;
		int grade=0;
		School12 school=new School12();
		
		// 값을 각각 받아오도록 각각 예외처리
		try {memberType=Integer.parseInt(request.getParameter("memberType"));} 
			catch(Exception e) {System.out.println("파싱오류");}
		if(memberType==1) {
			try {schoolNo=Integer.parseInt(request.getParameter("schoolNo"));}
				catch(Exception e) {System.out.println("파싱오류1");}
			try {grade=Integer.parseInt(request.getParameter("grade"));}
				catch(Exception e) {System.out.println("파싱오류2");}
			school.setSchoolNo(schoolNo);
		}
		
		// 교사인 경우 
		String teacherSubject = request.getParameter("teacherSubject");
		
		Member3 m = Member3.builder()
				.memberId(memberId)
				.memberPw(memberPw)
				.memberName(memberName)
				.email(email)
				.phone(phone)
				.address(address)
				.memberType(memberType)
				.school(school)
				.grade(grade)
				.teacherSubject(teacherSubject)
				.build();
		
		//db에 저장하기!
		String msg, loc="/";
		
		try {
			System.out.println("디비저장시작");
			int result = new MemberService().insertMember(m);
			msg="회원가입에 성공했습니다!";
		}catch(Exception e) {
			e.printStackTrace();
			msg="회원가입에 실패하셨습니다. 다시 시도해주세요.";
			loc="/enroll/termsofservice";
		}
		
		request.setAttribute("msg",msg);
		request.setAttribute("loc",loc);
		
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);

	}
}
