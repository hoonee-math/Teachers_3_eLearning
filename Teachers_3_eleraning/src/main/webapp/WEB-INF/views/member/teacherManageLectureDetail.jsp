<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="/WEB-INF/views/common/head.jsp" />
<link rel="stylesheet" href="${path}/resources/css/pages/mypage-common.css">
<link rel="stylesheet" href="${path}/resources/css/member/lectureDetail.css">
<title>강의 상세 정보 | Honey T</title>
</head>

<body>
<div id="wrap">
	<jsp:include page="/WEB-INF/views/common/modal.jsp" />
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	
	<main>
	<div class="main-container">
		<div class="main-content">
			<section class="main-section">
				<!-- 강의 정보 헤더 -->
				<div class="lecture-header">
					<h2>${lecture.courseTitle} - ${lecture.lectureOrder}차시</h2>
					<span class="lecture-date">
						<fmt:formatDate value="${lecture.lectureDate}" pattern="yyyy.MM.dd"/> 
						${lecture.lectureTime}
					</span>
				</div>
				<hr style="border: 2px solid #FAB350;">

				<!-- 강의 상세 정보 폼 -->
				<form id="lectureDetailForm" class="lecture-form">
					<input type="hidden" name="lectureNo" value="${lecture.lectureNo}">
					
					<div class="form-group">
						<label>강의 제목</label>
						<input type="text" name="lectureTitle" value="${lecture.lectureTitle}" 
							   class="form-input" required>
					</div>
					
					<div class="form-group">
						<label>강의 설명</label>
						<textarea name="lectureDesc" class="form-textarea" rows="4">${lecture.lectureDesc}</textarea>
					</div>
					
					<div class="form-group">
						<label>강의 영상</label>
						<div class="video-upload-area">
							<c:choose>
								<c:when test="${empty lecture.video.rename}">
									<div class="upload-placeholder">
										<i class="bi bi-cloud-upload"></i>
										<p>영상을 업로드하세요</p>
										<input type="file" id="videoFile" accept="video/*" 
											   style="display: none;">
										<button type="button" onclick="document.getElementById('videoFile').click()">
											파일 선택
										</button>
									</div>
								</c:when>
								<c:otherwise>
									<div class="video-preview">
										<video controls>
											<source src="${path}/resources/upload/${lecture.video.rename}" 
													type="video/mp4">
										</video>
										<button type="button" class="remove-video" onclick="removeVideo()">
											<i class="bi bi-x-circle"></i>
										</button>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>

					<div class="form-group">
						<label>강의 상태</label>
						<select name="lectureStatus" class="form-select">
							<option value="1" ${lecture.lectureStatus == '1' ? 'selected' : ''}>공개</option>
							<option value="2" ${lecture.lectureStatus == '2' ? 'selected' : ''}>비공개</option>
						</select>
					</div>

					<!-- 버튼 그룹 -->
					<div class="button-group">
						<button type="button" class="btn-secondary" onclick="history.back()">취소</button>
						<button type="submit" class="btn-primary">저장</button>
					</div>
				</form>
			</section>
		</div>
	</div>
	</main>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</div>

<script>
// 파일 업로드 처리
document.getElementById('videoFile').addEventListener('change', function(e) {
	const file = e.target.files[0];
	if(file) {
		const formData = new FormData();
		formData.append('video', file);
		formData.append('lectureNo', '${lecture.lectureNo}');
		
		fetch('${path}/teacher/course/uploadVideo', {
			method: 'POST',
			body: formData
		})
		.then(response => response.json())
		.then(data => {
			if(data.success) {
				location.reload();
			} else {
				alert('업로드에 실패했습니다.');
			}
		});
	}
});

// 영상 삭제
function removeVideo() {
	if(confirm('영상을 삭제하시겠습니까?')) {
		fetch('${path}/teacher/course/removeVideo', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json',
			},
			body: JSON.stringify({
				lectureNo: '${lecture.lectureNo}'
			})
		})
		.then(response => response.json())
		.then(data => {
			if(data.success) {
				location.reload();
			} else {
				alert('삭제에 실패했습니다.');
			}
		});
	}
}

// 폼 제출 처리
document.getElementById('lectureDetailForm').addEventListener('submit', function(e) {
	e.preventDefault();
	
	const formData = new FormData(this);
	
	fetch('${path}/teacher/course/saveLectureDetail', {
		method: 'POST',
		body: formData
	})
	.then(response => response.json())
	.then(data => {
		if(data.success) {
			alert('저장되었습니다.');
			location.href = '${path}/teacher/course/management';
		} else {
			alert('저장에 실패했습니다.');
		}
	});
});
</script>
</body>
</html>