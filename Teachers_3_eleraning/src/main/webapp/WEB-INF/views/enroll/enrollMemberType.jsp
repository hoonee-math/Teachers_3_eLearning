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
	<%-- <link rel="icon" href="${path }/resources/images/favicon.jpeg"> --%>
	<title>HONEY Y</title>
	
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	   
</head>
<body>
<!-- 콘텐츠 영역 -->
<div id="wrap">

<!-- 메인 콘텐츠 -->
<main class="main">
	<div class="main-container">
        
		<!-- 콘텐츠 영역 -->
		<div class="main-content">
			<!-- 섹션 1 -->
			<section class="main-section">
				
			</section>
			
						
			<header>
				<div class="menu">
					<div class="logo-container">
						<img alt="로고" src="${path}/resources/images/common/HoneyT_logo_square.png">
						<span class="logo-text">HONEY T</span>
						<img alt="로고" src="${path}/resources/images/common/HoneyT_logo_square.png">
					</div>
				</div>
			</header>
			<body></body>
			<div id="bodycontainer">
			  <div class="logocenter">
			  </div>
			
			  <div class="question">학생/교사 선택해주세요 :)</div>
			<form name="memberForm" action="${path}/member/enroll" method="post">
			  <div class="options">
			    <div class="option" onclick="selectOption('학생')">학생
						<img alt="학생 꿀벌" src="${path}/resources/images/elements/student.png">
			    </div>
			    <div class="option" onclick="selectOption('교사')">교사
						<img alt="교사 꿀벌" src="${path}/resources/images/elements/teacher.png">
			    </div>
			  </div>
			</form>
			</div>
			</body>
			  <script>
			  $(document).ready(function() {
				    $(".option").click(function() {
				        // 선택된 타입에 따른 값 설정
				        const selectedType = $(this).text() === "학생" ? "1" : "2";
				        
				        // form의 hidden input 초기화 후 추가
				        $("input[name='memberType']").remove();
				        $("form[name='memberForm']").append("<input type='hidden' name='memberType' value='" + selectedType + "'>");
				        $("form[name='memberForm']").submit();
				    });
				});
			  
			  </script>
			<jsp:include page="/WEB-INF/views/common/footer.jsp" />
		</div>
	</div>
</main>

<!-- wrap 태그 종료 -->
</div>

<!-- 8. 공통 JavaScript -->
<!-- 9. API/Ajax 관련 JavaScript -->
<!-- 10. 컴포넌트 JavaScript -->
<!-- 11. 페이지별 JavaScript -->
</body>
</html>