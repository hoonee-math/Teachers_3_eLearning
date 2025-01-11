/**
 * 선생님 목록 아코디언 메뉴 및 페이징 처리
 */
$(document).ready(function() {
	const teacherListContent = $('.teacher-list-content');

	// 아코디언 메뉴 기능
	$('.accordion-header').click(function() {
		const content = $(this).next('.accordion-content');
		const isActive = $(this).hasClass('active');
		const subject = $(this).data('subject');

		// 다른 모든 아코디언 닫기
		$('.accordion-header').removeClass('active');
		$('.accordion-content').slideUp(300);

		// 클릭된 아코디언 토글
		if (!isActive) {
			$(this).addClass('active');
			content.slideDown(300);
			// 선생님 목록 로드
			loadTeachersBySubject(subject, 1);
		}
	});

	// 페이지네이션 클릭 이벤트
	$(document).on('click', '.pagination a', function(e) {
		e.preventDefault();
		const page = $(this).data('page');
		const currentSubject = $('.list-title').text().replace(' 선생님', '');
		loadTeachersBySubject(currentSubject, page);
	});

})

// 과목별 선생님 목록 로드 함수
function loadTeachersBySubject(subject, page) {
	$.ajax({
		url: `${path}/teacher/list_and_detail`,
		data: {
			subject: subject,
			cpage: page
		},
		success: function(response) {
			// 리스트 타이틀 업데이트
			$('.list-title').text(`${subject} 선생님`);

			// 선생님 카드 리스트 업데이트
			updateTeacherList(response.teachers);

			// 페이징 업데이트
			updatePagination(response);
		},
		error: function(error) {
			console.error('선생님 목록 로드 중 오류 발생:', error);
		}
	});
}

// 선생님 카드 리스트 업데이트 함수
function updateTeacherList(teachers) {
	const $teacherList = $('.teacher-list');
	$teacherList.empty();

	teachers.forEach(teacher => {
		const imageUrl = (teacher.image && teacher.image.renamed)
			? `${path}/resources/images/profile/${teacher.image.renamed}`
			: `${path}/resources/images/profile/default.png`;

		$teacherList.append(`
            <div class="teacher-card" data-memberNo="${teacher.memberNo}" data-subject="${teacher.teacherSubjectName}">
                <div class="teacher-image">
                    <img src="${imageUrl}" alt="${teacher.memberName} 선생님">
                </div>
                <div class="teacher-info">
                    <h3>${teacher.memberName} 선생님</h3>
                    <p class="teacher-description">
                        ${teacher.teacherInfoTitle || ''} ${teacher.teacherInfoContent || ''}
                    </p>
                </div>
            </div>
        `);
	});
}

// 페이징 바 업데이트 함수
function updatePagination({ pageStart, pageEnd, totalPage, cpage }) {
	const $pagination = $('.pagination');
	let html = '';

	if (pageStart > 1) {
		html += `<a href="#" class="page-arrow" data-page="${pageStart - 1}">&lt;</a>`;
	}

	for (let i = pageStart; i <= pageEnd; i++) {
		if (i === cpage) {
			html += `<span class="current-page">${i}</span>`;
		} else {
			html += `<a href="#" data-page="${i}">${i}</a>`;
		}
	}

	if (pageEnd < totalPage) {
		html += `<a href="#" class="page-arrow" data-page="${pageEnd + 1}">&gt;</a>`;
	}

	$pagination.html(html);
}