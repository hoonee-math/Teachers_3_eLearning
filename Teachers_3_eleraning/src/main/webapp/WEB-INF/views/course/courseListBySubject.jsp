<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Honey T</title>

<!-- 2. 외부 CSS 파일들 -->
<!-- 2-1. Bootstrap CSS (다른 CSS보다 먼저) -->
<!-- 2-2. Bootstrap Icons (필요한 경우) -->
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"> -->

<!-- 2-3. 직접 제작한 CSS 파일들 (Bootstrap CSS 다음에 위치) -->
<link rel="stylesheet" href="${path}/resources/css/common/reset.css">
<link rel="stylesheet" href="${path}/resources/css/common/layout.css">
<link rel="stylesheet" href="${path}/resources/css/common/utilities.css">
<link rel="stylesheet" href="${path}/resources/css/common/navigator.css">

<!-- 3. 컴포넌트 CSS -->
<link rel="stylesheet" href="${path}/resources/css/components/header.css">
<link rel="stylesheet" href="${path}/resources/css/components/navigation.css">
<link rel="stylesheet" href="${path}/resources/css/components/modal.css">
<link rel="stylesheet" href="${path}/resources/css/components/buttons.css">
<link rel="stylesheet" href="${path}/resources/css/components/cards.css">

<!-- 4. 페이지별 CSS -->
<link rel="stylesheet" href="${path}/resources/css/pages/courseList.css">
<link rel="stylesheet" href="${path}/resources/css/course/courseListBySubject.css">

<!-- 5. jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- 6. Bootstrap JS (jQuery 다음, 내부 스타일 전에) -->

<!-- 7. 내부 style 태그 -->
<style>
/* 페이지 특정 스타일 */
</style>

</head>
<body>
	<!-- 콘텐츠 영역 -->
	<div id="wrap">
		<!-- 헤더 include -->
	    <jsp:include page="/WEB-INF/views/common/modal.jsp" />
	    <jsp:include page="/WEB-INF/views/common/header.jsp" />

		<!-- 메인 콘텐츠 -->
		<main>
			<!-- 페이지 내용 -->
			<!-- 강사/강좌 목록 섹션 -->
			<section id="teacher-section">
				<!-- wrapper div 추가 -->
   	 			<div class="course-content-wrapper">  
				<!-- 실제 콘텐츠 -->
				<div class="course-container">
					<!-- 왼쪽 메뉴 -->
					<nav class="subject-menu">
						<h2>과목</h2>
						<ul class="menu-list">
							<li><a href="${path}/course/list?subjectName=1" class="active">국어</a></li>
							<li><a href="${path}/course/list?subjectName=2">수학</a></li>
							<li><a href="${path}/course/list?subjectName=3">영어</a></li>
							<li><a href="${path}/course/list?subjectName=4">과학</a></li>
							<li><a href="${path}/course/list?subjectName=5">사회</a></li>
							<li><a href="${path}/course/list?subjectName=6">한국사</a></li>
							<li><a href="${path}/course/list?subjectName=7">직업</a></li>
							<li><a href="${path}/course/list?subjectName=8">제2외국어</a></li>
						</ul>
					</nav>

           			<!-- 오른쪽 리스트 -->
					<div class="content-list">
						<!-- 리스트 헤더 -->
						<div class="list-header">
							<h2 class="list-title">전체 강좌</h2>
							<div class="sub-category">
								<button class="active">전체</button>
								<button>수능특강</button>
								<button>내신대비</button>
								<button>단과강좌</button>
							</div>
						</div>

						<!-- 강좌 리스트 -->
						<div class="course-list">
							<!-- 강좌 카드들 -->
							<c:forEach var="course" items="${courses}">
								<div class="course-card">
									<div class="card-left">
										<div class="course-image">
											<img
												src="${path}/resources/images/course/${course.imageNo}.jpg"
												alt="${course.courseTitle}"
												onerror="this.src='${path}/resources/images/profile/default.png'">
										</div>
										<div class="course-info">
											<h3>${course.courseTitle}</h3>
											<p class="teacher-name">${course.memberName}선생님</p>
											<p class="course-desc">${course.courseDesc}</p>
											<div class="course-tags">
												<span class="course-tag">#${course.teacherSubject}</span> <span
													class="course-tag">#수능대비</span>
											</div>
										</div>
									</div>
									<div class="card-right">
										<button class="preview-btn">맛보기</button>
										<div class="price-section">
											<label class="checkbox-wrapper"> <input
												type="checkbox" name="selectedCourse"
												value="${course.courseNo}"> <span class="checkmark"></span>
											</label>
											<!-- 가격정보는 DB의 할인율 정보를 바탕으로 표현하기 -->
											<div class="price-info">
												<c:if test="${course.coursePriceSale > 0}">
													<span class="original-price"> <fmt:formatNumber
															value="${course.coursePrice}" type="currency"
															currencySymbol="₩" />
													</span>
													<span class="discount-rate">${course.coursePriceSale}%</span>
												</c:if>
												<span class="final-price"> <fmt:formatNumber
														value="${course.coursePrice * (1 - course.coursePriceSale/100)}"
														type="currency" currencySymbol="₩" />
												</span>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>

						<!-- 페이징 바 -->
						<div class="pagination">
							<c:if test="${pageStart > 1}">
								<a href="${path}/course/list?cpage=${pageStart-1}"
									class="page-arrow">&lt;</a>
							</c:if>

							<c:forEach var="i" begin="${pageStart}" end="${pageEnd}">
								<c:choose>
									<c:when test="${i == cpage}">
										<span class="current-page">${i}</span>
									</c:when>
									<c:otherwise>
										<a href="${path}/course/list?cpage=${i}">${i}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>

							<c:if test="${pageEnd < totalPage}">
								<a href="${path}/course/list?cpage=${pageEnd+1}"
									class="page-arrow">&gt;</a>
							</c:if>
						</div>

						<!-- 장바구니/구매 버튼 -->
						<div class="action-buttons">
							<button class="cart-btn">장바구니</button>
							<button class="purchase-btn">바로구매</button>
						</div>
					</div> <!-- .course-list -->

					</div> <!-- .course-container -->
    			</div> <!-- .course-content-wrapper -->
			</section>

		</main>

		<!-- 푸터 include -->
    	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>

	<!-- 8. 공통 JavaScript -->
	<script src="${path}/resources/js/common/utils.js"></script>

	<!-- 9. API/Ajax 관련 JavaScript -->
	<script src="${path}/resources/js/api/apiConfig.js"></script>
	<script src="${path}/resources/js/api/teacherApi.js"></script>
	<script src="${path}/resources/js/api/courseApi.js"></script>

	<!-- 10. 컴포넌트 JavaScript -->
	<script src="${path}/resources/js/components/modal.js"></script>
	<script src="${path}/resources/js/components/navigation.js"></script>
	<script src="${path}/resources/js/components/accordion.js"></script>
	<script src="${path}/resources/js/components/tabs.js"></script>

	<!-- 11. 페이지별 JavaScript -->
	<script src="${path}/resources/js/course/courseListBySubject.js"></script>
</body>
</html>