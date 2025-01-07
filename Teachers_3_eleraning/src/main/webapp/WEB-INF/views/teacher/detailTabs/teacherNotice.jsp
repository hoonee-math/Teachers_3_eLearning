<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
	
<!-- 게시판 영역 -->
<div class="board-container">
	<!-- 게시판 헤더 -->
	<div class="board-header">
		<h3>공지사항</h3>
		<div class="board-util">
			<select class="board-select">
				<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="both">제목+내용</option>
			</select>
			<input type="text" class="search-input" placeholder="검색어를 입력하세요">
			<button type="button" class="search-btn">검색</button>
		</div>
	</div>

	<!-- 게시판 목록 -->
	<div class="board-list">
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${noticeList}" var="notice">
					<tr>
						<td>${notice.postNo}</td>
						<td>
							<a href="#" class="post-title" data-post-no="${notice.postNo}">
								${notice.postTitle}
							</a>
						</td>
						<td>${notice.memberName}</td>
						<td>
							<fmt:formatDate value="${notice.createdAt}" pattern="yyyy-MM-dd"/>
						</td>
						<td>${notice.viewCount}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<!-- 페이징 바 -->
	<div class="board-pagination">
		<c:if test="${pageStart > 1}">
			<a href="#" class="page-link" data-page="${pageStart-1}">&lt;</a>
		</c:if>
		
		<c:forEach var="i" begin="${pageStart}" end="${pageEnd}">
			<c:choose>
				<c:when test="${i == currentPage}">
					<span class="current-page">${i}</span>
				</c:when>
				<c:otherwise>
					<a href="#" class="page-link" data-page="${i}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:if test="${pageEnd < totalPage}">
			<a href="#" class="page-link" data-page="${pageEnd+1}">&gt;</a>
		</c:if>
	</div>
</div>