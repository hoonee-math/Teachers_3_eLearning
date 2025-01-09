package com.ttt.controller.member.teacher;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.ttt.common.TextNormalizer;
import com.ttt.dto.Image3;
import com.ttt.dto.Member3;
import com.ttt.service.MemberService;

@WebServlet(name="teacherInfoUpdate", urlPatterns="/member/teacher/profile/save")
public class TeacherMyInfoSaveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    // TextNormalizer 인스턴스 생성
    private final TextNormalizer textNormalizer = new TextNormalizer();
       
    public TeacherMyInfoSaveServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 파일 업로드 설정
		String path = getServletContext().getRealPath("/resources/images/profile/");
		int maxSize = 1024*1024*10;
		String encoding = "UTF-8";
		
		// 파일 저장 디렉토리 생성
		File dir = new File(path);
		if(!dir.exists()) dir.mkdirs();
		
		try {
			MultipartRequest mr = new MultipartRequest(
					request, path, maxSize, encoding, new DefaultFileRenamePolicy()
			);
			
			// 세션에서 로그인 정보 가져오기
			HttpSession session = request.getSession();
			Member3 loginMember = (Member3)session.getAttribute("loginMember");
			
			if(loginMember != null) {
				// Member 객체 업데이트
				Member3 m = new Member3();
				
				// 입력받은 정보들 중 null이 있을 수 있으니까, 모든 정보를 기본 정보로 설정
				m.setMemberNo(loginMember.getMemberNo());
				m.setMemberId(loginMember.getMemberId());
				m.setMemberName(loginMember.getMemberName());
				m.setEmail(loginMember.getEmail());
				m.setMemberType(loginMember.getMemberType());
				m.setEnrollDate(loginMember.getEnrollDate());
				m.setTeacherSubject(loginMember.getTeacherSubject());
				m.setMemberPw(loginMember.getMemberPw());
				m.setPhone(loginMember.getPhone());
				m.setAddress(loginMember.getAddress());
				m.setTeacherInfoTitle(loginMember.getTeacherInfoTitle());
				m.setTeacherInfoContent(loginMember.getTeacherInfoContent());
				m.setImage(loginMember.getImage());
				
				// 수정된 정보만 업데이트
				String memberName = mr.getParameter("memberName");
				if(memberName != null && !memberName.isEmpty()) {
					m.setMemberName(memberName);
				}
				
				String memberPw = mr.getParameter("memberPw");
				if(memberPw != null && !memberPw.isEmpty()) {
					m.setMemberPw(memberPw);
					//password 암호화를 위한 설정
					request.setAttribute("encryptPassword", true);
				}
				
				String phone = mr.getParameter("phone");
				if(phone != null && !phone.isEmpty()) {
					m.setPhone(phone);
				}
				
				String addressNo = mr.getParameter("addressNo");
				String addressRoad = mr.getParameter("addressRoad");
				String addressDetail = mr.getParameter("addressDetail");
	            if(addressNo != null && addressRoad != null && !addressNo.isEmpty() && !addressRoad.isEmpty()) {
	                String address = addressNo+":"+addressRoad+":"+addressDetail;
	                m.setAddress(address);
	            }
				
				String teacherInfoTitle = mr.getParameter("teacherInfoTitle");
				if(teacherInfoTitle != null && !teacherInfoTitle.isEmpty()) {
					m.setTeacherInfoTitle(teacherInfoTitle);
				}
				
				String teacherInfoContent = mr.getParameter("teacherInfoContent");
				if(teacherInfoContent != null && !teacherInfoContent.isEmpty()) {
					m.setTeacherInfoContent(teacherInfoContent);
				}
				
				
				
				// 이미지 정보 설정
				String originalFileName = mr.getOriginalFileName("profileImageInput");
				if(originalFileName != null) {
	                // 파일명도 정규화 처리
	                String normalizedOriginalFileName = textNormalizer.normalizeText(originalFileName);
	                String renamedFileName = mr.getFilesystemName("profileImageInput");
	                String normalizedRenamedFileName = textNormalizer.normalizeText(renamedFileName);
	                
	                Image3 image = new Image3();
	                image.setOriname(normalizedOriginalFileName);
	                image.setRenamed(normalizedRenamedFileName);
					m.setImage(image);
				} 
				
				// 서비스 호출하여 DB 업데이트
				int result = new MemberService().updateMember(m);

				if(result > 0) {
					session.setAttribute("loginMember", m);
					request.setAttribute("msg", "회원 정보 수정에 성공하였습니다.");
				} else {
					request.setAttribute("msg", "회원 정보 수정에 실패하였습니다.");
				}
				
				request.setAttribute("loc", "/member/teacher/profile");
				request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("msg", "회원 정보 수정 중 오류가 발생하였습니다.");
			request.setAttribute("loc", "/member/teacher/profile");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
		}
	}

}
