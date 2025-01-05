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
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<!-- 2-3. 직접 제작한 CSS 파일들 (Bootstrap CSS 다음에 위치) -->
<link rel="stylesheet" href="${path}/resources/css/common/reset.css">
<link rel="stylesheet" href="${path}/resources/css/common/layout.css">
<link rel="stylesheet" href="${path}/resources/css/common/utilities.css">
<link rel="stylesheet" href="${path}/resources/css/common/navigator.css">

<!-- 3. 컴포넌트 CSS -->
<link rel="stylesheet"
	href="${path}/resources/css/components/header.css">
<link rel="stylesheet"
	href="${path}/resources/css/components/navigation.css">
<link rel="stylesheet" href="${path}/resources/css/components/modal.css">
<link rel="stylesheet"
	href="${path}/resources/css/components/buttons.css">
<link rel="stylesheet" href="${path}/resources/css/components/cards.css">

<!-- 4. 페이지별 CSS -->
<link rel="stylesheet" href="${path}/resources/css/components/dDay.css">
<link rel="stylesheet" href="${path}/resources/css/index/slider.css">
<link rel="stylesheet"
	href="${path}/resources/css/index/studentAndTeacherSection.css">
<link rel="stylesheet"
	href="${path}/resources/css/index/teacherSlider.css">
<link rel="stylesheet"
	href="${path}/resources/css/index/popularCourses.css">

<style>
.calendar-section {
	padding: 40px 0;
	background-color: #fff;
}

.calendar-container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 0 20px;
}

/* Toast UI Calendar 커스텀 스타일 */
.toastui-calendar-layout {
	border-radius: 8px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.toastui-calendar-day-name {
	color: #333;
}

.toastui-calendar-grid-cell {
	background-color: #fff;
}

.toastui-calendar-weekday-grid-date {
	color: #FAB350;
}
</style>

<!-- Toast UI Calendar CDN -->
<link rel="stylesheet"
	href="https://uicdn.toast.com/calendar/latest/toastui-calendar.min.css" />

<!-- 5. jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script
	src="https://uicdn.toast.com/calendar/latest/toastui-calendar.min.js"></script>

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
											<fmt:formatDate value="${course.lastViewTime}"
												pattern="yyyy-MM-dd HH:mm" />
										</p>
									</div>
									<div class="course-progress">
										<div class="progress-bar">
											<div class="progress" style="width: ${course.progressRate}%"></div>
										</div>
										<span class="progress-text">${course.progressRate}%
											수강완료 </span>
									</div>
									<div class="next-lecture">
										<h4>다음 강의</h4>
										<p>Chapter
											${course.nextLectureNo}.${course.nextLectureTitle}</p>
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
										<p>${course.beginDate}~${course.endDate}</p>
									</div>
									<a href="${path}/teacher/course/${course.courseNo}"
										class="course-link">강의 관리하기</a>
								</div>
							</c:forEach>
						</div>
					</div>
				</section>
			</c:if>


			<!-- 섹션4: 대표 강사진 슬라이더 -->
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
											<img src="${teacher.imageUrl}"
												alt="${teacher.memberName} 선생님">
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
			</section>


			<!-- index.jsp의 섹션5 부분 수정 -->
			<section id="popularCourses" class="popular-course-section">
				<div class="popular-course-container">
					<h2 class="section-title">인기 강좌</h2>

					<div class="popular-category-tabs">
						<!-- courseCategoryInfo 객체는 카테고리 번호와 이름을 key : value 형식으로 갖고있는 map -->
						<c:forEach var="category" items="${courseCategoryInfo}">
							<button
								class="popular-category-tab ${category.key == 1 ? 'active' : ''}"
								data-category="${category.key}">${category.value}</button>
						</c:forEach>
					</div>

					<div class="popular-course-container">
						<!-- 상단 카테리 번호에 따라 카테고리 생성 -->
						<c:forEach var="categoryId" begin="1" end="4">
							<div
								class="popular-course-list ${categoryId == 1 ? 'active' : ''}"
								data-category="${categoryId}">
								<div class="popular-course-grid">
									<c:forEach var="course" items="${popularCourses}">
										<c:if test="${course.courseCategoryNo == categoryId}">
											<div class="popular-course-card">
												<div class="popular-course-image">
													<img
														src="${path}/resources/images/common/HoneyT_logo_vertical.png"
														alt="${course.courseTitle}"> <span
														class="popular-grade-badge">고${course.grade}</span>
													<div class="popular-course-overlay">
														<p>${course.courseDesc}</p>
													</div>
												</div>
												<div class="popular-course-content">
													<h3 class="popular-course-title">${course.courseTitle}</h3>
													<p class="popular-teacher-name">${course.teacherName}
														선생님</p>
													<p class="popular-teacher-info">${course.teacherInfo}</p>
													<div class="popular-course-info">
														<div class="popular-rating">
															<i class="bi bi-star-fill"></i> <span><fmt:formatNumber
																	value="${course.rating}" pattern="#.0" /></span>
														</div>
														<div class="popular-student-count">
															<i class="bi bi-people-fill"></i> <span>${course.studentCount}명</span>
														</div>
													</div>
													<div class="popular-course-price">
														<span class="popular-discount">${course.coursePriceSale}%</span>
														<span class="popular-price"> <fmt:formatNumber
																value="${course.coursePrice * (100 - course.coursePriceSale) / 100}"
																type="currency" currencySymbol="" maxFractionDigits="0" />원
														</span>
													</div>
												</div>
												<a href="${path}/course/detail/${course.courseNo}"
													class="popular-course-link"> 자세히 보기 </a>
											</div>
										</c:if>
									</c:forEach>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</section>
			<!-- 캘린더 섹션 -->
			<section id="calendarSection" class="calendar-section">
				<div class="calendar-container">
					<h2 class="section-title">학습 일정</h2>
					<div id="calendar" style="height: 600px;"></div>
				</div>
			</section>
		</main>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>

	<!-- 8. 공통 JavaScript -->
	<script src="${path}/resources/js/common/utils.js"></script>

	<!-- 9. API/Ajax 관련 JavaScript -->
	<script src="${path}/resources/js/api/apiConfig.js"></script>
	<script src="${path}/resources/js/api/teacherApi.js"></script>
	<script src="${path}/resources/js/api/courseApi.js"></script>

	<script>
	document.addEventListener('DOMContentLoaded', function() {
	    console.log('DOMContentLoaded 이벤트 발생');
	    
		// 캘린더 컨테이너
		const container = document.getElementById('calendar');
	    console.log('캘린더 컨테이너:', container);

		// 현재 시간 기준 변수 설정
		const now = new Date();
	    console.log('현재 시간:', now);
		
	    // 캘린더 초기화 전 tui 객체 확인
	    console.log('tui 객체 확인:', tui);
	    
	    try {
			// 캘린더 초기화
			const calendar = new tui.Calendar(container, { // 'tui.Calendar' 대신 'toastui.Calendar' 사용
				defaultView : 'week', // 주간 뷰 설정
				usageStatistics : false,
				isReadOnly : false, // 수정 가능하도록 설정
				week : {
					startDayOfWeek : 0, // 일요일부터 시작
					dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
					workweek : false,
		            hourStart: 8,
		            hourEnd: 22
				// 주말 포함
				},
				theme : {
					common : {
						backgroundColor : '#ffffff',
						border : '1px solid #e5e5e5',
						gridSelection : {
							backgroundColor : 'rgba(81, 92, 230, 0.05)',
							border : '1px solid #FAB350'
						}
					},
					week : {
						dayName : {
							borderLeft : '1px solid #e5e5e5',
							borderTop : '1px solid #e5e5e5',
							borderBottom : '1px solid #e5e5e5',
							backgroundColor : '#f8f9fa'
						},
						timeGrid : {
							borderRight : '1px solid #e5e5e5'
						}
					}
				}
			});
	        console.log('캘린더 인스턴스 생성 성공:', calendar);

			// 샘플 일정 데이터 로깅
			console.log('스케줄 데이터:', schedules);

			// 일정 추가 시도
			try {
				calendar.createSchedules(schedules);
				console.log('일정 추가 성공');
			} catch (error) {
				console.error('일정 추가 중 에러:', error);
			}

			// 날짜 이동 시도
			try {
				calendar.setDate(new Date('2024-01-05'));
				console.log('날짜 설정 성공');
			} catch (error) {
				console.error('날짜 설정 중 에러:', error);
			}

		} catch (error) {
			console.error('캘린더 초기화 중 에러:', error);
		}

			// 샘플 일정 데이터 - TUI Calendar 형식에 맞춰 수정
			const schedules = [ {
				id : '1',
				calendarId : '1',
				title : '수학 기초 개념 학습',
				category : 'time',
				start : new Date('2024-01-05T10:00:00'),
				end : new Date('2024-01-05T12:00:00'),
				backgroundColor : '#FAB350'
			}, {
				id : '2',
				calendarId : '1',
				title : '영어 문법 스터디',
				category : 'time',
				start : new Date('2024-01-05T14:00:00'),
				end : new Date('2024-01-05T16:00:00'),
				backgroundColor : '#4A90E2'
			}, {
				id : '3',
				calendarId : '1',
				title : '과학 실험 보고서 작성',
				category : 'time',
				start : new Date('2024-01-06T13:00:00'),
				end : new Date('2024-01-06T15:00:00'),
				backgroundColor : '#50B766'
			} ];

			// 일정 추가
			calendar.createSchedules(schedules);

			// 현재 날짜로 이동
			calendar.setDate(now);
			calendar.setDate(new Date('2024-01-05'));

			/* // 일정 클릭 이벤트
			calendar.on('clickSchedule', function(event) {
				const schedule = event.schedule;
				alert(
					'일정: ' + schedule.title + 
					'\n시작: ' + schedule.start.toLocaleString() + 
					'\n종료: ' + schedule.end.toLocaleString()
				);
			}); */
		});
	</script>

	<!-- 10. 컴포넌트 JavaScript -->
	<script src="${path}/resources/js/components/modal.js"></script>
	<script src="${path}/resources/js/components/navigation.js"></script>
	<script src="${path}/resources/js/components/accordion.js"></script>
	<script src="${path}/resources/js/components/tabs.js"></script>

	<!-- 11. 페이지별 JavaScript -->
	<script src="${path}/resources/js/components/dDay.js"></script>
	<script src="${path}/resources/js/index/slider.js"></script>
	<script src="${path}/resources/js/index/teacherSlider.js"></script>
	<script src="${path}/resources/js/index/popularCourses.js"></script>
</body>
</html>