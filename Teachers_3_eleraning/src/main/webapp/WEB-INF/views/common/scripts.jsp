<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%-- 
공통 스크립트 영역
- jQuery는 가장 먼저 로드되어야 함
- path 전역변수 선언 (JavaScript에서 사용)
- 공통 유틸리티 함수들
--%>

<%-- 나머지 경우에는 body 태그 끝에서 언급 후 사용 --%>
<%-- (1) jQuery UI나 특정 플러그인이 초기화 시점에 jQuery를 찾는 경우 ex: "jquery.min.js", "jquery-ui.min.js" 등은 로드 시점에 jQuery 필요 --%>
<%-- (2) 인라인 스크립트가 즉시 jQuery를 사용하는 경우 --%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    const path = '${pageContext.request.contextPath}';
</script>
<script src="${path}/resources/js/components/modal.js"></script>
<script src="${path}/resources/js/common/headerBanner.js"></script>
<script src="${path}/resources/js/common/headerMenu.js"></script>
<script src="${path}/resources/js/common/headerMegaMenu.js"></script>