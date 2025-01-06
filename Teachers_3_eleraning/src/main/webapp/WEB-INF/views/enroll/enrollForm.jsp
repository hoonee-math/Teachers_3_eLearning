<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<!-- 1. 공통 head 요소/공통 CSS 포함 -->
<jsp:include page="/WEB-INF/views/common/head.jsp" />
<!-- 2. 페이지별 CSS -->
<link rel="stylesheet" href="${path}/resources/css/enroll/enrollMember.css">
<link rel="stylesheet" href="${path}/resources/css/enroll/enrollHeader.css">
<link rel="stylesheet" href="${path}/resources/css/enroll/enrollForm.css">
<title>Honey T</title>
</head>

<body>
<!-- 콘텐츠 영역 -->
<div id="wrap">
<!-- 3.헤더 영역 -->
<header>
<div class="menu">
	<div class="logo-container">
		<img class="logo-container" src="${path}/resources/images/common/HoneyT_Text_font_Oduba_warning.png" style="width:100px;">
	</div>
</div>
</header>
<!-- 4.메인 콘텐츠 -->
<main class="main-container">
<!-- (삭제 x)  본문 섹션 wrapper div -->
	
	
	<section id=enroll-container>
		<h2>회원 가입 정보 입력</h2>
		<!-- onsubmit 발생했을 때 action 속성을 이용해 enrollmemberend.do 로 post 요청. onsubmit 속성을 통해 유효성검사 실시-->
		<!-- onsubmit 값의 return 값이 true 일때 post 로 요청! -->
		<form action="${path}/enroll/end" method="post" onsubmit="return fn_invalidate();">
			<table>
				<tr>
					<th>아이디 *</th>
					<td>
						<input type="text" name="memberId" id="memberId" placeholder="아이디" required>
						<input type="button" value="중복검사" id="memberId_">
					</td>
				</tr>
				<tr>
					<th>이메일 *</th>
					<td>
						<input type="text" name="emailId" id="emailId" style="width: 150px;" required> 
						@ <input type="text" name="emailDomain" id="emailDomain" style="width: 150px;" required>
						<select id="emailSelect" onchange="handleEmailSelect()">
							<option value="">직접입력</option>
							<option value="gmail.com">gmail.com</option>
							<option value="naver.com">naver.com</option>
							<option value="daum.net">daum.net</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="nate.com">nate.com</option>
						</select> 
						<!-- 이메일 인증 서비스 코드를 모듈화 하기 위한 id 값 searchType : searchPassword/emailDuplicate -->
						<input type="hidden" id="searchType" value="emailDuplicate">
						<input type="button" id="emailCheckBtn" value="이메일 인증">
					</td>
				</tr>
				<tr>
					<th>패스워드 *</th>
					<td><input type="password" name="memberPw" id="password_" placeholder="대소문자, 숫자, 특수문자 포함" required><br>
					</td>
				</tr>
				<tr>
					<th>패스워드확인 *</th>
					<td><input type="password" id="password_2" required><br>
						<span id="checkResult"></span></td>
				</tr>
				<tr>
					<th>이름 *</th>
					<td><input type="text" name="memberName" id="userName" required><br>
					</td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td><input type="text" name="memberNick" id="memberNick" placeholder="다른 사용자에게 보여줄 닉네임을 입력하세요."><br>
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>
						<div style="margin-bottom:10px">
						<input type="text" id="sample4_postcode" name="addressNo" placeholder="우편번호">
						<input type="button" id="postcodeFindBtn" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
						</div>
						<div>
						<input type="text" id="sample4_roadAddress" name="addressRoad" placeholder="도로명주소" style="width: 300px;">
						<!-- <input type="text" id="sample4_jibunAddress" placeholder="지번주소" style="width: 300px;"> -->
						<span id="guide" style="color:#999;display:none"></span>
						<input type="text" id="sample4_detailAddress" name="addressDetail" placeholder="상세주소" style="width: 200px;">
						<!-- <input type="text" id="sample4_extraAddress" placeholder="참고항목" style="width: 150px;"> -->
						</div>
					</td>
				</tr>
				<tr>
				    <th><!-- 회원 구분 * --></th>
				    <td>
				        <input type="hidden" name="memberType" id="parents" value="1" ${memberType == '1' ? 'checked' : ''}>
				        <label for="parents"></label>
				        <input type="hidden" name="memberType" id="teacher" value="2" ${memberType == '2' ? 'checked' : ''}>
				        <label for="teacher"></label>
				    </td>
				</tr>
				<c:if test="${memberType == '1'}">
				<tr>
				    <th>학교</th>
				    <td>
				        <div style="margin-bottom:10px">
				            <select class="child_school" name="region" id="region" onchange="districtSearch(event);" style="width:108px">
				                <option value=''>전체지역</option><option value="서울">서울</option><option value="경기">경기</option>
								<option value="인천">인천</option><option value="부산">부산</option><option value="세종">세종</option>
								<option value="광주">광주</option><option value="대구">대구</option><option value="대전">대전</option>
								<option value="울산">울산</option><option value="강원">강원</option><option value="충남">충남</option>
								<option value="충북">충북</option><option value="경남">경남</option><option value="경북">경북</option>
								<option value="전남">전남</option><option value="전북">전북</option><option value="제주">제주</option>
				            </select>
				            <select class="child_school" id="district" onchange="schoolSearch(event);" style="width:88px">
				                <option value=''>구/군</option>
				            </select>
				            <select class="child_school" id="school-type" onchange="schoolSearch({target:document.getElementById('district')});" style="width:108px">
				                <option value="">초중고</option>
				                <option value="초등학교">초등학교</option>
				                <option value="중학교">중학교</option>
				                <option value="고등학교">고등학교</option>
				                <option value="고등학교">기타학교</option>
				            </select>
				            <!-- name에 standardCode 를 입력하여 회원정보에는 학교 코드가 저장되도록 설정 -->
				            <select class="child_school" id="school-name" name="schoolNo" style="width:186px">
				                <option value="">학교명</option>
				            </select>
				        </div>
				    </td>
				</tr></c:if>
			</table>
			<div class="enrollsubmit">
				<input type="reset" value="취소">	<input type="submit" value="가입">
			</div>
		</form>
	</section>



</main> <!-- /메인 콘텐츠 -->
<!-- 5. 푸터 영역 -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</div> <!-- /콘텐츠 영역 -->



<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    const path = '${pageContext.request.contextPath}';
</script>
<!-- 6. 페이지별 스크립트 APi-컴포넌트-페이지 순 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 다음 우편번호 서비스 -->
<script src="${pageContext.request.contextPath}/resources/js/enroll/enrollForm.js"></script>
	
	
</body>
</html>