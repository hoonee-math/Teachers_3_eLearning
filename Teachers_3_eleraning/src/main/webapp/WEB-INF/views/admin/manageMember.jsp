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
<style>

</style>
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
					<h2>회원 관리</h2>
					<hr style="border:2px solid #FAB350;">
					<p>회원 관리를 할 수 있습니다.</p>
				</div>
				
				
			</section>
		</div>
	</div> <!-- /페이지 내용 -->
	</main>


<!-- 푸터 include -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<!-- 콘텐츠 영역 종료 -->
</div>

<jsp:include page="/WEB-INF/views/common/scripts.jsp" />
<!-- API/Ajax 관련 JavaScript -->

</body>

</html>