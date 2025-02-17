<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ page import="com.google.gson.Gson" %>
<!-- 메가메뉴 데이터 전달을 위한 스크립트 추가 -->
<%
    Gson gson = new Gson();
    String teachersJson = gson.toJson(request.getAttribute("megaMenuTeachers"));
    String subjectsJson = gson.toJson(request.getAttribute("megaMenuSubjects"));
%>
<script>
    const megaMenuTeachers = <%= teachersJson != null ? teachersJson : "[]" %>;
    const megaMenuSubjects = <%= subjectsJson != null ? subjectsJson : "[]" %>;
</script>

<!-- 헤더 -->
<header class="header-container">

	<!-- 반응형 디자인의 핵심! 반응형 헤더를 추가 -->
	<div class="mobile-btn-section" >
		<button class="mobile-menu-btn">
			<i class="bi bi-list"></i>
		</button>
        <div class="logo mobile-logo">
            <a href="${pageContext.request.contextPath}">
                <img src="${pageContext.request.contextPath}/resources/images/common/HoneyT_logo_horizontal.png" alt="로고">
            </a>
        </div>
		<button class="mobile-user-btn">
			<i class="bi bi-person"></i>
		</button>
	</div>
	
	<c:if test="${not empty loginMember}">
		<input type="hidden" id="loginMemberGrade" value="${loginMember.grade}" />
	</c:if>
	<!-- 광고 배너 -->
	<div id="bannerContainer"></div>

	<!-- 모바일 메뉴 추가 -->
	<div class="slide-menu">
		<!-- 모바일 메뉴 내용 -->
		<div class="mobile-menu-content">
			<!-- 로그인 전 -->
			<c:if test="${empty sessionScope.loginMember}">
				<div class="mobile-auth">
					<button onclick="Modal.show('login')">로그인</button>
					<a href="${path}/enroll/termsofservice">회원가입</a>
				</div>
			</c:if>

			<!-- 로그인 후 -->
			<c:if test="${not empty sessionScope.loginMember}">
				<div class="mobile-user-info">
					<span>${sessionScope.loginMember.memberName}님</span>
					<button onclick="logout()">로그아웃</button>
				</div>
			</c:if>

			<!-- 메뉴 항목들 -->
			<nav class="mobile-nav">
				<!-- 기존 메뉴 항목들을 여기에 복제 -->
			</nav>
		</div>
	</div>

	<!-- 유틸리티 네비게이션 -->
	<div class="utility-nav">
		<div class="utility-container">
			<div class="left-links">
				<a href="https://hoonee-math.github.io/web/">블로그</a>
				<a href="${path }/teacher/list_and_detail">공지사항</a>
				<a href="#">이벤트</a>
			</div>
			
			<%-- 로그인 전 메뉴 --%>
			<c:if test="${empty sessionScope.loginMember}">
				<div class="right-links">
					<button class="btn-link" onclick="Modal.show('login')">로그인</button>
					<a href="${path }/enroll/termsofservice">회원가입</a>
					<a href="${path }">고객센터</a>
				</div>
			</c:if>
				
			<%-- 로그인 후 메뉴 --%>
			<c:if test="${not empty sessionScope.loginMember}">
				<div class="right-links">
					<span class="welcome-msg">${sessionScope.loginMember.memberName}님 환영합니다</span>
					
				    <c:if test="${not empty loginMember}">
						<c:if test="${sessionScope.loginMember.memberType == 0}">
							<a href="${path}/admin/menu">관리자페이지</a>
						</c:if>
						<c:if test="${sessionScope.loginMember.memberType == 1}">
							<a href="${path}/member/student/mypage/menu">마이페이지</a>
						</c:if>
						<c:if test="${sessionScope.loginMember.memberType == 2}">
							<a href="${path}/member/teacher/mypage/menu">교사페이지</a>
						</c:if>
				    </c:if>
				    
					<a href="${path}/cart">장바구니</a>
					<button class="btn-link" onclick="logout()">로그아웃</button>
					<a href="#">고객센터</a>
				</div>
			</c:if>
		</div>
	</div>

	<!-- 메인 네비게이션 -->
	<div class="main-nav">
		<div class="nav-container">
			<div class="logo">
				<a href="${pageContext.request.contextPath }">
				<img src="${pageContext.request.contextPath }/resources/images/common/HoneyT_logo_horizontal.png" alt="로고">
				</a>
			</div>
			<span class="grade-wrapper">
				<!-- 로그인 정보에 따른 초기 학년 표시 -->
				<button class="grade-btn" id="gradeBtn">
					${empty loginMember ? '고1' : '고'.concat(loginMember.grade)}
				</button>
				<div class="grade-dropdown" id="gradeDropdown">
					<!-- URL 정보 추가 -->
					<a href="#" class="menu-item" data-grade="고1" data-url="${path}/grade/high1">고1</a>
					<a href="#" class="menu-item" data-grade="고2" data-url="${path}/grade/high2">고2</a>
					<a href="#" class="menu-item" data-grade="고3/N수" data-url="${path}/grade/high3">고3/N수</a>
				</div>
			</span>
			<nav class="sub-nav" id="subNav"></nav>
		</div>
	</div>

	<!-- 메가메뉴 -->
	<div class="mega-menu-container" id="teacherMegaMenu">
		<div class="mega-menu-content" id="teacherMegaMenuContent">
			<!-- 여기는 JavaScript로 동적 생성 -->
		</div>
	</div>

	<div class="mega-menu-container" id="courseMegaMenu">
		<div class="mega-menu-content" id="courseMegaMenuContent">
			<!-- 여기는 JavaScript로 동적 생성 -->
		</div>
	</div>
</header>