/**
 * 선생님 목록 아코디언 메뉴 및 과목별 선생님 목록 로드
 */
$(document).ready(function() {
    // 초기 상태 설정
    $('.accordion-content').hide();

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
	        
	        // 과목별 필터링 함수 호출
	        filterBySubject(subject);
	    }
	});
	});
/*
	// 페이지네이션 클릭 이벤트 위임
	$(document).on('click', '.pagination a', function(e) {
		e.preventDefault();
		const page = $(this).data('page');
		const currentSubject = $('.list-title').text().replace(' 선생님', '');
		loadTeachersBySubject(currentSubject, page);
	});
});*/


// 아코디언 콘텐츠 업데이트 함수
function updateAccordionContent(subject, contentElement) {
    // window.teachersBySubject가 있는지 확인
    /*if (window.teachersBySubject && window.teachersBySubject[subject]) {
        const teacherList = window.teachersBySubject[subject];
        let html = '';
        
        teacherList.forEach(teacher => {
            html += `
                <a href="#" class="teacher-link" data-memberno="\${teacher.memberNo}">
                    \${teacher.memberName} 선생님
                </a>
            `;
        });
        
        contentElement.html(html);
    }*/
}
/*
// 과목별 선생님 목록 로드 함수
function loadTeachersBySubject(subject, page) {
	$.ajax({
		url: path + '/teacher/list_and_detail',
		method: 'GET',
		data: {
			subject: subject,
			cpage: page
		},
		success: function(response) {
			// HTML 텍스트로 파싱
			const parser = new DOMParser();
			const doc = parser.parseFromString(response, 'text/html');

			// 선생님 카드 리스트 업데이트
			const teacherList = $(doc).find('.teacher-list.real-data').html();
			$('.teacher-list.real-data').html(teacherList);

			// 페이징 바 업데이트
			const pagination = $(doc).find('.pagination').html();
			$('.pagination').html(pagination);
		},
		error: function(error) {
			console.error('선생님 목록 로드 중 오류 발생:', error);
		}
	});
}*/

// 선생님 카드 클릭 이벤트 위임
$(document).on('click', '.teacher-card', function() {
	const memberNo = $(this).data('memberno');
	if (memberNo) {
		location.href = path + '/teacher/detail/' + memberNo;
	}
});