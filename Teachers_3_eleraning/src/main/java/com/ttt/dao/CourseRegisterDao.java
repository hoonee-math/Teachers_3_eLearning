package com.ttt.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.CourseRegister3;

public class CourseRegisterDao {
	
	public List<CourseRegister3> selectIngCourse(SqlSession session, int memberNo) {
		return session.selectList("courseRegister.selectIngCourse",memberNo);
	}

}
