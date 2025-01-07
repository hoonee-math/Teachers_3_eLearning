package com.ttt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Course3;

public class CourseDao {
	public List<Course3> selectCourseBySubjectNo(SqlSession session, Map<String, Object> param) {
		return session.selectList("course.selectCourseBySubjectNo", param);
	}

}
