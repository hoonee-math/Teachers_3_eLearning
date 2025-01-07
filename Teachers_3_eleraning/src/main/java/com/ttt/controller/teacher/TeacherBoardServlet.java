package com.ttt.controller.teacher;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/TeacherBoardServlet")
public class TeacherBoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	   
	public TeacherBoardServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pathInfo = request.getPathInfo();
		String boardType = pathInfo.substring(1); // /notice, /qna 등
		
		// 페이징 처리를 위한 파라미터
		int cpage = 1;
		try {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		} catch (NumberFormatException e) {}
		
		int numPerPage = 10;
		int totalData = getTotalData(boardType); // 게시글 총 개수
		int totalPage = (int)Math.ceil((double)totalData/numPerPage);
		
		int pageBarSize = 5;
		int pageStart = ((cpage-1)/pageBarSize) * pageBarSize + 1;
		int pageEnd = pageStart + pageBarSize - 1;
		
		if(pageEnd > totalPage) {
			pageEnd = totalPage;
		}
		
		// 더미데이터 생성 및 페이징 처리
		List<Map<String,Object>> boardList = createDummyData(boardType, cpage, numPerPage);
		
		// request에 데이터 저장
		request.setAttribute("boardList", boardList);
		request.setAttribute("pageStart", pageStart);
		request.setAttribute("pageEnd", pageEnd);
		request.setAttribute("totalPage", totalPage);
		
		// 각 게시판 타입별 JSP로 포워딩
		String view = "/WEB-INF/views/teacher/tabs/teacher" + 
					 boardType.substring(0,1).toUpperCase() + 
					 boardType.substring(1) + ".jsp";
		request.getRequestDispatcher(view).forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	private List<Map<String,Object>> createNoticeDummyData(int cpage, int numPerPage) {
	    List<Map<String,Object>> list = new ArrayList<>();
	    
	    // 시작 번호 계산
	    int start = (cpage - 1) * numPerPage + 1;
	    
	    // 더미데이터 생성
	    for(int i = 0; i < numPerPage; i++) {
	        Map<String,Object> notice = new HashMap<>();
	        notice.put("postNo", start + i);
	        notice.put("postTitle", "공지사항 테스트 " + (start + i));
	        notice.put("memberName", "관리자");
	        notice.put("createdAt", new Date());
	        notice.put("viewCount", (int)(Math.random() * 100));
	        list.add(notice);
	    }
	    
	    return list;
	}

}
