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
<!-- 1. 공통 head 요소/공통 CSS 포함 -->
<jsp:include page="/WEB-INF/views/common/head.jsp" />
<title>Honey T</title>
</head>

<body>

<!-- 콘텐츠 영역 -->
<div id="wrap">
<!-- 헤더 include -->
<jsp:include page="/WEB-INF/views/common/modal.jsp" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
	
<!-- 현페이지의 css 코드 -->
<style>
    #find-main-container {
		display : flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		min-height: 90vh;
		padding: 20px;
	}
	#find-container{
		cursor: pointer;
	}
	#find-content {
		display: flex;
		flex-direction: column;
		gap:10px;
		width: 100%;
	}
    
    #find-content {
    	height:550px;
	    width: 610px;
        border: 1px solid #ddd;
        border-radius: 20px;
        background-color: #fff;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    #find-tab {
    	display: flex;
        border-bottom: 1px solid #ddd;
    }
    #find-tab>div {
    	width: 305px;
    	display : flex;
		align-items: center;
		justify-content: center;
    }
    #find-pw {
        flex: 1;
        padding: 20px;
        text-align: center;
        cursor: pointer;
        font-size: 14px;
        background-color: #f9f9f9;
        color: #6f6f6f;
    }
    #find-pw {
	    background-color: #FAB350;
        border-bottom: 2px solid #fff6c2;
        font-weight: bold;
        border-radius: 20px 20px 0 0;
    }
    
    #input-info {
        text-align: center;
        font-size: 14px;
        color: #666;
        height: 300px;
        margin-top: 50px;
    }
    #password_,
    #password_2 {
    	width: 300px;
    	border: 1px solid #cccccc;
    	border-radius: 5px;
    	padding: 10px;
    	margin-bottom: 20px;
    }
    #pw-update {
        margin-top: 20px;
        padding: 10px 20px;
        background-color: #FAB350;
        color: #6f6f6f;
        border: 1px solid #cccccc;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
    }
</style>
	
	
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
	<div id="main-content">
			<section class="row main-section">
				<!-- 섹션 1 -->
				<form id="find-form">
				<div id="find-content">
					<div id="find-tab">
						<div id="find-pw">비밀번호 변경</div>
					</div>
					<div id="input-info">
						<div><img src="${path}/resources/images/common/HoneyT_logo_vertical.png" style="width:100px; height:100px; margin-bottom:30px;"></div>
						<h3>비밀번호와 비밀번호확인을 입력하여 주세요.</h3>
						<br>
						<input type="password" id="password_" placeholder="비밀번호">
						<br>
						<input type="password" id="password_2" placeholder="비밀번호 확인">
						<br>
						<button type="submit" id="pw-update">저장</button>
					</div>
				</div>
				</form>
			</section>
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

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- 8. 공통 JavaScript -->
<script src="${path}/resources/js/common/utils.js"></script>
<!-- 9. API/Ajax 관련 JavaScript -->
<!-- 10. 컴포넌트 JavaScript -->
<script src="${path}/resources/js/components/modal.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/enroll/enrollForm.js"></script>

<!-- 11. 페이지별 JavaScript -->
<%-- <script src="path/resources/js/-"></script> --%>



</body>

</html>