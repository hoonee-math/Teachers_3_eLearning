package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.CourseDao;
import com.ttt.dto.Course3;

public class CourseService {
	private CourseDao dao = new CourseDao();
	
	public List<Course3> selectCourseBySubjectNo(Map<String, Object> param) {
		SqlSession session = getSession();
		List<Course3> courses = dao.selectCourseBySubjectNo(session, param);
		session.close();
		
		return courses;
	}
	
	// 트랜잭션을 통한 강좌 상태 업데이트
	public int updateCourseStatus(int courseNo) {
		SqlSession session = getSession();
		int result = 0;
		try {
			result = dao.updateCourseStatus(session, courseNo);
			if (result>=1) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			session.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return result;
	}

	// 상태별 강좌 목록 조회
	public List<Course3> selectCoursesByStatus(Map<String, Object> params, int memberNo) {
		SqlSession session = getSession();
		List<Course3> courses = null;
		try {
			// 모든 강좌의 상태를 먼저 업데이트
			dao.updateAllCoursesStatus(session, memberNo);

			courses = dao.selectCoursesByStatus(session, params);
			session.commit();
		} catch (Exception e) {
			session.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return courses;
	}

	// 상태별 강좌 수 조회
	public Map<String, Integer> selectCourseStatusCount(int memberNo) {
		SqlSession session = getSession();
		Map<String, Integer> counts = null;
		try {
			// 모든 강좌의 상태를 먼저 업데이트
			dao.updateAllCoursesStatus(session, memberNo);

			// 상태별 카운트 조회
			counts = dao.selectCourseStatusCount(session, memberNo);
			session.commit();
		} catch (Exception e) {
			session.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return counts;
	}
}
