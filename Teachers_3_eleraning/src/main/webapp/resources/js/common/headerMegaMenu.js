/**
 * 
 */
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
