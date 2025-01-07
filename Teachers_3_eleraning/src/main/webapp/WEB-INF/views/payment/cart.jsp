<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="${path}/resources/css/pages/courseList.css">
<link rel="stylesheet" href="${path}/resources/css/payment/cart.css">

<title>장바구니 | Honey T</title>
	
</head>
<body>
<!-- 콘텐츠 영역 -->
<div id="wrap">
<!-- 3.헤더 영역 -->
<jsp:include page="/WEB-INF/views/common/modal.jsp" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<!-- 4.메인 콘텐츠 -->
<main>
<!-- (삭제 x)  본문 섹션 wrapper div -->
<div class="sections-wrapper">

	<!-- : 섹션 1,2,3,4,5 중 사용할 섹션만 남기고 삭제  --> 
	
	
	<!-- 섹션 1: 3단 그리드 레이아웃 -->
	<section id="layout-section-1">
		<!-- 실제 콘텐츠 wrapper div -->
		<div>
			<!-- 왼쪽 사이드바 -->
			<div class="content-box">
				<h3>Left Sidebar</h3>
				<p>ID: left-section</p>
				<p>고정 너비: 250px</p>
				<p>주로 네비게이션이나 필터에 사용</p>
			</div>
			<!-- 메인 콘텐츠 -->
			<div class="content-box">
				<h3>Main Content Area</h3>
				<p>ID: main-section</p>
				<p>가변 너비: 남은 공간 자동 조절</p>
				<p>주요 콘텐츠가 표시되는 영역</p>
			</div>
			<!-- 오른쪽 사이드바 -->
			<div class="content-box">
				<h3>Right Sidebar</h3>
				<p>ID: right-section</p>
				<p>고정 너비: 250px</p>
				<p>주로 위젯이나 광고에 사용</p>
			</div>
		</div> <!-- /실제 콘텐츠 wrapper div -->
	</section> <!-- /섹션 1: 3단 그리드 레이아웃 -->
	
	<!-- 섹션 2: 자동 조절 그리드 -->
	<section id="layout-section-2">
		<!-- 실제 콘텐츠 wrapper div -->
		<div>
			<div class="info-card">
				<div class="card-header">Card 1</div>
				<div class="card-body">
					<p>자동 크기 조절 카드</p>
					<p>최소 너비: 300px</p>
					<p>호버 시 상승 효과</p>
				</div>
			</div>
			<div class="info-card">
				<div class="card-header">Card 2</div>
				<div class="card-body">
					<p>반응형 레이아웃</p>
					<p>화면 크기에 따라 자동 정렬</p>
					<p>그림자 효과 적용</p>
				</div>
			</div>
		</div> <!-- /실제 콘텐츠 wrapper div -->
	</section> <!-- /섹션 2: 자동 조절 그리드 -->
	
	<!-- 섹션 3: 복합 레이아웃 -->
	<section id="layout-section-3">
		<!-- 실제 콘텐츠 wrapper div -->
		<div>
			<!-- Flexbox 컨테이너 -->
			<div class="flex-container">
				<div class="flex-item">
					<h4>Flex Item 1</h4>
					<p>유동적 너비 조절</p>
				</div>
				<div class="flex-item">
					<h4>Flex Item 2</h4>
					<p>최소 너비 200px</p>
				</div>
				<div class="flex-item">
					<h4>Flex Item 3</h4>
					<p>자동 줄바꿈 처리</p>
				</div>
			</div>
			<!-- Grid 컨테이너 -->
			<div class="grid-container">
				<div class="grid-item">Grid 1</div>
				<div class="grid-item">Grid 2</div>
				<div class="grid-item">Grid 3</div>
			</div>
		</div> <!-- /실제 콘텐츠 wrapper div -->
	</section> <!-- /섹션 3: 복합 레이아웃 -->
	
	<!-- 섹션 4: 강사/강좌 목록 섹션 -->
	<section id="teacher-section">
		<!-- wrapper div 추가 -->
 	 		<div class="course-content-wrapper">  
			<!-- 실제 콘텐츠 wrapper div -->
			<div class="course-container">
				<!-- 왼쪽 메뉴 -->
				<nav class="subject-menu">
					<h2>과목</h2>
					<ul class="menu-list">
						<li><a href="#" class="active">국어</a></li>
						<li><a href="#">수학</a></li>
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
					</div>
				</div> <!-- /오른쪽 리스트 -->
			</div> <!-- /실제 콘텐츠 wrapper div -->
  			</div> <!-- /wrapper div 추가 -->
	</section> <!-- /섹션 4: 강사/강좌 목록 섹션 -->
	
	<!-- 섹션5 : 선생님 상세 페이지 -->
	<section id="teacher-detail-section">
		<!-- wrapper div .teacher-detail-container -->
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
					</div> <!-- /강사 카드 1 -->
				</div> <!-- /강사 리스트 -->
			</div> <!-- /오른쪽 상세 내용 섹션 2 : 리스트 헤더 -->
		</div> <!-- /wrapper div .teacher-detail-container -->
	</section> <!-- /섹션5 : 선생님 상세 페이지 -->



</div> <!-- (삭제 x) /본문 섹션 wrapper div -->
</main> <!-- /메인 콘텐츠 -->
<!-- 5. 푸터 영역 -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
		
</div> <!-- /콘텐츠 영역 -->

<jsp:include page="/WEB-INF/views/common/scripts.jsp" />
<!-- 6. 페이지별 스크립트 APi-컴포넌트-페이지 순 -->
<%-- <script src="${path}/resources/js/-"></script> --%>
	
</body>
</html>