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
<link rel="stylesheet" href="${path}/resources/css/pages/teacherListAndDetail.css">
<link rel="stylesheet" href="${path}/resources/css/pages/courseList.css">
<link rel="stylesheet" href="${path}/resources/css/teacher/teacherBoardCommon.css">

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
					    <c:forEach var="subject" items="${subjectData}">
						<div class="accordion-item">
						    <div class="accordion-header" data-subject="${subject}">
								${subject} <!-- 과목명 출력 -->
						    </div>
						    <div class="accordion-content">
							<c:forEach var="teacher" items="${teachers}">
							    <c:if test="${teacher.teacherSubject == subject}"> <!-- 과목번호와 과목 키값을 비교 -->
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
								<button class="tab-button active" data-tab="home">HOME</button>
								<button class="tab-button" data-tab="notice">공지사항</button>
								<button class="tab-button" data-tab="qna">학습 Q&A</button>
								<button class="tab-button" data-tab="resources">학습 자료실</button>
								<button class="tab-button" data-tab="reviews">수강 후기</button>
							</div>
	
							<!-- 탭 콘텐츠 영역 -->
							<div class="tab-content">
								<div id="teacherHome" class="tab-pane active">
									<jsp:include page="/WEB-INF/views/teacher/detailTabs/teacherHome.jsp" />
								</div>
								<div id="teacherNotice" class="tab-pane">
									<jsp:include page="/WEB-INF/views/teacher/detailTabs/teacherNotice.jsp" />
								</div>
								<div id="teacherQna" class="tab-pane">
									<jsp:include page="/WEB-INF/views/teacher/detailTabs/teacherQnA.jsp" />
								</div>
								<div id="teacherResources" class="tab-pane">
									<jsp:include page="/WEB-INF/views/teacher/detailTabs/teacherResources.jsp" />
								</div>
								<div id="teacherReviews" class="tab-pane">
									<jsp:include page="/WEB-INF/views/teacher/detailTabs/teacherReviews.jsp" />
								</div>
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
		
							<%-- <!-- 강사 리스트 -->
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
								<!-- 강사 리스트 아래에 추가 -->
								<div class="pagination">
									<c:if test="${pageStart > 1}">
										<a href="#" class="page-link" data-page="${pageStart-1}">&lt;</a>
									</c:if>
		
									<c:forEach var="i" begin="${pageStart}" end="${pageEnd}">
										<c:choose>
											<c:when test="${i == cpage}">
												<span class="current-page">${i}</span>
											</c:when>
											<c:otherwise>
												<a href="#" class="page-link" data-page="${i}">${i}</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>
		
									<c:if test="${pageEnd < totalPage}">
										<a href="#" class="page-link" data-page="${pageEnd+1}">&gt;</a>
									</c:if>
								</div>
							</div> --%>
							<!-- 실제 교사 데이터 출력 -->
							<div class="teacher-list real-data">
								<c:forEach var="teacher" items="${teachers}">
									<div class="teacher-card" data-memberNo="${teacher.memberNo}">
										<div class="teacher-image">
											<img
												src="https://i.namu.wiki/i/W-LhGCCNTAE3F7AJ81_DQpGg7XQbQolN76WcFDjbYgkSoOp8NnGgEj8PyGblftQNMKTTv_NJ8lfBz9XzpMlggQ.webp"
												alt="${teacher.memberName} 선생님">
										</div>
										<div class="teacher-info">
											<h3>
												${teacher.memberName} 선생님
												<%-- <c:if test="${not empty teacher.badge}">
							                        <span class="teacher-badge">${teacher.badge}</span>
							                    </c:if> --%>
											</h3>
											<p class="teacher-description">
												${teacher.teacherInfoTitle} ${teacher.teacherInfoContent}</p>
										</div>
									</div>
								</c:forEach>
							</div>
							<!-- 데이터 확인용 디버깅 출력 -->
							<div style="display: none;">
							    <p>Teachers 데이터: ${teachers}</p>
							    <p>Teachers 크기: ${fn:length(teachers)}</p>
							</div>
								
						</div>
					</div>
			</section>

		</main>

		<!-- 푸터 include -->
    	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>

<jsp:include page="/WEB-INF/views/common/scripts.jsp" />
<script src="${path}/resources/js/teacher/teacherListAndDetailAccordion.js"></script>
<script src="${path}/resources/js/api/teacherApi.js"></script>
<script src="${path}/resources/js/teacher/teacherBoard.js"></script>

</body>
</html>