<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!-- LocalDateTime 포맷팅을 위한 함수 정의 -->
<%
  java.time.format.DateTimeFormatter timeFormatter = java.time.format.DateTimeFormatter.ofPattern("HH:mm");
  request.setAttribute("timeFormatter", timeFormatter);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="/WEB-INF/views/common/head.jsp" />
<link rel="stylesheet" href="${path}/resources/css/pages/mypage-common.css">
<link rel="stylesheet" href="${path}/resources/css/member/lecturePlan.css">
<title>강의 계획 등록 | Honey T</title>
</head>

<body>
<div id="wrap">
	<jsp:include page="/WEB-INF/views/common/modal.jsp" />
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	
	<main>
	<div class="main-container">
		<div class="main-content">
			<section class="main-section">
				<!-- 강좌 기본 정보 -->
				<div class="course-info">
					<div style="display:flex; justify-content: space-between;">
						<p style="font-size: 30px; font-weight: bold; margin-bottom:10px;">${course.courseTitle}</p>
						<div id="courseNo" style="display:none;">${course.courseNo }</div>
						<a href="${path }/member/teacher/mypage/course">강좌 목록 보기</a>
					</div>
					
					<hr style="border: 2px solid #FAB350;">
					<div class="info-box" style="padding-top:10px">
						<p><strong>총 강의 수:</strong> <span id="totalLectures">0</span>회</p>
						<p><strong>강좌 기간:</strong> 
							<fmt:formatDate value="${course.beginDate}" pattern="yyyy.MM.dd"/> ~ 
							<fmt:formatDate value="${course.endDate}" pattern="yyyy.MM.dd"/>
						</p>
					</div>
				</div>
				
				<!-- 일괄 등록 설정 -->
				<details class="batch-settings">
        		<summary>일괄 등록 설정</summary>
					<div class="settings-grid">
						<div class="setting-group">
							<label>시작 날짜</label>
							<input type="date" id="startDate" min="${course.beginDate}" max="${course.endDate}">
						</div>
						<div class="setting-group">
							<label>강의 요일</label>
							<div class="day-checkboxes">
								<label><input type="checkbox" value="1"> 월</label>
								<label><input type="checkbox" value="2"> 화</label>
								<label><input type="checkbox" value="3"> 수</label>
								<label><input type="checkbox" value="4"> 목</label>
								<label><input type="checkbox" value="5"> 금</label>
								<label><input type="checkbox" value="6"> 토</label>
								<label><input type="checkbox" value="0"> 일</label>
							</div>
						</div>
						<div class="setting-group">
							<label>강의 시간</label>
							<div class="time-selects">
								<select id="lectureStartTime" class="time-select">
									<option value="">시작 시간</option>
									<c:forEach var="hour" begin="9" end="11">
										<c:forEach var="minute" items="00,30">
											<option value="${hour}:${minute}">
												${hour}:${minute}</option>
										</c:forEach>
									</c:forEach>
								</select> <span class="time-separator">~</span> <select
									id="lectureEndTime" class="time-select">
									<option value="">종료 시간</option>
									<c:forEach var="hour" begin="10" end="12">
										<c:forEach var="minute" items="00,30">
											<option value="${hour}:${minute}">
												${hour}:${minute}</option>
										</c:forEach>
									</c:forEach>
								</select>
							</div>
						</div>
						
						<div class="setting-group">
							<label>주차 수</label>
							<input type="number" id="weekCount" min="1" max="16">
						</div>
						
						<button type="button" class="btn-primary" onclick="generateSchedule()">일정 생성</button>
					</div><!-- /.setting-grid -->
				</details><!-- /일괄 등록 설정 -->

				<!-- 강의 목록 -->
				<div class="lecture-list">
					<h3>강의 목록</h3>
					<!-- 기존 강의 목록 표시 -->
					<c:if test="${not empty lectures}">
						<div id="existingLectureList">
						<c:forEach items="${lectures}" var="lecture">
							<div class="lecture-item" data-lecture-no="${lecture.lectureNo}">
								<div class="lecture-header">
									<h4>${lecture.lectureOrder}차시</h4>
									<div class="lecture-actions">
										<button type="button" class="btn-edit-lecture">수정</button>
										<button type="button" class="btn-delete-lecture">삭제</button>
									</div>
								</div>
								<div class="lecture-content">
									<input type="text" class="lecture-title" value="${lecture.lectureTitle}" readonly>
									<details style="border:1px solid #FAB350">
										<summary>강의 정보</summary>
										<div class="optional-inputs">
					                        <label>강의 날짜: </label>
					                        	<input type="date" class="lecture-date" value="${lecture.scheduleEvent.eventStart}" readonly>
					                        <label>강의 시간: </label>
					                        <div class="lecture-time-group">
												<input type="time" value="${lecture.scheduleEvent.eventStart.format(timeFormatter)}" class="lecture-start-time" readonly>
												<input type="time" value="${lecture.scheduleEvent.eventEnd.format(timeFormatter)}" class="lecture-end-time" readonly>
											</div>
					                        <label>동영상 url: </label>
											<input type="url" class="video-url"  value="${lecture.scheduleEvent.videoUrl}" readonly>
					                        
										</div>
									</details>
								</div>
							</div>
						</c:forEach>
						</div>
					</c:if><!-- /기존 강의 목록 표시 -->
				</div>
					
					
					 <!-- 새로운 강의 추가 영역 -->
					<button type="button" class="add-lecture-btn" onclick="addLecture()">
						<i class="bi bi-plus-circle"></i> 강의 추가
					</button>
					<div id="lectureContainer">
						<!-- 동적으로 강의 아이템이 추가됨 -->
					</div>
				</div><!-- /강의 목록 -->

				<!-- 저장 버튼 -->
				<div class="button-group">
					<button type="button" class="btn-secondary" onclick="history.back()">취소</button>
					<button type="button" class="btn-primary" onclick="saveLecturePlan()">저장</button>
				</div>
			</section>
		</div>
	</div>
	</main>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</div>

<jsp:include page="/WEB-INF/views/common/scripts.jsp" />
<!-- 페이지별 스크립트 APi-컴포넌트-페이지 순 -->
<script>
    const courseNo = ${course.courseNo}; // EL 표현식으로 courseNo 전달
</script>
<script src="${path}/resources/js/member/teacherManageLectureList.js"></script>

</body>
</html>