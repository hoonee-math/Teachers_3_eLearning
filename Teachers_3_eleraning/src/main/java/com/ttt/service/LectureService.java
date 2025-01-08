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
	
	// 학생의 수강 강좌 일정 조회
	public List<Map<String, Object>> selectEventsByStudentNo(int memberNo) {
		SqlSession session = getSession();
		try {
			return dao.selectEventsByStudentNo(session, memberNo);
		} finally {
			session.close();
		}
	}

	// 교사의 강좌 일정 조회
	public List<Map<String, Object>> selectEventsByTeacherNo(int memberNo) {
		SqlSession session = getSession();
		try {
			return dao.selectEventsByTeacherNo(session, memberNo);
		} finally {
			session.close();
		}
	}
}
