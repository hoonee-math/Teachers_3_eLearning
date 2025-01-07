package com.ttt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Course3;

public class CourseDao {
	public List<Course3> selectCourseBySubjectNo(SqlSession session, Map<String, Object> param) {
		return session.selectList("course.selectCourseBySubjectNo", param);
	}

	public int updateAllCoursesStatus(SqlSession session, int memberNo) {
		return session.update("course.updateAllCoursesStatus", memberNo);
	}
	
	public int updateCourseStatus(SqlSession session, int courseNo) {
		
	}
}
