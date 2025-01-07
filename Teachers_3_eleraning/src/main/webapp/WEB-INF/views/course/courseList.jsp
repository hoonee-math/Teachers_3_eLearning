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
<title>선생님 | Honey T</title>


<!-- 4. 페이지별 CSS -->
<link rel="stylesheet" href="${path}/resources/css/pages/courseList.css">

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
				<!-- 섹션 설명 -->
				<div class="section-description">
					<p>
						<strong>강사/강좌 목록 레이아웃</strong>
					</p>
					<p>- 구조: Flexbox를 사용한 2단 레이아웃</p>
					<p>- 왼쪽: 고정 너비(200px) 메뉴</p>
					<p>- 오른쪽: 유동적 너비의 카드 리스트</p>
				</div>
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
    			</div>
			</section>

		</main>

		<!-- 푸터 include -->
    	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>

<jsp:include page="/WEB-INF/views/common/scripts.jsp" />
<!-- 페이지별 JavaScript -->

</body>
</html>