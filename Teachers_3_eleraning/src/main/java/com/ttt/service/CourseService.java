package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.CourseDao;
import com.ttt.dto.Course3;

public class CourseService {
	private CourseDao dao = new CourseDao();

	// 코스 번호로 해당 코스 전체 정보 조회
	public Course3 selectCourseByNo(int courseNo) {
		SqlSession session = getSession();
		session.close();
		return dao.selectCourseByNo(session, courseNo);
	}

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
			if (result >= 1) {
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

	// 교사의 강좌 목록 조회 (상태별 필터링 포함)
	public Map<String, Object> selectCoursesByTeacher(int memberNo, String status) {
		SqlSession session = getSession();
		try {
			Map<String, Object> params = new HashMap<>();
	        params.put("memberNo", memberNo);
	        params.put("status", status);
			
			Map<String, Object> result = new HashMap<>();
			// 강좌 목록 조회
			List<Course3> courseList = dao.selectCoursesByStatus(session, params);
			result.put("courses", courseList);

			// 상태별 카운트 조회
			Map<String, Object> countMap = dao.selectCourseStatusCount(session, memberNo);

			// 각 상태별 카운트를 result에 추가
			result.put("totalCount", countMap.get("TOTAL"));
			result.put("preparingCount", countMap.get("PREPARING"));
			result.put("inProgressCount", countMap.get("INPROGRESS"));
			result.put("completedCount", countMap.get("COMPLETED"));

			session.commit();
			return result;
		} catch (Exception e) {
			session.rollback();
			e.printStackTrace();
			throw e;
		} finally {
			session.close();
		}
	}

	// 새 강좌 등록
	public int insertNewCourse(Course3 c) {
		SqlSession session = getSession();
		int result = 0;
		try {
			result = dao.insertNewCourse(session, c);
			if (result >= 1) {
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

	// 회원의 강의 존재여부 확인 - 보류
	public boolean checkEnrollment(int memberNo, int courseNo) {
		SqlSession session = getSession();
		// int result = dao.checkEnrollment(session, memberNo);
		return false;
	}

	//카테고리 목록 조회
	public List<String> selectAllCategories() {
		SqlSession session = getSession();
	    return dao.selectAllCategories(session);
	}
}
