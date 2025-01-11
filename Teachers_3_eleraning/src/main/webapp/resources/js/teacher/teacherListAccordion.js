/**
 * 선생님 목록 아코디언 메뉴 및 과목별 선생님 목록 로드
 */
$(document).ready(function() {
    // 초기 상태 설정
    $('.accordion-content').hide();

    // 아코디언 메뉴 기능 
    $('.accordion-header').click(function() {
        const content = $(this).next('.accordion-content');
        const isActive = $(this).hasClass('active');
        const subject = $(this).data('subject');

        // 다른 모든 아코디언 닫기
        $('.accordion-header').removeClass('active');
        $('.accordion-content').slideUp(300);

        // 클릭된 아코디언 토글
        if (!isActive) {
            $(this).addClass('active');
            content.slideDown(300);
            
            // 과목 선택시 해당 과목의 1페이지로 이동
            location.href = `${path}/teacher/list_and_detail?subject=\${subject}&cpage=1`;
            
            // 오른쪽 섹션 상단 과목 타이틀 업데이트
            $('.list-title').text(subject + ' 선생님');
        }
    });
});

// 선생님 카드 클릭시 상세페이지로 이동
$(document).on('click', '.teacher-card', function() {
    const memberNo = $(this).data('memberno');
    if(memberNo) {
        location.href = `${path}/teacher/detail/\${memberNo}`;
    }
});