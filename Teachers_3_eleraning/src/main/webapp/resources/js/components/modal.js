/**
 * 
 */

// 모달 관련 기능을 담당하는 모듈
const Modal = (function() {
    // private 변수
    const modalWrapper = '.modal-wrapper';
    const modalContainer = '.modal-container';
    
    // private 함수
    function hideAllModals() {
        document.querySelector(modalWrapper).style.display = 'none';
        document.querySelectorAll(modalContainer).forEach(modal => {
            modal.style.display = 'none';
        });
    }
    
    // 초기화 함수 - 이벤트 리스너 설정
    function init() {
        // 모달 외부 클릭 시 닫기
        document.querySelector(modalWrapper).addEventListener('click', function(e) {
            if (e.target === this) {
                hideAllModals();
            }
        });

        // 모달 내부 클릭 시 이벤트 전파 중단
        document.querySelectorAll(modalContainer).forEach(container => {
            container.addEventListener('click', function(e) {
                e.stopPropagation();
            });
        });
		
		// ESC 키 이벤트 추가
		document.addEventListener('keydown', function(e) {
		    if (e.key === 'Escape' || e.key === 'Esc') {
		        hideAllModals();
		    }
		});
    }
    
    // public 함수
    return {
        show: function(modalType) {
            const backdrop = document.querySelector(modalWrapper);
            const modal = document.getElementById(`${modalType}Modal`);
            
            if (backdrop && modal) {
                backdrop.style.display = 'block';
                modal.style.display = 'block';

				// 로그인 모달일 경우 memberId input에 포커스
				if(modalType === 'login') {
				    // 약간의 지연을 주어 모달이 완전히 표시된 후 포커스
				    setTimeout(() => {
				        modal.querySelector('input[name="memberId"]').focus();
				    }, 100);
				}
            }
        },
        
        hide: hideAllModals,
        
        // 초기화 함수를 외부에 노출
        initialize: init
    };
})();

// DOM이 로드된 후 모달 초기화
document.addEventListener('DOMContentLoaded', function() {
    Modal.initialize();
});

// 전역에서 사용할 수 있도록 window 객체에 할당
window.Modal = Modal;