package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.LectureDao;
import com.ttt.dto.Lecture3;
import com.ttt.dto.ScheduleEvent3;

public class LectureService {

	private LectureDao dao = new LectureDao();
	
	// 강의와 일정 일괄 리스트로 받아와서 일괄 등록하도록 설정
	public int insertLecturesWithSchedules(List<Lecture3> lectures, List<ScheduleEvent3> events) {
		SqlSession session = getSession();
		try {
			// 1. 강의 일괄 등록
			int result = dao.insertLecturesBatch(session, lectures);
			if (result != lectures.size()) {
				throw new RuntimeException("강의 등록 중 오류 발생");
			}

			// 2. 일정 일괄 등록
			result = dao.insertScheduleEventsBatch(session, events);
			if (result != events.size()) {
				throw new RuntimeException("일정 등록 중 오류 발생");
			}

			session.commit();
			return result;
		} catch (Exception e) {
			session.rollback();
			throw e;
		} finally {
			session.close();
		}
	}
	
	// 강좌별 강의 목록 조회
	public List<Lecture3> selectLecturesByCourseNo(int courseNo) {
		SqlSession session = getSession();
		List<Lecture3> lectures = dao.selectLecturesByCourseNo(session, courseNo);
		session.close();
		return lectures;
	}
	
	// 강의 등록 (일정 포함)
	public int insertLectureWithSchedule(Lecture3 lecture, ScheduleEvent3 event) {
		SqlSession session = getSession();
		int result = 0;
		try {
			result = dao.insertLecture(session, lecture);
			if(result > 0 && event != null) {
				event.setLectureNo(lecture.getLectureNo()); // 생성된 lectureNo 설정
				result = dao.insertScheduleEvent(session, event);
				if(result > 0) {
					session.commit();
				} else {
					session.rollback();
				}
			}
		} catch(Exception e) {
			session.rollback();
			throw e;
		} finally {
			session.close();
		}
		return result;
	}
	
	// 강의 수정 (일정 포함)
	public int updateLectureWithSchedule(Lecture3 lecture, ScheduleEvent3 event) {
		SqlSession session = getSession();
		int result = 0;
		try {
			result = dao.updateLecture(session, lecture);
			if(result > 0 && event != null) {
				result = dao.updateScheduleEvent(session, event);
				if(result > 0) {
					session.commit();
				} else {
					session.rollback();
				}
			}
		} catch(Exception e) {
			session.rollback();
			throw e;
		} finally {
			session.close();
		}
		return result;
	}
	
	// 강의 삭제 (lecture_status 를 이용 1공개, 2삭제, 0비공개)
	public int updateDeleteLecture(int lectureNo) {
		SqlSession session = getSession();
		int result = dao.updateDeleteLecture(session, lectureNo);
		if(result > 0) {
			session.commit();
		} else {
			session.rollback();
		}
		session.close();
		return result;
	}
	
	// 학생의 수강 강좌 일정 조회 (학년 필터 포함)
	public List<Map<String, Object>> selectEventsByStudentNo(Map<String, Object> params) {
		SqlSession session = getSession();
		try {
			return dao.selectEventsByStudentNo(session, params);
		} finally {
			session.close();
		}
	}
	
	// 교사의 강좌 일정 조회 (학년 필터 포함)
	public List<Map<String, Object>> selectEventsByTeacherNo(Map<String, Object> params) {
		SqlSession session = getSession();
		try {
			return dao.selectEventsByTeacherNo(session, params);
		} finally {
			session.close();
		}
	}
	
	// 학년별 강의 일정 조회
	public List<Map<String, Object>> selectEventsByGrade(Map<String, Object> params) {
		SqlSession session = getSession();
		try {
			return dao.selectEventsByGrade(session, params);
		} finally {
			session.close();
		}
	}

}
