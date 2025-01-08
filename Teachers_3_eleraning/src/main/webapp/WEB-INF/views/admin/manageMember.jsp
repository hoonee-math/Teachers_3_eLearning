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
</head>

<body>
<style>
* {
    /* border: 1px solid pink; */
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
}
table {
	margin-top: 40px;
	table-layout: fixed;
	width: 100%;
}
.mm-container {
}

/* 컨트롤 바 영역 */
.mm-control-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
	background:  #FAB350;
	padding: 10px;
	border-radius: 5px;
}

/* 회원 관리 액션 버튼 영역 */
.mm-actions button {
	margin-left: 10px;
	padding: 5px 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
	background: white;
	cursor: pointer;
}

.mm-actions button:hover {
	background: #f0f0f0;
}

/* 검색 및 정렬 영역 */
.mm-search-sort {
	display: flex;
	gap: 10px;
}

.mm-search-sort select, .mm-search-sort input {
	padding: 5px;
	border: 1px solid #FAB350;
	border-radius: 4px;
}

/* 회원 테이블 스타일 */
.mm-container table {
	border-collapse: collapse;
	margin-top: 20px;
}

.mm-container table th, .mm-container table td {
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid #FAB350;
}

.mm-container table th {
	background-color:  #FAB350;
	font-weight: bold;
}

.mm-container table tr:hover {
	background-color: #f5f5f5;
}

/* 체크박스 열 */
.mm-container .checkbox-cell {
	text-align: center;
}

/* 경고 횟수 강조 */
.mm-container .warning-count {
	color: #dc3545;
	font-weight: bold;
}

/* 페이지네이션 영역 */
.mm-container .pagination-container {
	margin-top: 20px;
	display: flex;
	justify-content: center;
}

#notice-div {
	color: red;	
	text-align: center;
	width: 1140px;
}
#categoryTitle {
	margin: 0 0 0 20px;
	font-size: 20pt;
	font-weight: bold;
}
ul {
	list-style-type: none;
	display: flex;
	align-items: center;
	justify-content: center;
	background-color: #FAB350;
	padding: 10px;
	width: 1140px;
}
li {
	margin: 0 10px;
	font-size: 13pt;
}
li>a {
	padding: 10px;
	text-decoration: none;
	color: #6f6f6f;
	background-color: #FAB350;
	width: 50px;
	height: 50px;
}
li>a:hover {
	background-color: white;
	border-radius: 50%;
	font-size: larger;
	font-weight: bold;
}
</style>
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
			<section class="main-section mm-container">
				<div>
					<div>
						<h2 style="font-size: 1.8em; margin-bottom:10px;">회원 목록</h2>
						<hr style="border:2px solid #FAB350;">
						<p style="margin-top:15px; font-size: 1.1em; color: #666;">회원을 조회, 경고, 정지 등 관리할 수 있습니다.</p>
					</div>
				</div>
				
				<!-- 컨트롤 바 -->
                <div class="mm-control-bar">
                    <!-- 회원 관리 액션 -->
                    <div class="mm-actions">
                        <button onclick="handleSelectedMembers('warning')">경고</button>
                        <button onclick="handleSelectedMembers('suspend')">활동정지</button>
                        <button onclick="handleSelectedMembers('delete')">회원삭제</button>
                    </div>
                    
                    <!-- 검색 및 정렬 -->
                    <div class="mm-search-sort">
                        <select id="numPerPage" onchange="changeNumPerPage(this.value)">
                            <option value="5" ${param.numPerPage == 5 ? 'selected' : ''}>5명씩 보기</option>
                            <option value="10" ${param.numPerPage == 10 ? 'selected' : ''}>10명씩 보기</option>
                            <option value="20" ${param.numPerPage == 20 ? 'selected' : ''}>20명씩 보기</option>
                        </select>
                        <select id="sortBy" onchange="changeSortBy(this.value)">
                            <option value="memberNo">회원번호순</option>
                            <option value="warningCount">경고횟수순</option>
                            <option value="enrollDate">가입일순</option>
                        </select>
                        <input type="text" id="searchKeyword" placeholder="검색어 입력">
                        <button onclick="searchMembers()">검색</button>
                    </div>
                </div>
                
				<div id="board-container">
					<table id="tbl-board">
						<colgroup>
							<col style="width: 20px;">
							<col style="width: 50px;">
							<col style="width: 60px;">
							<col style="width: 60px;">
							<col style="width: 180px;">
							<col style="width: 60px;">
							<col style="width: 60px;">
							<col style="width: 60px;">
							<col style="width: 60px;">
							<col style="width: 30px;">
						</colgroup>
						<thead>
							<tr>
									<th class="checkbox-cell">
										<input type="checkbox" id="selectAll" onclick="toggleAllCheckboxes()">
									</th>
									<th>회원번호</th>
									<th>아이디</th>
									<th>이름</th>
									<th>이메일</th>
									<th>신고접수</th>
									<th>유효신고</th>
									<th>경고횟수</th>
									<th>가입일</th>
									<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty members }">
				            	<tr>
				            		<td colspan="8" style="text-align: center;">
				            			죄회된 결과가 없습니다.
				            		</td>
				            	</tr>
				            </c:if>
							<c:forEach var="m" items="${members }">
								<tr>
									<td class="checkbox-cell">
										<input type="checkbox" name="selectedMembers" value="${m.memberNo}" >
									</td>
									<td>${m.memberNo}</td>
									<td>${m.memberId}</td>
									<td>${m.memberName}</td>
									<td>${m.email}</td>
	  							    <td class="warning-count">1</td>
									<td class="warning-count">1</td>
									<td class="warning-count">1</td>
									<td> 
										<fmt:formatDate value="${m.enrollDate}" pattern="yyyy-MM-dd" />
									</td>
									<td>
										<p>정상</p>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
			        <div id="pageBar">
			        	${pageBar}
			        </div>
			    </div>
			</section>
		</div>
	</div> <!-- /페이지 내용 -->
	</main>


<!-- 푸터 include -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<!-- 콘텐츠 영역 종료 -->
</div>

<jsp:include page="/WEB-INF/views/common/scripts.jsp" />
<!-- API/Ajax 관련 JavaScript -->
<script>
//페이지 변경
function changePage(page) {
    const numPerPage = document.getElementById('numPerPage').value;
    const sortBy = document.getElementById('sortBy').value;
    const keyword = document.getElementById('searchKeyword').value;
    
    location.href = `${path}/admin/member?cPage=\${page}&numPerPage=\${numPerPage}&sortBy=\${sortBy}&keyword=\${keyword}`;
}

// 페이지당 표시 개수 변경
function changeNumPerPage(num) {
    const sortBy = document.getElementById('sortBy').value;
    const keyword = document.getElementById('searchKeyword').value;
    
    location.href = `${path}/admin/member?cPage=1&numPerPage=\${num}&sortBy=\${sortBy}&keyword=\${keyword}`;
}

// 정렬 기준 변경
function changeSortBy(sort) {
    const numPerPage = document.getElementById('numPerPage').value;
    const keyword = document.getElementById('searchKeyword').value;
    
    location.href = `${path}/admin/member?cPage=1&numPerPage=\${numPerPage}&sortBy=\${sort}&keyword=\${keyword}`;
}

// 회원 검색
function searchMembers() {
    const numPerPage = document.getElementById('numPerPage').value;
    const sortBy = document.getElementById('sortBy').value;
    const keyword = document.getElementById('searchKeyword').value;
    
    location.href = `${path}/admin/member?cPage=1&numPerPage=\${numPerPage}&sortBy=\${sortBy}&keyword=\${keyword}`;
}

// 전체 체크박스 토글
function toggleAllCheckboxes() {
    const checkboxes = document.getElementsByName('selectedMembers');
    const selectAllCheckbox = document.getElementById('selectAll');
    
    checkboxes.forEach(checkbox => {
        checkbox.checked = selectAllCheckbox.checked;
    });
}

// 선택된 회원 처리
function handleSelectedMembers(action) {
    const selectedMembers = Array.from(document.getElementsByName('selectedMembers'))
        .filter(checkbox => checkbox.checked)
        .map(checkbox => checkbox.value);
    
    if(selectedMembers.length === 0) {
        alert('선택된 회원이 없습니다.');
        return;
    }
    
    // 실제 구현 시에는 서버로 Ajax 요청
    let message;
    switch(action) {
        case 'warning':
            message = '선택된 회원들에게 경고를 부여하시겠습니까?';
            break;
        case 'suspend':
            message = '선택된 회원들의 활동을 정지시키겠습니까?';
            break;
        case 'delete':
            message = '선택된 회원들을 삭제하시겠습니까?';
            break;
    }
    
    if(confirm(message)) {
        // 추후 실제 Ajax 통신으로 대체
        console.log(`Action: ${action}, Selected members:`, selectedMembers);
        alert('처리되었습니다.');
    }
}
</script>
</body>
</html>