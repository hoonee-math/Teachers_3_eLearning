/**
 * 
 */
$(document).ready(function() {
	// 초기 상태 설정 // 리스트 보이고 디테일 숨기기
	const teacherListContent = $('.teacher-list-content');
	
	// 아코디언 클릭 시 선생님 리스트 보이기 및 과목 필터링
	$('.accordion-header').click(function() {
		const subject = $(this).data('subject');
		loadTeachersBySubject(subject, 1); // 첫 페이지 로드
	});
	
	// 선생님 카드 필터링 함수
	function filterTeachersBySubject(subject) {
		console.log('subject',subject);
		$('.teacher-card').each(function() {
			const teacherSubjectName = $(this).data('subject');
			console.log('teacherSubjectName',teacherSubjectName);
			if (subject === '전체' || teacherSubjectName === subject) {
				$(this).show();
			} else {
				$(this).hide();
			}
		});
	}

    // 탭 메뉴 기능
    $('.tab-button').click(function() {
        $('.tab-button').removeClass('active');
        $(this).addClass('active');
    });

	// 강사 선택 이벤트 처리
	$(document).on('click', '.teacher-card, .teacher-link', function(e) {
		e.preventDefault();
		const memberNo = $(this).data('memberNo');
		loadTeacherDetail(memberNo);
	});
});
	