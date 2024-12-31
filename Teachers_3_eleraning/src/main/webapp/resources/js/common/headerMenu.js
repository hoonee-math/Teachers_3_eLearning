// 메뉴 데이터 정의
const subMenus = {
	'고1': [
		{name: '선생님', url: path + '/teacher/list_and_detail', megaMenu: 'teacher'},
		{name: '모든강좌', url: path + '/course/list', megaMenu: 'course'},
		{name: '교재', url: path + '/book/list/high1'},
		{name: '모의고사', url: path + '/exam/list/high1'},
		{name: '기출문제', url: path + '/previous/high1'},
		{name: '입시정보', url: path + '/info/high1'},
		{name: '시험응시실', url: path + '/test/high1'}
	],
	'고2': [
		{name: '선생님', url: path + '/teacher/list_and_detail', megaMenu: 'teacher'},
		{name: '모든강좌', url: path + '/course/list', megaMenu: 'course'},
		{name: '교재구매', url: path + '/book/list/high2'},
		{name: '모의고사', url: path + '/exam/list/high2'},
		{name: '기출문제', url: path + '/previous/high2'},
		{name: '입시자료', url: path + '/info/high2'},
		{name: '학습현황', url: path + '/status/high2'}
	],
	'고3/N수': [
		{name: '선생님', url: path + '/teacher/list_and_detail', megaMenu: 'teacher'},
		{name: '모든강좌', url: path + '/course/list', megaMenu: 'course'},
		{name: '수능교재', url: path + '/book/list/high3'},
		{name: '수능모의고사', url: path + '/exam/list/high3'},
		{name: '수능기출', url: path + '/previous/high3'},
		{name: '입시상담', url: path + '/counsel/high3'},
		{name: '학습관리', url: path + '/status/high3'}
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
	
		currentGrade = grade;
		$('#gradeBtn').text(grade).removeClass('active');
		$('#gradeDropdown').slideUp(200);
		updateSubNav(grade);
		sessionStorage.setItem('selectedGrade', grade);
		console.log('학년 변경:', grade);
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
