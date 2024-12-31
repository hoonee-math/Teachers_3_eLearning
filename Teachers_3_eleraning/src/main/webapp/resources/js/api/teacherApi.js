/**
 * 
 */
	
/* Ajax 요청으로 선생님 상세 페이지 확인 */
document.addEventListener('DOMContentLoaded', function() {
	const teacherDetailContent = document.querySelector('.teacher-detail-content');
	
	document.querySelectorAll('.teacher-link').forEach(link => {
		link.addEventListener('click', function(e) {
			e.preventDefault();
			const memberNo = this.getAttribute('data-memberNo');
			
			/* memberNo 값을 이용해서 post 요청 보내기 */
			fetch('/api/teachers', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/x-www-form-urlencoded',
				},
				body: `memberNo=${memberNo}`
			})
			.then(response => response.json())
			.then(teacher => {
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
			});
		});
	});
});