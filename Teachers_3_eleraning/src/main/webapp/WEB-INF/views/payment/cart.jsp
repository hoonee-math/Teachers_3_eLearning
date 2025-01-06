<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="/WEB-INF/views/common/head.jsp" />
<title>장바구니 | Honey T</title>
<!-- 페이지별 CSS -->
<link rel="stylesheet" href="${path}/resources/css/payment/cart.css">
</head>

<body>
	<!-- 콘텐츠 영역 -->
	<div id="wrap">
		<!-- 헤더 include -->
		<jsp:include page="/WEB-INF/views/common/modal.jsp" />
		<jsp:include page="/WEB-INF/views/common/header.jsp" />

		<!-- 메인 콘텐츠 -->
		<main>
			<!-- 페이지 내용 -->
			<div id="main-box" style="width:1100px;">
			<form action="${path }/payment/deletecart" method="POST" id="cartForm">
				<button type="button" id="checkAll" onclick="toggleCheckAll();">전체선택</button>
				<button type="submit" id="checkDelete">선택삭제</button>
			
			<!-- 임시 데이터 -->
			<section class="row main-section">
				<div class="list-container" 
					 data-course-no="${item.course.courseNo }"
					 data-course-price="${item.course.coursePrice }"
					 data-course-price-sale="${item.course.coursePriceSale }">
					<input type="checkbox" class="select-btn" name="cartNo" value="${item.cartNo }">
					<table class="product-container">
						<tr>
							<td class="list-img">
								<img src="${path}/resources/images/profile/ohaewon.jpg" width="100px">
							</td>
							<td class="list-content">
								<div>
									<!-- 판매 상품 제목 -->
									<p><strong>[수1] 새학기 대비 최고의 선택!</strong></p><br>
									
									<!-- 판매 상품 금액 -->
									<c:set var="finalCoursePrice" value="${item.course.coursePrice * (1-item.coursePriceSale) }"/>
									<p><strong>₩ <fmt:formatNumber value="260000" pattern="###,###,###"/></strong></p>
								
									<br>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</section>
			
			<c:forEach var="item" items="${carts }" varStatus="status">
				<section class="row main-section">
					<div class="list-container" 
						 data-course-no="${item.course.courseNo }"
						 data-course-price="${item.course.coursePrice }"
						 data-course-price-sale="${item.course.coursePriceSale }">
						<input type="checkbox" class="select-btn" name="cartNo" value="${item.cartNo }">
						<table class="product-container">
							<tr>
								<td class="list-img">
									<img src="${path}/resources/images/upload/${item.postImg[0].renamed}">
								</td>
								<td class="list-content">
									<div>
										<!-- 판매 상품 제목 -->
										<p><strong>${item.course.courseTitle}</strong></p><br>
										
										<!-- 판매 상품 금액 -->
										<c:set var="finalCoursePrice" value="${item.course.coursePrice * (1-item.coursePriceSale) }"/>
										<p><strong>₩ <fmt:formatNumber value="${finalCoursePrice }" pattern="###,###,###"/></strong></p>
									
										<br>
									</div>
								</td>
							</tr>
						</table>
					</div>
				</section>
			</c:forEach>
			</form>
			<form action="${path }/payment/purchase" method="POST" id="purchaseForm">
			<section class="row main-section">
				<!-- 섹션 2 -->
				<br>
				<div class="payment-info">
					<p>상품 총 금액 <span class="amount" id="total-product-price">0</span>원 + 배송비 <span class="amount" id="total-delivery-fee">0</span>원</p>
					<p>= 총 <span class="amount" id="total-price">0</span>원</p>
				</div>
			</section>
			
			<div id="purchase">
				<button type="button" id="purchase-btn">구매하기</button>
			</div>
			</form>
		</main>

		<!-- 푸터 include -->
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
		<!-- 콘텐츠 영역 종료 -->
	</div>

<jsp:include page="/WEB-INF/views/common/scripts.jsp" />
<!-- 페이지별 JavaScript -->
<script src="${path}/resources/js/payment/cart.js"></script>

</body>
</html>