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
	// 샘플 일정 데이터 삭제 - 현재 시점(2025년) 기준으로 수정
	
	//let calendar; // calendar 변수를 바깥에서 선언
	//캘린더 인스턴스를 내부에서 생성

	try {
		// 캘린더 초기화 전 calendar의 메서드들 확인
		console.log('calendar prototype 사용 가능한 메서드들:', Object.getOwnPropertyNames(tui.Calendar.prototype));
		/* console.log('calendar instance methods:', Object.getOwnPropertyNames(calendar));
		console.log('calendar defaultOptions:', calendar.getOptions()); */

		// 캘린더 초기화, 캘린더 인스턴스 생성
		// const로 캘린더 인스턴스 생성
		const calendar = new tui.Calendar(container, { // 'tui.Calendar' 대신 'toastui.Calendar' 사용
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
		console.log('캘린더 인스턴스 생성 성공:', calendar);
		// calendar 인스턴스의 상태 확인
		console.log('calendar store 상태:', calendar.getStoreState());
		console.log('calendar 뷰 타입:', calendar.getViewName());
		console.log('calendar 현재 날짜:', calendar.getDate());
		// 이벤트 추가
		//calendar.createEvents(events); // createSchedules 대신 createEvents 사용
		// TUI Calendar v2.1.3에서는 다음 메서드들을 사용
		//const currentEvents = calendar.getDisplayEvents();
		//const targetDate = new Date('2025-01-05');
		//const eventsInRange = calendar.getEventsByRange(targetDate, new Date(targetDate.getTime() + 24 * 60 * 60 * 1000)
		// 날짜 이동
		//calendar.setDate(now); console.log('날짜 설정 성공');
		
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
				.then(response => response.json())
				.then(data => {
					calendar.clear();
					const events = transformEvents(data);
					calendar.createEvents(events);
				})
				.catch(error => console.error('일정 로드 중 오류:', error));
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

		console.log('캘린더 초기화 완료');

	} catch (error) {
		console.error('캘린더 초기화 중 오류:', error);
	}

	/*// 일정 클릭 이벤트
	calendar.on('clickSchedule', function(event) {
		const schedule = event.schedule;
		alert(
			'일정: ' + schedule.title +
			'\n시작: ' + schedule.start.toLocaleString() +
			'\n종료: ' + schedule.end.toLocaleString()
		);
	});*/
});