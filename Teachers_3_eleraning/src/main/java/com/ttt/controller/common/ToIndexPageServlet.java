package com.ttt.controller.common;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Course3;
import com.ttt.dto.CourseRegister3;
import com.ttt.dto.Member3;
import com.ttt.service.CourseRegisterService;
import com.ttt.service.CourseService;
import com.ttt.service.MemberService;

@WebServlet(urlPatterns = {"","/home"}, name="indexPage")
public class ToIndexPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ToIndexPageServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 세션 체크 
		HttpSession session = request.getSession();
        Member3 loginMember = (Member3)session.getAttribute("loginMember");
        
		// (더미데이터) 섹션1: 광고 슬라이드
		List<Map<String, String>> mainSlides = new ArrayList<>();

		// 첫 번째 슬라이드
		Map<String, String> slide1 = new HashMap<>();
		slide1.put("imageUrl", request.getContextPath() + "/resources/images/common/HoneyT_logo_horizontal.png");
		slide1.put("title", "2026 수능 대비 얼리버드 할인!");
		slide1.put("description", "5월까지 전 강좌 30% 할인된 가격으로 수강하세요.");
		slide1.put("link", request.getContextPath() + "/");
		mainSlides.add(slide1);
		
		// 두 번째 슬라이드
		Map<String, String> slide2 = new HashMap<>();
		slide2.put("imageUrl", request.getContextPath() + "/resources/images/common/HoneyT_logo_horizontal.png");
		slide2.put("title", "인기 강사 신규 강의 오픈!");
		slide2.put("description", "수학의 신! 김수학 선생님의 새로운 강의를 만나보세요.");
		slide2.put("link", request.getContextPath() + "/");
		mainSlides.add(slide2);

		// request에 데이터 저장
		request.setAttribute("mainSlides", mainSlides);

	    // (더미데이터) 학생용 수강중인 강좌
	    List<Map<String, Object>> studentCoursesDummy = new ArrayList<>();
        
		if(loginMember != null) {
			// 학생인 경우
			if(loginMember.getMemberType() == 1) {
				int memberNo=loginMember.getMemberNo();
				List<CourseRegister3> studentCourses =  new CourseRegisterService().selectIngCourse(memberNo);

	            // 수강 정보 로그 출력
	            if(studentCourses != null && !studentCourses.isEmpty()) {
	                for(CourseRegister3 course : studentCourses) {
	                }
	            } else {
	                System.out.println("수강 중인 강좌가 없거나 데이터를 가져오는데 실패했습니다.");
	            }
				request.setAttribute("studentCourses", studentCourses);
			}
			// 교사인 경우
			else if(loginMember.getMemberType() == 2) {
			}
		} else { // 로그인 세션 정보가 없을 경우 테스트용 더미 데이터를 넣는 로직.
		
		}
		
	    // (실제 데이터) 교사용 업로드 중인 강좌
		if(loginMember != null && loginMember.getMemberType() == 2) {
			// 학생인 경우
			int memberNo=loginMember.getMemberNo();
		    Map<String,Object> params = new HashMap();
		    params.put("status", "inProgress");
		    List<Course3> teacherCourses = new CourseService().selectCoursesByStatus(params,memberNo);
		    System.out.println(teacherCourses);
		    request.setAttribute("teacherCourses", teacherCourses);
		}

	    String[] subjects = {"국어", "수학", "영어", "과학", "사회", "국어", "수학", "영어"}; // 8명
	    
	    // (실제 데이터) 대표 강사진 생성
		List<Member3> mainTeachers = new MemberService().selectMainTeachers();
		request.setAttribute("mainTeachers", mainTeachers);
	    

		List<Course3> popularCourses = new CourseService().selectMainCourses();
		System.out.println("popular"+popularCourses);

		
		// (더미데이터) 인기 강좌 메인 화면에 출력할 데이터
	    // 코스 카테고리 정보
	    Map<Integer, String> courseCategoryInfo = new HashMap<>();
	    courseCategoryInfo.put(1, "진도 강좌");
	    courseCategoryInfo.put(2, "내신대비 강좌");
	    courseCategoryInfo.put(3, "모의고사 대비 강좌");
	    courseCategoryInfo.put(4, "수능대비 강좌");
	    
//	    // 인기 강좌 더미데이터 생성
//	    List<Map<String, Object>> popularCoursesDummy = new ArrayList<>();
//		/* String[] subjects = {"국어", "수학", "영어", "과학", "사회"}; */
//	    String[] teacherNames = {"김선생", "이선생", "박선생", "정선생", "최선생"};
//	    
//	    // 각 카테고리별로 5개씩 강좌 생성
//	    for(int category = 1; category <= 4; category++) {
//	        for(int i = 0; i < 5; i++) {
//	            Map<String, Object> course = new HashMap<>();
//	            int courseNo = (category - 1) * 5 + i + 1;
//	            
//	            course.put("courseNo", courseNo);
//	            course.put("courseTitle", subjects[i] + " " + courseCategoryInfo.get(category));
//	            course.put("courseCategoryNo", category);
//	            course.put("grade", (i % 3) + 1); // 1,2,3 학년
//	            course.put("coursePrice", 150000 + (i * 10000));
//	            course.put("coursePriceSale", 10 + (i * 5)); // 10~30% 할인
//	            course.put("totalLectures", 20 + (i * 2));
//	            course.put("teacherName", teacherNames[i]);
//	            course.put("courseDesc", subjects[i] + "의 기초부터 실전까지! " + courseCategoryInfo.get(category));
//	            course.put("teacherInfo", teacherNames[i] + " 선생님과 함께하는 " + subjects[i] + " 마스터");
//	            course.put("rating", 4.5 + (Math.random() * 0.5)); // 4.5~5.0 평점
//	            course.put("studentCount", 100 + (int)(Math.random() * 900)); // 100~1000명
//	            
//	            popularCoursesDummy.add(course);
//	        }
//	    }
	    
	    request.setAttribute("courseCategoryInfo", courseCategoryInfo);
	    request.setAttribute("popularCourses", popularCourses);
	    
	    //System.out.println("인기 강좌 데이터 설정: " + popularCourses);
	    

        request.getRequestDispatcher("/index.jsp").forward(request, response);
	}

}
