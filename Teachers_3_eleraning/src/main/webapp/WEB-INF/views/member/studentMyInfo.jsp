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
	<link rel="stylesheet" href="${path}/resources/css/member/studentMyInfo.css">
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
					<form action="${path}/member/student/myinfo/save" method="post" onsubmit="return fn_invalidate();">
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
					<th>패스워드 *</th>
					<td><input type="password" name="memberPw" id="password_" placeholder="대소문자, 숫자, 특수문자 포함"><br>
					</td>
				</tr>
				<tr>
					<th>패스워드확인 *</th>
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
						<input type="text" id="sample4_postcode" name="addressNo" style="width:323px;" value="${addressNo != null ? addressNo : ''}" placeholder="우편번호">
						<input type="button" id="postcodeFindBtn" value="우편번호 찾기"><br>
						</div>
						<div>
						<input type="text" id="sample4_roadAddress" name="addressRoad" value="${addressRoad != null ? addressRoad : ''}" placeholder="도로명주소" style="width:323px;">
						<!-- <input type="text" id="sample4_jibunAddress" placeholder="지번주소" style="width: 300px;"> -->
						<span id="guide" style="color:#999;display:none"></span>
						<input type="text" id="sample4_detailAddress" name="addressDetail" value="${addressDetail != null ? addressDetail : ''}" placeholder="상세주소" style="width: 200px;">
						<!-- <input type="text" id="sample4_extraAddress" placeholder="참고항목" style="width: 150px;"> -->
						</div>
					</td>
				</tr>
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
    const path = '${pageContext.request.contextPath}';
</script>
<!-- 6. 페이지별 스크립트 APi-컴포넌트-페이지 순 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 다음 우편번호 서비스 -->
<script src="${pageContext.request.contextPath}/resources/js/enroll/enrollForm.js"></script>
	
	

</body>
</html>