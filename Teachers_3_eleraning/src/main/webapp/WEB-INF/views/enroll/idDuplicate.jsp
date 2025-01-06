<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



	<div id="checkId-container">
	${result }
		<c:if test="${result }">
			[<span style="color:green"><%=request.getParameter("userId") %> / ${param.id }</span>]는 사용가능합니다.	
			<br><br>
			<button type="button" onclick="closeWin()">닫기</button>
		</c:if>
		<c:if test="${!result }">
			[<span id="duplicated" style="color:red"> ${param.id }</span>]는 사용중입니다.
			<br><br>
			<!-- 아이디 재입력창 구성 -->
			<form action="${pageContext.request.contextPath}/member/idduplicate.do" method="get">
				<input type="text" name="id" id="userId">
				<input type="submit" value="중복검사" >
			</form>
		</c:if>
	</div>
	<script>
		const closeWin=()=>{
			//자식에서 부모 객체에 접근해서 자기가 갖고 있던 값을 넘겨줘야함!
			//opener 를 이용해서 부모에 접근할 수 있다!
			//enrollMember.jsp 에서 open한걸... 1210-T.1328
			const $parentInput=opener.document.getElementById("userId_");
			console.log($parentInput);
			$parentInput.value="${param.id}"
			$parentInput.readOnly=true; //disabled로 하면 넘어가질 않음...??
			$parentInput.style.backgroundColor="lightgray";
			close();
		}
	</script>