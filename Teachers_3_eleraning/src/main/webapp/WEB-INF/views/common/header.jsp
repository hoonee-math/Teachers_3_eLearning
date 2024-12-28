<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!-- 헤더 -->
<header class="header-container">
	<!-- 광고 배너 -->
	<div id="bannerContainer"></div>

	<!-- 유틸리티 네비게이션 -->
	<div class="utility-nav">
		<div class="utility-container">
			<div class="left-links">
				<a href="#">블로그</a> <a href="#">공지사항</a> <a href="#">이벤트</a>
			</div>
			<div class="right-links">
				<button class="btn-link" onclick="showModal('login')">로그인</button>
				<a href="#">회원가입</a> <a href="#">고객센터</a>
			</div>
		</div>
	</div>

	<!-- 메인 네비게이션 -->
	<div class="main-nav">
		<div class="nav-container">
			<div class="logo">
				<img
					src="${pageContext.request.contextPath }/resources/images/common/HoneyT_logo_horizontal.png"
					alt="로고" style="margin-top: 8px;">
			</div>
			<span class="grade-wrapper">
				<button class="grade-btn" id="gradeBtn">고1</button>
				<div class="grade-dropdown" id="gradeDropdown">
					<a href="#" class="menu-item" data-grade="고1">고1</a> <a href="#"
						class="menu-item" data-grade="고2">고2</a> <a href="#"
						class="menu-item" data-grade="고3/N수">고3/N수</a>
				</div>
			</span>
			<nav class="sub-nav" id="subNav"></nav>
		</div>
	</div>

	<!-- 메가메뉴 -->
	<div class="mega-menu-container" id="teacherMegaMenu">
		<div class="mega-menu-content">
			<div class="mega-menu-subject-group">
				<div class="mega-menu-subject-title">국어</div>
				<div class="mega-menu-teacher-list">
					<a href="#" class="mega-menu-teacher-item">최영주</a> <a href="#"
						class="mega-menu-teacher-item">김현아</a> <a href="#"
						class="mega-menu-teacher-item">손경화 <span
						class="mega-menu-teacher-badge">HOT</span></a>
				</div>
			</div>
			<div class="mega-menu-subject-group">
				<div class="mega-menu-subject-title">수학</div>
				<div class="mega-menu-teacher-list">
					<a href="#" class="mega-menu-teacher-item">박정은</a> <a href="#"
						class="mega-menu-teacher-item">윤송실</a> <a href="#"
						class="mega-menu-teacher-item">김승겸</a>
				</div>
			</div>
		</div>
	</div>

	<div class="mega-menu-container" id="courseMegaMenu">
		<div class="mega-menu-content">
			<div class="mega-menu-subject-group">
				<div class="mega-menu-subject-title">국어</div>
				<div class="mega-menu-teacher-list">
					<a href="#" class="mega-menu-teacher-item">문학 기초</a> <a href="#"
						class="mega-menu-teacher-item">독서 심화</a> <a href="#"
						class="mega-menu-teacher-item">화법과 작문 <span
						class="mega-menu-teacher-badge">NEW</span></a>
				</div>
			</div>
			<div class="mega-menu-subject-group">
				<div class="mega-menu-subject-title">수학</div>
				<div class="mega-menu-teacher-list">
					<a href="#" class="mega-menu-teacher-item">수1 개념완성</a> <a href="#"
						class="mega-menu-teacher-item">수2 문제풀이</a> <a href="#"
						class="mega-menu-teacher-item">확률과 통계 <span
						class="mega-menu-teacher-badge">HOT</span></a>
				</div>
			</div>
		</div>
	</div>
</header>