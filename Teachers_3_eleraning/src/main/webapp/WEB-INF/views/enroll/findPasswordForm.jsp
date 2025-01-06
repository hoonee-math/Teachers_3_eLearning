<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<script	src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.min.js"></script>
<!-- header 에만 부여해도 되는 속성 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="${path}/resources/images/common/HoneyT_logo_square.png">
<title>HONEY Y 비밀번호 찾기</title>
<!-- Bootstrap Icons을 추가하기 위한 태그 -->
<link rel="stylesheet"	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet"	href="${pageContext.request.contextPath }/resources/css/common/header.css">
<link rel="stylesheet"	href="${pageContext.request.contextPath }/resources/css/enroll/findPasswordForm.css">
</head>
<body>
	<section id="findInfo-container">
		<div class="find-page">
			<header>
				<div class="logo-container">
					<img alt="" src="/WEB-INF/resources/images/common/HoneyT_logo_square.png">
					<h1 class="logo">HONEY T</h1>
				</div>
				<p class="slogan">1등급 정복을 위한 꿀팁! Honey T!</p>
			</header>
			<div class="find-box">
				<h2>비밀번호 찾기</h2>
				<form id="find-form">
					<div class="input-group">
						<label for="text">이름</label>
						<input type="text" id="memberName"
							name="memberName" placeholder="이름을 입력하세요" required>
					</div>
					<div class="input-group">
						<label for="email">이메일</label>
						<input type="email" id="email"
							name="email" placeholder="이메일을 입력하세요" required>
					</div>
					<!-- 이메일 인증 서비스 코드를 모듈화 하기 위한 id 값 searchType : searchPassword/emailDuplicate -->
					<input type="hidden" id="searchType" value="searchPassword">
					<button type="submit" class="find-button">본인인증</button>
				</form>
				<div class="links">
					<a href="${path}/member/termsofservice">회원가입</a>
				</div>
			</div>
		</div>
	</section>
	<script>
		document.getElementById('find-form').addEventListener('submit',
				function(e) {
	        		console.log("Form submit event fired");
			        e.preventDefault(); // 폼 기본 제출 동작 방지
			        
			        const memberName = $("#memberName").val();
			        const email = $("#email").val();

			        if(!email || !memberName) {
			            alert("이름과 이메일을 모두 입력해주세요.");
			            return;
			        }
			        // 회원 존재 여부 확인
			        $.ajax({
			            url: `${pageContext.request.contextPath }/auth/checkEmailDuplicate.do`,
			            type: "POST",
			            data: {
			                memberName: memberName,
			                email: email,
			                searchType: 'searchPassword'
			            },
			            success: function(response) {
			                if(response.exists) {
			                    // 회원이 존재하면 이메일 인증 프로세스 시작
			                    const form = document.createElement('form');
			                    form.method = 'POST';
			                    form.action = `${pageContext.request.contextPath }/auth/sendEmail`;
			                    form.target = 'emailVerify';
			                    
			                    const emailInput = document.createElement('input');
			                    emailInput.type = 'hidden';
			                    emailInput.name = 'email';
			                    emailInput.value = email;
			                    
			                    const typeInput = document.createElement('input');
			                    typeInput.type = 'hidden';
			                    typeInput.name = 'authType';
			                    typeInput.value = 'reset';
			                    
			                    form.appendChild(emailInput);
			                    form.appendChild(typeInput);
			                    
			                    window.open(
		                            '',
			                        "emailVerify",
			                        "width=400,height=300,left=500,top=200"
			                    );
			                    
			                    document.body.appendChild(form);
			                    form.submit();
			                    document.body.removeChild(form);
			                } else {
			                    alert("일치하는 회원 정보가 없습니다.");
			                }
			            },
			            error: function(xhr, status, error) {
			                alert("서버 통신 중 오류가 발생했습니다.");
			                console.error("Error:", error);
			            }
			        });
	        	}
		);
		//로고에 메인 홈으로 이동하는 링크 추가
		$(".logo-container").click(function() {
			location.assign("${path}");
		});
	</script>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />