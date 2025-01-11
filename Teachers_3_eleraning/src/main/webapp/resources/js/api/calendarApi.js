/**
 * calendar API implementation for Toast UI Calendar v2.1.3
 */
document.addEventListener('DOMContentLoaded', function() {
    console.log('DOMContentLoaded 이벤트 발생');

    // 캘린더 컨테이너
    const container = document.getElementById('calendar');
    console.log('캘린더 컨테이너:', container);

    try {
        // 캘린더 초기화, 캘린더 인스턴스 생성
        const calendar = new tui.Calendar(container, {
            defaultView: 'week',
            usageStatistics: false,
            isReadOnly: true,
            week: {
                startDayOfWeek: 0,
                dayNames: ['일', '월', '화', '수', '목', '금', '토'],
                workweek: false,
                hourStart: 8,
                hourEnd: 22,
                showNowIndicator: true,
                taskView: false,      // Task 행 제거
                eventView: ['time'],  // 시간별 일정만 표시
				milestoneView: false  // Removes the milestone row
            },
            gridSelection: false,      // 그리드 선택 기능 비활성화
            // 캘린더 테마 설정
            theme: {
                common: {
                    backgroundColor: '#ffffff',
                    border: '1px solid #e5e5e5',
                    gridSelection: {
                        backgroundColor: 'rgba(81, 92, 230, 0.05)',
                        border: '1px solid #FAB350'
                    }
                },
                week: {
                    dayName: {
                        borderLeft: '1px solid #e5e5e5',
                        borderTop: '1px solid #e5e5e5',
                        borderBottom: '1px solid #e5e5e5',
                        backgroundColor: '#f8f9fa'
                    },
                    timeGrid: {
                        borderRight: '1px solid #e5e5e5'
                    }
                }
            },
            calendars: [
                {id: '국어', name: '국어', color: '#ffffff', backgroundColor: '#FF9AA2'},
                {id: '영어', name: '영어', color: '#ffffff', backgroundColor: '#FFB7B2'},
                {id: '수학', name: '수학', color: '#ffffff', backgroundColor: '#FFDAC1'},
                {id: '과학', name: '과학', color: '#ffffff', backgroundColor: '#B5EAD7'},
                {id: '사회', name: '사회', color: '#ffffff', backgroundColor: '#C7CEEA'}
            ]
        });

        // 초기 데이터 로드
        loadEvents();

        // 토글 버튼 이벤트 리스너 설정
        const viewToggle = document.getElementById('viewToggle');
        if (viewToggle) {
            viewToggle.addEventListener('change', function(e) {
                loadEvents(e.target.checked ? 'my' : 'all');
            });
        }

        // 학년 필터 변경 이벤트 리스너
        const gradeFilter = document.getElementById('gradeFilter');
        if (gradeFilter) {
            gradeFilter.addEventListener('change', function(e) {
                sessionStorage.setItem('gradeNum', e.target.value);
                loadEvents();
            });
        }

        // 일정 데이터 로드 함수
        function loadEvents(viewType = 'all') {
            const grade = sessionStorage.getItem('gradeNum') || '1';
            const params = new URLSearchParams({
                grade: grade,
                view: viewType
            });

            fetch(`${path}/api/calendar/events?${params}`)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('서버 응답 오류: ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    if (!data || !data.events) {
                        console.warn('유효한 이벤트 데이터가 없습니다');
                        return;
                    }
                    
                    calendar.clear();
                    const events = transformEvents(data);
                    if (events && events.length > 0) {
                        calendar.createEvents(events);
                        console.log(`${events.length}개의 이벤트가 로드되었습니다`);
                    }
                })
                .catch(error => {
                    console.error('일정 로드 중 오류:', error);
                    // 사용자에게 에러 알림
                    Swal.fire({
                        icon: 'error',
                        title: '일정 로드 실패',
                        text: '일정을 불러오는 중 문제가 발생했습니다. 잠시 후 다시 시도해주세요.'
                    });
                });
        }

        // 이벤트 데이터 변환 함수
        function transformEvents(data) {
            return data.events.map(event => ({
                id: String(event.EVENT_NO),
                calendarId: event.TEACHER_SUBJECT,
                title: event.EVENT_TITLE,
                start: event.EVENT_START,
                end: event.EVENT_END,
                category: 'time',
                isReadOnly: true,
                raw: {
                    EVENT_NO: event.EVENT_NO,
                    EVENT_TITLE: event.EVENT_TITLE,
                    COURSE_NO: event.COURSE_NO,
                    COURSE_TITLE: event.COURSE_TITLE,
                    TEACHER_NAME: event.TEACHER_NAME,
                    TEACHER_SUBJECT: event.TEACHER_SUBJECT,
                    VIDEO_URL: event.VIDEO_URL,
                    isEnrolled: data.enrolledCourses ? 
                               data.enrolledCourses.includes(event.COURSE_NO) : 
                               false
                }
            }));
        }

        // 시간 포맷팅 함수
        function formatTime(date) {
            return new Date(date).toLocaleTimeString('ko-KR', {
                hour: '2-digit',
                minute: '2-digit'
            });
        }

        // 일정 클릭 이벤트 핸들러
        calendar.on('clickEvent', function(eventObj) {
            const event = eventObj.event;
            const raw = event.raw;
            const now = new Date();
            const startTime = new Date(event.start);
            const canAccess = raw.isEnrolled && 
                ((startTime - now) <= 30 * 60 * 1000); // 30분 이내

            const modalContent = `
               <div class="event-detail-modal">
                   <h3>${event.title}</h3>
                   <p><strong>강좌:</strong> ${raw.COURSE_TITLE}</p>
                   <p><strong>강사:</strong> ${raw.TEACHER_NAME}</p>
                   <p><strong>과목:</strong> ${raw.TEACHER_SUBJECT}</p>
                   <p><strong>시간:</strong> ${formatTime(event.start)} ~ ${formatTime(event.end)}</p>
                   ${raw.VIDEO_URL ?
                    canAccess ?
                        `<a href="${raw.VIDEO_URL}" target="_blank" class="video-link">강의 입장하기</a>` :
                        `<span class="video-link disabled">강의 시작 30분 전부터 입장 가능합니다</span>`
                    : ''}
               </div>
           `;

            Swal.fire({
                html: modalContent,
                showConfirmButton: false,
                showCloseButton: true
            });
        });

    } catch (error) {
        console.error('캘린더 초기화 중 오류:', error);
    }
});