package com.ttt.dao;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Member3;

public class MemberDao {

	public int insertMember(SqlSession session, Member3 m) {
		return session.insert("member.insertMember",m);
	}
	public Member3 selectMemberById(SqlSession session, String email) {
		return session.selectOne("member.selectMemberById",email);
	}
	public Member3 selectMemberByNameAndEmail(SqlSession session, Member3 m) {
		return session.selectOne("member.selectMemberByNameAndEmail",m);
	}
	public int updatePassword(SqlSession session, Member3 m) {
		return session.update("member.updatePassword", m);
	}
	public int updateMember(SqlSession session, Member3 m) {
		return session.update("member.updateMember", m);
	}
	public int checkEmailDuplicate(SqlSession session, String email) {
		return session.selectOne("member.checkEmailDuplicate",email);
	}
}
