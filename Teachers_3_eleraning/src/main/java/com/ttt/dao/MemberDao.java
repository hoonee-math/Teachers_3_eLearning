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
		Member3 member = session.selectOne("member.selectMemberById", memberId);
		
		if(member != null) {
			if(member.getMemberType() == 1) { //학생
				Member3 student = session.selectOne("member.selectStudentById", memberId);
				if(student != null && student.getSchool() != null) {
					member.setSchool(student.getSchool());
					member.setGrade(student.getGrade());
				}
			} else if (member.getMemberType() == 2) { //교사
				Member3 teacher = session.selectOne("member.selectTeacherById", memberId);
				if(teacher != null) {
					member.setTeacherInfoTitle(teacher.getTeacherInfoTitle());
					member.setTeacherInfoContent(teacher.getTeacherInfoContent());
					member.setImage(teacher.getImage());
					member.setTeacherSubject(teacher.getTeacherSubject());
				}
			}
		} 
		
		return member;
	}
	public int updatePassword(SqlSession session, Member3 m) {
		return session.update("member.updatePassword", m);
	}
	public int updateMember(SqlSession session, Member3 m) {
		return session.update("member.updateMember", m);
	}
	public int updateStudent(SqlSession session,Member3 m) {
		return session.update("member.updateStudent", m);
	}
	public int updateTeacher(SqlSession session,Member3 m) {
		return session.update("member.updateTeacher", m);
	}
		//이미지 업로드
	public int insertImage(SqlSession session, Member3 m) {
		return session.insert("image.insertImage", m);
	}
	
	
	/* teacherListAndDetail 페이지의 리스트에 교사 출력용 */
	public int getTotalTeacherCount(SqlSession session, String teacherSubject){
		return session.selectOne("member.getTotalTeacherCount", teacherSubject);
	}
	public List<String> selectSubjects(SqlSession session){
		return session.selectList("member.selectSubjects");
	}
	public List<Member3> selectAllTeachers(SqlSession session, Map<String, Object> params){
		return session.selectList("member.selectAllTeachers");
	}
	public List<Member3> selectAllTeachersOnMegaMenu(SqlSession session){
 		return session.selectList("member.selectAllTeachersOnMegaMenu");
 	}
	
	/* 이메일 인증 관련 */
	public Member3 checkEmailDuplicateByEmail(SqlSession session, Member3 m) {
		return session.selectOne("member.checkEmailDuplicateByEmail",m);
	}
	
	public Member3 selectMemberByNameAndEmail(SqlSession session, Member3 m) {
		return session.selectOne("member.selectMemberByNameAndEmail",m);
	}
	
	// 관리자 메뉴 : 전체 멤버 리스트 출력
	public List<Member3> selectAllMember(SqlSession session){
		System.out.println("DAO - 전체 멤버 리스트 출력 시작");
		return session.selectList("member.selectAllMember");
	}
	//사용자 메뉴 : 아이디 찾기
	public String selectMemberIdByNameAndEmail(SqlSession session, Member3 m) {
		return session.selectOne("member.selectMemberIdByNameAndEmail", m);
	}
	//사용자 메뉴 : 비밀번호 찾기
	public Member3 selectMemberByIdAndEmail(SqlSession session, Member3 m) {
	   return session.selectOne("member.selectMemberByIdAndEmail", m);
	}
	
	
}
