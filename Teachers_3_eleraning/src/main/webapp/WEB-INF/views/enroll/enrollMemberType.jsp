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
	<title>HONEY Y</title>

	<link rel="stylesheet" href="${path}/resources/css/common/reset.css">
	<link rel="stylesheet" href="${path}/resources/css/enroll/enrollLayout.css">
	<link rel="stylesheet" href="${path}/resources/css/enroll/enrollHeader.css">
	<link rel="stylesheet" href="${path}/resources/css/enroll/enrollMemberType.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	
</head>
<body>
<!-- 콘텐츠 영역 -->
<div id="wrap">
<!-- 3.헤더 영역 -->
<header>
<div class="menu">
	<div class="logo-container">
		<img class="logo-container" src="${path}/resources/images/common/HoneyT_Text_font_Oduba_warning.png" style="width:100px;">
	</div>
</div>
</header>
<!-- 메인 콘텐츠 -->
<main class="main">
	<div class="main-container">

		<!-- 콘텐츠 영역 -->
		<div class="main-content">
			<div id="bodycontainer">
				<div class="logocenter"></div>

				<div class="question">학생/교사 선택해주세요 :)</div>
				<form name="memberForm" action="${path}/enroll/form"
					method="post">
					<div class="options">
						<label class="option">
							<input type="radio" name="memberType" value="1" required hidden> 
							<img alt="학생 꿀벌" src="${path}/resources/images/elements/student.png">
							<div class="option-text">학생</div>
						</label> 
						<label class="option">
							<input type="radio" name="memberType" value="2" required hidden> 
							<img alt="교사 꿀벌" src="${path}/resources/images/elements/teacher.png">
							<div class="option-text">교사</div>
						</label>
					</div>

					<button type="submit" class="submit-btn">가입하기</button>
				</form>
			</div> <!-- /.bodycontainer -->
		</div> <!-- /콘텐츠 영역 -->
	</div>
</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</div><!-- .wrap div 태그 종료 -->

<!-- 8. 공통 JavaScript -->
<!-- 9. API/Ajax 관련 JavaScript -->
<!-- 10. 컴포넌트 JavaScript -->
<!-- 11. 페이지별 JavaScript -->
<script>
	const path = "${pageContext.request.contextPath}";
	$(".logo-container").click((e)=>{
		location.assign("${path}");
	})
</script>
</body>
</html>