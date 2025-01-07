package com.ttt.controller.member.teacher;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Course3;

@WebServlet("/member/teacher/course/register")
public class TeacherManageCourseRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public TeacherManageCourseRegisterServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String courseTitle = request.getParameter("courseTitle");
		String courseDesc = request.getParameter("courseDesc");
		
		int courseCategoryNo=0, grade=0, coursePrice=0, coursePriceSale=0;
		try {courseCategoryNo = Integer.parseInt(request.getParameter("courseCategoryNo"));
		}catch(Exception e) {}
		try {grade = Integer.parseInt(request.getParameter("grade"));
		}catch(Exception e) {}
		try {coursePrice = Integer.parseInt(request.getParameter("coursePrice"));
		}catch(Exception e) {}
		try {coursePriceSale = Integer.parseInt(request.getParameter("coursePriceSale"));
		}catch(Exception e) {}
		
		String beginCourse = request.getParameter("beginDate");  // "2025-01-08" 형식
		LocalDate localDate = LocalDate.parse(beginCourse);  
		Date sqlDate = Date.valueOf(localDate);
		System.out.println("날짜 변환 LocaDate 이용 "+beginCourse+", "+sqlDate);
		
		Course3 course = Course3.builder()
				.courseTitle(courseTitle)
				.courseDesc(courseDesc)
				.courseCategoryNo(courseCategoryNo)
				.grade(grade)
				.coursePrice(coursePriceSale)
				.coursePriceSale(coursePriceSale)
				.beginDate(sqlDate)
				.build();
		
		System.out.println("강좌 추가 로직 start, course : "+course);
		
		
	}

}
