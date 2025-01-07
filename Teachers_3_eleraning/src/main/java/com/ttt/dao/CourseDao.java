package com.ttt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Course3;

public class CourseDao {
	public List<Course3> selectCourseBySubjectNo(SqlSession session, Map<String, Object> param) {
		return session.selectList("course.selectCourseBySubjectNo", param);
	}

	/* 강좌 필수 로직 다음을 항상 포함시켜서 트랜잭션 처리 하시오 */
	// 전체 상태 업데이트
	public int updateAllCoursesStatus(SqlSession session, int memberNo) {
		return session.update("course.updateAllCoursesStatus", memberNo);
	}
	// 개별 상태 업데이트
	public int updateCourseStatus(SqlSession session, int courseNo) {
		return session.update("cousre.updateCourseStatus",courseNo);
	}
	
	// 상태별 강좌 목록 조회
	public List<Course3> selectCoursesByStatus(SqlSession session, Map<String, Object> params){
		return session.selectList("course.selectCoursesByStatus",params);
	}
	// 상태별 강좌 수 조회
	public Map<String,Integer> selectCourseStatusCount(SqlSession session, int memberNo){
		return session.selectOne("course.selectCourseStatusCount",memberNo);
	}
	public int selectCoursesByStatusTotal(SqlSession session, int memberNo) {
		return session.selectOne("course.selectCoursesByStatusTotal",memberNo);
	}
	public int selectCoursesByStatusPreparing(SqlSession session, int memberNo) {
		return session.selectOne("course.selectCoursesByStatusPreparing",memberNo);
	}
	public int selectCoursesByStatusInProgress(SqlSession session, int memberNo) {
		return session.selectOne("course.selectCoursesByStatusInProgress",memberNo);
	}
	public int selectCoursesByStatusCompleted(SqlSession session, int memberNo) {
		return session.selectOne("course.selectCoursesByStatusCompleted",memberNo);
	}
	
}
