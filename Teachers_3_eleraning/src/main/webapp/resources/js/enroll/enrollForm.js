/**
 * enrollMember.jsp 에서 회원가입 관련 로직을 처리하기 위한 스크립트 제공
 */

$(document).ready(function() {
    initializeEventListeners();
});

// 모든 이벤트 리스너 초기화
function initializeEventListeners() {
    $(".logo-container").click(() => location.assign(path));
    $("#emailSelect").change(handleEmailSelect);
    $("#memberId_").click(checkDuplicate);
    $("#password_2").keyup(validatePasswordMatch);
    $("#emailCheckBtn").click(checkEmail);
    $("#postcodeFindBtn").click(sample4_execDaumPostcode);
	$("input[type='reset']").click(cancelEnroll);
}

// 이메일 도메인 선택 처리
function handleEmailSelect() {
    const domainInput = $("#emailDomain");
    const domainSelect = $("#emailSelect");
    
    if(domainSelect.val() === '') {
        domainInput.val('').prop('readonly', false);
    } else {
        domainInput.val(domainSelect.val()).prop('readonly', true);
    }
}

// 회원가입 폼 유효성 검사
function fn_invalidate() {
	/*해당 페이지에서는 아이디 사용 x*/
    /*const memberId = $("#memberId_").val();
    if(memberId.length < 4) {
        alert("아이디는 4글자 이상 입력해 주세요.");
        $("#memberId_").focus();
        return false;
    }*/

	/*이메일 인증 여부 확인*/
	const emailVerified = $("input[name='emailVerified']").val();
	if(emailVerified !== "Y") {
	    alert("이메일 인증이 필요합니다.");
	    return false;
	}
    
    const passwordReg = /(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()]).{8,}/;
    const password = $("#password_").val();
    if(!passwordReg.test(password)) {
        alert("비밀번호는 영문자,숫자,특수기호(!@#$%^&*())를 포함한 8글자 이상으로 입력해 주세요");
        return false;
    }
    return true;
}

// 비밀번호 일치 확인
function validatePasswordMatch(e) {
    const password = $("#password_").val();
    const passwordcheck = $(e.target).val();
    const $span = $("#checkResult");
    
    if(password.length >= 4 && passwordcheck.length >= 4) {
        if(password === passwordcheck) {
            $span.text("비밀번호가 일치합니다.").css("color", "green");
            $("input[value='가입']").prop("disabled", false);
        } else {
            $span.text("비밀번호가 일치하지 않습니다.").css("color", "red");
            $("input[value='가입']").prop("disabled", true);
        }
    }
}

// 아이디 중복 확인
function checkDuplicate() {
    const inputId = $("#memberId_").val();
    window.open(
        `${path}/member/idduplicate.do?id=${inputId}`,
        "_blank",
        "width=300,height=200"
    );
}

// 이메일 유효성 검사
function validateEmail(email) {
    const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
    return emailPattern.test(email);
}

// 이메일 인증 처리
function checkEmail() {
    const emailId = $("#emailId").val();
    const emailDomain = $("#emailDomain").val();
	const email = emailId + '@' + emailDomain;
	const searchType = $("#searchType").val();
    
    if(!emailId || !emailDomain) {
        alert("이메일을 입력해주세요.");
        return;
    }
    
    if(!validateEmail(email)) {
        alert("유효한 이메일 형식이 아닙니다.");
        return;
    }

	// 이메일 중복 체크
	$.ajax({
	    url: `${path}/auth/checkEmailDuplicate.do`,
	    method: "POST",
	    data: { email: email, searchType: searchType},
	    success: function(response) {
			console.log('Response:', response); // 응답 확인
	        if(response.exists) {
	            alert("이미 사용중인 이메일입니다.");
	            return;
	        } else {
	            // 중복이 아닌 경우에만 인증 이메일 발송
	            sendVerificationEmail(email);
	        }
	    },
	    error: function() {
			console.log('Error:', error); // 에러 상세 확인
	        alert("다시 시도해주세요.");
	    }
	});
}

// 인증 이메일 발송 함수 분리
function sendVerificationEmail(email) {
	//form 태그를 만들어서, email 값을 저장하고, body 태그에 form을 추가해서 submit 한 후 다시 제거하는 로직
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = `${path}/auth/sendEmail`;
    form.target = 'emailVerify';
    
    const emailInput = document.createElement('input');
    emailInput.type = 'hidden';
    emailInput.name = 'email';
    emailInput.value = email;
    
    const typeInput = document.createElement('input');
    typeInput.type = 'hidden';
    typeInput.name = 'authType';
    typeInput.value = 'signup'; // handleSendEmail 에서 인증 타입이 singup 인 경우 checkEmail.jsp 를 호출
    
    form.appendChild(emailInput);
    form.appendChild(typeInput);
    
    window.open('', 'emailVerify', 'width=400,height=300,left=500,top=200');
    
    document.body.appendChild(form);
    form.submit();
    document.body.removeChild(form);
}

// 이메일 관련 입력값이 변경될 때마다 인증 상태 초기화
$("#emailId, #emailDomain, #emailSelect").on("change", function() {
    const existingHidden = $("input[name='emailVerified']");
    if(existingHidden.length > 0) {
        existingHidden.val("N");
        
        // 입력 필드 잠금 해제
        $("#emailId").prop("readonly", false);
        $("#emailDomain").prop("readonly", false);
        $("#emailSelect").prop("disabled", false);
        
        // 스타일 원복
        $("#emailId, #emailDomain").css("backgroundColor", "");
        $("input[value='이메일 인증']").prop("disabled", false)
            .css("backgroundColor", "");
    }
});

// 우편번호 검색
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            const roadAddr = data.roadAddress;
            let extraRoadAddr = '';

            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                extraRoadAddr += data.bname;
            }
            if(data.buildingName !== '' && data.apartment === 'Y') {
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            
            // 우편번호와 주소 정보 입력
            $("#sample4_postcode").val(data.zonecode);
            $("#sample4_roadAddress").val(roadAddr);
            $("#sample4_detailAddress").val('');

            // 안내 텍스트 처리
            const $guide = $("#guide");
            if(data.autoRoadAddress) {
                $guide.html('(예상 도로명 주소 : ' + data.autoRoadAddress + extraRoadAddr + ')').show();
            } else {
                $guide.html('').hide();
            }
        }
    }).open();
}


/* 지역 선택시 해당 지역의 구/군 목록을 가져오는 함수 */
function districtSearch(e) {
    const select = $("#district");
    select.html("<option value=''>구/군</option>");
    const region = $(e.target).val();
    
    if(!region) return;
    
    $.ajax({
        url: `${path}/Ajax/school/district`,
        type: "GET",
        data: { region: region },
        success: function(data) {
            data.forEach(district => {
                const option = $("<option>")
                    .val(district)
                    .text(district);
                select.append(option);
            });
        },
        error: function(error) {
            console.error("Error: ", error);
        }
    });
}

/* 구/군 선택시 해당 지역의 학교 목록을 가져오는 함수 */
function schoolSearch(e) {
    const select = $("#school-name");
    select.html("<option value=''>학교명</option>");
    const district = $(e.target).val();
    const schoolType = $("#school-type").val();
	
	console.log(district,schoolType);
    
    if(!district || !schoolType) return;
    
    $.ajax({
        url: `${path}/Ajax/School/Search`,
        type: "GET",
        data: { 
            district: district,
            schoolType: schoolType 
        },
        success: function(data) {
			console.log('Received data:', data);  // 데이터 구조 확인
            data.forEach(school => {
				// option의 value는 standardCode, 화면에 표시되는 텍스트는 schoolName
                const option = $("<option>")
					.val(school.schoolNo)  // 실제 서버에 전송될 값 학교 코드를 value로
					.text(school.schoolName);  // 사용자에게 보여질 텍스트 학교 이름을 표시 텍스트로
                select.append(option);
            });
        },
        error: function(error) {
            console.error("Error: ", error);
        }
    });
}

function cancelEnroll(e) {
	alert("양식을 초기화하고 초기화면으로 아가시겠습니까?");
	location.assign(path);
}