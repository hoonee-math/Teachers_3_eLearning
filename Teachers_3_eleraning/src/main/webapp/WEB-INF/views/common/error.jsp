<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/common/head.jsp" />
<title>Error | Honey T</title>
<style>
.error-container {
    max-width: 600px;
    margin: 100px auto;
    padding: 40px;
    text-align: center;
    background: white;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.error-icon {
    font-size: 64px;
    color: #FAB350;
    margin-bottom: 20px;
}

.error-title {
    font-size: 24px;
    color: #333;
    margin-bottom: 20px;
}

.error-code {
    background: #f8f9fa;
    padding: 10px 20px;
    border-radius: 5px;
    color: #666;
    font-family: monospace;
    margin: 20px 0;
    display: inline-block;
}

.error-message {
    color: #666;
    margin-bottom: 30px;
    line-height: 1.6;
}

.timer {
    font-size: 20px;
    color: #FAB350;
    margin: 20px 0;
    font-weight: bold;
}

.error-buttons {
    display: flex;
    gap: 10px;
    justify-content: center;
}

.error-btn {
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-weight: bold;
    transition: all 0.3s ease;
}

.error-btn.primary {
    background: #FAB350;
    color: white;
}

.error-btn.secondary {
    background: #f8f9fa;
    color: #333;
    border: 1px solid #ddd;
}

.error-btn:hover {
    transform: translateY(-2px);
}
</style>
</head>
<body>
<div id="wrap">
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <main>
        <div class="error-container">
            <i class="bi bi-exclamation-circle error-icon"></i>
            <h1 class="error-title">문제가 발생했습니다</h1>
            
            <div class="error-code">
                에러 코드: ${pageContext.errorData.statusCode}
            </div>
            
            <p class="error-message">
                죄송합니다. 문제가 발생했습니다.<br>
                잠시 후 이전 페이지로 자동 이동합니다.<br>
                문제가 지속되면 관리자에게 문의해주세요.
            </p>

            <div class="timer" id="countdown">5</div>

            <div class="error-buttons">
                <button onclick="goBack()" class="error-btn primary">이전 페이지로</button>
                <button onclick="stopTimer()" class="error-btn secondary">페이지 머물기</button>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</div>

<script>
let timeLeft = 5;
let timerId = null;

function startTimer() {
    timerId = setInterval(() => {
        timeLeft--;
        document.getElementById('countdown').textContent = timeLeft;
        
        if (timeLeft <= 0) {
            clearInterval(timerId);
            goBack();
        }
    }, 1000);
}

function stopTimer() {
    if (timerId) {
        clearInterval(timerId);
        document.getElementById('countdown').textContent = '중지됨';
    }
}

function goBack() {
    window.history.back();
}

// 타이머 시작
startTimer();
</script>

</body>
</html>