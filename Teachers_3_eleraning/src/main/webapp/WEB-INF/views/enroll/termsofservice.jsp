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
	
	<link rel="stylesheet" href="${path}/resources/css/enroll/enrollHeader.css">
	<link rel="stylesheet" href="${path}/resources/css/enroll/enrollLayout.css">
	<link rel="stylesheet" href="${path }/resources/css/enroll/termsofservice.css">
    <!-- 5. 외부 라이브러리 ex: jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
    body {
    	margin: 0;
    }
    #logincheck-main-container {
		display : flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		height: 970px;
		padding: 20px;
	}
	.main-content {
		margin-top:0px;
		background: #fff;
	    padding: 0px 30px;
	    border-radius: 30px;
	    box-shadow: 0 8px 12px rgba(0, 0, 0, 0.3);
	    width: 550px;
	    height : 450px;
/* 	} */
	#login-font {
	    font-size: 2em;
	    color: #333;
	    text-align: center;
	    font-weight: bold;
	}
	.check-line  {
		margin-top:10px;
		display:flex;
	}
	.check-content {
		display:flex;
		justify-content:center;
	}
	.check-contentbox {
		overflow:auto;
		min-width: 500px;
		width:100%;
	    color: #6f6f6f;
	    font-size: 12px;
		max-height : 130px;
		border : 1px solid grey;
		border-radius : 3px;
		text-align: left;
		margin: 0;
		padding: 0;
	}
    .check-contentbox::before,
    .check-contentbox::after {
      content: "";
      display: block;
      height: 0;
    }
	#login-next {
		margin-top : 30px;
		background-color : #fffadd;
		color : #cccccc;
		border:none;
		padding:12px;
		width: 90px;
	}
	.login-mustcheck {
		color : red;
	}
	.main-section {
		display: flex;
		flex-direction: column;
	}
	#agree-button {
		display: flex;
		justify-content: center;
		margin-top: 20px;
		padding: 20px;
		gap: 30px;
	}
	#logincheck-inner-header {
		display:flex;
		justify-content: center;
		align-items:center;
		gap:30px;
	}
	#join {
	    cursor: pointer;
	    height: 50px;
	    background-color: #fffadd;
	    border: none;
	    padding: 10px 20px;
	    font-size: 16px;
	    color: #222;
	    border-radius: 5px;
	}
	#cancle {
		cursor: pointer;
	    height: 50px;
	    background-color: #grey;
	    border: none;
	    padding: 10px 20px;
	    font-size: 16px;
	    color: #cccccc;
	    border-radius: 5px;
	}
	#cancle:hover {
		background-color: #cccccc;
		color: #6f6f6f;
	}

	#join:hover {
	    background-color: #fff6c2;
	}
    </style>
</head>
<body>
<!-- 콘텐츠 영역 -->
<div id="wrap">
<!-- 헤더 영역 -->
<header>
<div class="menu">
	<div class="logo-container">
		<img class="logo-container" src="${path}/resources/images/common/HoneyT_Text_font_Oduba_warning.png" style="width:100px;">
	</div>
</div>
</header>
<!-- 메인 콘텐츠 -->
<main class="main">
	<div id="logincheck-main-container">
		<!-- 콘텐츠 영역 -->
		<div class="main-content">
			<section class="row main-section">
			<form action="${path}/enroll/type" method="post">
				<!-- 섹션 1 -->
				<div id="logincheck-inner-container">
					<div id="logincheck-inner-header">
						<img class="logo-container" src="${path}/resources/images/common/HoneyT_logo_square.png" style="width:40px;">
						<p id="login-font">회원 이용 약관</p>
						<img class="logo-container" src="${path}/resources/images/common/HoneyT_logo_square.png" style="width:40px;">
					</div>
					<div class="check-line">
						<p>이용약관 동의</p><p class="login-mustcheck">(필수)</p>
						<input type="checkbox" name="checked1">
					</div>
					<div class="check-content">
						<div class="check-contentbox">
							<!-- 2. 이용약관 영역 -->
							<jsp:include page="/WEB-INF/views/enroll/termsofserviceText1.jsp" />
						</div>
					</div>	
					<div class="check-line">
						<p>개인정보 처리방침 동의</p><p class="login-mustcheck">(필수)</p>
						<input type="checkbox" name="checked2">
					</div>
					<div class="check-content">
						<div class="check-contentbox">
							<!-- 2. 개인정보 처리방침 영역 -->
							<jsp:include page="/WEB-INF/views/enroll/termsofserviceText2.jsp" />
						</div>
					</div>	
					<div class="check-line">
						<p>광고성 정보 수신 동의</p>
						<input type="checkbox" name="checked3">
					</div>
					<div class="check-content">
						<div class="check-contentbox">
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
			</form>
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
		location.assign("${path}");
	});
	//로고 버튼 클릭시 메인페이지로 이동
	$(".logo-container").click(function() {
		location.assign("${path}");
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