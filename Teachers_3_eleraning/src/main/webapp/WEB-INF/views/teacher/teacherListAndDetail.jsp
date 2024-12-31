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
<link rel="stylesheet" href="${path}/resources/css/pages/teacherListAndDetail.css">
<link rel="stylesheet" href="${path}/resources/css/pages/courseList.css">

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
			<!-- 선생님 상세 페이지 -->
			<section id="teacher-detail-section">
				<div class="teacher-detail-container">
					<!-- 왼쪽 아코디언 메뉴 -->
					<nav class="accordion-menu">
						<!-- jstl core 태그로 리스트를 받아와서 출력해주기 -->
					    <c:forEach var="subjectEntry" items="${subjectData}">
						<div class="accordion-item">
						    <div class="accordion-header">
							${subjectEntry.value} <!-- 과목명 출력 -->
						    </div>
						    <div class="accordion-content">
							<c:forEach var="teacher" items="${teachers}">
							    <c:if test="${teacher.subject == subjectEntry.key}"> <!-- 과목번호와 과목 키값을 비교 -->
								<a href="#"  class="teacher-link" data-memberNo="${teacher.memberNo}">
								    ${teacher.memberName} 선생님
								</a>
							    </c:if>
							</c:forEach>
						    </div>
						</div>
					    </c:forEach>
					</nav>
	
						<!-- 오른쪽 상세 내용 섹션 1 : 선생님 프로필-->
						<div class="teacher-detail-content">
							<div class="teacher-profile">
								<div class="profile-image">
									<img src="https://i.namu.wiki/i/W-LhGCCNTAE3F7AJ81_DQpGg7XQbQolN76WcFDjbYgkSoOp8NnGgEj8PyGblftQNMKTTv_NJ8lfBz9XzpMlggQ.webp" alt="정승제 선생님">
								</div>
								<div class="profile-info">
									<div class="profile-header">
										<h1 class="profile-title">정승제 선생님</h1>
										<p class="profile-subtitle">TITLE 안내문 개념과 지독한 연습이 만점을 만듭니다!</p>
									</div>
									<div class="profile-tags">
										<span class="profile-tag">#개념</span> <span class="profile-tag">#학력과 통계</span> <span class="profile-tag">#수능 대비</span>
									</div>
								</div>
							</div>
	
							<!-- 소개 영상 -->
							<div class="preview-video">
								<div class="play-button"></div>
							</div>
	
							<!-- 탭 메뉴 -->
							<div class="tab-menu">
								<button class="tab-button active">HOME</button>
								<button class="tab-button">강의목록</button>
								<button class="tab-button">공지사항만</button>
								<button class="tab-button">학습 Q&A</button>
								<button class="tab-button">학습 자료실</button>
								<button class="tab-button">수강 후기</button>
							</div>
	
							<!-- 탭 콘텐츠 영역 -->
							<div class="tab-content">
								<!-- 탭 별 콘텐츠가 들어갈 영역 -->
							</div>
						</div>
						
						<!-- 오른쪽 상세 내용 섹션 2 : 리스트 헤더 -->
						<div class="content-list teacher-list-content">
							<div class="list-header">
								<h2 class="list-title">국어 선생님</h2>
								<div class="sub-category">
									<button class="active">전체</button>
									<button>문학</button>
									<button>독서</button>
									<button>화법과 작문</button>
								</div>
							</div>
		
							<!-- 강사 리스트 -->
							<div class="teacher-list">
								<!-- 강사 카드 1 -->
								<div class="teacher-card">
									<div class="teacher-image">
										<img
											src="https://i.namu.wiki/i/W-LhGCCNTAE3F7AJ81_DQpGg7XQbQolN76WcFDjbYgkSoOp8NnGgEj8PyGblftQNMKTTv_NJ8lfBz9XzpMlggQ.webp"
											alt="정승제 선생님">
									</div>
									<div class="teacher-info">
										<h3>
											정승제 선생님 <span class="teacher-badge">신규</span>
										</h3>
										<p class="teacher-description">국어의 달인이 되는 핵심 노하우 대공개! 학습의
											시작과 마무리를 책임지는 강의</p>
									</div>
								</div>
		
								<!-- 강사 카드 2 -->
								<div class="teacher-card">
									<div class="teacher-image">
										<img
											src="https://i.namu.wiki/i/PH9KzsC2-ubZ_bgZX2f1LQiDTTd3aXhg9oAgaGqidOb2Wku3WwdjhQ_nUQDZHm2b7jPOc2F1iqvlbxK_80rxuw.webp"
											alt="이지영 선생님">
									</div>
									<div class="teacher-info">
										<h3>
											이지영 선생님 <span class="teacher-badge">인기</span>
										</h3>
										<p class="teacher-description">문학의 감동을 전달하는 맛있는 강의! 수능 만점을
											위한 체계적인 커리큘럼</p>
									</div>
								</div>
		
								<!-- 강사 카드 3 -->
								<div class="teacher-card">
									<div class="teacher-image">
										<img
											src="https://i.namu.wiki/i/HD37stHzedpVHn3CRooaDUZnpY0lBKnMitQGuxOoLxSGpUBGxqAPhvc6MDjaViQgbHRnI5Q1j3AbTUJWCwW1VQ.webp"
											alt="우형철 선생님">
									</div>
									<div class="teacher-info">
										<h3>
											우형철 선생님 <span class="teacher-badge">베스트</span>
										</h3>
										<p class="teacher-description">독서와 문법의 기초부터 실전까지! 개념을 쉽게
											풀어주는 맞춤형 강의</p>
									</div>
								</div>
							</div>
						</div>
					</div>
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
	<script src="${path}/resources/js/teacher/teacherListAndDetailAccordion.js"></script>
	<script src="${path}/resources/js/api/teacherApi.js"></script>
    
	
</body>
</html>