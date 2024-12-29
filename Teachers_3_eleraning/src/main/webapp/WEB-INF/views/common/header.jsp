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
				<a href="${path }/courselist">블로그</a>
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
				<img src="${pageContext.request.contextPath }/resources/images/common/HoneyT_logo_horizontal.png" alt="로고">
				</a>
			</div>
			<span class="grade-wrapper">
				<!-- 로그인 정보에 따른 초기 학년 표시 -->
			    <button class="grade-btn" id="gradeBtn">
			        ${empty loginMember ? '고1' : loginMember.grade}
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

	<!----------------------------------->
	<!-- 1. 배너 이미지 관련 javaScript -->	
	<!----------------------------------->
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
	
	<!----------------------------------->
	<!-- 2. 메뉴 관련 javaScript        -->	
	<!----------------------------------->
	<script>
	// 콘솔 로그 추가
	console.log('Header script 시작');
	// contextPath를 JavaScript 변수로 설정
	const path = '${pageContext.request.contextPath}';
	console.log('Context Path:', path);
	
	// 메뉴 데이터 정의
	const subMenus = {
	    '고1': [
	        {name: '선생님', url: '${path }/teacherListAndDetail', megaMenu: 'teacher'},
	        {name: '모든강좌', url: '${path }/courselist', megaMenu: 'course'},
	        {name: '교재', url: '${path}/book/list/high1'},
	        {name: '모의고사', url: '${path}/exam/list/high1'},
	        {name: '기출문제', url: '${path}/previous/high1'},
	        {name: '입시정보', url: '${path}/info/high1'},
	        {name: '시험응시실', url: '${path}/test/high1'}
	    ],
	    '고2': [
	        {name: '선생님', url: '${path }/teacherListAndDetail', megaMenu: 'teacher'},
	        {name: '모든강좌', url: '${path }/courselist', megaMenu: 'course'},
	        {name: '교재구매', url: '${path}/book/list/high2'},
	        {name: '모의고사', url: '${path}/exam/list/high2'},
	        {name: '기출문제', url: '${path}/previous/high2'},
	        {name: '입시자료', url: '${path}/info/high2'},
	        {name: '학습현황', url: '${path}/status/high2'}
	    ],
	    '고3/N수': [
	        {name: '선생님', url: '${path }/teacherListAndDetail', megaMenu: 'teacher'},
	        {name: '모든강좌', url: '${path }/courselist', megaMenu: 'course'},
	        {name: '수능교재', url: '${path}/book/list/high3'},
	        {name: '수능모의고사', url: '${path}/exam/list/high3'},
	        {name: '수능기출', url: '${path}/previous/high3'},
	        {name: '입시상담', url: '${path}/counsel/high3'},
	        {name: '학습관리', url: '${path}/status/high3'}
	    ]
	};
	
	// 더미 교사 데이터
	const teacherData = {
	    '국어': [
	        {name: '최영주', id: 1},
	        {name: '김현아', id: 2, badge: 'HOT'},
	        {name: '손경화', id: 3, badge: 'NEW'}
	    ],
	    '수학': [
	        {name: '박정은', id: 4},
	        {name: '윤송실', id: 5, badge: 'HOT'},
	        {name: '김승겸', id: 6}
	    ]
	};
	
	// 더미 강좌 데이터
	const courseData = {
	    '국어': [
	        {name: '문학 기초', id: 1},
	        {name: '독서 심화', id: 2},
	        {name: '화법과 작문', id: 3, badge: 'NEW'}
	    ],
	    '수학': [
	        {name: '수1 개념완성', id: 4},
	        {name: '수2 문제풀이', id: 5},
	        {name: '확률과 통계', id: 6, badge: 'HOT'}
	    ]
	};
	
	// subNav 업데이트 함수
	function updateSubNav(grade) {
	    console.log('서브 네비게이션 업데이트:', grade);
	    const menuItems = subMenus[grade].map(item => {
	        const megaMenuAttr = item.megaMenu ? ' data-mega-menu="' + item.megaMenu + '"' : '';
	        return '<a href="' + item.url + '" class="menu-item"' + megaMenuAttr + '>' + item.name + '</a>';
	    }).join('');
	    $('#subNav').html(menuItems);
	}
	
	// 메가메뉴 생성 함수
	function updateTeacherMegaMenu() {
	    console.log('교사 메가메뉴 업데이트');
	    const menuHTML = Object.entries(teacherData).map(([subject, teachers]) => {
	        return '<div class="mega-menu-subject-group">' +
	            '<div class="mega-menu-subject-title">' + subject + '</div>' +
	            '<div class="mega-menu-teacher-list">' +
	            teachers.map(teacher => {
	                const badge = teacher.badge ? '<span class="mega-menu-teacher-badge">' + teacher.badge + '</span>' : '';
	                return '<a href="' + path + '/teacherListAndDetail?teacherName=' + teacher.name + '" class="mega-menu-teacher-item">' +
	                    teacher.name + badge + '</a>';
	            }).join('') +
	            '</div></div>';
	    }).join('');
	    $('#teacherMegaMenuContent').html(menuHTML);
	}
	
	function updateCourseMegaMenu() {
	    console.log('강좌 메가메뉴 업데이트');
	    const menuHTML = Object.entries(courseData).map(([subject, courses]) => {
	        return '<div class="mega-menu-subject-group">' +
	            '<div class="mega-menu-subject-title">' + subject + '</div>' +
	            '<div class="mega-menu-teacher-list">' +
	            courses.map(course => {
	                const badge = course.badge ? '<span class="mega-menu-teacher-badge">' + course.badge + '</span>' : '';
	                return '<a href="' + path + '/course/' + course.id + '" class="mega-menu-teacher-item">' +
	                    course.name + badge + '</a>';
	            }).join('') +
	            '</div></div>';
	    }).join('');
	    $('#courseMegaMenuContent').html(menuHTML);
	}
	
	$(document).ready(function() {
	    console.log('Document ready');
	    
	    // 초기화 함수 정의
	    function initializeMenus() {
	        // 초기 메가메뉴 생성
	        updateTeacherMegaMenu();
	        updateCourseMegaMenu();
	        // 초기 서브 네비게이션 설정
	        updateSubNav('고1');
	    }

	    // 학년 드롭다운 토글 이벤트 추가
	    $('#gradeBtn').click(function(e) {
	        e.stopPropagation();  // 이벤트 전파 중지
	        $(this).toggleClass('active');
	        $('#gradeDropdown').slideToggle(200);
	    });

	    // 학년 선택 이벤트
	    $('.grade-dropdown .menu-item').click(function(e) {
	        e.preventDefault();
	        e.stopPropagation();  // 이벤트 전파 중지
	        const grade = $(this).data('grade');
	        const url = $(this).data('url');
	        console.log('학년 선택:', grade, 'URL:', url);
	        
	        $('#gradeBtn').text(grade).removeClass('active');
	        $('#gradeDropdown').slideUp(200);
	        updateSubNav(grade);
	    });

	    // 문서 클릭 시 드롭다운 닫기
	    $(document).click(function(e) {
	        if (!$(e.target).closest('.grade-wrapper').length) {
	            $('#gradeDropdown').slideUp(200);
	            $('#gradeBtn').removeClass('active');
	        }
	    });

	    // 메가메뉴 표시/숨김 이벤트
	    $(document).on('mouseenter', '.sub-nav .menu-item', function() {
	        const megaMenu = $(this).data('mega-menu');
	        console.log('메가메뉴 진입:', megaMenu);
	        
	        if (megaMenu === 'teacher') {
	            $('#teacherMegaMenu').stop().slideDown(300);
	            $('#courseMegaMenu').stop().slideUp(300);
	        } else if (megaMenu === 'course') {
	            $('#courseMegaMenu').stop().slideDown(300);
	            $('#teacherMegaMenu').stop().slideUp(300);
	        } else {
	            $('.mega-menu-container').stop().slideUp(300);
	        }
	    });

	    // 메가메뉴 숨김
	    $('.mega-menu-container').mouseleave(function() {
	        console.log('메가메뉴 이탈');
	        $(this).stop().slideUp(300);
	    });

	    // 초기화 실행
	    try {
	        initializeMenus();
	        console.log('메뉴 초기화 완료');
	    } catch (error) {
	        console.error('메뉴 초기화 중 오류 발생:', error);
	    }
	});
	</script>
	
</header>