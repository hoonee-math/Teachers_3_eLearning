/**
 * 
 */

const TeacherBoard = {
	init(boardType) {
		this.boardType = boardType;
		this.bindEvents();
		this.loadBoardData(1);
	},

	bindEvents() {
		// 페이징 클릭 이벤트
		$(document).on('click', '.pagination a', e => {
			e.preventDefault();
			const page = $(e.currentTarget).data('page');
			this.loadBoardData(page);
		});
	},

	loadBoardData(page) {
		$.ajax({
			url: `${path}/teacher/board/${this.boardType}`,
			data: { cpage: page },
			success: response => {
				$('#boardContent').html(response);
			}
		});
	}
};