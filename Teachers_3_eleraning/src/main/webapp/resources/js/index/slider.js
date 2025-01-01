/**
 *  index 페이지의 두번째 섹션 광과 slider section 의 js
 */

// slider.js
class MainSlider {
	constructor() {
		this.sliderWrapper = $('.slider-wrapper');
		this.slides = $('.slide');
		this.indicators = $('.indicator');
		this.prevBtn = $('.prev-btn');
		this.nextBtn = $('.next-btn');
		this.pauseBtn = $('.pause-btn');

		this.currentIndex = 0;
		this.slideCount = this.slides.length;
		this.isPlaying = true;
		this.intervalId = null;

		this.init();
	}

	init() {
		console.log('MainSlider initialized');
		this.bindEvents();
		this.startAutoPlay();
	}

	bindEvents() {
		this.prevBtn.on('click', () => this.prevSlide());
		this.nextBtn.on('click', () => this.nextSlide());
		this.pauseBtn.on('click', () => this.togglePlay());
		this.indicators.on('click', (e) => {
			const index = $(e.target).data('slide');
			this.goToSlide(index);
		});
	}

	prevSlide() {
		console.log('Moving to previous slide');
		this.goToSlide(this.currentIndex - 1);
	}

	nextSlide() {
		console.log('Moving to next slide');
		this.goToSlide(this.currentIndex + 1);
	}

	goToSlide(index) {
		const newIndex = (index + this.slideCount) % this.slideCount;
		console.log(`Going to slide ${newIndex}`);

		this.currentIndex = newIndex;
		const offset = -100 * this.currentIndex;
		this.sliderWrapper.css('transform', `translateX(${offset}%)`);

		this.indicators.removeClass('active');
		$(this.indicators[newIndex]).addClass('active');
	}

	startAutoPlay() {
		console.log('Starting autoplay');
		this.intervalId = setInterval(() => this.nextSlide(), 5000);
	}

	stopAutoPlay() {
		console.log('Stopping autoplay');
		clearInterval(this.intervalId);
	}

	togglePlay() {
		this.isPlaying = !this.isPlaying;
		console.log(`Autoplay ${this.isPlaying ? 'started' : 'stopped'}`);

		if (this.isPlaying) {
			this.startAutoPlay();
			this.pauseBtn.text('II');
		} else {
			this.stopAutoPlay();
			this.pauseBtn.text('►');
		}
	}
}

// 페이지 로드시 슬라이더 초기화
$(document).ready(() => {
	const mainSlider = new MainSlider();
});