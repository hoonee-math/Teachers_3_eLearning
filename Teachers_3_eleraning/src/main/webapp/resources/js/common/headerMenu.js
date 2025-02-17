// 메뉴 데이터 정의
const subMenus = {
	'고1': [
		{name: '선생님', url: path + '/teacher/list_and_detail', megaMenu: 'teacher'},
		{name: '모든강좌', url: path + '/course/list', megaMenu: 'course'},
		{name: '교재구매', url: path + '/homepage'},
		{name: '모의고사', url: path + '/homepage'},
		{name: '기출문제', url: path + '/homepage'},
		{name: '입시정보', url: path + '/homepage'},
		{name: '시험응시실', url: path + '/homepage'},
		{name: '학습현황', url: path + '/homepage'}
	],
	'고2': [
		{name: '선생님', url: path + '/teacher/list_and_detail', megaMenu: 'teacher'},
		{name: '모든강좌', url: path + '/course/list', megaMenu: 'course'},
		{name: '교재구매', url: path + '/homepage'},
		{name: '모의고사', url: path + '/homepage'},
		{name: '기출문제', url: path + '/homepage'},
		{name: '입시자료', url: path + '/homepage'},
		{name: '학습현황', url: path + '/homepage'}
	],
	'고3/N수': [
		{name: '선생님', url: path + '/teacher/list_and_detail', megaMenu: 'teacher'},
		{name: '모든강좌', url: path + '/course/list', megaMenu: 'course'},
		{name: '수능교재', url: path + '/homepage'},
		{name: '수능모의고사', url: path + '/homepage'},
		{name: '수능기출', url: path + '/homepage'},
		{name: '입시상담', url: path + '/homepage'},
		{name: '학습관리', url: path + '/homepage'}
	]
};


// grade 관련 유틸리티 함수 추가
function getDefaultGrade() {
	// loginMember가 있고 grade가 유효한 경우
	if('${loginMember}' !== '' && '${loginMember.grade}' !== '') {
		return '고' + '${loginMember.grade}';
	}
	return '고1'; // 기본값
}

function isValidGrade(grade) {
	const validGrades = ['고1', '고2', '고3/N수'];
	return validGrades.includes(grade);
}

function updateSubNav(grade) {
	console.log('서브 네비게이션 업데이트:', grade);
	const menuItems = subMenus[grade].map(item => {
		const megaMenuAttr = item.megaMenu ? ` data-mega-menu="${item.megaMenu}"` : '';
		return `<a href="${item.url}" class="menu-item"${megaMenuAttr}>${item.name}</a>`;
	}).join('');
	$('#subNav').html(menuItems);
}	

function logout() {
	if(confirm('로그아웃 하시겠습니까?')) {
		// 추후 로그아웃 서블릿 연동
		location.assign(`${path}/member/logout`);
	}
}

$(document).ready(function() {
	console.log('Document ready');

	// 현재 선택된 학년을 전역 변수로 선언
	let currentGrade = getDefaultGrade();
	
	// 초기화 함수 정의
	function initializeMenus() {
		try {
			// 저장된 학년 정보 확인
			const savedGrade = sessionStorage.getItem('selectedGrade');
			if(savedGrade && isValidGrade(savedGrade)) {
				currentGrade = savedGrade;
				$('#gradeBtn').text(savedGrade);
			} else {
				$('#gradeBtn').text(currentGrade);
			}
			
			// 초기 메가메뉴 생성
			updateTeacherMegaMenu();
			updateCourseMegaMenu();
			
			// 초기 서브 네비게이션 설정
			updateSubNav(currentGrade);
			
			console.log('현재 설정된 학년:', currentGrade);
		} catch(error) {
			console.error('메뉴 초기화 중 오류:', error);
			// 오류 발생 시 기본값으로 설정
			currentGrade = '고1';
			$('#gradeBtn').text(currentGrade);
			updateSubNav(currentGrade);
		}
	}

	
	
	// 학년 드롭다운 토글 이벤트 추가
	$('#gradeBtn').click(function(e) {
		e.stopPropagation();
		console.log('grade button clicked');
		$(this).toggleClass('active');
		$('#gradeDropdown').slideToggle(200);
	});

	// 학년 선택 이벤트
	$('.grade-dropdown .menu-item').click(function(e) {
		e.preventDefault();
		e.stopPropagation();
	
		const grade = $(this).data('grade');
		if(!isValidGrade(grade)) {
			console.error('잘못된 학년 값:', grade);
			return;
		}
		
		//grade에서 숫자만 추출
		let gradeNum;
		if (grade === '고3/N수') {
			gradeNum = 3;
		} else {
			gradeNum = parseInt(grade.replace('고',''));
		}
	
		//세션 스토리지에 학년 정보 저장
		currentGrade = grade;
		$('#gradeBtn').text(grade).removeClass('active');
		$('#gradeDropdown').slideUp(200);
		updateSubNav(grade);
		sessionStorage.setItem('selectedGrade', grade);
		sessionStorage.setItem('gradeNum', gradeNum);
		console.log('학년 변경:', grade);
		
		//현재 경로 가져오기
		let currentUrl = window.location.href;
		
		if(currentUrl.includes('gradeNum=')) {
			currentUrl = currentUrl.replace(/gradeNum=\d+/, 'gradeNum=' + gradeNum);
		} else {
			currentUrl += (currentUrl.includes('?')? '&' : '?') + 'gradeNum=' + gradeNum;
		}
		
		//페이지 새로고침
		window.location.href = currentUrl;
		
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
	initializeMenus();
});

document.addEventListener('DOMContentLoaded', function() {
	const mobileMenuBtn = document.querySelector('.mobile-menu-btn');
	const mobileUserBtn = document.querySelector('.mobile-user-btn');
	const slideMenu = document.querySelector('.slide-menu');
	
	// 메뉴 버튼 클릭시 슬라이드 메뉴 토글
	mobileMenuBtn.addEventListener('click', function(e) {
		e.stopPropagation(); // 이벤트 버블링 방지
		slideMenu.classList.toggle('active');
	});	
	
	// 외부 클릭시 메뉴 닫기
	document.addEventListener('click', function(e) {
		if (slideMenu &&
			slideMenu.classList.contains('active') &&
			!slideMenu.contains(e.target) &&
			!mobileMenuBtn.contains(e.target)) {
			slideMenu.classList.remove('active');
		}
	});
	
	// ESC 키로 메뉴 닫기
	document.addEventListener('keydown', function(e) {
		if (e.key === 'Escape' && slideMenu && slideMenu.classList.contains('active')) {
			slideMenu.classList.remove('active');
		}
	});
});