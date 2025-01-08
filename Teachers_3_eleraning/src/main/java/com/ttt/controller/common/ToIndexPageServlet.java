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

@WebServlet(urlPatterns = {"","/home"}, name="indexPage")
public class ToIndexPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ToIndexPageServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 세션 체크 
        HttpSession session = request.getSession();
        
//        // (더미데이터) 세션에 로그인 정보가 없을 경우에만 테스트 데이터 생성
//        if(session.getAttribute("loginMember") == null) {
//            // 테스트용 회원 데이터 Map 생성 (SQL의 USERS, STUDENTS 테이블 구조 참고)
//            Map<String, Object> memberMap = new HashMap<>();
//            memberMap.put("memberNo", 1);
//            memberMap.put("memberId", "testuser");
//            memberMap.put("memberName", "테스트유저");
//            memberMap.put("email", "test@test.com");
//            memberMap.put("memberPhone", "010-1234-5678");
//            memberMap.put("memberType", 1); // 1: 학생
//            memberMap.put("enrollDate", new Date());
//            memberMap.put("memberAddress", "서울시 강남구");
//            memberMap.put("grade", 1); // 고1
//            memberMap.put("schoolNo", 1234);
//            
//            // 세션에 저장
//            session.setAttribute("loginMember", memberMap);
//        }
        
        System.out.println("현재 로그인 세션 정보 : "+session.getAttribute("loginMember"));

		// (더미데이터) 섹션1: 광고 슬라이드
		List<Map<String, String>> mainSlides = new ArrayList<>();

		// 첫 번째 슬라이드
		Map<String, String> slide1 = new HashMap<>();
		slide1.put("imageUrl", request.getContextPath() + "/resources/images/common/HoneyT_logo_horizontal.png");
		slide1.put("title", "2026 수능 대비 얼리버드 할인!");
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
		//System.out.println("메인 슬라이드 데이터 설정: " + mainSlides);
		
		
		
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
	    uploadCourse1.put("beginDate", "2024-03-15");
	    uploadCourse1.put("endDate", "2024-05-30");
	    teacherCourses.add(uploadCourse1);

	    request.setAttribute("studentCourses", studentCourses);
	    request.setAttribute("teacherCourses", teacherCourses);
	    
	    //System.out.println("학생 강좌 데이터 설정: " + studentCourses);
	    //System.out.println("교사 강좌 데이터 설정: " + teacherCourses);
	    
	    

	    // (더미데이터) 대표 강사진 생성
	    List<Map<String, Object>> mainTeachers = new ArrayList<>();
	    String[] subjects = {"국어", "수학", "영어", "과학", "사회", "국어", "수학", "영어"}; // 8명
	    
	    for(int i = 0; i < 8; i++) {
	        Map<String, Object> teacher = new HashMap<>();
	        teacher.put("memberNo", i + 1);
	        teacher.put("memberName", "강사" + (i + 1));
	        teacher.put("teacherSubject", subjects[i]);
	        teacher.put("teacherInfoTitle", "열정적인 " + subjects[i] + " 선생님");
	        teacher.put("imageUrl", request.getContextPath() + "/resources/images/common/HoneyT_logo_vertical.png");
	        mainTeachers.add(teacher);
	    }
	    
	    request.setAttribute("mainTeachers", mainTeachers);
	    //System.out.println("대표 강사진 데이터 설정: " + mainTeachers);
	    
	    
	    
	    
	    // (더미데이터) 인기 강좌 메인 화면에 출력할 데이터

	    // 코스 카테고리 정보
	    Map<Integer, String> courseCategoryInfo = new HashMap<>();
	    courseCategoryInfo.put(1, "진도 강좌");
	    courseCategoryInfo.put(2, "내신대비 강좌");
	    courseCategoryInfo.put(3, "모의고사 대비 강좌");
	    courseCategoryInfo.put(4, "수능대비 강좌");
	    
	    // 인기 강좌 더미데이터 생성
	    List<Map<String, Object>> popularCourses = new ArrayList<>();
		/* String[] subjects = {"국어", "수학", "영어", "과학", "사회"}; */
	    String[] teacherNames = {"김선생", "이선생", "박선생", "정선생", "최선생"};
	    
	    // 각 카테고리별로 5개씩 강좌 생성
	    for(int category = 1; category <= 4; category++) {
	        for(int i = 0; i < 5; i++) {
	            Map<String, Object> course = new HashMap<>();
	            int courseNo = (category - 1) * 5 + i + 1;
	            
	            course.put("courseNo", courseNo);
	            course.put("courseTitle", subjects[i] + " " + courseCategoryInfo.get(category));
	            course.put("courseCategoryNo", category);
	            course.put("grade", (i % 3) + 1); // 1,2,3 학년
	            course.put("coursePrice", 150000 + (i * 10000));
	            course.put("coursePriceSale", 10 + (i * 5)); // 10~30% 할인
	            course.put("totalLectures", 20 + (i * 2));
	            course.put("teacherName", teacherNames[i]);
	            course.put("courseDesc", subjects[i] + "의 기초부터 실전까지! " + courseCategoryInfo.get(category));
	            course.put("teacherInfo", teacherNames[i] + " 선생님과 함께하는 " + subjects[i] + " 마스터");
	            course.put("rating", 4.5 + (Math.random() * 0.5)); // 4.5~5.0 평점
	            course.put("studentCount", 100 + (int)(Math.random() * 900)); // 100~1000명
	            
	            popularCourses.add(course);
	        }
	    }
	    
	    request.setAttribute("courseCategoryInfo", courseCategoryInfo);
	    request.setAttribute("popularCourses", popularCourses);
	    
	    //System.out.println("인기 강좌 데이터 설정: " + popularCourses);
	    

        request.getRequestDispatcher("/index.jsp").forward(request, response);
	}

}
