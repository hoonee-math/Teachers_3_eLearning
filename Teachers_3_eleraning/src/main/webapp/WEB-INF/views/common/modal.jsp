<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!-- 모달 -->
<div class="modal-wrapper" id="modalBackdrop">
	<div class="modal-container" id="loginModal">
		<div class="modal-header">
			<h3 class="modal-title">로그인</h3>
		</div>
		<form id="loginForm" action="${path }/auth/login.do" method="post">
			<div class="form-group">
				<input type="text" name="memberId" class="form-input" placeholder="아이디" required> 
				<input type="password" name="memberPw" class="form-input" placeholder="비밀번호" required>
			</div>
			<div class="form-group">
				<label> <input type="checkbox" name="remember" class="form-checkbox"> 로그인 상태 유지 </label>
			</div>
			<div style="text-align: right;">
				<button type="button" class="btn btn-secondary" onclick="Modal.hide()">취소</button>
				<button type="submit" class="btn btn-primary">로그인</button>
			</div>
		</form>
		<div class="modal-footer">
			<a href="${path }/auth/find">아이디 찾기 / 비밀번호 찾기</a> <span>|</span>
			<a href="${path }/enroll/termsofservice">회원가입</a>
		</div>
	</div>
</div>
