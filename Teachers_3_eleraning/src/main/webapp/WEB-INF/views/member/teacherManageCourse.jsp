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
<title>강좌 관리 | Honey T</title>
</head>

<body>
<!-- 콘텐츠 영역 -->
<div id="wrap">
	<!-- 3.헤더 영역 -->
	<jsp:include page="/WEB-INF/views/common/modal.jsp" />
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

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
					<div class="stat-card">
						<h3>전체 강좌</h3>
						<p class="stat-number">5개</p>
					</div>
					<div class="stat-card">
						<h3>진행중 강좌</h3>
						<p class="stat-number">3개</p>
					</div>
					<div class="stat-card">
						<h3>준비중 강좌</h3>
						<p class="stat-number">2개</p>
					</div>
				</div>

				<!-- 강좌 등록 버튼 -->
				<div class="course-actions">
					<button onclick="location.href='${path}/teacher/course/register'" class="btn-primary">
						<i class="bi bi-plus-circle"></i> 새 강좌 등록
					</button>
				</div>

				<!-- 강좌 목록 테이블 -->
				<div class="course-list">
					<table>	
						<thead>
							<tr>
								<th>강좌명</th>
								<th>상태</th>
								<th>등록일</th>
								<th>수강생</th>
								<th>관리</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="course" items="${courses}">
								<tr>
									<td>${course.courseTitle}</td>
									<td>
										<span class="status-badge ${course.courseStatus == 0 ? 'draft' : (course.courseStatus == 1 ? 'active' : 'completed')}">
											${course.courseStatus == 0 ? '준비중' : (course.courseStatus == 1 ? '진행중' : '완료')}
										</span>
									</td>
									<td><fmt:formatDate value="${course.createdAt}" pattern="yyyy.MM.dd"/></td>
									<td>${course.studentCount}명</td>
									<td>
										<button onclick="location.href='${path}/teacher/course/edit/${course.courseNo}'" 
												class="btn-secondary">수정</button>
										<button onclick="viewCourseDetail(${course.courseNo})" 
												class="btn-secondary">상세</button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
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
<script>
	function viewCourseDetail(courseNo) {
		// 강좌 상세 정보 보기 로직 구현
	}
</script>
</body>
</html>