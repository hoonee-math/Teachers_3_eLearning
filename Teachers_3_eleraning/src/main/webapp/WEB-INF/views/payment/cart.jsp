<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>

<!-- 1. 공통 head 요소/공통 CSS 포함 -->
<jsp:include page="/WEB-INF/views/common/head.jsp" />

<!-- 2. 페이지별 CSS -->
<link rel="stylesheet" href="${path}/resources/css/pages/courseList.css">
<link rel="stylesheet" href="${path}/resources/css/payment/cart.css">

<title>장바구니 | Honey T</title>
	
</head>
<body>
<!-- 콘텐츠 영역 -->
<div id="wrap">
<!-- 3.헤더 영역 -->
<jsp:include page="/WEB-INF/views/common/modal.jsp" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<!-- 4.메인 콘텐츠 -->
<main>
<!-- (삭제 x)  본문 섹션 wrapper div -->
<div class="sections-wrapper">
	
	<!-- 섹션 4: 강사/강좌 목록 섹션 -->
	<section id="teacher-section">
		<!-- wrapper div 추가 -->
 	 		<div class="course-content-wrapper">  
			<!-- 실제 콘텐츠 wrapper div -->
			<div class="course-container">
				<!-- 왼쪽 메뉴 -->
				<nav class="subject-menu">
				    <h2>과목</h2>
				    <ul class="menu-list">
				        <li><a href="${path}/cart?subjectName=국어" class="${selectedSubject == '국어' ? 'active' : ''}">국어</a></li>
				        <li><a href="${path}/cart?subjectName=수학" class="${selectedSubject == '수학' ? 'active' : ''}">수학</a></li>
				        <li><a href="${path}/cart?subjectName=영어" class="${selectedSubject == '영어' ? 'active' : ''}">영어</a></li>
				        <li><a href="${path}/cart?subjectName=과학" class="${selectedSubject == '과학' ? 'active' : ''}">과학</a></li>
				        <li><a href="${path}/cart?subjectName=사회" class="${selectedSubject == '사회' ? 'active' : ''}">사회</a></li>
				        <li><a href="${path}/cart?subjectName=한국사" class="${selectedSubject == '한국사' ? 'active' : ''}">한국사</a></li>
				        <li><a href="${path}/cart?subjectName=직업" class="${selectedSubject == '직업' ? 'active' : ''}">직업</a></li>
				        <li><a href="${path}/cart?subjectName=제2외국어" class="${selectedSubject == '제2외국어' ? 'active' : ''}">제2외국어</a></li>
				    </ul>
				</nav>

				<!-- 오른쪽 리스트 -->
				<div class="content-list">
					<!-- 리스트 헤더 -->
					<div class="list-header">
						<h2 class="list-title">장바구니</h2>
					</div>

					<!-- 강사 리스트 -->
					<div class="teacher-list">
						<!-- 강좌 카드들 -->
						<c:forEach var="cart" items="${carts }">
							<div class="course-card">
								<div class="card-left">
									<div class="course-image">
										<img
											src="${path}/resources/images/course/${cart.member.image.imgNo}.jpg"
											alt="${cart.course.courseTitle}"
											onerror="this.src='${path}/resources/images/profile/default.png'">
									</div>
									<div class="course-info">
										<h3>${cart.course.courseTitle}</h3>
										<p class="teacher-name">${cart.member.memberName}선생님</p>
										<p class="course-desc">${cart.course.courseDesc}</p>
										<div class="course-tags">
											<span class="course-tag">#${cart.member.teacherSubject}</span> <span
												class="course-tag">#수능대비</span>
										</div>
									</div>
								</div>
								<div class="card-right">
									<button class="preview-btn">맛보기</button>
									<div class="price-section">
										<label class="checkbox-wrapper"> <input
											type="checkbox" name="selectedCourse"
											value="${cart.course.courseNo}"> <span class="checkmark"></span>
										</label>
										<!-- 가격정보는 DB의 할인율 정보를 바탕으로 표현하기 -->
										<div class="price-info">
											<c:if test="${cart.course.coursePriceSale > 0}">
												<span class="original-price"> <fmt:formatNumber
														value="${cart.course.coursePrice}" type="currency"
														currencySymbol="₩" />
												</span>
												<span class="discount-rate">${cart.course.coursePriceSale}%</span>
											</c:if>
											<span class="final-price"> <fmt:formatNumber
													value="${cart.course.coursePrice * (1 - cart.course.coursePriceSale/100)}"
													type="currency" currencySymbol="₩" />
											</span>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
						
						
						
					</div>
				</div> <!-- /오른쪽 리스트 -->
			</div> <!-- /실제 콘텐츠 wrapper div -->
  			</div> <!-- /wrapper div 추가 -->
	</section> <!-- /섹션 4: 강사/강좌 목록 섹션 -->

</div> <!-- (삭제 x) /본문 섹션 wrapper div -->
</main> <!-- /메인 콘텐츠 -->
<!-- 5. 푸터 영역 -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
		
</div> <!-- /콘텐츠 영역 -->

<jsp:include page="/WEB-INF/views/common/scripts.jsp" />
<!-- 6. 페이지별 스크립트 APi-컴포넌트-페이지 순 -->
<%-- <script src="${path}/resources/js/-"></script> --%>
	
</body>
</html>