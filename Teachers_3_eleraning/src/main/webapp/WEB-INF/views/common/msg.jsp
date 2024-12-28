<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시스템 메세지</title>
</head>
<body>
	<script type="text/javascript">
		/* request, session, servletContext 중에 msg라는 키값을 갖는 변수를 가져옴 */
		alert('${msg}');
		location.replace('${pageContext.request.contextPath}${loc}')
	</script>
</body>
</html>