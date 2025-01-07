package com.ttt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Course3;

public class CourseDao {
	public List<Course3> selectCourseBySubjectNo(SqlSession session, Map<String, Integer> param) {
		int cPage = param.get("cpage");
		int numPerPage = param.get("numPerPage");
		int subjectNo = param.get("subjectNo");
		
		List<Course3> result = session.selectList("course.selectCourseBySubjectNo",
				Map.of("subjectNo", subjectNo, "start", (cPage-1)*numPerPage+1, "end", cPage*numPerPage));
		
		return result;
	}

}
