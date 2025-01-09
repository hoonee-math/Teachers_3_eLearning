document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('newCourseForm').addEventListener('submit', function(e) {
        e.preventDefault();
        
        // 폼 데이터 수집 및 검증
        const formData = new FormData(this);
        
        // FormData 내용 확인 (디버깅용)
        for (let pair of formData.entries()) {
            console.log(pair[0] + ': ' + pair[1]);
        }
        
        // FormData를 URL-encoded 문자열로 변환
        const data = new URLSearchParams(formData);
        
        // AJAX 요청
        fetch(`${path}/member/teacher/course/register`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: data
        })
        .then(response => response.json())
        .then(data => {
            if(data.success) {
                alert('강좌가 성공적으로 등록되었습니다.');
                closeModal();
                location.reload();
            } else {
                alert(data.message || '강좌 등록에 실패했습니다.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('강좌 등록 중 오류가 발생했습니다.');
        });
    });
});

// 폼 데이터 검증 함수
function validateFormData(formData) {
    // 필수 필드 검증
    const requiredFields = ['courseTitle', 'courseDesc', 'courseCategoryNo', 'grade', 'coursePrice', 'beginDate'];
    for (let field of requiredFields) {
        if (!formData.get(field)) {
            alert(`${field} 필드는 필수입니다.`);
            return false;
        }
    }

    // 가격 검증
    const price = formData.get('coursePrice');
    if (isNaN(price) || price < 0) {
        alert('올바른 가격을 입력해주세요.');
        return false;
    }

    // 할인율 검증 (필수는 아님)
    const discount = formData.get('coursePriceSale') || '0';
    if (isNaN(discount) || discount < 0 || discount > 100) {
        alert('할인율은 0-100 사이의 값이어야 합니다.');
        return false;
    }

    return true;
}

// 모달 제어 함수들
function openModal() {
    document.getElementById('newCourseModal').style.display = 'block';
}

function closeModal() {
    document.getElementById('newCourseModal').style.display = 'none';
    document.getElementById('newCourseForm').reset();
}