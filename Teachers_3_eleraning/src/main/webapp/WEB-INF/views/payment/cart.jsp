<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="path/resources/images/common/HoneyT_logo_square.png">
<title>Honey T</title>

<!-- 2. 외부 CSS 파일들 -->

<!-- 2-3. 직접 제작한 CSS 파일들 (Bootstrap CSS 다음에 위치) -->
<link rel="stylesheet" href="${path}/resources/css/common/reset.css">
<link rel="stylesheet" href="${path}/resources/css/common/layout.css">
<link rel="stylesheet" href="${path}/resources/css/common/utilities.css">
<link rel="stylesheet" href="${path}/resources/css/common/navigator.css">

<!-- 3. 컴포넌트 CSS -->
<link rel="stylesheet" href="${path}/resources/css/components/header.css">
<link rel="stylesheet" href="${path}/resources/css/components/navigation.css">
<link rel="stylesheet" href="${path}/resources/css/components/modal.css">
<link rel="stylesheet" href="${path}/resources/css/components/buttons.css">
<link rel="stylesheet" href="${path}/resources/css/components/cards.css">

<!-- 4. 페이지별 CSS -->
<link rel="stylesheet" href="path/resources/css/payment/cart.css-">

<!-- 5. jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- 6. 외부 JS 파일들 (jQuery 다음, 내부 스타일 전에) -->

<!-- 7. 내부 style 태그 -->
<style>
/* 페이지 특정 스타일 */
#main-box {
	box-shadow: 0 0 5px rgba(0,0,0,0.2);
	padding: 20px;
	width: 1140px;
}
.main-content>p {
	margin: 0 0 0 20px;
	font-size: 20pt;
	font-weight: bold;
}
.list-container {
	display: flex;  /* Flexbox 사용 */
    align-items: start;  /* 세로 정렬 */
    gap: 10px;  /* 체크박스와 테이블 사이 간격 */
    margin: 15px;
    padding: 15px;
	width: 1100px;
	background: #eeeeee;
	box-shadow: 0 0 5px rgba(0,0,0,0.2);
	border-radius: 15px;
}
.select-btn {
    width: 20px;
    height: 20px;
    accent-color: #6f6f6f;
}
.product-container {
    border-collapse: collapse;
}
.list-img {
    width: 120px;
    height: 120px;
    overflow: hidden;
    padding: 0;  /* 패딩 제거 */
}
.list-img img {
    width: 100%;
    height: 100%;
    object-fit: cover;  /* 비율 유지하며 영역 채우기 */
    object-position: center;  /* 이미지 중앙 정렬 */
}
.list-content {
    padding-left: 15px;
}
.list-content p {
    margin: 5px 0;
    border: none;
    font-size: large;
    background-color: #eeeeee;
}
.amount {
	font-weight: bold;
}
#purchase {
	margin: 0 30px 20px 0;
	display: flex;
	justify-content: flex-end;
}
#purchase-btn {
	padding: 12px;
	background-color: white;
	border: 1px solid #cccccc;
	border-radius: 15px;
	color: #6f6f6f;
	font-size: larger;
	height: 50px;
	width: 120px;
}
#purchase-btn:hover {
	background-color: #fffadd;
}

#checkAll,
#checkDelete {
	margin: 10px;
	background-color: white;
	border: 1px solid #cccccc;
	border-radius: 5px;
	color: #6f6f6f;
	font-size: large;
}

.payment-info p {
	font-size: larger;
}
</style>
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





	<!-- 8. 공통 JavaScript -->
	<!-- 9. API/Ajax 관련 JavaScript -->
	<script src="${path}/resources/js/api/teacherApi.js"></script>

	<!-- 10. 컴포넌트 JavaScript -->
	<script src="${path}/resources/js/components/modal.js"></script>

	<!-- 11. 페이지별 JavaScript -->
	<script src="${path}/resources/js/payment/cart.js"></script>


</body>

</html>