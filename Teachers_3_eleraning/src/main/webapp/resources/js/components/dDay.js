/*
1. 페이지 로드
2. DOMContentLoaded 이벤트 발생
3. DdayManager 인스턴스 생성
4. initialize() 메서드 실행
5. loadAdminDday() 메서드에서 fetch API로 '/admin/dday' 엔드포인트에 GET 요청
6. 서버에서 응답 받으면 관리자 D-day 정보 업데이트

요청이 실패하거나 오류가 발생하면 쿠키에 저장된 기존 데이터를 사용
*/

class DdayManager {
	constructor(containerId) {
		this.container = document.getElementById(containerId);
		if (!this.container) {
			console.error('D-day 컨테이너를 찾을 수 없습니다.');
			return;
		}
		
		this.events = [];			 // 사용자 설정 D-day
		this.adminEvent = null;	   // 관리자 설정 D-day
		this.allMessages = [];		// 모든 메시지(관리자+사용자+오늘날짜)
		this.currentIndex = 0;
		
		this.initialize();
	}

	initialize() {
		this.loadUserEvents();
		this.loadAdminDday();  // 여기서 Ajax 요청
		this.initializeUI();
		this.startRotation();

		// 예: 60분마다 관리자 D-day 정보 업데이트
		setInterval(() => {
		    this.loadAdminDday();
		}, 60 * 60 * 1000);
	}

	loadUserEvents() {
		const savedEvents = getCookie('ddayEvents');
		this.events = savedEvents ? JSON.parse(savedEvents) : [];
	}

	saveUserEvents() {
		setCookie('ddayEvents', JSON.stringify(this.events), 365);
		this.updateAllMessages();
	}

	loadAdminDday() {
		fetch(`${path}/admin/dday`)
			.then(response => response.json())
			.then(result => {
				if (result.success && result.data) {
					const dday = this.calculateDday(result.data.ddayDate);
					if (dday >= 0) {
						this.adminEvent = {
							name: result.data.ddayName,
							date: result.data.ddayDate,
							isAdmin: true
						};
						this.updateAllMessages();
					}
				}
			})
			.catch(console.error);
	}

	calculateDday(targetDate) {
		const today = new Date();
		const target = new Date(targetDate);
		today.setHours(0, 0, 0, 0);
		target.setHours(0, 0, 0, 0);
		return Math.ceil((target - today) / (1000 * 60 * 60 * 24));
	}

	formatMessage(event) {
		const dday = this.calculateDday(event.date);
		return `${event.name}까지 D${dday > 0 ? '-'+dday : '+'+Math.abs(dday)} 파이팅!`;
	}

	formatTodayDate() {
		const today = new Date();
		const year = today.getFullYear();
		const month = String(today.getMonth() + 1).padStart(2, '0');
		const day = String(today.getDate()).padStart(2, '0');
		return `${year}년 ${month}월 ${day}일`;
	}

	updateAllMessages() {
		this.allMessages = [];
		
		if (this.adminEvent) {
			this.allMessages.push(this.formatMessage(this.adminEvent));
		}
		
		this.events.forEach(event => {
			this.allMessages.push(this.formatMessage(event));
		});
		
		this.allMessages.push(this.formatTodayDate());
		this.updateMessages();
	}

	initializeUI() {
		// 컨테이너가 이미 내용을 가지고 있다면 클리어
		this.container.innerHTML = '';
		
		// 메시지 영역과 설정 버튼 생성
		const content = document.createElement('div');
		content.className = 'dday-content';
		content.innerHTML = `
			<div class="dday-messages"></div>
			<i class="bi bi-gear-fill dday-settings"></i>
		`;
		this.container.appendChild(content);

		// 설정 버튼 이벤트 리스너
		const settingsButton = content.querySelector('.dday-settings');
		if(settingsButton) {
			settingsButton.onclick = () => {
				console.log('Settings clicked'); // 디버깅용
				this.showModal();
			};
		}

		// 모달 생성
		const existingModal = document.querySelector('.dday-modal');
		if (!existingModal) {
			this.createModal();
		}

		this.updateAllMessages();
	}

	createModal() {
		// 기존 모달이 있다면 제거
		const existingModal = document.querySelector('.dday-modal');
		const existingBackdrop = document.querySelector('.dday-backdrop');
		if (existingModal) existingModal.remove();
		if (existingBackdrop) existingBackdrop.remove();

		const modal = document.createElement('div');
		modal.className = 'dday-modal';
		modal.innerHTML = `
			<h3>D-day 설정 <span class="modal-close">&times;</span></h3>
			<div id="dday-event-list"></div>
		`;

		const backdrop = document.createElement('div');
		backdrop.className = 'dday-backdrop';
		
		// 이벤트 리스너 추가
		backdrop.onclick = () => this.hideModal();
		modal.querySelector('.modal-close').onclick = () => this.hideModal();

		document.body.appendChild(modal);
		document.body.appendChild(backdrop);
	}

	startRotation() {
		setInterval(() => {
			if (this.allMessages.length <= 1) return;
			
			const messages = this.container.querySelector('.dday-messages');
			if (!messages) return;

			this.currentIndex = (this.currentIndex + 1) % this.allMessages.length;
			this.updateMessages();
		}, 2000);
	}

	updateMessages() {
		const messagesContainer = this.container.querySelector('.dday-messages');
		if (messagesContainer) {
			messagesContainer.innerHTML = this.allMessages.map((message, index) => `
				<div class="dday-message ${index === this.currentIndex ? 'active' : ''}">
					${message}
				</div>
			`).join('');
		}
	}

	updateEventList() {
		const list = document.getElementById('dday-event-list');
		if (!list) return;

		list.innerHTML = this.events.map((event, index) => `
			<div class="dday-event-item">
				<input type="text" maxlength="8" value="${event.name}" 
					placeholder="이벤트 이름 (최대 8자)"
					onchange="ddayManager.updateEvent(${index}, 'name', this.value)">
				<input type="date" value="${event.date}" 
					onchange="ddayManager.updateEvent(${index}, 'date', this.value)">
				<button onclick="ddayManager.removeEvent(${index})">
					<i class="bi bi-trash"></i>
				</button>
			</div>
		`).join('');
		
		if (this.events.length < 3) {
			const addButton = document.createElement('button');
			addButton.className = 'add-button';
			addButton.onclick = () => this.addEvent();
			addButton.innerHTML = `
				<i class="bi bi-plus-circle"></i>
				D-day 추가 (${this.events.length}/3)
			`;
			list.appendChild(addButton);
		}
	}

	showModal() {
		document.querySelector('.dday-modal').style.display = 'block';
		document.querySelector('.dday-backdrop').style.display = 'block';
		this.updateEventList();
	}

	hideModal() {
		document.querySelector('.dday-modal').style.display = 'none';
		document.querySelector('.dday-backdrop').style.display = 'none';
	}

	addEvent() {
		if (this.events.length >= 3) return;
		
		const today = new Date();
		this.events.push({
			name: '새 이벤트',
			date: today.toISOString().split('T')[0]
		});
		
		this.saveUserEvents();
		this.updateEventList();
	}

	updateEvent(index, field, value) {
		if (index >= this.events.length) return;
		
		if (field === 'name' && value.length > 8) {
			value = value.substring(0, 8);
		}
		
		this.events[index][field] = value;
		this.saveUserEvents();
	}

	removeEvent(index) {
		if (index >= this.events.length) return;
		
		this.events.splice(index, 1);
		this.saveUserEvents();
		this.updateEventList();
	}
}

// 쿠키 유틸리티 함수
function setCookie(name, value, days) {
	const date = new Date();
	date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
	document.cookie = `${name}=${value};expires=${date.toUTCString()};path=/`;
}

function getCookie(name) {
	const value = `; ${document.cookie}`;
	const parts = value.split(`; ${name}=`);
	if (parts.length === 2) return parts.pop().split(';').shift();
}

// DdayManager 인스턴스 생성
let ddayManager;
document.addEventListener('DOMContentLoaded', () => {
	ddayManager = new DdayManager('my-dday-container');
});