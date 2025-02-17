/**
 * calendar API implementation for Toast UI Calendar v2.1.3
 */
// 공통 URL 설정 예시
const EXTERNAL_URLS = {
    COURSE_DETAIL: "https://us04web.zoom.us/j/7867964543?pwd=RFI5Vk5lSEtaMmJtZmVlbWx0VXE5UT09&omn=74834074218", // 강의 상세정보 기본 URL
    LECTURE_ROOM: "https://us04web.zoom.us/j/7867964543?pwd=RFI5Vk5lSEtaMmJtZmVlbWx0VXE5UT09&omn=74834074218",   // 강의실 입장 기본 URL
    VIDEO_STREAM: "https://us04web.zoom.us/j/7867964543?pwd=RFI5Vk5lSEtaMmJtZmVlbWx0VXE5UT09&omn=74834074218"          // 영상 스트리밍 기본 URL
};

document.addEventListener('DOMContentLoaded', function() {
    console.log('DOMContentLoaded 이벤트 발생');

    // 캘린더 컨테이너
    const container = document.getElementById('calendar');
    console.log('캘린더 컨테이너:', container);
	
	// 현재 시간 기준 변수 설정
	const now = new Date();
	console.log('현재 시간:', now);
	
	// 샘플 일정 데이터 - TUI Calendar 형식에 맞춰 수정
	// v2.1.3 객체 정보로 수정
	// 샘플 일정 데이터 - 현재 시점(2025년) 기준으로 수정
	const events = [{
		id: '1',
		calendarId: 'cal1',
		title: '수학 기초 개념 학습',
		category: 'time',
		start: new Date('2025-01-13T10:00:00'),  // 2024 -> 2025
		end: new Date('2025-01-13T12:00:00'),	// 2024 -> 2025
		isAllday: false,
		state: 'busy',
		raw: {
			class: 'public'
		},
		location: '온라인',
		attendees: ['학생1'],
		color: '#ffffff',
		backgroundColor: '#FAB350'
	}, {
		id: '2',
		calendarId: 'cal1',
		title: '영어 문법 스터디',
		category: 'time',
		start: new Date('2025-01-05T14:00:00'),  // 2024 -> 2025
		end: new Date('2025-01-05T14:00:00'),	// 2024 -> 2025
		isAllday: false,
		state: 'busy',
		raw: {
			class: 'public'
		},
		location: '온라인',
		attendees: ['학생1'],
		color: '#ffffff',
		backgroundColor: '#4A90E2'
	}, {
		id: '3',
		calendarId: 'cal1',
		title: '과학 실험 보고서 작성',
		category: 'time',
		start: new Date('2025-01-16T13:00:00'),  // 2024 -> 2025
		end: new Date('2025-01-16T15:00:00'),	// 2024 -> 2025
		isAllday: false,
		state: 'busy',
		raw: {
			class: 'public'
		},
		location: '온라인',
		attendees: ['학생1'],
		color: '#ffffff',
		backgroundColor: '#50B766'
	},
	{
	    id: '4',
	    calendarId: '국어',
	    title: '고전문학 특강',
	    category: 'time',
	    start: new Date('2025-01-13T09:00:00'),
	    end: new Date('2025-01-13T11:00:00'),
	    isAllday: false,
	    state: 'busy',
	    raw: { class: 'public' },
	    location: '온라인',
	    attendees: ['학생1'],
	    color: '#ffffff',
	    backgroundColor: '#FF9AA2'
	}, {
	    id: '5',
	    calendarId: '영어',
	    title: '토익 실전 모의고사',
	    category: 'time',
	    start: new Date('2025-01-13T13:00:00'),
	    end: new Date('2025-01-13T15:00:00'),
	    isAllday: false,
	    state: 'busy',
	    raw: { class: 'public' },
	    location: '온라인',
	    attendees: ['학생1'],
	    color: '#ffffff',
	    backgroundColor: '#FFB7B2'
	}, {
	    id: '6',
	    calendarId: '수학',
	    title: '미적분 개념 정리',
	    category: 'time',
	    start: new Date('2025-01-14T10:00:00'),
	    end: new Date('2025-01-14T12:00:00'),
	    isAllday: false,
	    state: 'busy',
	    raw: { class: 'public' },
	    location: '온라인',
	    attendees: ['학생1'],
	    color: '#ffffff',
	    backgroundColor: '#FFDAC1'
	}, {
	    id: '7',
	    calendarId: '과학',
	    title: '생명과학 실험 특강',
	    category: 'time',
	    start: new Date('2025-01-14T14:00:00'),
	    end: new Date('2025-01-14T16:00:00'),
	    isAllday: false,
	    state: 'busy',
	    raw: { class: 'public' },
	    location: '온라인',
	    attendees: ['학생1'],
	    color: '#ffffff',
	    backgroundColor: '#B5EAD7'
	}, {
	    id: '8',
	    calendarId: '사회',
	    title: '한국사 심화 특강',
	    category: 'time',
	    start: new Date('2025-01-15T09:30:00'),
	    end: new Date('2025-01-15T11:30:00'),
	    isAllday: false,
	    state: 'busy',
	    raw: { class: 'public' },
	    location: '온라인',
	    attendees: ['학생1'],
	    color: '#ffffff',
	    backgroundColor: '#C7CEEA'
	}, {
	    id: '9',
	    calendarId: '국어',
	    title: '현대문학 작품 분석',
	    category: 'time',
	    start: new Date('2025-01-15T13:30:00'),
	    end: new Date('2025-01-15T15:30:00'),
	    isAllday: false,
	    state: 'busy',
	    raw: { class: 'public' },
	    location: '온라인',
	    attendees: ['학생1'],
	    color: '#ffffff',
	    backgroundColor: '#FF9AA2'
	}, {
	    id: '10',
	    calendarId: '영어',
	    title: '영문법 마스터 클래스',
	    category: 'time',
	    start: new Date('2025-01-16T10:00:00'),
	    end: new Date('2025-01-16T12:00:00'),
	    isAllday: false,
	    state: 'busy',
	    raw: { class: 'public' },
	    location: '온라인',
	    attendees: ['학생1'],
	    color: '#ffffff',
	    backgroundColor: '#FFB7B2'
	}, {
	    id: '11',
	    calendarId: '수학',
	    title: '기하와 벡터 특강',
	    category: 'time',
	    start: new Date('2025-01-16T14:00:00'),
	    end: new Date('2025-01-16T16:00:00'),
	    isAllday: false,
	    state: 'busy',
	    raw: { class: 'public' },
	    location: '온라인',
	    attendees: ['학생1'],
	    color: '#ffffff',
	    backgroundColor: '#FFDAC1'
	}, {
	    id: '12',
	    calendarId: '과학',
	    title: '화학 실전 문제 풀이',
	    category: 'time',
	    start: new Date('2025-01-17T09:00:00'),
	    end: new Date('2025-01-17T11:00:00'),
	    isAllday: false,
	    state: 'busy',
	    raw: { class: 'public' },
	    location: '온라인',
	    attendees: ['학생1'],
	    color: '#ffffff',
	    backgroundColor: '#B5EAD7'
	}, {
	    id: '13',
	    calendarId: '사회',
	    title: '세계사 주요 테마 정리',
	    category: 'time',
	    start: new Date('2025-01-17T13:00:00'),
	    end: new Date('2025-01-17T15:00:00'),
	    isAllday: false,
	    state: 'busy',
	    raw: { class: 'public' },
	    location: '온라인',
	    attendees: ['학생1'],
	    color: '#ffffff',
	    backgroundColor: '#C7CEEA'
	}

	];

	let calendar;
		
    try {
        // 캘린더 초기화, 캘린더 인스턴스 생성
        calendar = new tui.Calendar(container, {
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
				taskView: false,      // Removes the task row
				eventView: ['time'],  // Only shows time-based events
				milestoneView: false  // Removes the milestone row
            },
            //gridSelection: false,      // 그리드 선택 기능
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
		
		// 일정 추가 시도
		calendar.createEvents(events); // createSchedules 대신 createEvents 사용
		console.log('일정 추가 성공');

		// 날짜 이동
		calendar.setDate(now);
		console.log('날짜 설정 성공');
	} catch (error) {
		console.error('캘린더 에러:', error);
	}

	// 캘린더 초기화 코드...
	// 이벤트 추가 코드...
	// 날짜를 한글 형식으로 변환하는 함수
	function formatDateToKorean(date) {
	    const month = date.getMonth() + 1;  // getMonth()는 0부터 시작
	    const day = date.getDate();
	    const hours = date.getHours().toString().padStart(2, '0');
	    const minutes = date.getMinutes().toString().padStart(2, '0');
	    
	    return `${month}월 ${day}일 ${hours}시 ${minutes}분`;
	}
	// 클릭 이벤트 처리 코드...

	// 일정 클릭 이벤트
	// Change from clickSchedule to clickEvent
	// calendarApi.js 수정
	calendar.on('clickEvent', function(eventObj) {
	    console.log('Event clicked:', eventObj);
	    
	    const event = eventObj.event;
	    const width = 400;
	    const height = 350;
	    const left = (window.innerWidth - width) / 2;
	    const top = (window.innerHeight - height) / 2;
	    
	    // 버튼 HTML을 조건부로 생성
	    const buttonHtml = isLoggedIn ? `
	        <div class="button-container">
	            <a href="${EXTERNAL_URLS.COURSE_DETAIL}/${event.id}" class="lecture-button" target="_blank">강의 상세보기</a>
	            <a href="${EXTERNAL_URLS.LECTURE_ROOM}/${event.id}" class="lecture-button" target="_blank">강의실 입장</a>
	        </div>
	    ` : `
	        <div class="button-container">
	            <p style="color: #666; text-align: center;">강의 정보를 보려면 로그인이 필요합니다.</p>
	            <a href="#" class="lecture-button" onclick="window.opener.Modal.show('login'); window.close();">로그인하기</a>
	        </div>
	    `;

	    const popupContent = `
	        <!DOCTYPE html>
	        <html>
	        <head>
	            <title>강의 상세 정보</title>
	            <style>
	                body { 
	                    font-family: Arial, sans-serif; 
	                    padding: 20px; 
	                }
	                h2 { 
	                    color: #333; 
	                    margin-bottom: 20px; 
	                }
	                .info-row { 
	                    margin-bottom: 10px; 
	                }
	                .label { 
	                    font-weight: bold; 
	                    color: #666; 
	                }
	                .button-container {
	                    margin-top: 20px;
	                    text-align: center;
	                }
	                .lecture-button {
	                    background-color: #FAB350;
	                    color: white;
	                    padding: 10px 20px;
	                    border: none;
	                    border-radius: 5px;
	                    cursor: pointer;
	                    text-decoration: none;
	                    display: inline-block;
	                    margin: 0 5px;
	                }
	                .lecture-button:hover {
	                    background-color: #e59d3b;
	                }
	                .lecture-button.disabled {
	                    background-color: #cccccc;
	                    cursor: not-allowed;
	                }
	            </style>
	        </head>
	        <body>
	            <h2>${event.title}</h2>
	            <div class="info-row">
	                <span class="label">과목:</span> ${event.calendarId}
	            </div>
	            <div class="info-row">
	                <span class="label">시작:</span> ${formatDateToKorean(event.start)}
	            </div>
	            <div class="info-row">
	                <span class="label">종료:</span> ${formatDateToKorean(event.end)}
	            </div>
	            <div class="info-row">
	                <span class="label">장소:</span> ${event.location || '온라인'}
	            </div>
	            ${buttonHtml}
	        </body>
	        </html>
	    `;
	       
	    const popup = window.open('', 'eventPopup', 
	        `width=${width},height=${height},left=${left},top=${top},resizable=yes,scrollbars=yes`);
	        
	    popup.document.write(popupContent);
	    popup.document.close();
	});
		
});