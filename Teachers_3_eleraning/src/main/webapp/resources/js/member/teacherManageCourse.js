/**
 *  필터링과 페이징을 처리할 JavaScript 함수
 */

// 상태 필터링
function filterByStatus(status) {
	const url = new URL(window.location);
	url.searchParams.set('status', status);
	url.searchParams.set('cpage', '1'); // 필터 변경시 첫 페이지로
	window.location.href = url.toString();
}

// 표시 개수 변경
function changeDisplayCount(count) {
	const url = new URL(window.location);
	url.searchParams.set('numPerPage', count);
	url.searchParams.set('cpage', '1'); // 개수 변경시 첫 페이지로
	window.location.href = url.toString();
}

// 강의 관리 페이지로 이동
function goToLectureManage(courseNo) {
	location.href = `${path}/member/teacher/mypage/lecturelist?courseNo=${courseNo}`;
}