package com.ttt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Member3;

public class MemberDao {
	
	/* 회원 등록 */
	public int insertMember(SqlSession session, Member3 m) {
		return session.insert("member.insertMember",m);
	}
	public int insertStudent(SqlSession session, Member3 m) {
		return session.insert("member.insertStudent",m);
	}
	public int insertTeacher(SqlSession session, Member3 m) {
		return session.insert("member.insertTeacher",m);
	}
	
	/* 회원정보 조회-업데이트 관련 */
	public Member3 selectMemberById(SqlSession session, String memberId) {
		return session.selectOne("member.selectMemberById",memberId);
	}
	public int updatePassword(SqlSession session, Member3 m) {
		return session.update("member.updatePassword", m);
	}
	public int updateMember(SqlSession session, Member3 m) {
		return session.update("member.updateMember", m);
	}
	/* teacherListAndDetail 페이지의 리스트에 교사 출력용 */
	public List<Member3> selectTeachersBySubject(SqlSession session, Map<String, Object> param){
		return session.selectList("member.selectTeachersBySubject", param);
	}
	public int selectTeachersCount(SqlSession session, Map<String, Object> param){
		return session.selectOne("member.selectTeachersCount", param);
	}
	public List<String> selectSubjects(SqlSession session){
		return session.selectList("member.selectSubjects");
	}
	public List<Member3> selectAllTeachers(SqlSession session){
		return session.selectList("member.selectAllTeachers");
	}
	
	
	/* 이메일 인증 관련 */
	public Member3 checkEmailDuplicateByEmail(SqlSession session, Member3 m) {
		return session.selectOne("member.checkEmailDuplicateByEmail",m);
	}
	public Member3 selectMemberByNameAndEmail(SqlSession session, Member3 m) {
		return session.selectOne("member.selectMemberByNameAndEmail",m);
	}
	
	
}
