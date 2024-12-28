<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Honey T</title>
	
    <!-- 2. 외부 CSS 파일들 -->
    <!-- 2-1. Bootstrap CSS (다른 CSS보다 먼저) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 2-2. Bootstrap Icons (필요한 경우) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <!-- 2-3. 직접 제작한 CSS 파일들 (Bootstrap CSS 다음에 위치) -->
    <link rel="stylesheet" href="<c:url value='resources/css/common/reset.css'/>">
    <link rel="stylesheet" href="<c:url value='resources/css/common/layout.css'/>">
    <link rel="stylesheet" href="<c:url value='resources/css/common/utilities.css'/>">

    <!-- 3. 컴포넌트 CSS -->
    <link rel="stylesheet" href="<c:url value='resources/css/components/header.css'/>">
    <link rel="stylesheet" href="<c:url value='resources/css/components/navigation.css'/>">
    <link rel="stylesheet" href="<c:url value='resources/css/components/modal.css'/>">
    <link rel="stylesheet" href="<c:url value='resources/css/components/buttons.css'/>">
    <link rel="stylesheet" href="<c:url value='resources/css/components/cards.css'/>">

    <!-- 4. 페이지별 CSS -->
    <link rel="stylesheet" href="<c:url value='/css/pages/teacher-detail.css'/>">

    <!-- 5. jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	
    <!-- 6. Bootstrap JS (jQuery 다음, 내부 스타일 전에) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- 7. 내부 style 태그 -->
    <style>
        /* 페이지 특정 스타일 */
    </style>
	
</head>
<body>
    <!-- 콘텐츠 영역 -->
    <div id="wrap">
        <!-- 헤더 include -->
        <%-- <jsp:include page="../common/header.jsp" /> --%>
        
        <!-- 메인 콘텐츠 -->
        <main>
            <!-- 페이지 내용 -->
			
        </main>

        <!-- 푸터 include -->
        <%-- <jsp:include page="../common/footer.jsp" /> --%>
    </div>

    <!-- 8. 공통 JavaScript -->
    <script src="<c:url value='resources/js/common/utils.js'/>"></script>
    
    <!-- 9. API/Ajax 관련 JavaScript -->
    <script src="<c:url value='resources/js/api/apiConfig.js'/>"></script>
    <script src="<c:url value='resources/js/api/teacherApi.js'/>"></script>
    <script src="<c:url value='resources/js/api/courseApi.js'/>"></script>

    <!-- 10. 컴포넌트 JavaScript -->
    <script src="<c:url value='resources/js/components/modal.js'/>"></script>
    <script src="<c:url value='resources/js/components/navigation.js'/>"></script>
    <script src="<c:url value='resources/js/components/accordion.js'/>"></script>
    <script src="<c:url value='resources/js/components/tabs.js'/>"></script>

    <!-- 11. 페이지별 JavaScript -->
    <script src="<c:url value='/js/pages/teacher-detail.js'/>"></script>
</body>
</html>