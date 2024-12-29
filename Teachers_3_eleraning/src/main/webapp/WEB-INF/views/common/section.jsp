<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!-- 추가 -->
<div class="sections-wrapper">
<!-- 본문 섹션 -->
<!-- 섹션 1: 3단 그리드 레이아웃 -->
<section id="layout-section-1">
	<!-- 섹션 설명 -->
	<div class="section-description">
		<p>
			<strong>3단 그리드 레이아웃 (Left Sidebar + Main Content + Right Sidebar)</strong>
		</p>
		<p>
			- 구조:
			<code>grid-template-columns: 250px 1fr 250px</code>
		</p>
		<p>- 사용 사례: 메인 콘텐츠와 양쪽 사이드바가 필요한 레이아웃 (블로그, 쇼핑몰 등)</p>
		<p>- 반응형: 768px 이하에서 단일 컬럼으로 변경</p>
	</div>
	<!-- 실제 콘텐츠 -->
	<div>
		<!-- 왼쪽 사이드바 -->
		<div class="content-box">
			<h3>Left Sidebar</h3>
			<p>ID: left-section</p>
			<p>고정 너비: 250px</p>
			<p>주로 네비게이션이나 필터에 사용</p>
		</div>
		<!-- 메인 콘텐츠 -->
		<div class="content-box">
			<h3>Main Content Area</h3>
			<p>ID: main-section</p>
			<p>가변 너비: 남은 공간 자동 조절</p>
			<p>주요 콘텐츠가 표시되는 영역</p>
		</div>
		<!-- 오른쪽 사이드바 -->
		<div class="content-box">
			<h3>Right Sidebar</h3>
			<p>ID: right-section</p>
			<p>고정 너비: 250px</p>
			<p>주로 위젯이나 광고에 사용</p>
		</div>
	</div>
</section>

<!-- 섹션 2: 자동 조절 그리드 -->
<section id="layout-section-2">
	<!-- 섹션 설명 -->
	<div class="section-description">
		<p>
			<strong>반응형 카드 그리드 레이아웃</strong>
		</p>
		<p>
			- 구조:
			<code>grid-template-columns: repeat(auto-fit, minmax(300px, 1fr))</code>
		</p>
		<p>- 특징: 화면 크기에 따라 자동으로 열 수 조절</p>
		<p>- 호버 효과: 카드에 마우스 오버 시 상승 효과</p>
	</div>
	<!-- 실제 콘텐츠 -->
	<div>
		<div class="info-card">
			<div class="card-header">Card 1</div>
			<div class="card-body">
				<p>자동 크기 조절 카드</p>
				<p>최소 너비: 300px</p>
				<p>호버 시 상승 효과</p>
			</div>
		</div>
		<div class="info-card">
			<div class="card-header">Card 2</div>
			<div class="card-body">
				<p>반응형 레이아웃</p>
				<p>화면 크기에 따라 자동 정렬</p>
				<p>그림자 효과 적용</p>
			</div>
		</div>
	</div>
</section>

<!-- 섹션 3: 복합 레이아웃 -->
<section id="layout-section-3">
	<!-- 섹션 설명 -->
	<div class="section-description">
		<p>
			<strong>복합 Flexbox + Grid 레이아웃</strong>
		</p>
		<p>
			- Flexbox:
			<code>display: flex</code>
			상단 아이템 배치
		</p>
		<p>
			- Grid:
			<code>grid-template-columns: repeat(3, 1fr)</code>
			하단 그리드
		</p>
		<p>- 반응형: 화면 크기에 따라 다단계 레이아웃 변경</p>
	</div>
	<!-- 실제 콘텐츠 -->
	<div>
		<!-- Flexbox 컨테이너 -->
		<div class="flex-container">
			<div class="flex-item">
				<h4>Flex Item 1</h4>
				<p>유동적 너비 조절</p>
			</div>
			<div class="flex-item">
				<h4>Flex Item 2</h4>
				<p>최소 너비 200px</p>
			</div>
			<div class="flex-item">
				<h4>Flex Item 3</h4>
				<p>자동 줄바꿈 처리</p>
			</div>
		</div>
		<!-- Grid 컨테이너 -->
		<div class="grid-container">
			<div class="grid-item">Grid 1</div>
			<div class="grid-item">Grid 2</div>
			<div class="grid-item">Grid 3</div>
		</div>
	</div>
</section>

</div>