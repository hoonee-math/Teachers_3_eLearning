/**
 * 
 */

// 시간 관련 유틸리티 함수
function combineDateTime(date, time) {
    const [hours, minutes] = time.split(':');
    const dateTime = new Date(date);
    dateTime.setHours(parseInt(hours), parseInt(minutes), 0);
    return dateTime.toISOString().slice(0, 19).replace('T', ' ');
}

function calculateEndTime(startTime) {
    // 기본 강의 시간을 90분으로 설정
    const [hours, minutes] = startTime.split(':');
    let endDate = new Date();
    endDate.setHours(parseInt(hours));
    endDate.setMinutes(parseInt(minutes) + 90);
    return `${String(endDate.getHours()).padStart(2, '0')}:${String(endDate.getMinutes()).padStart(2, '0')}`;
}

// 강의 일정 동적 생성을 위한 템플릿
function createLectureTemplate(index, date = '', time = '') {
	// 종료 시간 계산
	const endTime = time ? calculateEndTime(time) : '';

	return `
		<div class="lecture-item" data-index="\${index}">
			<div class="lecture-header">
				<h4>${index}차시</h4>
				<input type="date" value="${date}" class="lecture-date">
				<div class="lecture-time-group">
					<input type="time" value="${time}" class="lecture-start-time">
					<span>~</span>
					<input type="time" value="${endTime}" class="lecture-end-time" readonly>
				</div>
			</div>
			<div class="lecture-content">
				<input type="text" class="lecture-title" placeholder="강의 제목" value="${index}차시 강의">
				<input type="url" class="video-url" placeholder="강의 영상 URL">
			</div>
		</div>
	`;
}

// 일정 자동 생성
function generateSchedule() {
	const startDate = new Date(document.getElementById('startDate').value);
	const selectedDays = Array.from(document.querySelectorAll('.day-checkboxes input:checked'))
							 .map(cb => parseInt(cb.value));
	const weekCount = parseInt(document.getElementById('weekCount').value);
	const lectureStartTime = document.getElementById('lectureStartTime').value;
	
	if(!startDate || selectedDays.length === 0 || !weekCount || !lectureStartTime) {
		alert('모든 설정을 입력해주세요.');
		return;
	}

	// 기존 강의 목록 초기화
	document.getElementById('lectureContainer').innerHTML = '';
	
	let lectureCount = 1;
	let currentDate = new Date(startDate);
	
	// 주차별로 선택된 요일마다 강의 생성
	for(let week = 0; week < weekCount; week++) {
		for(let day of selectedDays) {
			currentDate.setDate(startDate.getDate() + (week * 7) + ((7 + day - startDate.getDay()) % 7));
			
			const dateStr = currentDate.toISOString().split('T')[0];
			const template = createLectureTemplate(lectureCount++, dateStr, lectureStartTime);
			document.getElementById('lectureContainer').insertAdjacentHTML('beforeend', template);
		}
	}
	
	updateTotalLectures();
}

// 강의 계획 저장
function saveLecturePlan() {
	const lectures = Array.from(document.querySelectorAll('.lecture-item')).map(item => {
		const date = item.querySelector('.lecture-date').value;
		const startTime = item.querySelector('.lecture-start-time').value;
		const endTime = item.querySelector('.lecture-end-time').value;
		
		return {
			lectureOrder: parseInt(item.getAttribute('data-index')),
			lectureTitle: item.querySelector('.lecture-title').value,
			eventStart: combineDateTime(date, startTime),
			eventEnd: combineDateTime(date, endTime),
			videoUrl: item.querySelector('.video-url').value || null
		};
	});
	
	// AJAX로 서버에 저장
	fetch(`${path}/member/teacher/mypage/lecturelist`, {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json',
			},
			body: JSON.stringify({
				courseNo: courseNo, // jsp에서 전달받은 강좌 번호
				lectures: lectures
			})
		})
		.then(response => response.json())
		.then(data => {
			if(data.success) {
				alert(data.message);
				location.href = `${path}/member/teacher/mypage/course`;
			} else {
				alert(data.message);
			}
		})
		.catch(error => {
			console.error('Error:', error);
			alert('저장 중 오류가 발생했습니다.');
		});
}

// 개별 강의 추가
function addLecture() {
	const currentCount = document.querySelectorAll('.lecture-item').length + 1;
	const template = createLectureTemplate(currentCount);
	document.getElementById('lectureContainer').insertAdjacentHTML('beforeend', template);
	updateTotalLectures();
}

// 강의 삭제
function removeLecture(index) {
	const item = document.querySelector(`.lecture-item[data-index="${index}"]`);
	item.remove();
	updateTotalLectures();
	reorderLectures();
}

// 강의 순서 재정렬
function reorderLectures() {
	const lectures = document.querySelectorAll('.lecture-item');
	lectures.forEach((lecture, index) => {
		lecture.setAttribute('data-index', index + 1);
		lecture.querySelector('h4').textContent = `${index + 1}차시`;
	});
}

// 총 강의 수 업데이트
function updateTotalLectures() {
	const count = document.querySelectorAll('.lecture-item').length;
	document.getElementById('totalLectures').textContent = count;
}