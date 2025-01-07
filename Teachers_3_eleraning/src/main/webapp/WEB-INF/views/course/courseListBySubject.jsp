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
<jsp:include page="/WEB-INF/views/common/head.jsp" />
<title>Honey T</title>

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
				        <li><a href="${path}/course/list?subjectName=국어" class="${selectedSubject == '국어' ? 'active' : ''}">국어</a></li>
				        <li><a href="${path}/course/list?subjectName=수학" class="${selectedSubject == '수학' ? 'active' : ''}">수학</a></li>
				        <li><a href="${path}/course/list?subjectName=영어" class="${selectedSubject == '영어' ? 'active' : ''}">영어</a></li>
				        <li><a href="${path}/course/list?subjectName=과학" class="${selectedSubject == '과학' ? 'active' : ''}">과학</a></li>
				        <li><a href="${path}/course/list?subjectName=사회" class="${selectedSubject == '사회' ? 'active' : ''}">사회</a></li>
				        <li><a href="${path}/course/list?subjectName=한국사" class="${selectedSubject == '한국사' ? 'active' : ''}">한국사</a></li>
				        <li><a href="${path}/course/list?subjectName=직업" class="${selectedSubject == '직업' ? 'active' : ''}">직업</a></li>
				        <li><a href="${path}/course/list?subjectName=제2외국어" class="${selectedSubject == '제2외국어' ? 'active' : ''}">제2외국어</a></li>
				    </ul>
				</nav>
           			<!-- 오른쪽 리스트 -->
					<div class="content-list">
					
					<!-- 학년 선택 정보 가져오기 위한 태그 -->
					<input type="hidden" name="gradeNum" id="gradeNum">
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
												src="${path}/resources/images/course/${course.member.image.imgNo}.jpg"
												alt="${course.courseTitle}"
												onerror="this.src='${path}/resources/images/profile/default.png'">
										</div>
										<div class="course-info">
											<h3>${course.courseTitle}</h3>
											<p class="teacher-name">${course.member.memberName}선생님</p>
											<p class="course-desc">${course.courseDesc}</p>
											<div class="course-tags">
												<span class="course-tag">#${course.member.teacherSubject}</span> <span
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

<jsp:include page="/WEB-INF/views/common/scripts.jsp" />
<!-- 페이지별 JavaScript -->
<script src="${path}/resources/js/course/courseListBySubject.js"></script>

</body>
</html>