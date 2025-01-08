<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<!-- 1. 공통 head 요소/공통 CSS 포함 -->
<jsp:include page="/WEB-INF/views/common/head.jsp" />
<!-- 2. 페이지별 CSS -->
<link rel="stylesheet" href="${path}/resources/css/pages/mypage-common.css">
<link rel="stylesheet" href="${path}/resources/css/member/courseManagement.css">
<link rel="stylesheet" href="${path}/resources/css/member/teacherManageCourseModal.css">
<title>강좌 관리 | Honey T</title>
</head>

<body>
<!-- 콘텐츠 영역 -->
<div id="wrap">
	<!-- 3.헤더 영역 -->
	<jsp:include page="/WEB-INF/views/common/modal.jsp" />
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<!-- 새 강좌 등록 모달 추가 -->
	<jsp:include page="/WEB-INF/views/member/teacherManageCourseModal.jsp" />

	<!-- 4.메인 콘텐츠 -->
	<main>
	<div class="main-container">
		<div class="main-content">
			<section class="main-section">
				<!-- 섹션 헤더 -->
				<div>
					<h2>강좌 관리</h2>
					<hr style="border: 2px solid #FAB350;">
					<p>내 강좌를 관리하고 등록할 수 있습니다.</p>
				</div>

				<!-- 강좌 통계 요약 -->
				<div class="course-summary">
					<button class="stat-card" data-status="all" onclick="filterByStatus('all')">
						<h3>전체 강좌</h3>
						<p class="stat-number">${totalCount }개</p>
					</button>
					<button class="stat-card" data-status="inProgress" onclick="filterByStatus('inProgress')">
						<h3>진행중 강좌</h3>
						<p class="stat-number">${inProgressCount }개</p>
					</button>
					<button class="stat-card" data-status="preparing" onclick="filterByStatus('preparing')">
						<h3>준비중 강좌</h3>
						<p class="stat-number">${preparingCount }개</p>
					</button>
					<button class="filter-btn" data-status="completed" onclick="filterByStatus('completed')">
						<h3>종료된 강좌</h3>
						<span class="count">${completedCount}개</span>
					</button>
				</div>

				<!-- 강좌 등록 버튼 -->
				<div class="course-actions">
					<button onclick="openModal()" class="btn-primary">
						<i class="bi bi-plus-circle"></i> 새 강좌 등록
					</button>
				</div>
				<!-- 필터 옵션 영역 -->
				<div class="course-filters">
					<select id="displayCount" onchange="changeDisplayCount(this.value)">
						<option value="5">5개씩 보기</option>
						<option value="10" selected>10개씩 보기</option>
						<option value="20">20개씩 보기</option>
					</select>
				</div>
				<!-- 강좌 목록 테이블 -->
				<div class="course-list">
					<table>	
						<thead>
							<tr>
								<th>강좌명</th>
								<th>상태</th>
								<th>등록일</th>
								<th>관리</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="course" items="${courses}">
								<tr>
									<td>
										<a href="javascript:void(0)"
											onclick="goToLectureManage(${course.courseNo})"
											class="course-title">
										${course.courseTitle}${course.courseNo} 강의 제목</a>
									</td>
									<td>
										<span class="status-badge ${course.courseStatus == 0 ? 'draft' : (course.courseStatus == 1 ? 'active' : 'completed')}">
											${course.courseStatus == 0 ? '준비중' : (course.courseStatus == 1 ? '진행중' : '완료')}
										</span>
									</td>
									<td><fmt:formatDate value="${course.createdAt}" pattern="yyyy.MM.dd"/></td>
									<td>
										<button onclick="goToLectureManage(${course.courseNo})" 
				                                class="btn-primary">강의 관리</button>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${empty courses}">
								<tr>
									<td colspan="4" class="no-data">등록된 강좌가 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
					
					<!-- 페이지네이션 -->
					<div class="pagination">
						<!-- 이전 페이지 -->
						<c:if test="${cpage > 1}">
							<a href="javascript:void(0)" onclick="changePage(${cpage-1})">&laquo;</a>
						</c:if>

						<!-- 페이지 번호 -->
						<c:forEach var="i" begin="${pageStart}" end="${pageEnd}">
							<a href="javascript:void(0)" onclick="changePage(${i})"
								class="${i == cpage ? 'active' : ''}">${i}</a>
						</c:forEach>

						<!-- 다음 페이지 -->
						<c:if test="${cpage < totalPage}">
							<a href="javascript:void(0)" onclick="changePage(${cpage+1})">&raquo;</a>
						</c:if>
					</div>
				</div>
			</section>
		</div>
	</div>
	</main>

	<!-- 5. 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</div> <!-- /콘텐츠 영역 -->

<jsp:include page="/WEB-INF/views/common/scripts.jsp" />
<!-- 6. 페이지별 스크립트 -->
<script src="${path}/resources/js/member/teacherManageCourseModal.js"></script>
<!-- 필터링과 페이징을 처리할 JavaScript 함수 -->
<script src="${path}/resources/js/member/teacherManageCourse.js"></script>
<script>
	function viewCourseDetail(courseNo) {
		// 강좌 상세 정보 보기 로직 구현
	}
</script>
</body>
</html>