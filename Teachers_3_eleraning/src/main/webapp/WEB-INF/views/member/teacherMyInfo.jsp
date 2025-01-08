<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="ko">
<head>
	<title>Honey T</title>
	<jsp:include page="/WEB-INF/views/common/head.jsp" />
	<link rel="stylesheet" href="${path}/resources/css/pages/mypage-common.css">
	<link rel="stylesheet" href="${path}/resources/css/member/teacherMyInfo.css">
</head>

<body>

<!-- 콘텐츠 영역 -->
<div id="wrap">
<!-- 헤더 include -->
<jsp:include page="/WEB-INF/views/common/modal.jsp" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<!-- 메인 콘텐츠 -->
	<main class="main">
		<!-- 페이지 내용 -->
		<div class="main-container">
		
			<div class="main-content">
				<section id="enroll-container" class="main-section">
					<div>
						<h2>내정보 수정하기</h2>
						<hr style="border: 2px solid #FAB350;">
						<p>나의 개인정보를 관리할 수 있습니다.</p>
					</div>
					<form action="${path}/student/infosave" method="post" onsubmit="return fn_invalidate();">
					<table>
						<tr>
							<th>아이디 *</th>
							<td>
								<input type="text" name="memberId" id="memberId_" value="${loginMember.memberId}" style="width:323px;" readonly>
							</td>
						</tr>
						<tr>
							<th>이메일 *</th>
							<td>
								<input type="text" name="emailId" id="emailId" value="${loginMember.email}" style="width: 323px;" readonly> 
							</td>
						</tr>
						<tr>
							<th>패스워드</th>
							<td><input type="password" name="memberPw" id="password_" placeholder="대소문자, 숫자, 특수문자 포함"><br>
							</td>
						</tr>
						<tr>
							<th>패스워드확인</th>
							<td><input type="password" id="password_2"><br>
								<span id="checkResult"></span></td>
						</tr>
						<tr>
							<th>이름 *</th>
							<td><input type="text" name="memberName" id="userName" value="${loginMember.memberName}" readonly><br>
							</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td><input type="text" name="phone" id="phone" value="${loginMember.phone != null ? loginMember.phone : ''}" placeholder="예)01055556666"><br>
							</td>
						</tr>
						<tr>
							<th>주소</th>
							<td>
								<div style="margin-bottom:10px">
								<input type="text" id="sample4_postcode" name="addressNo" style="width:190px;" value="${addressNo != null ? addressNo : ''}" placeholder="우편번호">
								<input type="button" id="postcodeFindBtn" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
								</div>
								<div style="margin-bottom:10px">
								<input type="text" id="sample4_roadAddress" name="addressRoad" value="${addressRoad != null ? addressRoad : ''}" placeholder="도로명주소" style="width:323px;">
								<!-- <input type="text" id="sample4_jibunAddress" placeholder="지번주소" style="width: 300px;"> -->
								<span id="guide" style="color:#999;display:none"></span>
								</div>
								<div>
								<input type="text" id="sample4_detailAddress" name="addressDetail" value="${addressDetail != null ? addressDetail : ''}" placeholder="상세주소" style="width: 323px;">
								<!-- <input type="text" id="sample4_extraAddress" placeholder="참고항목" style="width: 150px;"> -->
								</div>
							</td>
						</tr>
						<tr>
						    <th>프로필 사진</th>
						    <td>
						    <div class="profile-upload" style="margin-bottom:10px">
						    	        <img id="profilePreview" src="${path}/resources/images/profile/default.png" 
						    	        	 alt="프로필 미리보기" style="width: 150px; height: 150px; border-radius: 75px; object-fit: cover;">
							    <input type="file" id="profileImageInput" accept="image/*" style="display: none;"/>
								
        						<button type="button" onclick="document.getElementById('profileImageInput').click()"  class="btn-secondary mt-2">									
								사진변경</button>
							</div>
						    </td>
						</tr>
						<tr>
						    <th>소개 타이틀</th>
						    <td>
						        <div style="margin-bottom:10px">
						            <input type="text" name="teacherInfoTitle" id="teacherInfoTitle" value="${loginMember.teacherInfoTitle}" style="width:323px;">
						        </div>
						    </td>
						</tr>
						<tr>
						    <th>소개글</th>
						    <td>
						        <div style="margin-bottom:10px">
						            <textarea  rows="5" name="teacherInfoContent" id="teacherInfoContent" value="${loginMember.teacherInfoContent}" style="width:323px;resize:none;"></textarea>
						        </div>
						    </td>
						</tr>
					</table>
					<div class="enrollsubmit">
						<input type="reset" value="취소">	<input type="submit" value="저장">
					</div>
					</form>
					
				</section>
			</div>
		</div>
	</main>


<!-- 푸터 include -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<!-- 콘텐츠 영역 종료 -->
</div>

<jsp:include page="/WEB-INF/views/common/scripts.jsp" />
<!-- API/Ajax 관련 JavaScript -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    
	// 프로필 이미지 프리뷰 처리
	function handleProfileImageChange(event) {
		const file = event.target.files[0];
		// 파일이 선택됐는지 확
		if(!file) return;
		
		// FileReader를 사용하여 이미지 프리뷰
		conset reader = new FileReader();
		reader.onload = function(e) {
			//프리뷰 이미지 업데이트
			const previewImg = document.getElementById("profilePreview");
			previewImg.scr = e.target.result;
			previewImg.style.display = 'block';
		};
		reader.readAsDataURL(file);
	}
	
	// 초기화 시 이벤트 리스너 등록
	document.addEventListener('DOMContentLoaded', function() {
		const fileInput = document.getElementById('profileImageInput');
		if (fileInput) {
			fileInput.addEventListener('change', handleProfileImageChange);
		}
	});
       
</script>
<!-- 6. 페이지별 스크립트 APi-컴포넌트-페이지 순 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 다음 우편번호 서비스 -->
<script src="${pageContext.request.contextPath}/resources/js/enroll/enrollForm.js"></script>
	
	

</body>
</html>