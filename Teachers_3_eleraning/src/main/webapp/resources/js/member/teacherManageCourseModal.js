/**
 * 모달 관련 함수
 */

function openModal() {
    document.getElementById('newCourseModal').style.display = 'block';
}

function closeModal() {
    document.getElementById('newCourseModal').style.display = 'none';
}

// 강좌 등록 폼 제출 처리
document.getElementById('newCourseForm').addEventListener('submit', function(e) {
    e.preventDefault();
    
    const formData = new FormData(this);
    
    fetch('${path}/member/teacher/course/register', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if(data.success) {
            alert('강좌가 등록되었습니다.');
            location.reload();
        } else {
            alert('강좌 등록에 실패했습니다.');
        }
    });
});