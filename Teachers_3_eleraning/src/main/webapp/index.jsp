<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Honey T</title>
	
	<!-- 2. 외부 CSS 파일들 -->
	<!-- 2-1. Bootstrap CSS (다른 CSS보다 먼저) -->
	<!-- 2-2. Bootstrap Icons (필요한 경우) -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
	
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
	<link rel="stylesheet" href="${path}/resources/css/components/dDay.css">
    <link rel="stylesheet" href="${path}/resources/css/index/slider.css">
    <link rel="stylesheet" href="${path}/resources/css/index/studentAndTeacherSection.css">

	<!-- 5. jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	
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
							<a href="${slide.link}"> <img src="${slide.imageUrl}"
								alt="${slide.title}">
								<div class="slide-content">
									<h2>${slide.title}</h2>
									<p>${slide.description}</p>
								</div>
							</a>
						</div>
					</c:forEach>
				</div>

				<!-- 슬라이더 컨트롤 -->
				<div class="slider-controls">
					<button class="prev-btn">&lt;</button>
					<button class="pause-btn">II</button>
					<button class="next-btn">&gt;</button>
				</div>

				<!-- 슬라이더 인디케이터 -->
				<div class="slider-indicators">
					<c:forEach var="slide" items="${mainSlides}" varStatus="status">
						<button class="indicator${status.first ? ' active' : ''}"
							data-slide="${status.index}"></button>
					</c:forEach>
				</div>
			</div>
		</section>


		<!-- 섹션2: 학생 수강 현황 (memberType == 1) -->
		<c:if test="${sessionScope.loginMember.memberType != 5}">
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
									<span class="progress-text">${course.progressRate}%
										수강완료</span>
								</div>
								<div class="next-lecture">
									<h4>다음 강의</h4>
									<p>Chapter ${course.nextLectureNo}.
										${course.nextLectureTitle}</p>
									<span class="lecture-count">(${course.nextLectureNo}/${course.totalLectures}강)</span>
									<span class="resume-time">이어보기: ${course.stopAt div 60}분
										${course.stopAt mod 60}초</span>
								</div>
								<a href="${path}/course/detail/${course.courseRegisterNo}"
									class="course-link">이어서 학습하기</a>
							</div>
						</c:forEach>
					</div>
				</div>
			</section>
		</c:if>

		<!-- 섹션3: 교사 강좌 업로드 현황 (memberType == 2) -->
		<c:if test="${sessionScope.loginMember.memberType != 5}">
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
										<div class="progress"
											style="width: ${course.uploadProgress}%"></div>
									</div>
									<span class="progress-text">
										${course.uploadedLectures}/${course.totalLectures}강 업로드 완료 </span>
								</div>
								<div class="course-schedule">
									<p>강의 등록 기간</p>
									<p>${course.startDate}~ ${course.endDate}</p>
								</div>
								<a href="${path}/teacher/course/${course.courseNo}"
									class="course-link">강의 관리하기</a>
							</div>
						</c:forEach>
					</div>
				</div>
			</section>
		</c:if>
	</main>
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
	<script src="${path}/resources/js/components/dDay.js"></script>
	<script src="${path}/resources/js/index/slider.js"></script>
</body>
</html>