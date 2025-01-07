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
<title>마이 페이지 | Honey T</title>
<jsp:include page="/WEB-INF/views/common/head.jsp" />
<link rel="stylesheet" href="${path}/resources/css/pages/mypage-common.css">
</head>

<body>

<!-- 콘텐츠 영역 -->
<div id="wrap">
<!-- 헤더 include -->
<jsp:include page="/WEB-INF/views/common/modal.jsp" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
	
	<!-- 메인 콘텐츠 -->
	<main class="main">
		<div class="main-container">
			<div class="main-content">
				<section class="main-section">
					<div>
						<h2>교사 페이지</h2>
						<hr style="border: 2px solid #FAB350;">
						<p>강의 관리와 수강생 관리를 할 수 있습니다.</p>
					</div>
					<div class="row mypage-card-container">
						<!-- 프로필 관리 카드 -->
						<div class="mypage-card">
							<h3>프로필 관리</h3>
							<div>
								<i class="bi bi-person-badge"
									style="font-size: 10rem; color: #FAB350;"></i>
							</div>
							<div>
								<p>교사 프로필과 소개를</p>
								<p>관리할 수 있습니다.</p>
							</div>
							<div>
								<a href="${path}/teacher/profile">프로필 관리하기</a>
							</div>
						</div>
						<!-- 강좌 관리 카드 -->
						<div class="mypage-card">
							<h3>강좌 관리</h3>
							<div>
								<i class="bi bi-camera-video"
									style="font-size: 10rem; color: #FAB350;"></i>
							</div>
							<div>
								<p>강좌와 강의 영상을</p>
								<p>관리할 수 있습니다.</p>
							</div>
							<div>
								<a href="${path}/member/teacher/mypage/manager/course">강좌 관리하기</a>
							</div>
						</div>
						<!-- 게시판 관리 카드 -->
						<div class="mypage-card">
							<h3>게시판 관리</h3>
							<div>
								<i class="bi bi-clipboard2-check"
									style="font-size: 10rem; color: #FAB350;"></i>
							</div>
							<div>
								<p>공지사항과 Q&A를</p>
								<p>관리할 수 있습니다.</p>
							</div>
							<div>
								<a href="${path}/teacher/board">게시판 관리하기</a>
							</div>
						</div>
					</div>
				</section>
			</div>
		</div>
	</main>


<!-- 푸터 include -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</div><!-- /콘텐츠 영역 종료 -->

<jsp:include page="/WEB-INF/views/common/scripts.jsp" />
<!-- API/Ajax 관련 JavaScript -->
<script src="${path}/resources/js/api/teacherApi.js"></script>

</body>

</html>