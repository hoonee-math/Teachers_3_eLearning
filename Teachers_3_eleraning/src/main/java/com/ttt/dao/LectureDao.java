package com.ttt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Lecture3;
import com.ttt.dto.ScheduleEvent3;

public class LectureDao {
    
    // 강좌별 강의 목록 조회
    public List<Lecture3> selectLecturesByCourseNo(SqlSession session, int courseNo) {
        return session.selectList("lecture.selectLecturesByCourseNo", courseNo);
    }
    
    // 강의 등록 (트랜잭션 처리를 위해 반환값 int)
    public int insertLecture(SqlSession session, Lecture3 lecture) {
        return session.insert("lecture.insertLecture", lecture);
    }
    
    // 강의 일정 등록 (일정 포함)
    public int insertScheduleEvent(SqlSession session, ScheduleEvent3 event) {
        return session.insert("lecture.insertScheduleEvent", event);
    }
    
    // 강의 수정 (일정 포함)
    public int updateLecture(SqlSession session, Lecture3 lecture) {
        return session.update("lecture.updateLecture", lecture);
    }
    
    // 강의 일정 수정
    public int updateScheduleEvent(SqlSession session, ScheduleEvent3 event) {
        return session.update("lecture.updateScheduleEvent", event);
    }
    
    // 강의 삭제 (lecture_status 를 이용 1공개, 2삭제, 0비공개)
    public int updateDeleteLecture(SqlSession session, int lectureNo) {
        return session.delete("lecture.deleteLecture", lectureNo);
    }
    
    // 강의와 연결된 일정 조회
    public ScheduleEvent3 selectScheduleEventByLectureNo(SqlSession session, int lectureNo) {
        return session.selectOne("lecture.selectScheduleEventByLectureNo", lectureNo);
    }
    
	// 학생의 수강 강좌 일정 조회 (학년 필터 포함)
	public List<Map<String, Object>> selectEventsByStudentNo(SqlSession session, Map<String, Object> params) {
		return session.selectList("lecture.selectEventsByStudentNo");
	}
	// 교사의 강좌 일정 조회 (학년 필터 포함)
	public List<Map<String, Object>> selectEventsByTeacherNo(SqlSession session, Map<String, Object> params) {
		return session.selectList("lecture.selectEventsByTeacherNo");
	}
	// 학년별 강의 일정 조회
	public List<Map<String, Object>> selectEventsByGrade(SqlSession session, Map<String, Object> params) {
		return session.selectList("lecture.selectEventsByGrade"); 
	}
}
