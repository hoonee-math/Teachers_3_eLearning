/**
 *  배너 이미지 관련 javaScript
 */

// JSP가 서버에서 처리될 때 contextPath를 실제 경로로 변환
const bannerImage = path + '/resources/images/커비.jpg';
console.log('설정된 이미지 경로:', bannerImage); // 경로 확인

// DOM이 로드된 후 배너 이미지 설정
document.addEventListener('DOMContentLoaded', function() {
	console.log('DOM 로드됨'); // DOM 로드 시점 확인
	
	const bannerContainer = document.getElementById('bannerContainer');
	console.log('배너 컨테이너 요소:', bannerContainer); // 요소 존재 여부 확인
	
	if(bannerContainer) {
		console.log('배너 컨테이너 찾음, 이미지 설정 시도');
		const bannerDiv = document.createElement('div');
		bannerDiv.className = 'banner-area';
		// 템플릿 리터럴 대신 일반 문자열 연결 사용
		bannerDiv.style.backgroundImage = 'url(' + bannerImage + ')';
		console.log('설정된 background-image:', bannerDiv.style.backgroundImage); // 실제 설정된 스타일 확인
		
		bannerContainer.appendChild(bannerDiv);
		console.log('배너 div 추가 완료');
	} else {
		console.log('배너 컨테이너를 찾을 수 없음');
	}
});