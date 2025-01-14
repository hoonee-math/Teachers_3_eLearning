/**
 * 
 */let currentPage = 1;
let currentSubject = 'all';
let filteredTeachers = [...allTeachers];

// 교사 목록 표시 함수
function displayTeachers(page) {
    const startIndex = (page - 1) * itemsPerPage;
    const endIndex = startIndex + itemsPerPage;
    const teachersToShow = filteredTeachers.slice(startIndex, endIndex);
    
    const teacherListDiv = document.querySelector('.teacher-list.real-data');
    teacherListDiv.innerHTML = teachersToShow.map(teacher => {
        // 이미지 경로 처리
        const imagePath = teacher.image && teacher.image.renamed ? 
            path + '/resources/images/profile/' + teacher.image.renamed :
            path + '/resources/images/common/default-profile.png';
            
        return `
            <div class="teacher-card" data-memberNo="${teacher.memberNo}" data-subject="${teacher.teacherSubjectName}">
                <div class="teacher-image">
                    <img src="${imagePath}" alt="${teacher.memberName} 선생님">
                </div>
                <div class="teacher-info">
                    <h3>${teacher.memberName} 선생님</h3>
                    <p class="teacher-description">
                        ${teacher.teacherInfoTitle || ''} ${teacher.teacherInfoContent || ''}
                    </p>
                </div>
            </div>
        `;
    }).join('');

    // 페이징 업데이트 호출 추가
    updatePagination(page);
}

// 페이징 UI 업데이트 함수 수정
function updatePagination(currentPage) {
    const totalPages = Math.ceil(filteredTeachers.length / itemsPerPage);
    const paginationDiv = document.getElementById('teacherPagination');
    const pageBarSize = 5; // 페이지 바에 표시할 페이지 수
    
    // 시작 페이지와 끝 페이지 계산
    const pageStart = Math.floor((currentPage - 1) / pageBarSize) * pageBarSize + 1;
    let pageEnd = pageStart + pageBarSize - 1;
    if (pageEnd > totalPages) pageEnd = totalPages;
    
    let paginationHTML = '';
    
    // 이전 페이지 버튼
    if (pageStart > 1) {
        paginationHTML += `<a href="javascript:void(0)" onclick="goToPage(${pageStart - 1})" class="page-arrow">&lt;</a>`;
    }
    
    // 페이지 번호
    for (let i = pageStart; i <= pageEnd; i++) {
        if (i === currentPage) {
            paginationHTML += `<span class="current-page">${i}</span>`;
        } else {
            paginationHTML += `<a href="javascript:void(0)" onclick="goToPage(${i})">${i}</a>`;
        }
    }
    
    // 다음 페이지 버튼
    if (pageEnd < totalPages) {
        paginationHTML += `<a href="javascript:void(0)" onclick="goToPage(${pageEnd + 1})" class="page-arrow">&gt;</a>`;
    }
    
    paginationDiv.innerHTML = paginationHTML;
}
// 페이지 이동 함수
function goToPage(page) {
    currentPage = page;
    displayTeachers(page);
}

// 과목별 필터링 함수
function filterBySubject(subject) {
    currentSubject = subject;
    if (subject === 'all') {
        filteredTeachers = [...allTeachers];
    } else {
        filteredTeachers = allTeachers.filter(teacher => 
            teacher.teacherSubjectName === subject
        );
    }
    currentPage = 1; // 필터링 후 첫 페이지로 이동
    displayTeachers(1);
    
    // 과목 타이틀 업데이트
    document.querySelector('.list-title').textContent = subject + ' 선생님';
}

// 페이지 로드 시 초기화
document.addEventListener('DOMContentLoaded', () => {
    displayTeachers(1);
});

// 아코디언 메뉴 클릭 이벤트에 필터링 추가
document.querySelectorAll('.accordion-header').forEach(header => {
    header.addEventListener('click', function() {
        const subject = this.dataset.subject;
        filterBySubject(subject);
    });
});