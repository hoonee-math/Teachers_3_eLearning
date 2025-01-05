/**
 * 
 */
document.addEventListener('DOMContentLoaded', function() {
	console.log('DOMContentLoaded 이벤트 발생');

	// 캘린더 컨테이너
	const container = document.getElementById('calendar');
	console.log('캘린더 컨테이너:', container);

	// 현재 시간 기준 변수 설정
	const now = new Date();
	console.log('현재 시간:', now);

	// 캘린더 초기화 전 tui 객체 확인
	console.log('tui 객체 확인:', tui);

	// 샘플 일정 데이터 - TUI Calendar 형식에 맞춰 수정
	// v2.1.3 객체 정보로 수정
	// 샘플 일정 데이터 - 현재 시점(2025년) 기준으로 수정
	const events = [{
		id: '1',
		calendarId: 'cal1',
		title: '수학 기초 개념 학습',
		category: 'time',
		start: new Date('2025-01-05T10:00:00'),  // 2024 -> 2025
		end: new Date('2025-01-05T12:00:00'),	// 2024 -> 2025
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
		end: new Date('2025-01-05T16:00:00'),	// 2024 -> 2025
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
		start: new Date('2025-01-06T13:00:00'),  // 2024 -> 2025
		end: new Date('2025-01-06T15:00:00'),	// 2024 -> 2025
		isAllday: false,
		state: 'busy',
		raw: {
			class: 'public'
		},
		location: '온라인',
		attendees: ['학생1'],
		color: '#ffffff',
		backgroundColor: '#50B766'
	}];

	// 샘플 일정 데이터 로깅
	console.log('이벤트 데이터:', events);

	let calendar; // calendar 변수를 바깥에서 선언

	try {
		// 캘린더 초기화 전 calendar의 메서드들 확인
		console.log('calendar prototype 사용 가능한 메서드들:', Object.getOwnPropertyNames(tui.Calendar.prototype));
		/* console.log('calendar instance methods:', Object.getOwnPropertyNames(calendar));
		console.log('calendar defaultOptions:', calendar.getOptions()); */

		// 캘린더 초기화, 캘린더 인스턴스 생성
		calendar = new tui.Calendar(container, { // 'tui.Calendar' 대신 'toastui.Calendar' 사용
			defaultView: 'week', // 주간 뷰 설정
			usageStatistics: false,
			isReadOnly: false, // 수정 가능하도록 설정
			week: {
				startDayOfWeek: 0, // 일요일부터 시작
				dayNames: ['일', '월', '화', '수', '목', '금', '토'],
				workweek: false,
				hourStart: 8,
				hourEnd: 22
				// 주말 포함
			},
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
			calendars: [{
				id: 'cal1',
				name: '학습일정',
				color: '#ffffff',
				backgroundColor: '#FAB350'
			}]
		});
		console.log('캘린더 인스턴스 생성 성공:', calendar);

		// calendar 인스턴스의 상태 확인
		console.log('calendar store 상태:', calendar.getStoreState());
		console.log('calendar 뷰 타입:', calendar.getViewName());
		console.log('calendar 현재 날짜:', calendar.getDate());

		// 일정 추가 시도
		try {
			// 이벤트 추가 전 확인
			console.log('calendar 인스턴스:', calendar);

			// calendar의 모든 메서드 확인
			console.log('calendar methods:', Object.getOwnPropertyNames(Object.getPrototypeOf(calendar)));

			// 이벤트 추가
			calendar.createEvents(events); // createSchedules 대신 createEvents 사용
			console.log('일정 추가 성공');

			try {
				// TUI Calendar v2.1.3에서는 다음 메서드들을 사용
				// 현재 뷰에 표시된 이벤트 가져오기
				const currentEvents = calendar.getDisplayEvents();
				console.log('현재 표시된 이벤트:', currentEvents);

				// 특정 날짜의 이벤트 가져오기
				const targetDate = new Date('2025-01-05');
				const eventsInRange = calendar.getEventsByRange(
					targetDate,
					new Date(targetDate.getTime() + 24 * 60 * 60 * 1000)
				);
				console.log('2024-01-05의 이벤트:', eventsInRange);
			} catch (error) {
				console.error('이벤트 조회 중 에러:', error);
			}

			// 날짜 이동
			calendar.setDate(now);
			console.log('날짜 설정 성공');
		} catch (error) {
			console.error('일정 추가 중 에러:', error);
		}

	} catch (error) {
		console.error('캘린더 에러:', error);
	}

	// 일정 클릭 이벤트
	calendar.on('clickSchedule', function(event) {
		const schedule = event.schedule;
		alert(
			'일정: ' + schedule.title +
			'\n시작: ' + schedule.start.toLocaleString() +
			'\n종료: ' + schedule.end.toLocaleString()
		);
	});
});