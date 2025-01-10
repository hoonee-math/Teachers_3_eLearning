/**
 * 
 */
// 더미 교사 데이터
/*const teacherData = {
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
};*/

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
	try {
		// 서버에서 전달받은 데이터를 활용 (JSP에서 전달)
		const teachers = (typeof megaMenuTeachers !== 'undefined') ? megaMenuTeachers : [];
		const subjects = (typeof megaMenuSubjects !== 'undefined') ? megaMenuSubjects : [];
		
	
		if (teachers.length === 0 || subjects.length === 0) {
			console.log('메가메뉴 데이터가 아직 로드되지 않았습니다.');
			return;
		}

	// 과목별로 교사 데이터 그룹화
	const teachersBySubject = teachers.reduce(
		// reduce() 메서드의 첫번째 콜백 함수 파라미터 : (acc, teacher) => { ... }
		// acc: 누적값 (accumulator), teacher: 현재 처리중인 배열 요소
		(acc, teacher) => { 
			
			const subject = teacher.teacherSubjectName;
			if (!acc[subject]) {
				acc[subject] = [];
			}
			acc[subject].push(teacher);
			return acc;
		}, 
		// reduce() 메서드의 두번째 파라미터 : 초기값 (여기서는 빈 객체 {})
		{}
	);
	const menuHTML = subjects.map(subject => {
	        const subjectTeachers = teachersBySubject[subject] || [];
	        return `
	            <div class="mega-menu-subject-group">
	                <div class="mega-menu-subject-title">${subject}</div>
	                <div class="mega-menu-teacher-list">
	                    ${subjectTeachers.map(teacher => `
	                        <a href="${path}/teacher/detail/${teacher.memberNo}" 
	                           class="mega-menu-teacher-item">
	                            ${teacher.memberName} 선생님
	                        </a>
	                    `).join('')}
	                </div>
	            </div>
	        `;
	}).join('');
	$('#teacherMegaMenuContent').html(menuHTML);
	
	} catch (error) {
		console.error('메가메뉴 업데이트 중 오류 발생:', error);
	}
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

