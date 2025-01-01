/**
 * 
 */

// teacher-slider.js
class TeacherSlider {
	constructor() {
		this.slider = document.querySelector('.teacher-slider');
		this.slides = document.querySelectorAll('.teacher-slide');
		this.currentIndex = 0;
		this.slideCount = this.slides.length;
		this.visibleSlides = 5;
		this.slideWidth = 100 / this.visibleSlides;
		this.isTransitioning = false;

		this.init();
	}

	init() {
		console.log('TeacherSlider initialized');
		if (this.slideCount > this.visibleSlides) {
			this.cloneSlides();
			this.setupSlider();
			this.startAutoSlide();
		}
	}

	cloneSlides() {
		// 처음 5개의 슬라이드를 끝에 복제
		for (let i = 0; i < this.visibleSlides; i++) {
			const clone = this.slides[i].cloneNode(true);
			this.slider.appendChild(clone);
		}

		// 마지막 5개의 슬라이드를 앞에 복제
		for (let i = this.slideCount - 1; i >= this.slideCount - this.visibleSlides; i--) {
			const clone = this.slides[i].cloneNode(true);
			this.slider.insertBefore(clone, this.slider.firstChild);
		}

		// 초기 위치 설정 (복제된 앞쪽 슬라이드들 뒤로)
		this.currentIndex = this.visibleSlides;
		console.log('Slides cloned and initial position set');
	}

	setupSlider() {
		// 슬라이더 초기 위치 설정
		this.updateSliderPosition(false);

		// 트랜지션 종료 이벤트 리스너
		this.slider.addEventListener('transitionend', () => {
			this.handleTransitionEnd();
		});

		console.log('Slider setup completed');
	}

	updateSliderPosition(useTransition = true) {
		if (useTransition) {
			this.slider.style.transition = 'transform 0.5s ease-in-out';
		} else {
			this.slider.style.transition = 'none';
		}

		const offset = -this.currentIndex * this.slideWidth;
		this.slider.style.transform = `translateX(${offset}%)`;
		console.log('Slider position updated:', offset);
	}

	handleTransitionEnd() {
		if (this.currentIndex >= this.slideCount + this.visibleSlides) {
			// 마지막 복제 슬라이드에서 원본 위치로
			this.currentIndex = this.visibleSlides;
			this.updateSliderPosition(false);
			console.log('Jumped to start position');
		} else if (this.currentIndex < this.visibleSlides) {
			// 첫 복제 슬라이드에서 원본 위치로
			this.currentIndex = this.slideCount + this.visibleSlides - 1;
			this.updateSliderPosition(false);
			console.log('Jumped to end position');
		}

		this.isTransitioning = false;
	}

	nextSlide() {
		if (this.isTransitioning) return;

		this.isTransitioning = true;
		this.currentIndex++;
		this.updateSliderPosition(true);

		console.log('Next slide:', this.currentIndex);
	}

	startAutoSlide() {
		setInterval(() => this.nextSlide(), 3000);
		console.log('Auto slide started');
	}
}

// 페이지 로드시 슬라이더 초기화
document.addEventListener('DOMContentLoaded', () => {
	const teacherSlider = new TeacherSlider();
});