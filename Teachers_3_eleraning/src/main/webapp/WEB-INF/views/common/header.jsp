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
				<a href="${path }/lecturelist">블로그</a>
				<a href="${path }/teacherListAndDetail">공지사항</a>
				<a href="#">이벤트</a>
			</div>
			<div class="right-links">
				<button class="btn-link" onclick="showModal('login')">로그인</button>
				<a href="#">회원가입</a>
				<a href="#">고객센터</a>
			</div>
		</div>
	</div>

	<!-- 메인 네비게이션 -->
	<div class="main-nav">
		<div class="nav-container">
			<div class="logo">
				<a href="${pageContext.request.contextPath }">
				<img src="${pageContext.request.contextPath }/resources/images/common/HoneyT_logo_horizontal.png" alt="로고" style="margin-top: 8px;">
				</a>
			</div>
			<span class="grade-wrapper">
				<button class="grade-btn" id="gradeBtn">고1</button>
				<div class="grade-dropdown" id="gradeDropdown">
					<a href="#" class="menu-item" data-grade="고1">고1</a>
					<a href="#" class="menu-item" data-grade="고2">고2</a>
					<a href="#" class="menu-item" data-grade="고3/N수">고3/N수</a>
					<a href="${pageContext.request.contextPath }/lecturelist" class="menu-item" data-grade="고3/N수">lectureList.jsp</a>
					<a href="${pageContext.request.contextPath }/teacherListAndDetail" class="menu-item" data-grade="고3/N수">teacherListAndDetail.jsp</a>
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
					<a href="#" class="mega-menu-teacher-item">최영주</a>
					<a href="#"	class="mega-menu-teacher-item">김현아</a>
					<a href="#" class="mega-menu-teacher-item">손경화<span class="mega-menu-teacher-badge">HOT</span></a>
				</div>
			</div>
			<div class="mega-menu-subject-group">
				<div class="mega-menu-subject-title">수학</div>
				<div class="mega-menu-teacher-list">
					<a href="#" class="mega-menu-teacher-item">박정은</a>
					<a href="#"class="mega-menu-teacher-item">윤송실</a>
					<a href="#" class="mega-menu-teacher-item">김승겸</a>
				</div>
			</div>
		</div>
	</div>

	<div class="mega-menu-container" id="courseMegaMenu">
		<div class="mega-menu-content">
			<div class="mega-menu-subject-group">
				<div class="mega-menu-subject-title">국어</div>
				<div class="mega-menu-teacher-list">
					<a href="#" class="mega-menu-teacher-item">문학 기초</a>
					<a href="#" class="mega-menu-teacher-item">독서 심화</a>
					<a href="#" class="mega-menu-teacher-item">화법과 작문 <span class="mega-menu-teacher-badge">NEW</span></a>
				</div>
			</div>
			<div class="mega-menu-subject-group">
				<div class="mega-menu-subject-title">수학</div>
				<div class="mega-menu-teacher-list">
					<a href="#" class="mega-menu-teacher-item">수1 개념완성</a>
					<a href="#" class="mega-menu-teacher-item">수2 문제풀이</a>
					<a href="#" class="mega-menu-teacher-item">확률과 통계 <span class="mega-menu-teacher-badge">HOT</span></a>
				</div>
			</div>
		</div>
	</div>
	
	<script>
    // JSP가 서버에서 처리될 때 contextPath를 실제 경로로 변환
    const bannerImage = '${pageContext.request.contextPath}/resources/images/커비.jpg';
    console.log('설정된 이미지 경로:', bannerImage); // 경로 확인
    
    // DOM이 로드된 후 배너 이미지 설정
    document.addEventListener('DOMContentLoaded', function() {
        console.log('DOM 로드됨'); // DOM 로드 시점 확인
        
        const bannerContainer = document.getElementById('bannerContainer');
        console.log('배너 컨테이너 요소:', bannerContainer); // 요소 존재 여부 확인
        
        if(bannerContainer) {
            console.log('배너 컨테이너 찾음, 이미지 설정 시도');
            const bannerDiv = document.createElement('div');
            bannerDiv.className = 'banner-area';
            // 템플릿 리터럴 대신 일반 문자열 연결 사용
            bannerDiv.style.backgroundImage = 'url(' + bannerImage + ')';
            console.log('설정된 background-image:', bannerDiv.style.backgroundImage); // 실제 설정된 스타일 확인
            
            bannerContainer.appendChild(bannerDiv);
            console.log('배너 div 추가 완료');
        } else {
            console.log('배너 컨테이너를 찾을 수 없음');
        }
    });
</script>
	
	
</header>