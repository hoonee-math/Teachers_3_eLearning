<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 인증번호 입력을 위한 팝업 창 페이지로, 인증 성공 시 부모창의 이메일 입력란을 readonly로 변경 -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>이메일 인증</title>
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.min.js"></script>
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
    		<input type="hidden" name="authType" value="signup">
            <input type="text" name="authCode" id="authCode" placeholder="인증번호 입력">
            <input type="submit" value="확인">
        </form>
        
        <c:if test="${result != null}">
            <c:choose>
                <c:when test="${result}">
                    <p class="message" style="color:green">인증이 완료되었습니다.</p>
                    <button type="button" onclick="closeVerifyWindow()">닫기</button>
                </c:when>
                <c:otherwise>
                    <p class="message" style="color:red">인증번호가 일치하지 않습니다.</p>
                </c:otherwise>
            </c:choose>
        </c:if>
    </div>

     <script>
     function closeVerifyWindow() {
 	    try {
	        // 부모 창의 요소들에 접근
	        const parentEmail = opener.document.getElementById("emailId");
	        const parentDomain = opener.document.getElementById("emailDomain");
	        const parentSelect = opener.document.getElementById("emailSelect");
	        const emailBtn = opener.document.querySelector("input[value='이메일 인증']");
	        
	        // 이메일 입력란 읽기전용 및 비활성화
	        parentEmail.readOnly = true;
	        parentDomain.readOnly = true;
	        parentSelect.disabled = true;  // readOnly 대신 disabled 사용
	        
	        // 스타일 적용
	        const disabledColor = "#f0f0f0";
	        parentEmail.style.backgroundColor = disabledColor;
	        parentDomain.style.backgroundColor = disabledColor;
	        
	        // 이메일 인증 버튼 비활성화
	        if(emailBtn) {
	            emailBtn.disabled = true;
	            emailBtn.style.backgroundColor = disabledColor;
	        }
	        
	        // hidden input 처리 - 중복 방지
	        const existingHidden = opener.document.querySelector("input[name='emailVerified']");
	        if (!existingHidden) {
	            const hiddenInput = opener.document.createElement("input");
	            hiddenInput.type = "hidden";
	            hiddenInput.name = "emailVerified";
	            hiddenInput.value = "Y";
	            opener.document.forms[0].appendChild(hiddenInput);
	        }
	        
	        window.close();
	    } catch (error) {
	        console.error("이메일 인증 창 닫기 중 오류 발생:", error);
	        alert("창을 닫는 중 오류가 발생했습니다.");
	    }
   	}
    </script> 
</body>
</html>