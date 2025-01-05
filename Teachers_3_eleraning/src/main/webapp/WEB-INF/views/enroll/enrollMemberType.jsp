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
	
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
.option {
  display: inline-block;
  text-align: center;
  margin: 10px;
  border: 2px solid transparent;
  border-radius: 10px;
  padding: 10px;
  transition: border-color 0.3s;
}

.option img {
  display: block;
  margin: 0 auto;
}

/* 선택된 라벨 강조 */
.option input:checked + img {
  border: 2px solid #007bff;
  border-radius: 10px;
}
</style>
	
</head>
<body>
<!-- 콘텐츠 영역 -->
<div id="wrap">

<!-- 메인 콘텐츠 -->
<main class="main">
	<div class="main-container">

		<!-- 콘텐츠 영역 -->
		<div class="main-content">

			<div class="menu">
				<div class="logo-container">
					<img alt="로고" src="${path}/resources/images/common/HoneyT_logo_square.png" style="width: 50px;">
					<span class="logo-text">HONEY T</span> 
					<img alt="로고" src="${path}/resources/images/common/HoneyT_logo_square.png" style="width: 50px;">
				</div>
			</div>
			
			<div id="bodycontainer">
				<div class="logocenter"></div>

				<div class="question">학생/교사 선택해주세요 :)</div>
				<form name="memberForm" action="${path}/enroll/form"
					method="post">
					<div class="options">
						<label class="option">
							<input type="radio" name="memberType" value="1" required hidden> 
							<img alt="학생 꿀벌" src="${path}/resources/images/elements/student.png" style="width: 150px;">
							학생
						</label> 
						<label class="option">
							<input type="radio" name="memberType" value="2" required hidden> 
							<img alt="교사 꿀벌" src="${path}/resources/images/elements/teacher.png" style="width: 150px;">
							교사
						</label>
					</div>

					<button type="submit">가입하기</button>
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