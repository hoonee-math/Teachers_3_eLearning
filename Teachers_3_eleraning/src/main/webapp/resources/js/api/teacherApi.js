/**
 * 
 */
$(document).ready(function() {

	// 아코디언 클릭 시 선생님 리스트 보이기
	$('.accordion-header').click(function() {
	    // 리스트 보이고 디테일 숨기기
	    $('.teacher-detail-content').hide();
	    $('.teacher-list-content').show();
	});

    // 탭 메뉴 기능
    $('.tab-button').click(function() {
        $('.tab-button').removeClass('active');
        $(this).addClass('active');
    });
});
	
// teacherListAndDetailAccordion.js 수정
function updateTeacherList(subject) {
    fetch(`${path}/teacher/list_and_detail?subject=${subject}&cpage=${page}`)
		.then(response => response.text())
		.then(html => {
			$('.teacher-list-content').html(html);
		})
		.catch(error => console.error('Error:', error));
}

// 페이지네이션 클릭 이벤트
$(document).on('click', '.pagination a', function(e) {
    e.preventDefault();
    const page = $(this).data('page');
    const subject = $('.accordion-header.active').data('subject');
    updateTeacherList(subject, page);
});

/* Ajax 요청으로 선생님 상세 페이지 확인 */
document.addEventListener('DOMContentLoaded', function() {
	// 초기 UI 상태 설정
	const teacherDetailContent = document.querySelector('.teacher-detail-content');
	const teacherListContent = document.querySelector('.teacher-list-content');
	try{
		teacherDetailContent.style.display = 'none';
	} catch(error) {
		console.error("teacherDetailContent 를 찾지 못해서 발생한 오류");
	}
	// 강사 선택 이벤트 처리
	document.querySelectorAll('.teacher-link, .teacher-card').forEach(link => {
		link.addEventListener('click', function(e) {
			e.preventDefault();
			const memberNo = this.getAttribute('data-memberNo');
			
			/* memberNo 값을 이용해서 post 요청 보내기 */
			fetch(`${path}/api/teachers`, {
				method: 'POST',
				headers: {
					'Content-Type': 'application/x-www-form-urlencoded',
				},
				body: `memberNo=${memberNo}`
			})
			.then(response => {
				if (!response.ok) {
				    throw new Error('Network response was not ok');
				}
				return response.json();
			})
			.then(teacher => {
				// UI 업데이트
				teacherDetailContent.style.display = 'block';
				teacherListContent.style.display = 'none';
	
				// 선생님 프로필 업데이트
				teacherDetailContent.innerHTML = `
					<div class="teacher-profile">
						<div class="profile-image">
							<img src="${teacher.imageUrl}" alt="${teacher.name} 선생님">
						</div>
						<div class="profile-info">
							<div class="profile-header">
								<h1 class="profile-title">${teacher.name} 선생님</h1>
								<p class="profile-subtitle">${teacher.title}</p>
							</div>
							<div class="profile-tags">
								${teacher.tags.map(tag => `<span class="profile-tag">#${tag}</span>`).join(' ')}
							</div>
						</div>
					</div>

					/* 소개 영상 */
					<div class="preview-video">
						<div class="play-button"></div>
					</div>

					/* 탭 메뉴 */
					<div class="tab-menu">
						<button class="tab-button active">HOME</button>
						<button class="tab-button">강의목록</button>
						<button class="tab-button">공지사항만</button>
						<button class="tab-button">학습 Q&A</button>
						<button class="tab-button">학습 자료실</button>
						<button class="tab-button">수강 후기</button>
					</div>

					/* 탭 콘텐츠 영역 */
					<div class="tab-content">
						/* 탭 별 콘텐츠가 들어갈 영역 */
					</div>
				`;
			})
			.catch(error => {
			    console.error('Error:', error);
			});
		});
	});
});