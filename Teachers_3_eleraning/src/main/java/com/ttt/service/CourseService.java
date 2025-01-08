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

			List<Course3> courses = dao.selectCoursesByTeacher(session, params);
			Map<String, Object> result = new HashMap<>();
			result.put("courses", courses);

			// 첫 번째 행에서 카운트 정보 추출 (조회 결과가 있는 경우)
			if (!courses.isEmpty()) {
				Course3 first = courses.get(0);
				result.put("totalCount", first.getTotalCount());
				result.put("preparingCount", first.getPreparingCount());
				result.put("inProgressCount", first.getInProgressCount());
				result.put("completedCount", first.getCompletedCount());
			} else {
				// 조회 결과가 없는 경우 모든 카운트를 0으로 설정
				result.put("totalCount", 0);
				result.put("preparingCount", 0);
				result.put("inProgressCount", 0);
				result.put("completedCount", 0);
			}

			return result;
		} finally {
			session.close();
		}
	}

	// 새 강좌 등록
	public int insertNewCourse(Course3 c) {
		SqlSession session = getSession();
		return dao.insertNewCourse(session, c);
	}

	// 회원의 강의 존재여부 확인 - 보류
	public boolean checkEnrollment(int memberNo, int courseNo) {
		SqlSession session = getSession();
		// int result = dao.checkEnrollment(session, memberNo);
		return false;
	}

}
