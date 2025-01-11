/**
 * 강의 일정 관리를 위한 JavaScript
 * - courseNo를 JSP에서 전달받아 사용
 * - 시간 형식을 HH:mm으로 표준화
 */

// 시간 관련 유틸리티 함수들
function combineDateTime(date, time) {
	if (!date || !time) return null;

	const [hours, minutes] = time.split(':');
	const dateTime = new Date(date);
	dateTime.setHours(parseInt(hours), parseInt(minutes), 0);
	return dateTime.toISOString().slice(0, 19).replace('T', ' ');
}

function formatTimeString(timeStr) {
	if (!timeStr) return '';
	const [hours, minutes] = timeStr.split(':');
	return `${String(hours).padStart(2, '0')}:${String(minutes).padStart(2, '0')}`;
}

// 강의 템플릿 생성 함수
function createLectureTemplate(index, date = '', startTime = '', endTime = '') {
	return `
        <div class="lecture-item" data-index="${index}">
            <div class="lecture-header">
                <h4>${index}차시</h4>
                <div class="lecture-actions">
                    <button type="button" class="btn-save-lecture">저장</button>
                    <button type="button" class="btn-delete-lecture">삭제</button>
                </div>
            </div>
            <div class="lecture-content">
                <input type="text" class="lecture-title" 
                       placeholder="${index}차시 강의">
                <details>
                    <summary>추가 정보 입력 (선택사항)</summary>
                    <div class="optional-inputs">
                        <input type="date" class="lecture-date" value="${date}">
                        <div class="lecture-time-group">
                            <input type="time" class="lecture-start-time" value="${startTime}">
                            <span>~</span>
                            <input type="time" class="lecture-end-time" value="${endTime}">
                        </div>
                        <input type="url" class="video-url" 
                               placeholder="강의 영상 URL">
                    </div>
                </details>
            </div>
        </div>
    `;
}

// 일정 자동 생성 (기존 기능 유지)
function generateSchedule() {
	const startDate = new Date(document.getElementById('startDate').value);
	const selectedDays = Array.from(document.querySelectorAll('.day-checkboxes input:checked'))
		.map(cb => parseInt(cb.value));
	const weekCount = parseInt(document.getElementById('weekCount').value);
	const lectureStartTime = formatTimeString(document.getElementById('lectureStartTime').value);
	const lectureEndTime = formatTimeString(document.getElementById('lectureEndTime').value);

	if (!startDate || selectedDays.length === 0 || !weekCount || !lectureStartTime || !lectureEndTime) {
		alert('모든 설정을 입력해주세요.');
		return;
	}

	// 기존 강의 목록 초기화
	document.getElementById('lectureContainer').innerHTML = '';

	let lectureCount = document.querySelectorAll('.lecture-item').length + 1;
	let currentDate = new Date(startDate);

	// 주차별로 선택된 요일마다 강의 생성
	for (let week = 0; week < weekCount; week++) {
		for (let day of selectedDays) {
			currentDate.setDate(startDate.getDate() + (week * 7) + ((7 + day - startDate.getDay()) % 7));

			const dateStr = currentDate.toISOString().split('T')[0];
			const template = createLectureTemplate(lectureCount++, dateStr, lectureStartTime, lectureEndTime);
			document.getElementById('lectureContainer').insertAdjacentHTML('beforeend', template);
			const newLectureItem = document.getElementById('lectureContainer').lastElementChild;
			bindNewLectureEvents(newLectureItem);
		}
	}

	updateTotalLectures();
}

// 개별 강의 저장
function saveLecture(lectureItem) {
	const lectureData = {
		courseNo: courseNo,
		lectureOrder: parseInt(lectureItem.getAttribute('data-index')),
		lectureTitle: lectureItem.querySelector('.lecture-title').value ||
			`${lectureItem.getAttribute('data-index')}차시 강의`,
		lectureStatus: '1'
	};

	// 선택적 데이터 추가
	const date = lectureItem.querySelector('.lecture-date').value;
	const startTime = lectureItem.querySelector('.lecture-start-time').value;
	const endTime = lectureItem.querySelector('.lecture-end-time').value;
	const videoUrl = lectureItem.querySelector('.video-url').value;

	if (date && startTime && endTime) {
		lectureData.eventStart = combineDateTime(date, startTime);
		lectureData.eventEnd = combineDateTime(date, endTime);
		if (videoUrl) {
			lectureData.videoUrl = videoUrl;
		}
	}

	fetch(`${path}/member/teacher/mypage/lecture/save`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
		},
		body: JSON.stringify(lectureData)
	})
		.then(response => response.json())
		.then(data => {
			if (data.success) {
				alert('강의가 저장되었습니다.');
				lectureItem.setAttribute('data-lecture-no', data.lectureNo);
				makeReadonly(lectureItem);
				convertSaveToEdit(lectureItem);
			} else {
				alert(data.message || '저장 중 오류가 발생했습니다.');
			}
		})
		.catch(error => {
			console.error('Error:', error);
			alert('저장 중 오류가 발생했습니다.');
		});
}

// 강의 수정 모드 전환
function enableEdit(lectureItem) {
	// 모든 input 요소의 readonly 속성 제거
	const inputs = lectureItem.querySelectorAll('input');
	inputs.forEach(input => input.removeAttribute('readonly'));

	// 수정 버튼을 저장 버튼으로 변경
	const editBtn = lectureItem.querySelector('.btn-edit-lecture');
	editBtn.textContent = '저장';
	editBtn.onclick = () => updateLecture(lectureItem);
}

// 강의 수정 저장
function updateLecture(lectureItem) {
	const lectureNo = lectureItem.getAttribute('data-lecture-no');
	if (!lectureNo) {
		alert('잘못된 접근입니다.');
		return;
	}

	const date = lectureItem.querySelector('.lecture-date').value;
	const startTime = lectureItem.querySelector('.lecture-start-time').value;
	const endTime = lectureItem.querySelector('.lecture-end-time').value;

	const lectureData = {
		lectureNo: parseInt(lectureNo),
		courseNo: courseNo,
		lectureOrder: parseInt(lectureItem.getAttribute('data-index')),
		lectureTitle: lectureItem.querySelector('.lecture-title').value,
		eventStart: date && startTime ? combineDateTime(date, startTime) : null,
		eventEnd: date && endTime ? combineDateTime(date, endTime) : null,
		videoUrl: lectureItem.querySelector('.video-url').value || null
	};

	fetch(`${path}/member/teacher/mypage/lecture/update`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
		},
		body: JSON.stringify(lectureData)
	})
	.then(response => response.json())
	.then(data => {
		if (data.success) {
			alert('강의가 수정되었습니다.');
			makeReadonly(lectureItem);
			convertEditToSave(lectureItem);
		} else {
			alert(data.message || '수정 중 오류가 발생했습니다.');
		}
	})
	.catch(error => {
		console.error('Error:', error);
		alert('수정 중 오류가 발생했습니다.');
	});
}

// 읽기 전용 모드 전환
function makeReadonly(lectureItem) {
	const inputs = lectureItem.querySelectorAll('input');
	inputs.forEach(input => input.setAttribute('readonly', true));
}

// 버튼 상태 변경 - 강의 등록시 강의 저장 버튼을 수정
function convertSaveToEdit(lectureItem) {
	const saveBtn = lectureItem.querySelector('.btn-save-lecture');
	saveBtn.textContent = '수정';
	saveBtn.className = 'btn-edit-lecture';
	saveBtn.onclick = () => enableEdit(lectureItem);
}

// 저장 버튼을 수정 버튼으로 변경 - 강의 수정시 저장 버튼을 수정
function convertEditToSave(lectureItem) {
    const saveBtn = lectureItem.querySelector('.btn-edit-lecture');
    saveBtn.textContent = '수정';
    saveBtn.onclick = () => enableEdit(lectureItem);
}

// 강의 삭제
function deleteLecture(lectureItem) {
	const lectureNo = lectureItem.getAttribute('data-lecture-no');

	if (!lectureNo) {
		lectureItem.remove();
		updateTotalLectures();
		return;
	}

	if (!confirm('정말 이 강의를 삭제하시겠습니까?')) {
		return;
	}

	fetch(`${path}/member/teacher/mypage/lecture/delete/${lectureNo}`, {
		method: 'POST'
	})
		.then(response => response.json())
		.then(data => {
			if (data.success) {
				lectureItem.remove();
				updateTotalLectures();
				alert('강의가 삭제되었습니다.');
			} else {
				alert(data.message || '삭제 중 오류가 발생했습니다.');
			}
		})
		.catch(error => {
			console.error('Error:', error);
			alert('삭제 중 오류가 발생했습니다.');
		});
}

// 개별 강의 추가
function addLecture() {
	const currentCount = document.querySelectorAll('.lecture-item').length + 1;
	const template = createLectureTemplate(currentCount);
	const container = document.getElementById('lectureContainer');

	// 템플릿을 DOM에 추가
	container.insertAdjacentHTML('beforeend', template);

	// 새로 추가된 강의 아이템에 이벤트 바인딩
	const newLectureItem = container.lastElementChild;
	bindNewLectureEvents(newLectureItem);

	updateTotalLectures();
}

// 새 강의 이벤트 바인딩
function bindNewLectureEvents(lectureItem) {
	const saveBtn = lectureItem.querySelector('.btn-save-lecture');
	const deleteBtn = lectureItem.querySelector('.btn-delete-lecture');

	saveBtn.onclick = () => saveLecture(lectureItem);
	deleteBtn.onclick = () => deleteLecture(lectureItem);
}

// 전체 저장 (일괄 저장)
function saveLecturePlan() {
	const unsavedLectures = document.querySelectorAll('.lecture-item:not([data-lecture-no])');

	if (unsavedLectures.length === 0) {
		alert('저장할 새로운 강의가 없습니다.');
		return;
	}

	if (!confirm(`${unsavedLectures.length}개의 강의를 저장하시겠습니까?`)) {
		return;
	}

	const lectures = Array.from(unsavedLectures).map(item => {
		const lectureOrder = parseInt(item.getAttribute('data-index'));
		const date = item.querySelector('.lecture-date').value;
		const startTime = item.querySelector('.lecture-start-time').value;
		const endTime = item.querySelector('.lecture-end-time').value;

		return {
			courseNo: courseNo,
			lectureOrder: lectureOrder,
			lectureTitle: item.querySelector('.lecture-title').value || `${lectureOrder}차시 강의`,
			eventStart: date && startTime ? combineDateTime(date, startTime) : null,
			eventEnd: date && endTime ? combineDateTime(date, endTime) : null,
			videoUrl: item.querySelector('.video-url').value || null
		};
	});

	// 서버에 저장 요청
	fetch(`${path}/member/teacher/mypage/lecturelist`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
		},
		body: JSON.stringify({
			courseNo: courseNo,
			lectures: lectures
		})
	})
		.then(response => response.json())
		.then(data => {
			if (data.success) {
				alert(data.message);
				location.reload(); // 성공시 페이지 새로고침
			} else {
				alert(data.message || '저장 중 오류가 발생했습니다.');
			}
		})
		.catch(error => {
			console.error('Error:', error);
			alert('저장 중 오류가 발생했습니다.');
		});
}

// 총 강의 수 업데이트
function updateTotalLectures() {
	const count = document.querySelectorAll('.lecture-item').length;
	document.getElementById('totalLectures').textContent = count;
}

// 페이지 로드시 실행
document.addEventListener('DOMContentLoaded', function() {
	// 기존 강의 수정/삭제 버튼 이벤트 바인딩
	document.querySelectorAll('.btn-edit-lecture').forEach(btn => {
		btn.onclick = () => enableEdit(btn.closest('.lecture-item'));
	});

	document.querySelectorAll('.btn-delete-lecture').forEach(btn => {
		btn.onclick = () => deleteLecture(btn.closest('.lecture-item'));
	});

	// 초기 총 강의 수 업데이트
	updateTotalLectures();
});