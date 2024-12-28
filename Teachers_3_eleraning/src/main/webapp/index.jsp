<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="contextPath" content="${pageContext.request.contextPath}">
	<title>Honey T</title>
	
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
        /* Reset CSS */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
        }

        /* 공통 스타일 */
        .header-container {
            width: 100%;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        /* 광고 배너 스타일 */
        .banner-area {
            width: 100%;
            height: 60px;
            overflow: hidden;
            background-color: #f8f9fa;
            background-repeat: repeat;
            background-size: auto 100%;
        }

        .banner-area img {
            height: 100%;
            display: block;
            object-fit: fill;
        }

        /* 유틸리티 네비게이션 스타일 */
        .utility-nav {
            background-color: #f8f9fa;
            padding: 8px 0;
            border-bottom: 1px solid #e1e1e1;
        }

        .utility-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }

        .left-links a, .right-links a, .right-links button {
            color: #666;
            font-size: 0.9em;
            margin-right: 15px;
        }

        /* 메인 네비게이션 스타일 */
        .main-nav {
            border-bottom: 1px solid #e1e1e1;
            padding: 15px 0;
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            padding: 0 20px;
        }

        /* 로고 스타일 */
        .logo {
            margin-right: 30px;
        }

        .logo img {
            height: 40px;
            width: auto;
        }

        /* 학년 선택 스타일 */
        .grade-wrapper {
            position: relative;
            width: 200px;
            margin-right: 20px;
        }

        .grade-btn {
            width: 100%;
            padding: 10px 20px;
            background-color: #FAB350;
            color: white;
            border: none;
            border-radius: 4px;
            text-align: left;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 1.1em;
        }

        /* 모달 스타일 */
        .modal-wrapper {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
        }

        .modal-container {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            width: 90%;
            max-width: 400px;
        }

        .modal-header {
            margin-bottom: 20px;
        }

        .modal-title {
            font-size: 1.5em;
            font-weight: bold;
        }

        /* 폼 스타일 */
        .form-group {
            margin-bottom: 15px;
        }

        .form-input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 10px;
        }

        .form-checkbox {
            margin-right: 5px;
        }

        /* 버튼 스타일 */
        .btn {
            padding: 8px 16px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-size: 0.9em;
        }

        .btn-primary {
            background-color: #FAB350;
            color: white;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
            margin-right: 10px;
        }

        .btn-link {
            background: none;
            border: none;
            color: #666;
            padding: 0;
            font: inherit;
            cursor: pointer;
        }

        /* 메가메뉴 스타일 */
        .mega-menu-container {
            display: none;
            position: absolute;
            left: 0;
            width: 100%;
            background: white;
            border-bottom: 1px solid #e1e1e1;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            z-index: 900;
        }

        .mega-menu-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        /* 서브 네비게이션 스타일 */
.sub-nav {
    display: flex;
    gap: 20px;
    flex-grow: 1;
    justify-content: center;
}

.sub-nav .menu-item {
    color: #333;
    padding: 8px 15px;
    border-radius: 4px;
    transition: all 0.2s;
}

.sub-nav .menu-item:hover {
    background-color: #f8f9fa;
}

/* 메가메뉴 상세 스타일 */
.subject-group {
    width: 100%;
}

.subject-title {
    font-weight: bold;
    color: #FAB350;
    margin-bottom: 10px;
    padding-bottom: 5px;
    border-bottom: 2px solid #FAB350;
}

.teacher-list {
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.teacher-item {
    color: #333;
    font-size: 0.9em;
    padding: 4px 0;
}

.teacher-item:hover {
    color: #FAB350;
}

.teacher-badge {
    display: inline-block;
    font-size: 0.8em;
    padding: 2px 6px;
    border-radius: 10px;
    background-color: #f8f9fa;
    margin-left: 5px;
}

/* 드롭다운 스타일 */
.grade-dropdown {
    display: none;
    position: absolute;
    top: 100%;
    left: 0;
    width: 100%;
    background-color: white;
    border: 1px solid #e1e1e1;
    border-radius: 4px;
    margin-top: 5px;
    z-index: 1000;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.grade-btn:after {
    content: '▼';
    font-size: 0.8em;
    margin-left: 10px;
}

.grade-btn.active:after {
    content: '▲';
}

.grade-dropdown .menu-item {
    display: block;
    padding: 12px 20px;
    text-decoration: none;
    color: #333;
    cursor: pointer;
}

.grade-dropdown .menu-item:hover {
    background-color: #f8f9fa;
}

/* 모달 푸터 스타일 */
.modal-footer {
    margin-top: 15px;
    text-align: center;
    padding-top: 15px;
    border-top: 1px solid #eee;
}

.modal-footer a {
    margin: 0 10px;
    color: #666;
}

.modal-footer span {
    color: #ddd;
}

/* 레이아웃 섹션 공통 스타일 */
section {
    padding: 20px 0;
    max-width: 1200px;
    margin: 0 auto;
}

section > div {
    margin-bottom: 40px;
}

/* 섹션 설명 스타일 */
.section-description {
    background-color: #f8f9fa;
    border-left: 4px solid #FAB350;
    padding: 15px;
    margin-bottom: 20px;
    font-size: 0.9em;
    line-height: 1.6;
}

.section-description code {
    background-color: #e9ecef;
    padding: 2px 4px;
    border-radius: 3px;
    font-family: monospace;
}

/* 섹션 1 스타일 */
#layout-section-1 > div {
    display: grid;
    grid-template-columns: 250px 1fr 250px;
    gap: 20px;
    padding: 0 20px;
}

#layout-section-1 .content-box {
    background-color: white;
    border: 1px solid #e1e1e1;
    padding: 20px;
    border-radius: 5px;
    min-height: 200px;
}

/* 섹션 2 스타일 */
#layout-section-2 > div {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 20px;
    padding: 0 20px;
}

#layout-section-2 .info-card {
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    overflow: hidden;
    transition: transform 0.3s ease;
}

#layout-section-2 .info-card:hover {
    transform: translateY(-5px);
}

#layout-section-2 .card-header {
    background-color: #FAB350;
    color: white;
    padding: 15px;
    font-weight: bold;
}

#layout-section-2 .card-body {
    padding: 15px;
}

/* 섹션 3 스타일 */
#layout-section-3 .flex-container {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    padding: 0 20px;
}

#layout-section-3 .flex-item {
    flex: 1;
    min-width: 200px;
    background-color: #f8f9fa;
    padding: 15px;
    border-radius: 5px;
    border: 1px solid #e1e1e1;
}

#layout-section-3 .grid-container {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 10px;
    margin-top: 15px;
}

#layout-section-3 .grid-item {
    background-color: #e9ecef;
    padding: 10px;
    text-align: center;
    border-radius: 3px;
}

/* 강사/강좌 목록 섹션 스타일 */
#teacher-section {
    padding: 20px 0;
    max-width: 1200px;
    margin: 0 auto;
}

.teacher-container {
    display: flex;
    gap: 30px;
    padding: 0 20px;
}

/* 왼쪽 메뉴 스타일 */
.subject-menu {
    width: 200px;
    flex-shrink: 0;
    background-color: #f8f9fa;
    border-radius: 5px;
    overflow: hidden;
}

.subject-menu h2 {
    padding: 15px;
    background-color: #e9ecef;
    margin: 0;
    font-size: 1.2em;
    font-weight: bold;
}

.menu-list {
    list-style: none;
    padding: 0;
    margin: 0;
}

.menu-list li {
    border-bottom: 1px solid #e1e1e1;
}

.menu-list li:last-child {
    border-bottom: none;
}

.menu-list a {
    display: block;
    padding: 12px 15px;
    color: #333;
    text-decoration: none;
    transition: all 0.2s;
}

.menu-list a:hover {
    background-color: #e9ecef;
    color: #FAB350;
}

.menu-list a.active {
    background-color: #FAB350;
    color: white;
}

/* 오른쪽 리스트 스타일 */
.content-list {
    flex-grow: 1;
}

.list-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.list-title {
    font-size: 1.5em;
    font-weight: bold;
}

.sub-category {
    display: flex;
    gap: 10px;
}

.sub-category button {
    padding: 5px 15px;
    border: 1px solid #ddd;
    background-color: white;
    border-radius: 20px;
    cursor: pointer;
    transition: all 0.2s;
}

.sub-category button:hover,
.sub-category button.active {
    background-color: #FAB350;
    color: white;
    border-color: #FAB350;
}

/* 강사/강좌 카드 스타일 */
.teacher-list {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.teacher-card {
    display: flex;
    gap: 20px;
    padding: 20px;
    background-color: white;
    border: 1px solid #e1e1e1;
    border-radius: 8px;
    transition: all 0.2s;
}

.teacher-card:hover {
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.teacher-image {
    width: 120px;
    height: 120px;
    border-radius: 8px;
    overflow: hidden;
    flex-shrink: 0;
}

.teacher-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.teacher-info {
    flex-grow: 1;
}

.teacher-info h3 {
    font-size: 1.2em;
    margin: 0 0 10px 0;
}

.teacher-description {
    color: #666;
    font-size: 0.9em;
    line-height: 1.6;
    margin: 0;
}

.teacher-badge {
    display: inline-block;
    padding: 3px 8px;
    background-color: #e9ecef;
    color: #666;
    border-radius: 4px;
    font-size: 0.8em;
    margin-left: 8px;
}

/* 선생님 상세 페이지 스타일 */
#teacher-detail-section {
    padding: 20px 0;
    max-width: 1200px;
    margin: 0 auto;
}

.teacher-detail-container {
    display: flex;
    gap: 30px;
    padding: 0 20px;
}

/* 아코디언 메뉴 스타일 */
.accordion-menu {
    width: 200px;
    flex-shrink: 0;
    background-color: #f8f9fa;
    border-radius: 5px;
    overflow: hidden;
}

.accordion-item {
    border-bottom: 1px solid #e1e1e1;
}

.accordion-header {
    padding: 12px 15px;
    background-color: #f8f9fa;
    cursor: pointer;
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: bold;
}

.accordion-header:hover {
    background-color: #e9ecef;
}

.accordion-header::after {
    content: '▼';
    font-size: 0.8em;
    transition: transform 0.3s;
}

.accordion-header.active {
    background-color: #FAB350;
    color: white;
}

.accordion-header.active::after {
    transform: rotate(180deg);
}

.accordion-content {
    display: none;
    background-color: white;
}

.accordion-content.show {
    display: block;
}

.accordion-content a {
    display: block;
    padding: 10px 15px 10px 25px;
    color: #666;
    text-decoration: none;
}

.accordion-content a:hover {
    background-color: #f8f9fa;
    color: #FAB350;
}

.accordion-content a.active {
    color: #FAB350;
    font-weight: bold;
}

/* 선생님 상세 정보 스타일 */
.teacher-detail-content {
    flex-grow: 1;
}

.teacher-profile {
    display: flex;
    gap: 30px;
    margin-bottom: 30px;
}

.profile-image {
    width: 200px;
    height: 200px;
    border-radius: 100px;
    overflow: hidden;
}

.profile-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.profile-info {
    flex-grow: 1;
}

.profile-header {
    margin-bottom: 15px;
}

.profile-title {
    font-size: 1.8em;
    margin: 0 0 5px 0;
}

.profile-subtitle {
    color: #666;
    margin: 0;
}

.profile-tags {
    margin: 10px 0;
}

.profile-tag {
    display: inline-block;
    padding: 5px 10px;
    background-color: #f8f9fa;
    border-radius: 15px;
    margin-right: 8px;
    font-size: 0.9em;
    color: #666;
}

.preview-video {
    width: 100%;
    aspect-ratio: 16/9;
    background-color: #f8f9fa;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 20px 0;
}

.preview-video .play-button {
    width: 60px;
    height: 60px;
    background-color: rgba(0,0,0,0.6);
    border-radius: 30px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
}

.preview-video .play-button::after {
    content: '▶';
    color: white;
    font-size: 24px;
}

/* 탭 메뉴 스타일 */
.tab-menu {
    display: flex;
    border-bottom: 1px solid #e1e1e1;
    margin-bottom: 20px;
}

.tab-button {
    padding: 12px 24px;
    border: none;
    background: none;
    cursor: pointer;
    font-size: 1em;
    color: #666;
    position: relative;
}

.tab-button:hover {
    color: #FAB350;
}

.tab-button.active {
    color: #FAB350;
    font-weight: bold;
}

.tab-button.active::after {
    content: '';
    position: absolute;
    bottom: -1px;
    left: 0;
    width: 100%;
    height: 2px;
    background-color: #FAB350;
}

/* 반응형 스타일 */
@media (max-width: 768px) {
    .teacher-detail-container {
        flex-direction: column;
    }

    .accordion-menu {
        width: 100%;
    }

    .teacher-profile {
        flex-direction: column;
        align-items: center;
        text-align: center;
    }

    .profile-tags {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        gap: 8px;
    }
}
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
	
</head>
<body>    <!-- 모달 -->
    <div class="modal-wrapper" id="modalBackdrop">
        <div class="modal-container" id="loginModal">
            <div class="modal-header">
                <h3 class="modal-title">로그인</h3>
            </div>
            <form id="loginForm" action="/login" method="post">
                <div class="form-group">
                    <input type="text" name="username" class="form-input" placeholder="아이디" required>
                    <input type="password" name="password" class="form-input" placeholder="비밀번호" required>
                </div>
                <div class="form-group">
                    <label>
                        <input type="checkbox" name="remember" class="form-checkbox"> 로그인 상태 유지
                    </label>
                </div>
                <div style="text-align: right;">
                    <button type="button" class="btn btn-secondary" onclick="hideModal()">취소</button>
                    <button type="submit" class="btn btn-primary">로그인</button>
                </div>
            </form>
            <div class="modal-footer">
                <a href="#">아이디 찾기</a>
                <span>|</span>
                <a href="#">비밀번호 찾기</a>
                <span>|</span>
                <a href="#">회원가입</a>
            </div>
        </div>
    </div>

    <!-- 헤더 -->
    <header class="header-container">
        <!-- 광고 배너 -->
        <div id="bannerContainer"></div>

        <!-- 유틸리티 네비게이션 -->
        <div class="utility-nav">
            <div class="utility-container">
                <div class="left-links">
                    <a href="#">블로그</a>
                    <a href="#">공지사항</a>
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
                    <img src="${pageContext.request.contextPath }/resources/images/common/HoneyT_logo_horizontal.png" alt="로고" style="margin-top:8px;">
                </div>
                <span class="grade-wrapper">
                    <button class="grade-btn" id="gradeBtn">고1</button>
                    <div class="grade-dropdown" id="gradeDropdown">
                        <a href="#" class="menu-item" data-grade="고1">고1</a>
                        <a href="#" class="menu-item" data-grade="고2">고2</a>
                        <a href="#" class="menu-item" data-grade="고3/N수">고3/N수</a>
                    </div>
                </span>
                <nav class="sub-nav" id="subNav"></nav>
            </div>
        </div>

        <!-- 메가메뉴 -->
        <div class="mega-menu-container" id="teacherMegaMenu">
            <div class="mega-menu-content">
                <div class="subject-group">
                    <div class="subject-title">국어</div>
                    <div class="teacher-list">
                        <a href="#" class="teacher-item">최영주</a>
                        <a href="#" class="teacher-item">김현아</a>
                        <a href="#" class="teacher-item">손경화 <span class="teacher-badge">HOT</span></a>
                    </div>
                </div>
                <div class="subject-group">
                    <div class="subject-title">수학</div>
                    <div class="teacher-list">
                        <a href="#" class="teacher-item">박정은</a>
                        <a href="#" class="teacher-item">윤송실</a>
                        <a href="#" class="teacher-item">김승겸</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="mega-menu-container" id="courseMegaMenu">
            <div class="mega-menu-content">
                <div class="subject-group">
                    <div class="subject-title">국어</div>
                    <div class="teacher-list">
                        <a href="#" class="teacher-item">문학 기초</a>
                        <a href="#" class="teacher-item">독서 심화</a>
                        <a href="#" class="teacher-item">화법과 작문 <span class="teacher-badge">NEW</span></a>
                    </div>
                </div>
                <div class="subject-group">
                    <div class="subject-title">수학</div>
                    <div class="teacher-list">
                        <a href="#" class="teacher-item">수1 개념완성</a>
                        <a href="#" class="teacher-item">수2 문제풀이</a>
                        <a href="#" class="teacher-item">확률과 통계 <span class="teacher-badge">HOT</span></a>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- 본문 섹션 -->
    <!-- 섹션 1: 3단 그리드 레이아웃 -->
    <section id="layout-section-1">
        <!-- 섹션 설명 -->
        <div class="section-description">
            <p><strong>3단 그리드 레이아웃 (Left Sidebar + Main Content + Right Sidebar)</strong></p>
            <p>- 구조: <code>grid-template-columns: 250px 1fr 250px</code></p>
            <p>- 사용 사례: 메인 콘텐츠와 양쪽 사이드바가 필요한 레이아웃 (블로그, 쇼핑몰 등)</p>
            <p>- 반응형: 768px 이하에서 단일 컬럼으로 변경</p>
        </div>
        <!-- 실제 콘텐츠 -->
        <div>
            <!-- 왼쪽 사이드바 -->
            <div class="content-box">
                <h3>Left Sidebar</h3>
                <p>ID: left-section</p>
                <p>고정 너비: 250px</p>
                <p>주로 네비게이션이나 필터에 사용</p>
            </div>
            <!-- 메인 콘텐츠 -->
            <div class="content-box">
                <h3>Main Content Area</h3>
                <p>ID: main-section</p>
                <p>가변 너비: 남은 공간 자동 조절</p>
                <p>주요 콘텐츠가 표시되는 영역</p>
            </div>
            <!-- 오른쪽 사이드바 -->
            <div class="content-box">
                <h3>Right Sidebar</h3>
                <p>ID: right-section</p>
                <p>고정 너비: 250px</p>
                <p>주로 위젯이나 광고에 사용</p>
            </div>
        </div>
    </section>

    <!-- 섹션 2: 자동 조절 그리드 -->
    <section id="layout-section-2">
        <!-- 섹션 설명 -->
        <div class="section-description">
            <p><strong>반응형 카드 그리드 레이아웃</strong></p>
            <p>- 구조: <code>grid-template-columns: repeat(auto-fit, minmax(300px, 1fr))</code></p>
            <p>- 특징: 화면 크기에 따라 자동으로 열 수 조절</p>
            <p>- 호버 효과: 카드에 마우스 오버 시 상승 효과</p>
        </div>
        <!-- 실제 콘텐츠 -->
        <div>
            <div class="info-card">
                <div class="card-header">Card 1</div>
                <div class="card-body">
                    <p>자동 크기 조절 카드</p>
                    <p>최소 너비: 300px</p>
                    <p>호버 시 상승 효과</p>
                </div>
            </div>
            <div class="info-card">
                <div class="card-header">Card 2</div>
                <div class="card-body">
                    <p>반응형 레이아웃</p>
                    <p>화면 크기에 따라 자동 정렬</p>
                    <p>그림자 효과 적용</p>
                </div>
            </div>
        </div>
    </section>

    <!-- 섹션 3: 복합 레이아웃 -->
    <section id="layout-section-3">
        <!-- 섹션 설명 -->
        <div class="section-description">
            <p><strong>복합 Flexbox + Grid 레이아웃</strong></p>
            <p>- Flexbox: <code>display: flex</code> 상단 아이템 배치</p>
            <p>- Grid: <code>grid-template-columns: repeat(3, 1fr)</code> 하단 그리드</p>
            <p>- 반응형: 화면 크기에 따라 다단계 레이아웃 변경</p>
        </div>
        <!-- 실제 콘텐츠 -->
        <div>
            <!-- Flexbox 컨테이너 -->
            <div class="flex-container">
                <div class="flex-item">
                    <h4>Flex Item 1</h4>
                    <p>유동적 너비 조절</p>
                </div>
                <div class="flex-item">
                    <h4>Flex Item 2</h4>
                    <p>최소 너비 200px</p>
                </div>
                <div class="flex-item">
                    <h4>Flex Item 3</h4>
                    <p>자동 줄바꿈 처리</p>
                </div>
            </div>
            <!-- Grid 컨테이너 -->
            <div class="grid-container">
                <div class="grid-item">Grid 1</div>
                <div class="grid-item">Grid 2</div>
                <div class="grid-item">Grid 3</div>
            </div>
        </div>
    </section>

    <!-- 강사/강좌 목록 섹션 -->
    <section id="teacher-section">
        <!-- 섹션 설명 -->
        <div class="section-description">
            <p><strong>강사/강좌 목록 레이아웃</strong></p>
            <p>- 구조: Flexbox를 사용한 2단 레이아웃</p>
            <p>- 왼쪽: 고정 너비(200px) 메뉴</p>
            <p>- 오른쪽: 유동적 너비의 카드 리스트</p>
        </div>
        <!-- 실제 콘텐츠 -->
        <div class="teacher-container">
            <!-- 왼쪽 메뉴 -->
            <nav class="subject-menu">
                <h2>과목</h2>
                <ul class="menu-list">
                    <li><a href="#" class="active">국어</a></li>
                    <li><a href="#">수학</a></li>
                    <li><a href="#">영어</a></li>
                    <li><a href="#">과학</a></li>
                    <li><a href="#">사회</a></li>
                    <li><a href="#">한국사</a></li>
                    <li><a href="#">직업</a></li>
                    <li><a href="#">제2외국어</a></li>
                    <li><a href="#">영양/진로/교양</a></li>
                </ul>
            </nav>

            <!-- 오른쪽 리스트 -->
            <div class="content-list">
                <!-- 리스트 헤더 -->
                <div class="list-header">
                    <h2 class="list-title">국어 선생님</h2>
                    <div class="sub-category">
                        <button class="active">전체</button>
                        <button>문학</button>
                        <button>독서</button>
                        <button>화법과 작문</button>
                    </div>
                </div>

                <!-- 강사 리스트 -->
                <div class="teacher-list">
                    <!-- 강사 카드 1 -->
                    <div class="teacher-card">
                        <div class="teacher-image">
                            <img src="https://i.namu.wiki/i/W-LhGCCNTAE3F7AJ81_DQpGg7XQbQolN76WcFDjbYgkSoOp8NnGgEj8PyGblftQNMKTTv_NJ8lfBz9XzpMlggQ.webp" alt="정승제 선생님">
                        </div>
                        <div class="teacher-info">
                            <h3>
                                정승제 선생님
                                <span class="teacher-badge">신규</span>
                            </h3>
                            <p class="teacher-description">
                                국어의 달인이 되는 핵심 노하우 대공개!
                                학습의 시작과 마무리를 책임지는 강의
                            </p>
                        </div>
                    </div>

                    <!-- 강사 카드 2 -->
                    <div class="teacher-card">
                        <div class="teacher-image">
                            <img src="https://i.namu.wiki/i/PH9KzsC2-ubZ_bgZX2f1LQiDTTd3aXhg9oAgaGqidOb2Wku3WwdjhQ_nUQDZHm2b7jPOc2F1iqvlbxK_80rxuw.webp" alt="이지영 선생님">
                        </div>
                        <div class="teacher-info">
                            <h3>
                                이지영 선생님
                                <span class="teacher-badge">인기</span>
                            </h3>
                            <p class="teacher-description">
                                문학의 감동을 전달하는 맛있는 강의!
                                수능 만점을 위한 체계적인 커리큘럼
                            </p>
                        </div>
                    </div>

                    <!-- 강사 카드 3 -->
                    <div class="teacher-card">
                        <div class="teacher-image">
                            <img src="https://i.namu.wiki/i/HD37stHzedpVHn3CRooaDUZnpY0lBKnMitQGuxOoLxSGpUBGxqAPhvc6MDjaViQgbHRnI5Q1j3AbTUJWCwW1VQ.webp" alt="우형철 선생님">
                        </div>
                        <div class="teacher-info">
                            <h3>
                                우형철 선생님
                                <span class="teacher-badge">베스트</span>
                            </h3>
                            <p class="teacher-description">
                                독서와 문법의 기초부터 실전까지!
                                개념을 쉽게 풀어주는 맞춤형 강의
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 선생님 상세 페이지 -->
    <section id="teacher-detail-section">
        <div class="teacher-detail-container">
            <!-- 왼쪽 아코디언 메뉴 -->
            <nav class="accordion-menu">
                <!-- 국어 -->
                <div class="accordion-item">
                    <div class="accordion-header active">국어</div>
                    <div class="accordion-content show">
                        <a href="#" class="active">강기동 선생님</a>
                        <a href="#">김미선 선생님</a>
                        <a href="#">장재학 선생님</a>
                    </div>
                </div>
                <!-- 수학 -->
                <div class="accordion-item">
                    <div class="accordion-header">수학</div>
                    <div class="accordion-content">
                        <a href="#">박정은 선생님</a>
                        <a href="#">윤송실 선생님</a>
                        <a href="#">김승겸 선생님</a>
                    </div>
                </div>
                <!-- 과목 추가... -->
            </nav>

            <!-- 오른쪽 상세 내용 -->
            <div class="teacher-detail-content">
                <!-- 선생님 프로필 -->
                <div class="teacher-profile">
                    <div class="profile-image">
                        <img src="/api/placeholder/200/200" alt="강기동 선생님">
                    </div>
                    <div class="profile-info">
                        <div class="profile-header">
                            <h1 class="profile-title">강기동 선생님</h1>
                            <p class="profile-subtitle">TITLE 안내문 개념과 지독한 연습이 만점을 만듭니다!</p>
                        </div>
                        <div class="profile-tags">
                            <span class="profile-tag">#개념</span>
                            <span class="profile-tag">#학력과 통계</span>
                            <span class="profile-tag">#수능 대비</span>
                        </div>
                    </div>
                </div>

                <!-- 소개 영상 -->
                <div class="preview-video">
                    <div class="play-button"></div>
                </div>

                <!-- 탭 메뉴 -->
                <div class="tab-menu">
                    <button class="tab-button active">HOME</button>
                    <button class="tab-button">강의목록</button>
                    <button class="tab-button">공지사항만</button>
                    <button class="tab-button">학습 Q&A</button>
                    <button class="tab-button">학습 자료실</button>
                    <button class="tab-button">수강 후기</button>
                </div>

                <!-- 탭 콘텐츠 영역 -->
                <div class="tab-content">
                    <!-- 탭 별 콘텐츠가 들어갈 영역 -->
                </div>
            </div>
        </div>
    </section>

    <script>
    $(document).ready(function() {
        // 아코디언 메뉴 기능
        $('.accordion-header').click(function() {
            const content = $(this).next('.accordion-content');
            const isActive = $(this).hasClass('active');
            
            // 다른 모든 아코디언 닫기
            $('.accordion-header').removeClass('active');
            $('.accordion-content').slideUp(300);
            
            // 클릭된 아코디언 토글
            if (!isActive) {
                $(this).addClass('active');
                content.slideDown(300);
            }
        });

        // 탭 메뉴 기능
        $('.tab-button').click(function() {
            $('.tab-button').removeClass('active');
            $(this).addClass('active');
            // 탭 콘텐츠 전환 로직 추가
        });
    });
    </script>

    <footer>
        <div id="main-footer"></div>
    </footer>
    <script>
        // 배너 이미지 로드
        const imagePath = `${contextPath}/resources/images/커비.jpg`;
        
        function loadBanner(imagePath) {
            const bannerContainer = document.getElementById('bannerContainer');
            if(imagePath && bannerContainer) {
                const bannerDiv = document.createElement('div');
                bannerDiv.className = 'banner-area';
                bannerDiv.style.backgroundImage = `url('${imagePath}')`;
                
                bannerDiv.onerror = () => {
                    console.warn('배너 이미지를 로드할 수 없습니다:', imagePath);
                    bannerDiv.style.backgroundColor = '#f8f9fa'; // 기본 배경색
                };
                
                bannerContainer.appendChild(bannerDiv);
            }
        }

        $(document).ready(function() {
            // 배너 로드
            loadBanner(imagePath);

            // 서브메뉴 설정
            const subMenus = {
                '고1': ['선생님', '모든강좌', '교재', '모의고사', '기출문제', '입시정보', '시험응시실'],
                '고2': ['선생님', '전체강좌', '교재구매', '모의고사', '기출문제', '입시자료', '학습현황'],
                '고3/N수': ['강사진', '수능강좌', '수능교재', '수능모의고사', '수능기출', '입시상담', '학습관리']
            };

            // 학년 드롭다운 토글
            $('#gradeBtn').click(function(e) {
                e.stopPropagation();
                $(this).toggleClass('active');
                $('#gradeDropdown').slideToggle(200);
            });

            // 학년 선택
            $('.grade-dropdown .menu-item').click(function(e) {
                e.preventDefault();
                const grade = $(this).data('grade');
                $('#gradeBtn').text(grade);
                $('#gradeDropdown').slideUp(200);
                $('#gradeBtn').removeClass('active');
                
                // 서브메뉴 업데이트
                if (subMenus[grade]) {
                    const menuHTML = subMenus[grade].map(item => 
                        `<a href="#" class="menu-item">${item}</a>`
                    ).join('');
                    $('#subNav').html(menuHTML);
                }
            });

            // 메가메뉴 관리
            let megaMenuTimer;
            const teacherMegaMenu = $('#teacherMegaMenu');
            const courseMegaMenu = $('#courseMegaMenu');

            function hideAllMegaMenus() {
                $('.mega-menu-container').stop().slideUp(300);
            }

            function showMegaMenu(menuElement) {
                clearTimeout(megaMenuTimer);
                hideAllMegaMenus();
                menuElement.stop().slideDown(300);
            }

            function hideMegaMenu(menuElement) {
                megaMenuTimer = setTimeout(() => {
                    menuElement.stop().slideUp(300);
                }, 200);
            }

            // 메가메뉴 이벤트 바인딩
            $(document).on('mouseenter', '.sub-nav .menu-item', function() {
                const menuText = $(this).text();
                if (menuText === '선생님' || menuText === '강사진') {
                    showMegaMenu(teacherMegaMenu);
                } else if (menuText === '모든강좌' || menuText === '전체강좌' || menuText === '수능강좌') {
                    showMegaMenu(courseMegaMenu);
                }
            });

            // 메가메뉴에 마우스 진입/이탈 이벤트
            $('.mega-menu-container').hover(
                function() {
                    clearTimeout(megaMenuTimer);
                },
                function() {
                    hideAllMegaMenus();
                }
            );

            // 문서 클릭 시 메뉴 닫기
            $(document).click(function(e) {
                // 드롭다운 메뉴 닫기
                if (!$(e.target).closest('.grade-wrapper').length) {
                    $('#gradeDropdown').slideUp(200);
                    $('#gradeBtn').removeClass('active');
                }
                
                // 메가메뉴 닫기
                if (!$(e.target).closest('.mega-menu-container').length && 
                    !$(e.target).closest('.sub-nav .menu-item').length) {
                    hideAllMegaMenus();
                }
            });

            // 초기 메뉴 선택
            $('.grade-dropdown .menu-item:first').click();
        });

        // 모달 관련 함수
        function showModal(modalType) {
            const backdrop = document.querySelector('.modal-wrapper');
            const modal = document.getElementById(`${modalType}Modal`);
            
            if (backdrop && modal) {
                backdrop.style.display = 'block';
                modal.style.display = 'block';
            }
        }

        function hideModal() {
            const backdrop = document.querySelector('.modal-wrapper');
            const modals = document.querySelectorAll('.modal-container');
            
            if (backdrop) {
                backdrop.style.display = 'none';
            }
            
            modals.forEach(modal => {
                modal.style.display = 'none';
            });
        }

        // 모달 외부 클릭 시 닫기
        document.querySelector('.modal-wrapper').addEventListener('click', function(e) {
            if (e.target === this) {
                hideModal();
            }
        });

        // 모달 내부 클릭 시 이벤트 전파 중단
        document.querySelectorAll('.modal-container').forEach(container => {
            container.addEventListener('click', function(e) {
                e.stopPropagation();
            });
        });
    </script>
</body>
</html>