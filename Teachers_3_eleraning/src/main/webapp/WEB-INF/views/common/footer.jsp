<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>


<style>
/* footer 스타일 */
footer {
    width: 100%;
    padding: 20px 0;
    margin-top: auto; /* 컨텐츠가 적을 때 하단에 고정 */
    background-color: #fffadd;
    border-top: 1px solid #eee;
    text-align: center;
    font-size: 14px;
    color: #6f6f6f;
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