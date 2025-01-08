<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

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
				<h2>강의 계획 등록</h2>
				<hr style="border: 2px solid #FAB350;">
				
				<!-- 강좌 기본 정보 -->
				<div class="course-info">
					<h3>강좌 정보</h3>
					<div class="info-box">
						<p><strong>강좌명:</strong> ${course.courseTitle}</p>
						<p><strong>총 강의 수:</strong> <span id="totalLectures">0</span>회</p>
					</div>
				</div>

				<!-- 일괄 등록 설정 -->
				<div class="batch-settings">
					<h3>일괄 등록 설정</h3>
					<div class="settings-grid">
						<div class="setting-group">
							<label>시작 날짜</label>
							<input type="date" id="startDate">
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
							<input type="time" id="lectureTime">
						</div>
						<div class="setting-group">
							<label>주차 수</label>
							<input type="number" id="weekCount" min="1" max="16">
						</div>
						<button type="button" class="btn-primary" onclick="generateSchedule()">일정 생성</button>
					</div>
				</div>

				<!-- 강의 목록 -->
				<div class="lecture-list">
					<h3>강의 목록</h3>
					<button type="button" class="add-lecture-btn" onclick="addLecture()">
						<i class="bi bi-plus-circle"></i> 강의 추가
					</button>
					<div id="lectureContainer">
						<!-- 여기에 강의가 동적으로 추가됨 -->
					</div>
				</div>

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
<script src="${path}/resources/js/member/teacherManageLectureList.js"></script>

</body>
</html>