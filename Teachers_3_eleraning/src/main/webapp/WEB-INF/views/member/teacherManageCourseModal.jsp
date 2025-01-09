<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!-- 강좌 등록 모달 추가 -->
<div class="modal" id="newCourseModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h3>새 강좌 등록</h3>
				<button type="button" class="close-modal" onclick="closeModal()">&times;</button>
			</div>
			<div class="modal-body">
				<form id="newCourseForm">
					<div class="form-group">
						<label for="courseTitle">강좌명 *</label>
						<div class="input-wrapper">
							<input type="text" id="courseTitle" name="courseTitle" required placeholder="강좌 제목을 입력하세요">
						</div>
					</div>
					
					<div class="form-group">
						<label for="courseDesc">강좌 설명 *</label>
						<div class="input-wrapper">
							<textarea id="courseDesc" name="courseDesc" rows="3" required placeholder="강좌에 대한 설명을 입력하세요"></textarea>
						</div>
					</div>
					
					<div class="form-group">
					    <label for="courseCategoryNo">카테고리 *</label>
					    <div class="input-wrapper">
					        <select id="courseCategoryNo" name="courseCategoryNo" required>
							 	<option value="">카테고리 선택</option>
							    <c:forEach items="${categories}" var="category" varStatus="vs">
							        <!-- index가 0부터 시작하므로 1을 더해줍니다 -->
							        <option value="${vs.index + 1}">${category}</option>
							    </c:forEach>
							</select>
					    </div>
					</div>
					
					<div class="form-group">
						<label for="grade">대상 학년 *</label>
						<div class="input-wrapper">
							<select id="grade" name="grade" required>
								<option value="">학년 선택</option>
								<option value="1">1학년</option>
								<option value="2">2학년</option>
								<option value="3">3학년</option>
							</select>
						</div>
					</div>
					
					<div class="form-group">
						<label for="coursePrice">강좌 가격 *</label>
						<div class="input-wrapper price-container">
							<div class="price-input-wrapper">
								<input type="number" id="coursePrice" name="coursePrice" required placeholder="가격을 입력하세요">
								<span class="price-unit">원</span>
							</div>
							<div class="price-input-wrapper">
								<input type="number" id="coursePriceSale" name="coursePriceSale" placeholder="할인율">
								<span class="price-unit">%</span>
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<label for="beginDate">강좌 시작일 *</label>
						<div class="input-wrapper">
							<input type="date" id="beginDate" name="beginDate" required>
						</div>
					</div>
					
					<div class="modal-footer">
						<button type="button" class="btn-secondary" onclick="closeModal()">취소</button>
						<button type="submit" class="btn-primary">등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>