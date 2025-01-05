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
	<link rel="icon" href="${path }/resources/images/favicon.jpeg">
	<title>HONEY T</title>
	
	<link rel="stylesheet" href="${path }/resources/css/enroll/termsofservice.css">
    <!-- 5. 외부 라이브러리 ex: jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<!-- 콘텐츠 영역 -->
<div id="wrap">
<!-- 메인 콘텐츠 -->
<main class="main">
	<div id="logincheck-main-container">
		<!-- 콘텐츠 영역 -->
		<div class="main-content">
			<section class="row main-section">
				<!-- 섹션 1 -->
				<div id="logincheck-inner-container">
					<div id="logincheck-inner-header">
						<img class="logo-container" src="${path}/resources/images/favicon.jpeg" style="width:60px; height:60px;">
						<p id="login-font">회원 동의 약관</p>
						<img class="logo-container" src="${path}/resources/images/favicon.jpeg" style="width:60px; height:60px;">
					</div>
					<div id="check-line1">
						<p>이용약관 동의</p><p class="login-mustcheck">(필수)</p>
						<input type="checkbox">
					</div>
					<div id="check-content">
						<div id="check-contentbox">
							<!-- 2. 이용약관 영역 -->
							<jsp:include page="/WEB-INF/views/enroll/termsofserviceText1.jsp" />
						</div>
					</div>	
					<div id="check-line2">
						<p>개인정보 처리방침 동의</p><p class="login-mustcheck">(필수)</p>
						<input type="checkbox">
					</div>
					<div id="check-content2">
						<div id="check-contentbox2">
							<!-- 2. 개인정보 처리방침 영역 -->
							<jsp:include page="/WEB-INF/views/enroll/termsofserviceText2.jsp" />
						</div>
					</div>	
					<div id="check-line3">
						<p>광고성 정보 수신 동의</p>
						<input type="checkbox">
					</div>
					<div id="check-content3">
						<div id="check-contentbox3">
							<!-- 3. 개인정보 처리방침 영역 -->
							<jsp:include page="/WEB-INF/views/enroll/termsofserviceText3.jsp" />
						</div>
					</div>
				</div>
				<div id="agree-button">
				<div id="canclediv">
					<input type="reset" id="cancle" style="cursor: pointer; height:50px; border:none;" value="메인으로">
				</div>
				<div id="joindiv">
					<input type="submit" id="join" value="회원가입">
				</div>
			</div>
			</section>
		</div>
	</div>
</main>
<script>
//서블릿에서 유효성 검사 후 알람 띄우기
	<c:if test="${errorMessage != null}">
		alert('${errorMessage}');
	</c:if>
	//메인으로 버튼 클릭시 메인페이지로 이동
	$("#cancle").click(function() {
		location.assign("${path}/home");
	});
	//로고 버튼 클릭시 메인페이지로 이동
	$(".logo-container").click(function() {
		location.assign("${path}");
	});
	//회원가입 버튼 클릭시 회원정보입력페이지로 이동
	$("#join").click(function() {
		location.assign("${path}/member/enrollmain");
	});
</script>
<!-- 푸터 include -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<!-- wrap 태그 종료 -->
</div>

<!-- 8. 공통 JavaScript -->
<!-- 9. API/Ajax 관련 JavaScript -->
<!-- 10. 컴포넌트 JavaScript -->
<!-- 11. 페이지별 JavaScript -->
</body>
</html>