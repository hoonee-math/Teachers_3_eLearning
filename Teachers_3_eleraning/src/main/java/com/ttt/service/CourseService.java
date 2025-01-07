package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.CourseDao;
import com.ttt.dto.Course3;

public class CourseService {
	private CourseDao dao = new CourseDao();
	
	public List<Course3> selectCourseBySubjectNo(Map<String, Integer> param) {
		SqlSession session = getSession();
		List<Course3> courses = dao.selectCourseBySubjectNo(session, param);
		session.close();
		
		return courses;
	}
}
