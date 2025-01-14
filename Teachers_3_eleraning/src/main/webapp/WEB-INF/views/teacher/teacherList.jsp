<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!-- JSP/JSTL 태그 라이브러리 선언 바로 아래에 추가 -->
<%@ page import="com.google.gson.Gson" %>


<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="/WEB-INF/views/common/head.jsp" />
<title>선생님 | Honey T</title>
<!-- </title> 태그 아래에 추가 -->
<script>
    // 전체 교사 데이터를 JavaScript 객체로 변환
    const allTeachers = <%= new Gson().toJson(request.getAttribute("teachers")) %>;
    const itemsPerPage = 5; // 페이지당 표시할 항목 수
    const path = '${pageContext.request.contextPath}'; // 컨텍스트 경로 추가
</script>
<link rel="stylesheet" href="${path}/resources/css/teacher/teacherList.css">
<link rel="stylesheet" href="${path}/resources/css/teacher/teacherBoardCommon.css">
<link rel="stylesheet" href="${path}/resources/css/pages/courseList.css">
<link rel="stylesheet" href="${path}/resources/css/course/courseListBySubject.css">

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
			<!-- 선생님 상세 페이지 -->
			<section id="teacher-detail-section">
				<div class="teacher-detail-container">
					<!-- 왼쪽 아코디언 메뉴 -->
					<nav class="accordion-menu">
						<!-- jstl core 태그로 리스트를 받아와서 출력해주기 -->
					    <c:forEach var="subject" items="${subjectData}">
						<div class="accordion-item">
						    <div class="accordion-header" data-subject="${subject}">
								${subject} <!-- 과목명 출력 -->
						    </div>
						    <div class="accordion-content">
							<c:forEach var="teacher" items="${teachers}">
							    <c:if test="${teacher.teacherSubjectName == subject}"> <!-- 과목번호와 과목 키값을 비교 -->
								<a href="#"  class="teacher-link" data-memberNo="${teacher.memberNo}">
								    ${teacher.memberName} 선생님
								</a>
							    </c:if>
							</c:forEach>
						    </div>
						</div>
					    </c:forEach>
					</nav>
						
						<!-- 오른쪽 상세 내용 섹션 2 : 리스트 헤더 -->
						<div class="content-list teacher-list-content">
							<div class="list-header">
								<h2 class="list-title">국어 선생님</h2>
								<div class="sub-category">
									<button class="active">전체</button>
									<button>문학</button>
									<button>독서</button>
									<button>화법과 작문</button>
								</div>
							</div>
							<!-- 실제 교사 데이터 출력 -->
							<div class="teacher-list real-data">
								<c:forEach var="teacher" items="${teachers}">
									<div class="teacher-card" data-memberNo="${teacher.memberNo}" data-subject="${teacher.teacherSubjectName}">
										<div class="teacher-image">
											<img
												src="${path }/resources/images/profile/${teacher.image.renamed }"
												alt="${teacher.memberName} 선생님">${teacher.image.renamed }
										</div>
										<div class="teacher-info">
											<h3>
												${teacher.memberName} 선생님
												<%-- <c:if test="${not empty teacher.badge}">
							                        <span class="teacher-badge">${teacher.badge}</span>
							                    </c:if> --%>
											</h3>
											<p class="teacher-description">
												${teacher.teacherInfoTitle} ${teacher.teacherInfoContent}</p>
										</div>
									</div>
								</c:forEach>
							</div>
							<!-- 페이징 바 -->
							<!-- <div class="pagination"> 부분을 아래 코드로 교체 -->
							<div class="pagination" id="teacherPagination">
								<!-- 페이징 버튼은 JavaScript로 동적 생성됩니다 -->
							</div>
							<!-- 데이터 확인용 디버깅 출력 -->
							<div style="display: none;">
							    <p>Teachers 데이터: ${teachers}</p>
							    <p>Teachers 크기: ${fn:length(teachers)}</p>
							</div>
								
						</div>
					</div>
			</section>

		</main>

		<!-- 푸터 include -->
    	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>

	<jsp:include page="/WEB-INF/views/common/scripts.jsp" />
<script src="${path}/resources/js/teacher/teacherListAccordion.js"></script>
<!-- 기존 scripts.jsp include 아래에 추가 -->
<script src="${path}/resources/js/teacher/teacherPaging.js"></script>

</body>
</html>