/**
 * 
 */
$(document).ready(function() {
	// 아코디언 메뉴 기능
	$('.accordion-header').click(function() {
		const content = $(this).next('.accordion-content');
		const isActive = $(this).hasClass('active');
		
		// 다른 모든 아코디언 닫기
		$('.accordion-header').removeClass('active');
		$('.accordion-content').slideUp(300);
		
		// 클릭된 아코디언 토글
		if (!isActive) {
		$(this).addClass('active');
		content.slideDown(300);
		}
	});

	// 탭 메뉴 기능
	$('.tab-button').click(function() {
		$('.tab-button').removeClass('active');
		$(this).addClass('active');
		// 탭 콘텐츠 전환 로직 추가
	});
});