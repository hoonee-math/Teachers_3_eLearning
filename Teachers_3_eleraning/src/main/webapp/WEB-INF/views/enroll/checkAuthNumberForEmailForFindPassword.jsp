<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 인증번호 입력을 위한 팝업 창 페이지로, 인증 성공 시 부모창의 이메일 입력란을 readonly로 변경 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 인증</title>
<script
	src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.min.js"></script>
<style>
#verify-container {
	text-align: center;
	padding: 20px;
}

.message {
	margin: 10px 0;
	font-size: 14px;
}
</style>
</head>
<body>
	<div id="verify-container">
		<form action="${pageContext.request.contextPath}/auth/verify" method="post">
			<input type="hidden" name="email" value="${param.email}"> 
    		<input type="hidden" name="authType" value="reset">
			<input type="text" name="authCode" id="authCode" placeholder="인증번호 입력">
			<input type="submit" value="확인">
		</form>

		<c:if test="${result != null}">
			<c:choose>
				<c:when test="${result}">
					<p class="message" style="color: green">인증이 완료되었습니다.</p>
					<button type="button" onclick="closeVerifyWindow()">닫기</button>
				</c:when>
				<c:otherwise>
					<p class="message" style="color: red">인증번호가 일치하지 않습니다.</p>
				</c:otherwise>
			</c:choose>
		</c:if>
	</div>

	<script>
	function closeVerifyWindow() {
	    try {
	    	// 세션에 인증 완료 상태 저장을 위한 요청
	        $.ajax({
	            url: '${pageContext.request.contextPath}/auth/complete',
	            method: 'POST',
	            data: {
	                email: '${param.email}',
	                isPasswordReset: true
	            },
	            success: function(data) {
	                if(data.success) {
	                    opener.location.href = '${pageContext.request.contextPath}/member/resetpassword.do';
	                    window.close();
	                } else {
	                    alert('인증 처리 중 오류가 발생했습니다.');
	                }
	            },
	            error: function(xhr, status, error) {
	                console.error('인증 처리 중 오류 발생:', error);
	                alert('인증 처리 중 오류가 발생했습니다.');
	            }
	        });
	    } catch (error) {
	        console.error("창 닫기 중 오류 발생:", error);
	        alert("창을 닫는 중 오류가 발생했습니다.");
	    }
	}
    </script>
</body>
</html>