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
<jsp:include page="/WEB-INF/views/common/head.jsp" />
<title>관리자 메뉴 | Honey T</title>
<!-- 페이지별 CSS -->
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
						<h2>관리자 페이지</h2>
						<hr style="border: 2px solid #FAB350;">
						<p>사이트 전반적인 관리를 할 수 있습니다.</p>
					</div>
					<div class="row mypage-card-container">
						<!-- 회원 관리 카드 -->
						<div class="mypage-card">
							<h3>회원 관리</h3>
							<div>
								<i class="bi bi-people"
									style="font-size: 10rem; color: #FAB350;"></i>
							</div>
							<div>
								<p>회원 정보와 권한을</p>
								<p>관리할 수 있습니다.</p>
							</div>
							<div>
								<a href="${path}/admin/member">회원 관리하기</a>
							</div>
						</div>
						<!-- 강좌 관리 카드 -->
						<div class="mypage-card">
							<h3>강좌 관리</h3>
							<div>
								<i class="bi bi-collection-play"
									style="font-size: 10rem; color: #FAB350;"></i>
							</div>
							<div>
								<p>전체 강좌와 카테고리를</p>
								<p>관리할 수 있습니다.</p>
							</div>
							<div>
								<a href="${path}/admin/course">강좌 관리하기</a>
							</div>
						</div>
						<!-- 결제 관리 카드 -->
						<div class="mypage-card">
							<h3>결제 관리</h3>
							<div>
								<i class="bi bi-cash-coin"
									style="font-size: 10rem; color: #FAB350;"></i>
							</div>
							<div>
								<p>결제와 환불 현황을</p>
								<p>관리할 수 있습니다.</p>
							</div>
							<div>
								<a href="${path}/admin/payment">결제 관리하기</a>
							</div>
						</div>
						<!-- 게시판 관리 카드 -->
						<div class="mypage-card">
							<h3>게시판 관리</h3>
							<div>
								<i class="bi bi-layout-text-window-reverse"
									style="font-size: 10rem; color: #FAB350;"></i>
							</div>
							<div>
								<p>게시판과 신고글을</p>
								<p>관리할 수 있습니다.</p>
							</div>
							<div>
								<a href="${path}/admin/board">게시판 관리하기</a>
							</div>
						</div>
						<!-- 게시판 관리 카드 -->
						<div class="mypage-card">
							<h3>사이트 관리</h3>
							<div>
								<i class="bi bi-gear-wide-connected"
									style="font-size: 10rem; color: #FAB350;"></i>
							</div>
							<div>
								<p>홈페이지 정보를</p>
								<p>관리할 수 있습니다.</p>
							</div>
							<div>
								<a href="${path}/admin/manage/site">게시판 관리하기</a>
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
<!-- 페이지별 JavaScript -->

</body>
</html>