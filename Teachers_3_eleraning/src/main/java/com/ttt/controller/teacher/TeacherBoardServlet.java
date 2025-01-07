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
	
	// 랜덤 날짜 생성 유틸리티 메서드
	// 특정 기간 내의 랜덤 날짜 생성
	private java.sql.Date getRandomDate(int startDaysAgo, int endDaysAgo) {
	    long currentTime = System.currentTimeMillis();
	    long start = currentTime - ((long)startDaysAgo * 24 * 60 * 60 * 1000);
	    long end = currentTime - ((long)endDaysAgo * 24 * 60 * 60 * 1000);  // 최근 startDaysAgo일에서 endDaysAgo까지 ex 최근 10일 이내에서 1 어제까지
	    long randomTime = start + (long)(Math.random() * (start - end));
	    return new java.sql.Date(randomTime);
	}
	
	private int getTotalData(String boardType) {
		// 각 게시판 타입별 전체 데이터 수 반환
		switch(boardType) {
			case "notice": return 50;  // 공지사항 
			case "qna": return 100;	// Q&A  
			case "resources": return 30; // 자료실
			case "reviews": return 80;  // 후기
			default: return 0;
		}
	}

	private List<Map<String,Object>> createDummyData(String boardType, int cpage, int numPerPage) {
		switch(boardType) {
			case "notice": return createNoticeDummyData(cpage, numPerPage);
			case "qna": return createQnaDummyData(cpage, numPerPage);
			case "resources": return createResourcesDummyData(cpage, numPerPage);
			case "reviews": return createReviewsDummyData(cpage, numPerPage);
			default: return new ArrayList<>();
		}
	}
	
	// 공지사항 더미데이터
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
	        notice.put("createdAt", getRandomDate(10, -10));
	        notice.put("viewCount", (int)(Math.random() * 100));
	        list.add(notice);
	    }
	    
	    return list;
	}
	
	// Q&A 더미데이터
	private List<Map<String,Object>> createQnaDummyData(int cpage, int numPerPage) {
		List<Map<String,Object>> list = new ArrayList<>();
		int start = (cpage - 1) * numPerPage + 1;
		
		for(int i = 0; i < numPerPage; i++) {
			Map<String,Object> qna = new HashMap<>();
			qna.put("postNo", start + i);
			qna.put("postTitle", "Q&A 질문입니다 " + (start + i));
			qna.put("memberName", "학생" + (int)(Math.random() * 100));
			qna.put("createdAt", getRandomDate(10, -10));
			qna.put("viewCount", (int)(Math.random() * 100));
			qna.put("answerStatus", Math.random() > 0.5 ? "답변완료" : "대기중");
			list.add(qna);
		}
		return list;
	}

	// 자료실 더미데이터
	private List<Map<String,Object>> createResourcesDummyData(int cpage, int numPerPage) {
		List<Map<String,Object>> list = new ArrayList<>();
		int start = (cpage - 1) * numPerPage + 1;
		
		for(int i = 0; i < numPerPage; i++) {
			Map<String,Object> resource = new HashMap<>();
			resource.put("postNo", start + i);
			resource.put("postTitle", "학습자료 " + (start + i));
			resource.put("memberName", "선생님");
			resource.put("createdAt", getRandomDate(10, -10));
			resource.put("viewCount", (int)(Math.random() * 100));
			resource.put("fileCount", (int)(Math.random() * 3) + 1); // 첨부파일 수
			list.add(resource);
		}
		return list;
	}

	// 수강후기 더미데이터
	private List<Map<String,Object>> createReviewsDummyData(int cpage, int numPerPage) {
		List<Map<String,Object>> list = new ArrayList<>();
		int start = (cpage - 1) * numPerPage + 1;
		
		for(int i = 0; i < numPerPage; i++) {
			Map<String,Object> review = new HashMap<>();
			review.put("postNo", start + i);
			review.put("courseName", "2024 수능대비 강좌 " + ((int)(Math.random() * 5) + 1));
			review.put("memberName", "학생" + (int)(Math.random() * 100));
			review.put("createdAt", getRandomDate(10, -10));
			review.put("rating", ((int)(Math.random() * 50) + 1) / 10.0); // 1.0-5.0
			review.put("reviewContent", "강의가 너무 좋았습니다. " + (start + i));
			list.add(review);
		}
		return list;
	}

}
