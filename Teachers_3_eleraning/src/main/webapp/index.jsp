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
<title>Honey T</title>

<!-- 1. 공통 head 요소/공통 CSS 포함 -->
<jsp:include page="/WEB-INF/views/common/head.jsp" />

<!-- 4. 페이지별 CSS -->
<link rel="stylesheet" href="${path}/resources/css/components/dDay.css">
<link rel="stylesheet" href="${path}/resources/css/components/calendar.css">
<link rel="stylesheet" href="${path}/resources/css/index/slider.css">
<link rel="stylesheet" href="${path}/resources/css/index/studentAndTeacherSection.css">
<link rel="stylesheet" href="${path}/resources/css/index/teacherSlider.css">
<link rel="stylesheet" href="${path}/resources/css/index/popularCourses.css">

<!-- Toast UI Calendar CDN -->
<link rel="stylesheet" href="https://uicdn.toast.com/calendar/v2.1.3/toastui-calendar.min.css" />

<!-- 5. jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://uicdn.toast.com/calendar/v2.1.3/toastui-calendar.min.js"></script>

<style>
section {
	margin-bottom:20px;
}
</style>

</head>
<body>

	<!-- 콘텐츠 영역 -->
	<div id="wrap">
		<jsp:include page="/WEB-INF/views/common/modal.jsp" />
		<jsp:include page="/WEB-INF/views/common/header.jsp" />

		<main>
			<!-- 섹션1: D-day section -->
			<div id="my-dday-container" class="dday-container">
				<div class="dday-content">
					<div class="dday-messages"></div>
					<i class="bi bi-gear-fill dday-settings"></i>
				</div>
			</div>

			<!-- 섹션2: 광고 메인 슬라이더 section -->
			<section id="mainSlider" class="slider-section">
				<div class="slider-container">
					<div class="slider-wrapper">
						<c:forEach var="slide" items="${mainSlides}">
							<div class="slide">
								<a href="${slide.link}"> 
									<img src="${slide.imageUrl}" alt="${slide.title}">
									<div class="slide-content">
										<h2>${slide.title}</h2>
										<p>${slide.description}</p>
									</div>
								</a>
							</div>
						</c:forEach>
					</div><!-- /.slider-wrapper -->

					<!-- 슬라이더 컨트롤 -->
					<div class="slider-controls">
						<button class="prev-btn">&lt;</button>
						<button class="pause-btn">II</button>
						<button class="next-btn">&gt;</button>
					</div>

					<!-- 슬라이더 인디케이터 -->
					<div class="slider-indicators">
						<c:forEach var="slide" items="${mainSlides}" varStatus="status">
							<button class="indicator${status.first ? ' active' : ''}" data-slide="${status.index}">
							</button>
						</c:forEach>
					</div>
				</div><!-- /.slider-container -->
			</section><!-- / 섹션2: 광고 메인 슬라이더 section -->


			<!-- 섹션2: 학생 수강 현황 (memberType == 1) -->
			<c:if test="${sessionScope.loginMember.memberType == 1}">
				<section id="studentCourses" class="course-section">
					<div class="section-container">
						<h2 class="section-title">나의 학습 현황</h2>
						<div class="course-grid">
							<c:forEach var="course" items="${studentCourses}">
								<div class="course-card">
									<div class="course-header">
										<h3>${course.courseTitle}</h3>
										<span class="teacher-name">${course.teacherName} 선생님</span>
										<p class="last-view">
											마지막 수강:
											<fmt:formatDate value="${course.lastViewTime}" pattern="yyyy-MM-dd HH:mm" />
										</p>
									</div>
									<div class="course-progress">
										<div class="progress-bar">
											<div class="progress" style="width: ${course.progressRate}%"></div>
										</div>
										<span class="progress-text">${course.progressRate}% 수강완료 </span>
									</div>
									<div class="next-lecture">
										<h4>다음 강의</h4>
										<%-- <p>Chapter ${course.nextLectureNo} ${course.nextLectureTitle}</p>
										<span class="lecture-count">(${course.nextLectureNo} ${course.totalLectures}강)</span>
										<span class="resume-time">이어보기: ${course.stopAt div 60}분 ${course.stopAt mod 60}초</span> --%>
									</div>
									<a href="${path}" class="course-link">이어서 학습하기</a>
								</div>
							</c:forEach>
						</div><!-- /.course-grid -->
					</div><!-- /.section-container -->
				</section><!-- /.course-section -->
			</c:if><!-- / 섹션2: 학생 수강 현황 (memberType == 1) -->

			<!-- 섹션3: 교사 강좌 업로드 현황 (memberType == 2) -->
			<c:if test="${sessionScope.loginMember.memberType == 2}">
				<section id="teacherCourses" class="course-section">
					<div class="section-container">
						<h2 class="section-title">강좌 업로드 현황</h2>
						<div class="course-grid">
							<c:forEach var="course" items="${teacherCourses}">
								<div class="course-card">
									<div class="course-header">
										<h3>${course.courseTitle}</h3>
										<span class="upload-status">업로드 진행중</span>
									</div>
									<div class="upload-progress">
										<div class="progress-bar">
											<div class="progress" style="width: ${course.uploadProgress}%"></div>
										</div>
										<span class="progress-text">
											${course.uploadedLectures}/${course.totalLectures}강 업로드 완료
										</span>
									</div>
									<div class="course-schedule">
										<p>강의 등록 기간</p>
										<p>${course.beginDate}~${course.endDate}</p>
									</div>
									<a href="${path}/teacher/course/${course.courseNo}" class="course-link">강의 관리하기</a>
								</div>
							</c:forEach>
						</div><!-- /.course-grid -->
					</div><!-- /.section-container -->
				</section><!-- /.course-section -->
			</c:if>

			<!-- 섹션4: 캘린더 섹션 -->
			<section id="calendarSection" class="calendar-section">
				<!-- 캘린더 컨트롤러 -->
				<div class="calendar-controls">
					<!-- 현재 선택된 학년 표시 -->
					<div class="current-grade">
						<span>고${gradeNum} 강의 일정</span>
					</div>

					<!-- 로그인한 경우에만 표시되는 토글 -->
					<c:if test="${not empty loginMember}">
						<div class="view-toggles">
							<!-- 전체/내 강의 토글 -->
							<div class="toggle-switch">
								<input type="checkbox" id="viewToggle" class="toggle-input">
								<label for="viewToggle" class="toggle-label"> <span
									class="toggle-text">전체 강의</span>
								</label>
							</div>

							<!-- 학년 필터 -->
							<select id="gradeFilter" class="grade-select">
								<option value="1" ${gradeNum == 1 ? 'selected' : ''}>고1</option>
								<option value="2" ${gradeNum == 2 ? 'selected' : ''}>고2</option>
								<option value="3" ${gradeNum == 3 ? 'selected' : ''}>고3</option>
							</select>
						</div><!-- /.view-toggles -->
					</c:if>
				</div><!-- /.calendar-controls -->
				<div class="calendar-container">
					<h2 class="section-title">학습 일정</h2>
					<div id="calendar" style="height: 600px;"></div>
				</div>
			</section>

			<!-- 섹션5: 대표 강사진 슬라이더 -->
			<section id="mainTeachers" class="teacher-slider-section">
				<div class="section-container">
					<h2 class="section-title">대표 강사진</h2>
					<div class="teacher-slider-container">
						<div class="teacher-slider">
							<c:forEach var="teacher" items="${mainTeachers}"
								varStatus="status">
								<div class="teacher-slide">
									<div class="teacher-card">
										<div class="teacher-image">
											<img src="${teacher.imageUrl}" alt="${teacher.memberName} 선생님">
										</div>
										<div class="teacher-info">
											<h3>${teacher.memberName}선생님</h3>
											<p class="subject">${teacher.teacherSubject}</p>
											<p class="title">${teacher.teacherInfoTitle}</p>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</section><!-- / 섹션5: 대표 강사진 슬라이더 -->


			<!-- 섹션6: 부분 수정 -->
			<section id="popularCourses" class="popular-course-section">
				<div class="popular-course-container">
					<h2 class="section-title">인기 강좌</h2>

					<div class="popular-category-tabs">
						<!-- courseCategoryInfo 객체는 카테고리 번호와 이름을 key : value 형식으로 갖고있는 map -->
						<c:forEach var="category" items="${courseCategoryInfo}">
							<button class="popular-category-tab ${category.key == 1 ? 'active' : ''}" data-category="${category.key}">
								${category.value}
							</button>
						</c:forEach>
					</div>

					<div class="popular-course-container">
						<!-- 상단 카테리 번호에 따라 카테고리 생성 -->
						<c:forEach var="categoryId" begin="1" end="4">
							<div class="popular-course-list ${categoryId == 1 ? 'active' : ''}" data-category="${categoryId}">
								<div class="popular-course-grid">
									<c:forEach var="course" items="${popularCourses}">
										<c:if test="${course.courseCategoryNo == categoryId}">
											<div class="popular-course-card">
												<div class="popular-course-image">
													<img
														src="${path}/resources/images/common/HoneyT_logo_vertical.png"
														alt="${course.courseTitle}">
													<span class="popular-grade-badge">
														고${course.grade}
													</span>
													<div class="popular-course-overlay">
														<p>${course.courseDesc}</p>
													</div>
												</div>
												<div class="popular-course-content">
													<h3 class="popular-course-title">${course.course.courseTitle}</h3>
													<p class="popular-teacher-name">${course.teacherName} 선생님</p>
													<p class="popular-teacher-info">${course.teacherInfo}</p>
													<div class="popular-course-info">
														<div class="popular-rating">
															<i class="bi bi-star-fill"></i>
															<span>
																<fmt:formatNumber value="${course.rating}" pattern="#.0" />
															</span>
														</div>
														<div class="popular-student-count">
															<i class="bi bi-people-fill"></i> <span>${course.studentCount}명</span>
														</div>
													</div>
													<div class="popular-course-price">
														<span class="popular-discount">${course.coursePriceSale}%</span>
														<span class="popular-price">
															<fmt:formatNumber 
																value="${course.coursePrice * (100 - course.coursePriceSale) / 100}"
																type="currency" currencySymbol="" maxFractionDigits="0" />
															원
														</span>
													</div>
												</div>
												<a href="${path}/course/detail/${course.courseNo}" class="popular-course-link"> 자세히 보기 </a>
											</div><!-- /.popular-course-card -->
										</c:if>
									</c:forEach>
								</div><!-- /.popular-course-grid -->
							</div><!-- /.popular-course-list -->
						</c:forEach>
					</div><!-- /.popular-course-container ?? 똑같은 클래스가 두개로 묶여있네-->
				</div><!-- /.popular-course-container -->
			</section><!-- / 섹션6: 부분 수정 -->
		</main>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div><!-- /콘텐츠 영역 /.wrap -->

	<!-- 6-1. 공통 JavaScript -->
	<jsp:include page="/WEB-INF/views/common/scripts.jsp" />
	<!-- 페이지별 JavaScript -->
	<!-- 6-2. API/Ajax 관련 JavaScript -->
	<script src="${path}/resources/js/api/teacherApi.js"></script>
	<script src="${path}/resources/js/api/calendarApi.js"></script>
	<!-- 6-3. 컴포넌트 JavaScript -->
	<script src="${path}/resources/js/components/dDay.js"></script>
	<!-- 6-4. 페이지별 JavaScript -->
	<script src="${path}/resources/js/index/slider.js"></script>
	<script src="${path}/resources/js/index/teacherSlider.js"></script>
	<script src="${path}/resources/js/index/popularCourses.js"></script>
</body>
</html>