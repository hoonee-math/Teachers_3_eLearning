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
	<title>Honey T</title>
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
		<!-- 페이지 내용 -->
		<div class="main-container">
			<div class="main-content">
				<section class="main-section">
					<div>
						<h2>마이 페이지</h2>
						<hr style="border: 2px solid #FAB350;">
						<p>나의 학습현황과 개인정보를 관리할 수 있습니다.</p>
					</div>
					<div class="row mypage-card-container">
						<!-- 내 정보 카드 -->
						<div class="mypage-card">
							<h3>내 정보</h3>
							<div>
								<i class="bi bi-person-vcard"
									style="font-size: 10rem; color: #FAB350;"></i>
							</div>
							<div>
								<p>개인정보를 수정할 수 있는</p>
								<p>내 정보 페이지로 이동합니다.</p>
							</div>
							<div>
								<a href="${path}/member/student/myinfo">내 정보 확인하기</a>
							</div>
						</div>
						<!-- 수강 관리 카드 -->
						<div class="mypage-card">
							<h3>수강 관리</h3>
							<div>
								<i class="bi bi-journal-text"
									style="font-size: 10rem; color: #FAB350;"></i>
							</div>
							<div>
								<p>수강중인 강좌와 진도율을</p>
								<p>확인할 수 있습니다.</p>
							</div>
							<div>
								<a href="${path}/member/student/enrollment">수강현황 보기</a>
							</div>
						</div>
						<!-- 결제 내역 카드 -->
						<div class="mypage-card">
							<h3>결제 내역</h3>
							<div>
								<i class="bi bi-credit-card"
									style="font-size: 10rem; color: #FAB350;"></i>
							</div>
							<div>
								<p>결제 내역과 환불 현황을</p>
								<p>확인할 수 있습니다.</p>
							</div>
							<div>
								<a href="${path}/member/student/payment">결제내역 보기</a>
							</div>
						</div>
						<!-- 작성글 관리 카드 -->
						<div class="mypage-card">
							<h3>작성글 관리</h3>
							<div>
								<i class="bi bi-pencil-square"
									style="font-size: 10rem; color: #FAB350;"></i>
							</div>
							<div>
								<p>내가 작성한 게시글과</p>
								<p>댓글을 관리합니다.</p>
							</div>
							<div>
								<a href="${path}/member/student/mypost">작성글 보기</a>
							</div>
						</div>
					</div>
				</section>
			</div>
		</div>
	</main>


<!-- 푸터 include -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<!-- 콘텐츠 영역 종료 -->
</div>

<jsp:include page="/WEB-INF/views/common/scripts.jsp" />
<!-- API/Ajax 관련 JavaScript -->

</body>

</html>