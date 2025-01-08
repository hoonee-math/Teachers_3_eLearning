package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.MemberDao;
import com.ttt.dto.Member3;

public class AdminMemberService {

private MemberDao dao=new MemberDao();
	
	public List<Member3> selectAllMember(){
		SqlSession session=getSession();	
		return dao.selectAllMember(session);
	}
}
