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
	<%-- <link rel="stylesheet" href="path/resources/css/-"> --%>
	
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
<div class="sections-wrapper">
<section id="layout-section-1">
<!-- 페이지 내용 -->
<!-- 메인 콘텐츠 -->
<div>
	<!-- 왼쪽 공백 -->
	<div class="content-box" style="border:none;">
	</div>
	
	<!-- 메인 콘텐츠 -->
	<div class="content-box" style="min-width:500px">
		<!-- ID/PW 찾기 타이틀 영영 -->
		<div style="display:flex; justify-content:space-between;">
			<div><h3>아이디/비밀번호 찾기</h3></div>
			<div style="margin-top:5px; font-size:small; right:0">HOME > 내정보 > 아이디/비밀번호 찾기</div>
		</div>
		
		<!-- ID/PW 찾기 선택 영역 -->
		<div style="display:flex; justify-content:space-between;">
			<div style="width:50%; text-align: center;">아이디 찾기</div>
			<div style="width:50%; text-align: center;">비밀번호 찾기</div>
		</div>
		
		<!-- ID/PW 찾기 사용자 휴대폰번호 or 이메일 입력 영역 -->
		<div style="display:flex; flex-direction: column;">
			<p>가입 시 등록한 <strong>휴대폰 번호</strong>로 아이디를 찾을 수 있습니다.</p>
			<div>
				<div style="margin-left:auto;">
					<label>이름</label>
					<input type="text" id="memberName" name="memberName">
				</div>
				<div style="margin-left:auto;">
					<label>휴대폰</label>
					<input type="text" id="phone" name="phone">
				</div>
			</div>
		</div>
	</div>
	
	<!-- 오른쪽 공백 -->
	<div class="content-box" style="border:none;">
	</div>
</div>
</section>
</div>
</main>
	
	
	
	
	
<!-- 푸터 include -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<!-- 콘텐츠 영역 종료 -->
</div>





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
<%-- <script src="path/resources/js/-"></script> --%>


</body>

</html>