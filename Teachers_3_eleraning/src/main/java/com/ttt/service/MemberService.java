package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.MemberDao;
import com.ttt.dto.Member3;

/* Connection 과 MemberDao 객체를 만들어서 서버와 db 서버가 서로 통신할 수 있게 서비스를 제공하는 클래스 */
public class MemberService {
	
	private MemberDao dao=new MemberDao();
	
	/* 회원가입 서비스 */
	public int insertMember(Member3 m) {
		SqlSession session=getSession();
	    int result = dao.insertMember(session, m);
	    try {
	        System.out.println("db에 기본값 저장 후 객체 정보 m : "+m.toString());
	        if(result > 0) {
	        	if(m.getMemberType() == 1) {  // 학생
	                result = dao.insertStudent(session, m);
	                
	            } else if(m.getMemberType() == 2) {  // 교사
	                result = dao.insertTeacher(session, m);
	            }
	            session.commit();
	        } else {
	            session.rollback();
	        }
	    } catch(Exception e) {
	        e.printStackTrace();
	        session.rollback();
	        throw e;
	    } finally {
	        session.close();
	    }
		return result;
	}
	
	/* Id 값으로 회원 정보 조회 서비스 */
	public Member3 selectMemberById(String memberId) {
		SqlSession session=getSession();
		return dao.selectMemberById(session, memberId);
	}
	
	/* teacherListAndDetail 페이지의 리스트에 교사 출력용 */
	public List<Member3> selectAllTeachers(){
		SqlSession session=getSession();
		return dao.selectAllTeachers(session);
	}
	public List<Member3> selectTeachersBySubject(Map<String, Object> param){
		SqlSession session=getSession();
		return dao.selectTeachersBySubject(session, param);
	}
	public int selectTeachersCount(Map<String, Object> param){
		SqlSession session=getSession();
		return dao.selectTeachersCount(session, param);
	}
	
	/* 학생의 회원 정보 수정 서비스*/
	public int updateMember(Member3 m) {
		SqlSession session=getSession();
	    int result = 0;
	    try {
	    	result = dao.updateMember(session, m);
	        System.out.println("db에 기본값 저장 후 객체 정보 m : "+m.toString());
	        if(result > 0) {
	        	if(m.getMemberType() == 1) {  // 학생
	                result = dao.updateStudent(session, m);
	                
	            } else if(m.getMemberType() == 2) {  // 교사
	                result = dao.updateTeacher(session, m);
	            }
	            session.commit();
	        } else {
	            session.rollback();
	        }
	    } catch(Exception e) {
	        e.printStackTrace();
	        session.rollback();
	        throw e;
	    } finally {
	        session.close();
	    }
		return result;
	}
	// 과목을 distinct 로 리스트 출력
	public List<String> selectSubjects(){
		SqlSession session=getSession();
		return dao.selectSubjects(session);
	}
	
}
	
