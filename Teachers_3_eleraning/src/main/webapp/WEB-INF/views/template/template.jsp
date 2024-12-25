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
	
    <!-- 2. 공통 CSS -->
    <link rel="stylesheet" href="<c:url value='/css/common/reset.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/common/layout.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/common/utilities.css'/>">

    <!-- 3. 컴포넌트 CSS -->
    <link rel="stylesheet" href="<c:url value='/css/components/header.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/components/navigation.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/components/modal.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/components/buttons.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/components/cards.css'/>">

    <!-- 4. 페이지별 CSS -->
    <link rel="stylesheet" href="<c:url value='/css/pages/teacher-detail.css'/>">

    <!-- 5. 외부 라이브러리 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	
</head>
<body>
    <!-- 콘텐츠 영역 -->
    <div id="wrap">
        <!-- 헤더 include -->
        <jsp:include page="../common/header.jsp" />
        
        <!-- 메인 콘텐츠 -->
        <main>
            <!-- 페이지 내용 -->
			
        </main>

        <!-- 푸터 include -->
        <jsp:include page="../common/footer.jsp" />
    </div>

    <!-- 6. 공통 JavaScript -->
    <script src="<c:url value='/js/common/utils.js'/>"></script>
    
    <!-- 7. API/Ajax 관련 JavaScript -->
    <script src="<c:url value='/js/api/apiConfig.js'/>"></script>
    <script src="<c:url value='/js/api/teacherApi.js'/>"></script>
    <script src="<c:url value='/js/api/courseApi.js'/>"></script>

    <!-- 8. 컴포넌트 JavaScript -->
    <script src="<c:url value='/js/components/modal.js'/>"></script>
    <script src="<c:url value='/js/components/navigation.js'/>"></script>
    <script src="<c:url value='/js/components/accordion.js'/>"></script>
    <script src="<c:url value='/js/components/tabs.js'/>"></script>

    <!-- 9. 페이지별 JavaScript -->
    <script src="<c:url value='/js/pages/teacher-detail.js'/>"></script>
</body>
</html>