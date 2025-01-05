package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.SchoolDao;
import com.ttt.dto.School12;

/* Connection 과 dao 객체를 만들어서 서버와 db 서버가 서로 통신할 수 있게 서비스를 제공하는 클래스 */
public class SchoolService {

	private SchoolDao dao=new SchoolDao();
	
	public List<School12> selectNameAndCode(Map<String,Object> inputSchoolInfo) {
		SqlSession session=getSession();
		List<School12> result=dao.selectNameAndCode(session,inputSchoolInfo);
		session.close();
		return result;
		
	}
	
	public School12 selectSchoolInfoBySchoolNo(int schoolNo) {
		SqlSession session=getSession();
		return dao.selectSchoolInfoBySchoolNo(session,schoolNo);
		
	}

}
