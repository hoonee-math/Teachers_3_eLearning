package com.ttt.controller.member.teacher;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.ttt.dto.Course3;
import com.ttt.dto.Member3;
import com.ttt.service.CourseService;

@WebServlet("/member/teacher/course/register")
public class TeacherManageCourseRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public TeacherManageCourseRegisterServlet() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 인코딩 설정
	    request.setCharacterEncoding("UTF-8");
	    response.setContentType("application/json;charset=UTF-8");
	    Map<String, Object> responseData = new HashMap<>();
	    
	    try {
	        // 파라미터 로깅
	        System.out.println("Received parameters:");
	        request.getParameterMap().forEach((key, value) -> {
//	            System.out.println(key + ": " + Arrays.toString(value));
	        });

	        // 1. 필수값 검증
	        String courseTitle = request.getParameter("courseTitle");
	        String courseDesc = request.getParameter("courseDesc");
	        String categoryNoStr = request.getParameter("courseCategoryNo");
	        String gradeStr = request.getParameter("grade");
	        String priceStr = request.getParameter("coursePrice");
	        String beginDateStr = request.getParameter("beginDate");
	        
	        if (courseTitle == null || courseDesc == null || categoryNoStr == null || 
	            gradeStr == null || priceStr == null || beginDateStr == null) {
	            throw new IllegalArgumentException("필수 입력값이 누락되었습니다.");
	        }

	        // 2. 숫자 변환 (할인율은 선택값)
	        int courseCategoryNo = Integer.parseInt(categoryNoStr);
	        int grade = Integer.parseInt(gradeStr);
	        int coursePrice = Integer.parseInt(priceStr);
	        int coursePriceSale = 0;
	        
	        String salePriceStr = request.getParameter("coursePriceSale");
	        if (salePriceStr != null && !salePriceStr.trim().isEmpty()) {
	            coursePriceSale = Integer.parseInt(salePriceStr);
	        }

	        // 3. 날짜 처리
	        LocalDate beginDate = LocalDate.parse(beginDateStr);
	        Date sqlDate = Date.valueOf(beginDate);
	        
	        // 4. 세션에서 교사 정보 가져오기
	        HttpSession session = request.getSession();
	        Member3 loginMember = (Member3)session.getAttribute("loginMember");
	        
	        if (loginMember == null) {
	            throw new IllegalStateException("로그인이 필요합니다.");
	        }

	        // 5. Course3 객체 생성
	        Course3 course = Course3.builder()
	                .courseTitle(courseTitle)
	                .courseDesc(courseDesc)
	                .courseCategoryNo(courseCategoryNo)
	                .grade(grade)
	                .coursePrice(coursePrice)
	                .coursePriceSale(coursePriceSale)
	                .beginDate(sqlDate)
	                .courseStatus(0)
	                .memberNo(loginMember.getMemberNo())
	                .build();

	        // 디버깅 로그
//	        System.out.println("Creating course: " + course);

	        // 6. 서비스 호출
	        int result = new CourseService().insertNewCourse(course);
	        
	        // 7. 응답 데이터 설정
	        responseData.put("success", result > 0);
	        responseData.put("message", result > 0 ? "강좌가 성공적으로 등록되었습니다." : "강좌 등록에 실패했습니다.");
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        responseData.put("success", false);
	        responseData.put("message", e.getMessage());
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	    }
	    
	    // JSON 응답 전송
	    response.getWriter().write(new Gson().toJson(responseData));
	}
}
