<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%-- 
공통 head 요소
- 모든 페이지에서 공통으로 사용되는 메타태그와 기본 CSS
- path 변수는 여기서 선언하지 않음 (각 페이지에서 선언)
--%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="${path}/resources/images/common/HoneyT_logo_square.png">

<%-- 
1. 외부 라이브러리 CSS
- 기본 스타일을 제공하는 외부 라이브러리 먼저 로드
- 커스터마이징 가능성을 열어두기 위해 먼저 위치
--%>
<%-- 1-1. Bootstrap CSS (다른 CSS보다 먼저) --%>
<%-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"> --%>
<%-- 1-2. Bootstrap Icons (필요한 경우) : Icons의 경우는 다른 CSS와 충돌 가능성이 적고 아이콘 폰트만을 다루기 때문에 아래쪽에 선언하기도 함 --%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<%-- <link rel="stylesheet" href="[기타 외부 CSS 라이브러리]"> --%>

<%-- 
2. 직접 제작한 공통 CSS
- 외부 라이브러리의 스타일을 덮어쓸 수 있음
- 프로젝트의 기본 스타일 정의
--%>
<link rel="stylesheet" href="${path}/resources/css/common/reset.css">
<link rel="stylesheet" href="${path}/resources/css/common/utilities.css">
<link rel="stylesheet" href="${path}/resources/css/common/layout.css">
<link rel="stylesheet" href="${path}/resources/css/common/navigator.css">

<%-- 
3. 주요 컴포넌트 CSS
- 공통 스타일을 기반으로 컴포넌트별 스타일 적용
- 컴포넌트별로 독립적인 스타일 정의
--%>
<link rel="stylesheet" href="${path}/resources/css/components/modal.css">
<link rel="stylesheet" href="${path}/resources/css/components/buttons.css">
<%-- <link rel="stylesheet" href="${path}/resources/css/components/footer.css"> --%>


<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>