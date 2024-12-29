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
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Honey T</title>
	
    <!-- 2. 외부 CSS 파일들 -->
    <!-- 2-1. Bootstrap CSS (다른 CSS보다 먼저) -->
    <!-- 2-2. Bootstrap Icons (필요한 경우) -->
    
    <!-- 2-3. 직접 제작한 CSS 파일들 (Bootstrap CSS 다음에 위치) -->
    <link rel="stylesheet" href="${path}/resources/css/common/reset.css">
    <link rel="stylesheet" href="${path}/resources/css/common/layout.css">
    <link rel="stylesheet" href="${path}/resources/css/common/utilities.css">
    <link rel="stylesheet" href="${path}/resources/css/common/navigator.css">

    <!-- 3. 컴포넌트 CSS -->
    <link rel="stylesheet" href="${path}/resources/css/components/header.css">
    <link rel="stylesheet" href="${path}/resources/css/components/navigation.css">
    <link rel="stylesheet" href="${path}/resources/css/components/modal.css">
    <link rel="stylesheet" href="${path}/resources/css/components/buttons.css">
    <link rel="stylesheet" href="${path}/resources/css/components/cards.css">

    <!-- 4. 페이지별 CSS -->

    <!-- 5. jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	
</head>
<body>    

    <jsp:include page="/WEB-INF/views/common/modal.jsp" />
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <main>
	    <jsp:include page="/WEB-INF/views/common/section.jsp" />
	</main>

    <footer>
	    <style>
			footer {
			    margin-top: 40px;
			    padding: 40px 0;
			    background-color: #f8f9fa;
			    border-top: 1px solid #e1e1e1;
			}
			
			#main-footer {
			    max-width: 1200px;
			    margin: 0 auto;
			    padding: 0 20px;
			}
	    </style>
        <div id="main-footer"></div>
    </footer>
    
    <!-- 8. 공통 JavaScript -->
    <script src="${path}/resources/js/common/utils.js"></script>
    
    <!-- 9. API/Ajax 관련 JavaScript -->
    <script src="${path}/resources/js/api/apiConfig.js"></script>
    <script src="${path}/resources/js/api/teacherApi.js"></script>
    <script src="${path}/resources/js/api/courseApi.js"></script>

    <!-- 10. 컴포넌트 JavaScript -->
    <script src="${path}/resources/js/components/modal.js"></script>
    <script src="${path}/resources/js/components/navigation.js"></script>
    <script src="${path}/resources/js/components/accordion.js"></script>
    <script src="${path}/resources/js/components/tabs.js"></script>

    <!-- 11. 페이지별 JavaScript -->
    <script src="${path}/resources/js/pages/teacherDetail.js"></script>
</body>
</html>