package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.CourseRegisterDao;
import com.ttt.dto.CourseRegister3;

public class CourseRegisterService {
	private CourseRegisterDao dao = new CourseRegisterDao();
	
	public List<CourseRegister3> selectIngCourse(int memberNo) {
		SqlSession session = getSession();
		return dao.selectIngCourse(session,memberNo);
	}
}
