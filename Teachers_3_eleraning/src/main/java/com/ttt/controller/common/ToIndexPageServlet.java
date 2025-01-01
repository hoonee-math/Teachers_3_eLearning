package com.ttt.controller.common;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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

		// (더미데이터) 섹션1: 광고 슬라이드
		List<Map<String, String>> mainSlides = new ArrayList<>();

		// 첫 번째 슬라이드
		Map<String, String> slide1 = new HashMap<>();
		slide1.put("imageUrl", request.getContextPath() + "/resources/images/common/HoneyT_logo_horizontal.png");
		slide1.put("title", "2024 수능 대비 얼리버드 할인!");
		slide1.put("description", "5월까지 전 강좌 30% 할인된 가격으로 수강하세요.");
		slide1.put("link", request.getContextPath() + "/event/early-bird");
		mainSlides.add(slide1);

		// 두 번째 슬라이드
		Map<String, String> slide2 = new HashMap<>();
		slide2.put("imageUrl", request.getContextPath() + "/resources/images/common/HoneyT_logo_horizontal.png");
		slide2.put("title", "인기 강사 신규 강의 오픈!");
		slide2.put("description", "수학의 신! 김수학 선생님의 새로운 강의를 만나보세요.");
		slide2.put("link", request.getContextPath() + "/course/new-math");
		mainSlides.add(slide2);

		// request에 데이터 저장
		request.setAttribute("mainSlides", mainSlides);

		// 콘솔에 전달된 데이터 확인
		System.out.println("메인 슬라이드 데이터 설정: " + mainSlides);
		
		
		
	    // (더미데이터) 학생용 수강중인 강좌
	    List<Map<String, Object>> studentCourses = new ArrayList<>();
	    
	    Map<String, Object> course1 = new HashMap<>();
	    course1.put("courseRegisterNo", 1);                 // 변경: enrollmentNo → courseRegisterNo
	    course1.put("courseTitle", "수학의 정석: 미적분 마스터");
	    course1.put("teacherName", "김수학");
	    course1.put("progressRate", 45);
	    course1.put("nextLectureNo", 8);
	    course1.put("nextLectureTitle", "미분 계수의 활용");
	    course1.put("totalLectures", 20);
	    course1.put("lastViewTime", new Date()); 			// 추가: 마지막 수강 시간
	    course1.put("stopAt", 720);                         // 추가: 마지막 재생 위치(초)
	    studentCourses.add(course1);

	    Map<String, Object> course2 = new HashMap<>();
	    course1.put("courseRegisterNo", 2);                 // 변경: enrollmentNo → courseRegisterNo
	    course2.put("courseTitle", "국어 독해의 비밀");
	    course2.put("teacherName", "박국어");
	    course2.put("progressRate", 75);
	    course2.put("nextLectureNo", 15);
	    course2.put("nextLectureTitle", "비문학 독해 전략");
	    course2.put("totalLectures", 20);
	    course1.put("lastViewTime", new Date()); // 추가: 마지막 수강 시간
	    course1.put("stopAt", 720);                         // 추가: 마지막 재생 위치(초)
	    studentCourses.add(course2);

	    // (더미데이터) 교사용 업로드 중인 강좌
	    List<Map<String, Object>> teacherCourses = new ArrayList<>();
	    
	    Map<String, Object> uploadCourse1 = new HashMap<>();
	    uploadCourse1.put("courseNo", 3);
	    uploadCourse1.put("courseTitle", "2025 수능 대비 화학I");
	    uploadCourse1.put("uploadedLectures", 5);
	    uploadCourse1.put("totalLectures", 30);
	    uploadCourse1.put("uploadProgress", 16);
	    uploadCourse1.put("startDate", "2024-03-15");
	    uploadCourse1.put("endDate", "2024-05-30");
	    teacherCourses.add(uploadCourse1);

	    request.setAttribute("studentCourses", studentCourses);
	    request.setAttribute("teacherCourses", teacherCourses);
	    
	    System.out.println("학생 강좌 데이터 설정: " + studentCourses);
	    System.out.println("교사 강좌 데이터 설정: " + teacherCourses);
	    
	    

        request.getRequestDispatcher("/index.jsp").forward(request, response);
	}

}
