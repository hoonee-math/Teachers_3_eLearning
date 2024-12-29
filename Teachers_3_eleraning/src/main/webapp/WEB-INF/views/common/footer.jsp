<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>


<style>
footer {
	margin-top: 40px;
	padding: 40px 0;
	background-color: #f8f9fa;
	border-top: 1px solid #e1e1e1;
}

#main-footer {
	max-width: 1200px;
	margin: 0 auto;
	padding: 0 20px;
}
</style>

<footer>
	<div id="main-footer"></div>
</footer>