package com.ttt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Course3;

public class CourseDao {
	
	// 코스 번호로 해당 코스 전체 정보 조회
	public Course3 selectCourseByNo(SqlSession session, int courseNo) {
		return session.selectOne("course.selectCourseByNo",courseNo);
	}
	
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
	public Map<String,Object> selectCourseStatusCount(SqlSession session, int memberNo){
		return session.selectOne("course.selectCourseStatusCount",memberNo);
	}

    // 교사의 강좌 목록 조회 (상태별 필터링 포함)
    public List<Course3> selectCoursesByTeacher(SqlSession session, Map<String, Object> params) {
        return session.selectList("course.selectCoursesByTeacher", params);
    }
	
	// 새 강좌 등록
	public int insertNewCourse(SqlSession session, Course3 c) {
		return session.insert("course.insertNewCourse",c);
	}
	
	//카테고리 목록 조회
	public List<String> selectAllCategories(SqlSession session) {
		return session.selectList("course.selectAllCategories");
	}
	
	// 학생이 수강 중인 강좌 번호 목록 조회
	public List<Integer> selectEnrolledCourseNos(SqlSession session, int memberNo) {
		return session.selectList("course.selectEnrolledCourseNos", memberNo);
	}
	
	// 교사가 가르치는 강좌 번호 목록 조회
	public List<Integer> selectTeachingCourseNos(SqlSession session, int memberNo) {
		return session.selectList("course.selectTeachingCourseNos", memberNo);
	}
	
	public List<Course3> selectMainCourses(SqlSession session){
		return session.selectList("course.selectMainCourses");
	}
}
