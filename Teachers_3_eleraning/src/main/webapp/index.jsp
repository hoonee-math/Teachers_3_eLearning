<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Honey T</title>
	
    <!-- 2. 외부 CSS 파일들 -->
    <!-- 2-1. Bootstrap CSS (다른 CSS보다 먼저) -->
    <!-- 2-2. Bootstrap Icons (필요한 경우) -->
    
    <!-- 2-3. 직접 제작한 CSS 파일들 (Bootstrap CSS 다음에 위치) -->
    <link rel="stylesheet" href="${path}/resources/css/common/reset.css">
    <link rel="stylesheet" href="${path}/resources/css/common/layout.css">
    <link rel="stylesheet" href="${path}/resources/css/common/utilities.css">
    <link rel="stylesheet" href="${path}/resources/css/common/navigator.css">

    <!-- 3. 컴포넌트 CSS -->
    <link rel="stylesheet" href="${path}/resources/css/components/header.css">
    <link rel="stylesheet" href="${path}/resources/css/components/navigation.css">
    <link rel="stylesheet" href="${path}/resources/css/components/modal.css">
    <link rel="stylesheet" href="${path}/resources/css/components/buttons.css">
    <link rel="stylesheet" href="${path}/resources/css/components/cards.css">

    <!-- 4. 페이지별 CSS -->

    <!-- 5. jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	
</head>
<body>    

    <jsp:include page="/WEB-INF/views/common/modal.jsp" />
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <jsp:include page="/WEB-INF/views/common/section.jsp" />


    <footer>
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
        <div id="main-footer"></div>
    </footer>
    <script>

        $(document).ready(function() {

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
    
    
    <!-- 8. 공통 JavaScript -->
    <script src="${path}/resources/js/common/utils.js"></script>
    
    <!-- 9. API/Ajax 관련 JavaScript -->
    <script src="${path}/resources/js/api/apiConfig.js"></script>
    <script src="${path}/resources/js/api/teacherApi.js"></script>
    <script src="${path}/resources/js/api/courseApi.js"></script>

    <!-- 10. 컴포넌트 JavaScript -->
    <script src="${path}/resources/js/components/modal.js"></script>
    <script src="${path}/resources/js/components/navigation.js"></script>
    <script src="${path}/resources/js/components/accordion.js"></script>
    <script src="${path}/resources/js/components/tabs.js"></script>

    <!-- 11. 페이지별 JavaScript -->
    <script src="${path}/resources/js/pages/teacherDetail.js"></script>
</body>
</html>