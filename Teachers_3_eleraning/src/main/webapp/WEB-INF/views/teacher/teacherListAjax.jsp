<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!-- AJAX로 교체될 선생님 카드 리스트 부분만 포함 -->
<div class="teacher-list real-data">
    <c:forEach var="teacher" items="${teachers}">
        <div class="teacher-card" data-memberNo="${teacher.memberNo}" data-subject="${teacher.teacherSubjectName}">
            <div class="teacher-image">
                <img src="${path}/resources/images/profile/${teacher.image.renamed}"
                     alt="${teacher.memberName} 선생님">
            </div>
            <div class="teacher-info">
                <h3>${teacher.memberName} 선생님</h3>
                <p class="teacher-description">
                    ${teacher.teacherInfoTitle} ${teacher.teacherInfoContent}
                </p>
            </div>
        </div>
    </c:forEach>
</div>

<!-- 페이징 바 -->
<div class="pagination">
    <c:if test="${pageStart > 1}">
        <a href="#" class="page-arrow" data-page="${pageStart-1}">&lt;</a>
    </c:if>
    <c:forEach var="i" begin="${pageStart}" end="${pageEnd}">
        <c:choose>
            <c:when test="${i == cpage}">
                <span class="current-page">${i}</span>
            </c:when>
            <c:otherwise>
                <a href="#" data-page="${i}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <c:if test="${pageEnd < totalPage}">
        <a href="#" class="page-arrow" data-page="${pageEnd+1}">&gt;</a>
    </c:if>
</div>