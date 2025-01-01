/**
 * 
 */

// popular-courses.js
document.addEventListener('DOMContentLoaded', () => {
    const tabs = document.querySelectorAll('.popular-category-tab');
    const courseLists = document.querySelectorAll('.popular-course-list');
    
    tabs.forEach(tab => {
        tab.addEventListener('click', () => {
            const category = tab.dataset.category;
            
            // 탭 활성화
            tabs.forEach(t => t.classList.remove('active'));
            tab.classList.add('active');
            
            // 강좌 목록 표시
            courseLists.forEach(list => {
                if(list.dataset.category === category) {
                    list.classList.add('active');
                } else {
                    list.classList.remove('active');
                }
            });
            
            console.log('Category changed:', category);
        });
    });
});