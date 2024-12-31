/**
 *  로그인 관련 javaScript
 */
function logout() {
	if(confirm('로그아웃 하시겠습니까?')) {
		// 추후 로그아웃 서블릿 연동
		location.href = '${path}/logout';
	}
}