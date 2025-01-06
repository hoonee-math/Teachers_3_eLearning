/**
 * 
 */
// 강의 일정 동적 생성을 위한 템플릿
function createLectureTemplate(index, date = '') {
	return `
		<div class="lecture-item" data-index="\${index}">
			<div class="lecture-header">
				<h4>\${index}차시</h4>
				<input type="date" value="\${date}" class="lecture-date">
				<input type="time" class="lecture-time">
			</div>
			<div class="lecture-preview">
				<span>제목과 설명은 나중에 입력 가능합니다</span>
			</div>
			<button type="button" class="remove-lecture" onclick="removeLecture(\${index})">
				<i class="bi bi-trash"></i>
			</button>
		</div>
	`;
}

// 일정 자동 생성
function generateSchedule() {
	const startDate = new Date(document.getElementById('startDate').value);
	const selectedDays = Array.from(document.querySelectorAll('.day-checkboxes input:checked'))
							 .map(cb => parseInt(cb.value));
	const weekCount = parseInt(document.getElementById('weekCount').value);
	const lectureTime = document.getElementById('lectureTime').value;
	
	if(!startDate || selectedDays.length === 0 || !weekCount || !lectureTime) {
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
			const template = createLectureTemplate(lectureCount++, dateStr);
			document.getElementById('lectureContainer').insertAdjacentHTML('beforeend', template);
			
			// 시간 설정
			const lastAdded = document.querySelector('.lecture-item:last-child');
			lastAdded.querySelector('.lecture-time').value = lectureTime;
		}
	}
	
	updateTotalLectures();
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

// 강의 계획 저장
function saveLecturePlan() {
	const lectures = Array.from(document.querySelectorAll('.lecture-item')).map(item => ({
		lectureOrder: parseInt(item.getAttribute('data-index')),
		lectureDate: item.querySelector('.lecture-date').value,
		lectureTime: item.querySelector('.lecture-time').value
	}));

	// AJAX로 서버에 저장
	fetch('${path}/teacher/course/saveLecturePlan', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
		},
		body: JSON.stringify({
			courseNo: '${course.courseNo}',
			lectures: lectures
		})
	})
	.then(response => response.json())
	.then(data => {
		if(data.success) {
			alert('강의 계획이 저장되었습니다.');
			location.href = '${path}/teacher/course/management';
		} else {
			alert('저장에 실패했습니다.');
		}
	});
}