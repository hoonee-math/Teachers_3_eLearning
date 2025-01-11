/**
 * 메가 메뉴에 선생님, 강좌 리스트를 출력해주는 script
 */

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
	
	// 전역으로 데이터 공유
	window.teachersBySubject = teachersBySubject;
	
	// 메가메뉴 HTML 생성
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


const TeacherDataManager = {
    // 버전 관리를 위한 해시 생성
    generateHash(data) {
        return data.map(t => `${t.memberNo}-${t.teacherSubject}`).sort().join('|');
    },

    // 로컬 스토리지에 데이터 저장
    saveToStorage(teachers) {
        const hash = this.generateHash(teachers);
        const data = {
            timestamp: new Date().getTime(),
            hash: hash,
            teachers: teachers
        };
        localStorage.setItem('teacherData', JSON.stringify(data));
    },

    // 데이터가 유효한지 확인
    isDataValid(serverHash) {
        try {
            const stored = JSON.parse(localStorage.getItem('teacherData'));
            if (!stored) return false;

            // 24시간 이상 지났거나 해시가 다르면 무효
            const isExpired = (new Date().getTime() - stored.timestamp) > 24 * 60 * 60 * 1000;
            const hashChanged = stored.hash !== serverHash;

            return !isExpired && !hashChanged;
        } catch (e) {
            return false;
        }
    },

	// 데이터 로드 함수
	loadTeachers() {
	    // 서버에서 현재 해시값 먼저 받아옴
	    return this.getServerHash().then(serverHash => {
	        if (this.isDataValid(serverHash)) {
	            const stored = JSON.parse(localStorage.getItem('teacherData'));
	            return stored.teachers;
	        }

	        // 유효하지 않으면 전체 데이터 다시 로드
	        const teachers = megaMenuTeachers; // 서버에서 새로 받아온 데이터
	        this.saveToStorage(teachers);
	        return teachers;
	    }).catch(error => {
	        console.error("Error loading teachers:", error);
	    });
	}
};