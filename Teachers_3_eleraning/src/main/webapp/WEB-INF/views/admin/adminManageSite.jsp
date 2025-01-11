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
						<h2>사이트 정보 수정하기</h2>
						<hr style="border: 2px solid #FAB350;">
						<p>사이트 정보를 관리할 수 있습니다.</p>
					</div>
					<form action="${path}/admin/manage/site/save" method="post" enctype="multipart/form-data" onsubmit="return fn_invalidate();">
					<table>
						<tr>
							<th>패스워드 수정</th>
							<td><input type="password" name="memberPw" id="password_" placeholder="대소문자, 숫자, 특수문자 포함"><br>
							</td>
						</tr>
						<tr>
							<th>패스워드 확인</th>
							<td><input type="password" id="password_2"><br>
								<span id="checkResult"></span></td>
						</tr>
						<tr>
						    <th>상단 배너 이미지</th>
						    <td>
						    <div class="profile-upload" style="margin-bottom:10px">
						    	<img id="profilePreview" 
						    	src="${path}/resources/images/profile/${empty loginMember.image ? 'default.png' : loginMember.image.renamed}"  
				    	        	 alt="프로필 미리보기" style="width: 150px; height: 150px; border-radius: 75px; object-fit: cover;">
							    <input type="file" id="profileImageInput" name="profileImageInput" accept="image/*" style="display: none;"/>
	       						<button type="button" onclick="document.getElementById('profileImageInput').click()" id="profileChange-btn">									
									사진변경</button>
							</div>
						    </td>
						</tr>
						<tr>
						    <th>사이트 소개 글</th>
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
						            <textarea  rows="5" name="teacherInfoContent" id="teacherInfoContent" style="padding:5px;width:323px;resize:none;">${loginMember.teacherInfoContent}</textarea>
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
<!-- 프로필 이미지 프리뷰 JavaScript -->
//프로필 이미지 프리뷰 함수
function previewImage() {
    const fileInput = document.getElementById('profileImageInput');
    const previewContainer = document.querySelector('.profile-upload');
    const changeButton = document.getElementById('profileChange-btn');
    
    fileInput.addEventListener('change', function(e) {
        const file = e.target.files[0];
        
        if (file) {
            // 파일이 이미지인지 확인
            if (!file.type.startsWith('image/')) {
                alert('이미지 파일만 선택할 수 있습니다.');
                return;
            }
            
            // 기존 이미지와 새 이미지 모두 제거
            const oldImage = document.getElementById('profilePreview');
            const existingNewImage = document.getElementById('newProfilePreview');
            if (existingNewImage) {
                existingNewImage.remove();
            }
            
            // 새 이미지 생성 및 표시
            const newImage = document.createElement('img');
            newImage.id = 'newProfilePreview';
            newImage.style.width = '150px';
            newImage.style.height = '150px';
            newImage.style.borderRadius = '75px';
            newImage.style.objectFit = 'cover';
            
            // FileReader로 이미지 읽기
            const reader = new FileReader();
            reader.onload = function(e) {
                newImage.src = e.target.result;
                oldImage.style.display = 'none';
                // 새 이미지를 버튼 앞에 삽입
                previewContainer.insertBefore(newImage, changeButton);
            }
            reader.readAsDataURL(file);
        }
    });
}

// DOM이 로드된 후 실행
document.addEventListener('DOMContentLoaded', function() {
    previewImage();
});
</script>
<!-- 6. 페이지별 스크립트 APi-컴포넌트-페이지 순 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 다음 우편번호 서비스 -->
<script src="${pageContext.request.contextPath}/resources/js/enroll/enrollForm.js"></script>
	
	

</body>
</html>