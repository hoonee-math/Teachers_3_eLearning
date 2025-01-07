/**
 * 
 */

//학년에 대한 숫자값 넘겨주기
//서블릿에서 이용하기 위해 input 태그 안에 넣어주는 로직
$(document).ready(function() {
	const gradeNum = parseInt(sessionStorage.getItem('gradeNum'));
	$('#gradeNum').val(gradeNum);
	
	//URL 파라미터에 gradeNum 추가 
	$('.pagination a').each(function() {
	    let href = $(this).attr('href');
	    href += href.includes('?') ? '&' : '?';
		href += 'gradeNum=' + gradeNum;
		$(this).attr('href', href);
	});
	
		//과목 링크에 gradeNum 추가
	$('.menu-list a').each(function() {
		let href = $(this).attr('href');
		href += href.includes('?') ? '&' : '?';
		href += 'gradeNum=' + gradeNum;
		$(this).attr('href', href);
	});
})


// DOM이 로드된 후 실행
document.addEventListener('DOMContentLoaded', function() {
	// 체크박스 전체 선택/해제 기능 구현 예정
	const checkboxes = document.querySelectorAll('input[name="selectedCourse"]');

	// 장바구니 버튼 클릭 이벤트
	document.querySelector('.cart-btn').addEventListener('click', function() {
		const selectedCourses = [];
		checkboxes.forEach(checkbox => {
			if (checkbox.checked) {
				selectedCourses.push(checkbox.value);
			}
		});

		if (selectedCourses.length === 0) {
			alert('선택된 강좌가 없습니다.');
			return;
		}

		// AJAX로 장바구니 추가 요청 보내기
		fetch('/cart/add', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json',
			},
			body: JSON.stringify({
				courseNos: selectedCourses
			})
		})
			.then(response => response.json())
			.then(data => {
				if (data.success) {
					alert('선택한 강좌가 장바구니에 추가되었습니다.');
				} else {
					alert('장바구니 추가 중 오류가 발생했습니다.');
				}
			})
			.catch(error => {
				console.error('Error:', error);
				alert('장바구니 추가 중 오류가 발생했습니다.');
			});
	});

	// 바로구매 버튼 클릭 이벤트
	document.querySelector('.purchase-btn').addEventListener('click', function() {
		const selectedCourses = [];
		checkboxes.forEach(checkbox => {
			if (checkbox.checked) {
				selectedCourses.push(checkbox.value);
			}
		});

		if (selectedCourses.length === 0) {
			alert('선택된 강좌가 없습니다.');
			return;
		}

		// 선택된 강좌들의 courseNo를 쿼리스트링으로 만들어서 결제 페이지로 이동
		const queryString = selectedCourses.map(courseNo => `courseNo=${courseNo}`).join('&');
		window.location.href = `/payment?${queryString}`;
	});

	// 맛보기 버튼 클릭 이벤트
	document.querySelectorAll('.preview-btn').forEach(btn => {
		btn.addEventListener('click', function() {
			const courseCard = this.closest('.course-card');
			const courseNo = courseCard.querySelector('input[name="selectedCourse"]').value;

			// 맛보기 동영상 팝업 또는 페이지로 이동
			window.location.href = `/course/preview/${courseNo}`;
		});
	});
});