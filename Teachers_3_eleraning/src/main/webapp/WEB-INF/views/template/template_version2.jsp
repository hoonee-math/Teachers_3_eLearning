<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%-- JSP/JSTL 태그 라이브러리 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- JSP/JSTL의 ${path}: path 변수는 각 페이지에서 반드시 선언, JSP가 서버에서 처리될 때 해석됨, HTML이 생성될 때 실제 경로로 대체됨--%>
<c:set var="path" value="$${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>

<!-- 1. 공통 head 요소/공통 CSS 포함 -->
<jsp:include page="/WEB-INF/views/common/head.jsp" />

<!-- 2. 페이지별 CSS -->
<%-- <link rel="stylesheet" href="${path}/resources/css/페이지명.css"> --%>

<%-- Bootstrap Icons (사용하는 페이지에서만 불러오기, 나머지 삭제) --%>
<%-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"> --%>

<title>Honey T</title>
	
</head>
<body>
<!-- 콘텐츠 영역 -->
<div id="wrap">
	<!-- 3.헤더 영역 -->
	<jsp:include page="/WEB-INF/views/common/modal.jsp" />
	<jsp:include page="/WEB-INF/views/common/header.jsp" />


	<!-- 4.메인 콘텐츠 -->
	<main>
		<!-- 페이지 내용 -->
		${cursor }
		
		
	</main> <!-- /메인 콘텐츠 -->


	<!-- 5. 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
		
</div> <!-- /콘텐츠 영역 -->

<!-- 6. 스크립트 로딩 순서 -->
<!-- 6-1. 공통 스크립트 (jQuery 포함) -->
<jsp:include page="/WEB-INF/views/common/scripts.jsp" />
<!-- 6-2. API/AJAX 설정 (필요한 경우만) -->
<!-- 6-3. 페이지별 스크립트 -->
<%-- <script src="${path}/resources/js/-"></script> --%>
	
</body>
</html>