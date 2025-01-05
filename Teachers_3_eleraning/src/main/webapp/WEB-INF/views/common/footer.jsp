<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>


<style>
body {
    min-height: 100vh; /* 최소 높이를 뷰포트 높이로 설정 */
    display: flex;
    flex-direction: column;
}

footer {
    width: 100%;
    margin-top: auto; /* 컨텐츠가 적을 때 아래로 밀어줌 */
    padding: 20px;
    text-align: center;
    font-size: 14px;
    background-color: #fff;
    border-top: 1px solid #eee;
}

footer p {
    margin: 0;
}
</style>

<footer>
	<div id="main-footer">
		<p>© 2025 HONEY T | 이용 약관 | 개인정보 보호 정책 | 청소년 보호 정책</p>
	</div>
</footer>