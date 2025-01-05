<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="$${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="${path}/resources/images/common/HoneyT_logo_square.png">
<title>Honey T</title>

<!-- 2. 외부 CSS 파일들 -->

<!-- 2-3. 직접 제작한 CSS 파일들 (Bootstrap CSS 다음에 위치) -->
<link rel="stylesheet" href="$${path}/resources/css/common/reset.css">
<link rel="stylesheet" href="$${path}/resources/css/common/layout.css">
<link rel="stylesheet" href="$${path}/resources/css/common/utilities.css">
<link rel="stylesheet" href="$${path}/resources/css/common/navigator.css">

<!-- 3. 컴포넌트 CSS -->
<link rel="stylesheet" href="$${path}/resources/css/components/header.css">
<link rel="stylesheet" href="$${path}/resources/css/components/navigation.css">
<link rel="stylesheet" href="$${path}/resources/css/components/modal.css">
<link rel="stylesheet" href="$${path}/resources/css/components/buttons.css">
<link rel="stylesheet" href="$${path}/resources/css/components/cards.css">

<!-- 4. 페이지별 CSS -->
<%-- <link rel="stylesheet" href="${path}/resources/css/-"> --%>

<!-- 5. jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- 6. 외부 JS 파일들 (jQuery 다음, 내부 스타일 전에) -->

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
			${cursor }
		</main>





		<!-- 푸터 include -->
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
		<!-- 콘텐츠 영역 종료 -->
	</div>





	<!-- 8. 공통 JavaScript -->
	<!-- 9. API/Ajax 관련 JavaScript -->
	<script src="$${path}/resources/js/api/teacherApi.js"></script>

	<!-- 10. 컴포넌트 JavaScript -->
	<script src="$${path}/resources/js/components/modal.js"></script>

	<!-- 11. 페이지별 JavaScript -->
	<%-- <script src="${path}/resources/js/-"></script> --%>


</body>

</html>