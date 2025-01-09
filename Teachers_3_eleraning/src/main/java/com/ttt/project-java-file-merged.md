# 디렉토리: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt

# 디렉토리: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/common

# 디렉토리: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/common/filter

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/common/filter/AdminCheckFilter.java
```java
package com.ttt.common.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Member3;

@WebFilter("/member/admin/*")
public class AdminCheckFilter extends HttpFilter implements Filter {
   
public AdminCheckFilter() {
super();
}

public void destroy() {
}

public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

HttpSession session = ((HttpServletRequest)request).getSession();
Member3 loginMember = (Member3)session.getAttribute("loginMember");

// 관리자 권한 체크 (memberType = 0) 
if (loginMember.getMemberType() != 0) {
request.setAttribute("msg", "관리자만 접근 가능한 페이지입니다.");
request.setAttribute("loc", "/");
request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
return;
}

chain.doFilter(request, response);
}

/**
 * @see Filter#init(FilterConfig)
 */
public void init(FilterConfig fConfig) throws ServletException {
// TODO Auto-generated method stub
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/common/filter/CookieCheckFilter.java
```java
package com.ttt.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Member3;
import com.ttt.service.MemberService;

@WebFilter("/*")
public class CookieCheckFilter extends HttpFilter implements Filter {
   
public CookieCheckFilter() {
super();
}

public void destroy() {
}

public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

HttpServletRequest httpRequest = (HttpServletRequest) request;
HttpSession session = httpRequest.getSession();

// 세션이 없는 경우 쿠키 체크
if(session.getAttribute("loginMember") == null) {
Cookie[] cookies = ((HttpServletRequest)request).getCookies();
if(cookies != null) {
for(Cookie c : cookies) {
if(c.getName().equals("saveId")) {
String memberId = c.getValue();
// 저장된 ID로 회원정보 조회
Member3 m = new MemberService().selectMemberById(memberId); 
if(m != null) {
session.setAttribute("loginMember", m);
break;
}
}
}
}
}



chain.doFilter(request, response);
}

public void init(FilterConfig fConfig) throws ServletException {
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/common/filter/EncodingFilter.java
```java
package com.ttt.common.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;

/* 서블릿 요청에 대해 전부 utf-8 처리하는 filter 추가 */
@WebFilter("/*")
public class EncodingFilter extends HttpFilter implements Filter {
   
public EncodingFilter() {
super();
}

public void destroy() {
}

public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
request.setCharacterEncoding("utf-8");
response.setCharacterEncoding("utf-8");
chain.doFilter(request, response);
}

public void init(FilterConfig fConfig) throws ServletException {
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/common/filter/LoginCheckFilter.java
```java
package com.ttt.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Member3;
import com.ttt.service.MemberService;

/* 로그인 여부 확인하는 서블릿 */
@WebFilter( servletNames= {
/* 로그인을 체크할 서블릿에 네이밍 후 서블릿네임 선언하기 */

})
public class LoginCheckFilter extends HttpFilter implements Filter {
   
public LoginCheckFilter() {
super();
}

public void destroy() {
}

public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
// place your code here

// HttpSession 에 로그인 정보가 있는지 확인
HttpSession session=((HttpServletRequest)request).getSession();
Member3 loginMember=(Member3)session.getAttribute("loginMember");

// 로그인 체크 로직
// Exception 발생시켜서 에러페이지로 이동 예외처리 - 예외 처리 로직은 꼭 필요한가..?
if(session==null||loginMember==null) { //jsp 를 사용하고 있기 때문에 사실은 session 은 null 이 나올 수가 없음

// 메시지와 원래 URL을 전달하여 예외 발생
request.setAttribute("msg", "로그인 후 이용 가능한 서비스입니다.");
request.setAttribute("loc", "");

// msg.jsp로 포워드
request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);

return; // 필터 체인 종료
}
// pass the request along the filter chain
chain.doFilter(request, response);
}

public void init(FilterConfig fConfig) throws ServletException {
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/common/filter/PasswordEncryptFilter.java
```java
package com.ttt.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;

import com.ttt.common.PasswordEncoding;

/* 회원가입 & 로그인 -> 비밀번호 인코딩처리 해주는 filter */
@WebFilter(servletNames= {
//"teacherInfoUpdate"
})
public class PasswordEncryptFilter extends HttpFilter implements Filter {
   
public PasswordEncryptFilter() {
super();
}

public void destroy() {
}

public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
// place your code here
PasswordEncoding pe=new PasswordEncoding((HttpServletRequest)request);
// pass the request along the filter chain
chain.doFilter(pe, response);
}

public void init(FilterConfig fConfig) throws ServletException {
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/common/filter/StudentCheckFilter.java
```java
package com.ttt.common.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Member3;

@WebFilter("/member/student/*")
public class StudentCheckFilter extends HttpFilter implements Filter {
   
public StudentCheckFilter() {
super();
}

public void destroy() {
}

public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

HttpSession session = ((HttpServletRequest)request).getSession();
Member3 loginMember = (Member3)session.getAttribute("loginMember");

// 학생 권한 체크 (memberType = 1) 
if (loginMember.getMemberType() != 1) {
request.setAttribute("msg", "학생만 접근 가능한 페이지입니다.");
request.setAttribute("loc", "/");
request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
return;
}

chain.doFilter(request, response);
}

public void init(FilterConfig fConfig) throws ServletException {
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/common/filter/TeacherCheckFilter.java
```java
package com.ttt.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Member3;

@WebFilter("/member/teacher/*")
public class TeacherCheckFilter extends HttpFilter implements Filter {
   
public TeacherCheckFilter() {
super();
}

public void destroy() {
}

public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

HttpSession session = ((HttpServletRequest)request).getSession();
Member3 loginMember = (Member3)session.getAttribute("loginMember");

// 교사 권한 체크 (memberType = 2) 
if (loginMember.getMemberType() != 2) {
request.setAttribute("msg", "교사만 접근 가능한 페이지입니다.");
request.setAttribute("loc", "/");
request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
return;
}

chain.doFilter(request, response);
}

public void init(FilterConfig fConfig) throws ServletException {
}

}

```


## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/common/PasswordEncoding.java
```java
package com.ttt.common;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

/* PasswordEncryptFilter.java 필터를 통해 받아온 비밀번호를 암호화 해주는 객체 */
public class PasswordEncoding extends HttpServletRequestWrapper {

public PasswordEncoding(HttpServletRequest request) {
super(request);
}

@Override
public String getParameter(String name) {
String originPw=super.getParameter(name); // super는 위에서 request를 변환한 값을 가져오기 때문에! key값으로 받아온 값을 저장시킴!
if(name.equals("memberPw")) {
String enocodingPw=getSHA512(originPw);
return enocodingPw;
}
return originPw;
}

private String getSHA512(String orival) {
//java.security.MessageDigest 클래스 이용
MessageDigest md=null;

try {
//암호화 알고리즘 선택
md=MessageDigest.getInstance("SHA-512");
}catch(NoSuchAlgorithmException e) {
e.printStackTrace();
}
byte[] originPwByte=orival.getBytes();
md.update(originPwByte);
byte[] enocodingPwByte=md.digest();
String enocodingPw=Base64.getEncoder().encodeToString(enocodingPwByte);
return enocodingPw;
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/common/SqlSessionTemplate.java
```java
package com.ttt.common;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlSessionTemplate {
public static SqlSession getSession() {
SqlSession session = null;
String fileName="mybatis-config.xml";
try (InputStream is = Resources.getResourceAsStream(fileName)) {
session = new SqlSessionFactoryBuilder().build(is).openSession(false);
} catch (IOException e) {
e.printStackTrace();
}
return session;
}
}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/common/TextNormalizer.java
```java
package com.ttt.common;

import java.text.Normalizer;

public class TextNormalizer {
public String normalizeText(String input) {
// NFD 형식으로 저장된 텍스트를 NFC 형식으로 변환
return Normalizer.normalize(input, Normalizer.Form.NFC);
}
}

```


# 디렉토리: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller

# 디렉토리: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/admin

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/admin/AdminDdayServlet.java
```java
package com.ttt.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

@WebServlet("/admin/dday")
public class AdminDdayServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
private Gson gson = new Gson();
   
public AdminDdayServlet() {
super();
}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");

Map<String, Object> result = new HashMap<>();

try {
// 임시 데이터를 Map으로 생성
Map<String, String> dday = new HashMap<>();
dday.put("ddayName", "전국연합학력평가");
dday.put("ddayDate", "2024-03-20");

result.put("success", true);
result.put("data", dday);

} catch (Exception e) {
result.put("success", false);
result.put("message", "D-day 정보를 불러올 수 없습니다.");
}

response.getWriter().write(gson.toJson(result));

}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request, response);
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/admin/AdminMemberServlet.java
```java
package com.ttt.controller.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Member3;
import com.ttt.service.AdminMemberService;


@WebServlet("/admin/member")
public class AdminMemberServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
   

public AdminMemberServlet() {
super();
}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//페이징 처리를 위한 변수들 
int cPage;
try {
cPage = Integer.parseInt(request.getParameter("cPage"));
} catch(NumberFormatException e) {
cPage = 1;
}

int numPerPage;
try {
numPerPage = Integer.parseInt(request.getParameter("numPerPage"));
} catch(NumberFormatException e) {
numPerPage = 5; // 기본값 5명씩 출력
}

// 더미데이터 생성 (30명)
List<Map<String,Object>> members3 = new ArrayList<>();
for(int i=1; i<=30; i++) {
Map<String,Object> member = new HashMap<>();
member.put("memberNo", i);
member.put("memberId", "user" + i);
member.put("memberName", "사용자" + i);
member.put("email", "user" + i + "@example.com");
member.put("warningCount", (int)(Math.random() * 3));  // 0~2 사이 랜덤 경고횟수
member.put("enrollDate", new java.sql.Date(System.currentTimeMillis())); 
member.put("isDeleted", 0);
members3.add(member);
}

List<Member3> allMembers= new AdminMemberService().selectAllMember();
System.out.println("DB 실행 완료 : 리스트 출력 -> "+allMembers.toString());

// 페이징 처리
int totalData = allMembers.size();
int totalPage = (int)Math.ceil((double)totalData/numPerPage);
int pageBarSize = 5;
int startPage = ((cPage-1)/pageBarSize) * pageBarSize + 1;
int endPage = startPage + pageBarSize - 1;
if(endPage > totalPage) endPage = totalPage;

// 현재 페이지 데이터 범위 계산
int start = (cPage-1) * numPerPage;
int end = Math.min(start + numPerPage, totalData);

List<Member3> members = allMembers.subList(start, end);
//List<Map<String,Object>> currentPageMembers = members.subList(start, end);

// 페이지바 HTML 생성
StringBuilder pageBar = new StringBuilder();
pageBar.append("<ul class='pagination'>");
   
// 이전 페이지
if(startPage > 1) {
pageBar.append("<li><a href='javascript:changePage(" + (startPage-1) + ")'>이전</a></li>");
}

// 페이지 번호
for(int i=startPage; i<=endPage; i++) {
if(i == cPage) {
pageBar.append("<li><span class='current'>" + i + "</span></li>");
} else {
pageBar.append("<li><a href='javascript:changePage(" + i + ")'>" + i + "</a></li>");
}
}

// 다음 페이지
if(endPage < totalPage) {
pageBar.append("<li><a href='javascript:changePage(" + (endPage+1) + ")'>다음</a></li>");
}

pageBar.append("</ul>");

// request에 데이터 저장
request.setAttribute("members", members); // 전체 리스트 전달
request.setAttribute("pageBar", pageBar.toString());

request.getRequestDispatcher("/WEB-INF/views/admin/manageMember.jsp").forward(request, response);

}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request, response);
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/admin/AdminMenu.java
```java
package com.ttt.controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name="admin", urlPatterns = "/member/admin/*")
public class AdminMenu extends HttpServlet {
private static final long serialVersionUID = 1L;
   
public AdminMenu() {
super();
}

// "/admin/*" 으로 들어오는 모든 요청을 분기처리하여 각 페이지로 응답하기
// 각 페이지에서의 내용은 ajax 요청으로 처리하기 위한 서블릿 만들기
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
String uri = request.getRequestURI();
String path = uri.substring(request.getContextPath().length());

switch(path) {
case "/member/admin/menu":
request.getRequestDispatcher("/WEB-INF/views/admin/adminmenu.jsp").forward(request, response);
break;
case "/member/admin/myinfo": 
request.getRequestDispatcher("/WEB-INF/views/admin/adminmenu.jsp").forward(request, response);
break;
case "/member/admin/managePost": 
request.getRequestDispatcher("/WEB-INF/views/admin/managePost.jsp").forward(request, response);
break;
case "/member/admin/managePayment": 
request.getRequestDispatcher("/WEB-INF/views/admin/managePayment.jsp").forward(request, response);
break;
case "/member/admin/manageMember": 
request.getRequestDispatcher("/WEB-INF/views/admin/manageMember.jsp").forward(request, response);
break;
case "/member/admin/notify/board": 
request.getRequestDispatcher("/WEB-INF/views/admin/notifyBoard.jsp").forward(request, response);
break;
case "/member/admin/notify/write": 
request.getRequestDispatcher("/WEB-INF/views/admin/notifyWrite.jsp").forward(request, response);
break;
}
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
}

}

```


# 디렉토리: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/auth

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/auth/EmailAuthenticationController.java
```java
package com.ttt.controller.auth;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.ttt.dto.EmailAuthenticationResult;
import com.ttt.dto.Member3;
import com.ttt.service.EmailAuthenticationService;

@WebServlet("/auth/*")
public class EmailAuthenticationController extends HttpServlet {
private EmailAuthenticationService authService = new EmailAuthenticationService();
private static final long serialVersionUID = 1L;
   
public EmailAuthenticationController() {
super();
}

@Override
protected void doPost(HttpServletRequest request, 
HttpServletResponse response) 
throws ServletException, IOException {

// 서블릿 주소 요청 주소에 따라서 분기처리
String pathInfo = request.getPathInfo();
System.out.println(pathInfo);

switch (pathInfo) {
case "/sendEmail":
handleSendEmail(request, response);
break;
case "/verify":
handleVerification(request, response);
break;
case "/complete":
handleComplete(request, response);
break;
case "/checkEmailDuplicate.do":
handleDuplicateCheck(request, response);
break;
default:
response.sendError(HttpServletResponse.SC_NOT_FOUND);
}
}

private void handleSendEmail(HttpServletRequest request, 
HttpServletResponse response) 
throws ServletException, IOException {

String email = request.getParameter("email");
String authType = request.getParameter("authType"); // signup or reset

try {
String authNumber = authService.generateAuthNumber();
String hashedNumber = authService.hashAuthNumber(authNumber);

authService.setAuthenticationInfo(request.getSession(), 
email, hashedNumber);
authService.sendAuthEmail(email, authNumber);

// JSP 선택 (회원가입용/비밀번호 재설정용)
String jspPath = authType.equals("signup") ? 
"/WEB-INF/views/enroll/checkAuthNumberForEnrollUseEmail.jsp" :
"/WEB-INF/views/enroll/checkAuthNumberForEmailForFindPassword.jsp";

request.setAttribute("email", email);
request.getRequestDispatcher(jspPath).forward(request, response);

} catch (Exception e) {
response.setContentType("application/json");
response.getWriter().write("{\"error\": \"" + 
e.getMessage() + "\"}");
}
}

private void handleVerification(HttpServletRequest request, 
HttpServletResponse response) 
throws ServletException, IOException {

String inputCode = request.getParameter("authCode");
String authType = request.getParameter("authType");

EmailAuthenticationResult result = 
authService.verifyAuthNumber(request.getSession(), inputCode);

request.setAttribute("result", result.isSuccess());
request.setAttribute("message", result.getMessage());

// returnPath를 authType에 따라 분기처리
String returnPath = "/WEB-INF/views/enroll/" + 
(authType.equals("reset") ? "checkAuthNumberForEmailForFindPassword.jsp" : "checkAuthNumberForEnrollUseEmail.jsp");
   
request.getRequestDispatcher(returnPath).forward(request, response);
}

private void handleComplete(HttpServletRequest request, 
HttpServletResponse response) 
throws ServletException, IOException {

HttpSession session = request.getSession();
boolean isPasswordReset = Boolean.parseBoolean(request.getParameter("isPasswordReset"));
String email = request.getParameter("email");  // 이메일 파라미터 받기

try {
if (isPasswordReset) {
session.setAttribute("passwordResetAuthorized", true);
session.setAttribute("email", email);  // 이메일도 세션에 저장
response.setContentType("application/json");
response.getWriter().write("{\"success\": true}");
}
/* authService.clearAuthenticationInfo(session); */

} catch (Exception e) {
response.setContentType("application/json");
response.getWriter().write("{\"error\": \"" + 
e.getMessage() + "\"}");
}
}

private void handleDuplicateCheck(HttpServletRequest request,  HttpServletResponse response) throws ServletException, IOException  {

HttpSession session = request.getSession();
Gson gson = new Gson();
String email="",searchType="", memberName="";

// request 로 받아온 값을 변수에 저장
try {
email = request.getParameter("email");  // 이메일 파라미터 받기
searchType=request.getParameter("searchType"); // 이메일 중복검사로 회원가입, 비밀번호, 아이디 찾기 기능 구현
memberName=request.getParameter("memberName"); // 아이디,비밀번호 찾기시 필요

System.out.println(searchType + "," + email + ","+ memberName);
} catch(Exception e ) {
System.out.println("이메일 중보검사중 파라미터를 받아오지 못한 값이 존재함");
}

// 실제 이메일 중복검사 서비스 실행
try {

Member3 m= new Member3();
Member3 result = new Member3();
switch(searchType) {
case "emailDuplicate" : m.setEmail(email); System.out.println(m); 
result = new EmailAuthenticationService().checkEmailDuplicateByEmail(m); break;
case "searchPassword" : m.setEmail(email); m.setMemberName(memberName);; System.out.println(m); 
result = new EmailAuthenticationService().selectMemberByNameAndEmail(m); break;
}

System.out.println("result : "+result);
boolean exists = (result!=null);
System.out.println("exists : "+exists);

response.setContentType("application/json");
response.getWriter().write("{\"exists\": " + exists + "}");

} catch(Exception e) {
e.printStackTrace();
System.out.println("EmailAuthenticationController : 이메일 중복체크 중 오류 발생");

// 에러 응답 처리 추가
response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
Map<String, Object> errorResponse = new HashMap<>();
// json 데이터로 "error" : "메세지" 전달
errorResponse.put("error", "이메일 중복 체크 중 오류가 발생했습니다.");
response.getWriter().write(gson.toJson(errorResponse));
}
}
}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/auth/FindIdEndServlet.java
```java
package com.ttt.controller.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Member3;
import com.ttt.service.MemberService;

@WebServlet("/auth/findidend")
public class FindIdEndServlet extends HttpServlet {
private static final long serialVersionUID = 1L;

public FindIdEndServlet() {
super();
}


protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

String memberName = request.getParameter("input-name");
String email = request.getParameter("input-email");


Member3 m = Member3.builder()
.memberName(memberName)
.email(email)
.build();

String memberId = new MemberService().selectMemberIdByNameAndEmail(m);

String msg, loc;

if(memberId != null && !memberId.isEmpty()) {
msg = memberName+"님의 아이디는 "+memberId+" 입니다.";
loc = "/";
}else {
msg = "일치하는 회원 정보가 없습니다.";
loc = "/auth/find";
}

request.setAttribute("msg", msg);
request.setAttribute("loc", loc);

request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);


}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request, response);
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/auth/FindPwEndServlet.java
```java
package com.ttt.controller.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Member3;
import com.ttt.service.MemberService;

@WebServlet("/auth/checkEmailDuplicate")
public class FindPwEndServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
   
public FindPwEndServlet() {
super();
}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
String searchType=request.getParameter("searchType");
String email=request.getParameter("email");
String memberId=request.getParameter("memberId");

System.out.println("Received parameters:");
System.out.println("searchType: " + searchType);
System.out.println("email: " + email);
System.out.println("memberId: " + memberId);

System.out.println(searchType + "," + email + ","+ memberId);

Member3 m = new Member3();
switch(searchType) {
case "emailDuplicate" : m.setEmail(email); System.out.println(m); break;
case "searchPassword" : m.setEmail(email); m.setMemberId(memberId); System.out.println(m); break;
}

Member3 result=new MemberService().selectMemberByIdAndEmail(m);
System.out.println("Query result: " + result);

response.setContentType("application/json");
response.getWriter().write("{\"exists\": " + (result != null) + "}");


}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request, response);
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/auth/LoginServlet.java
```java
package com.ttt.controller.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Member3;
import com.ttt.service.MemberService;

@WebServlet("/auth/login.do")
public class LoginServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
   
public LoginServlet() {
super();
}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
String memberId = request.getParameter("memberId");
String memberPw = request.getParameter("memberPw");
String saveId = request.getParameter("remember");

Member3 m = new MemberService().selectMemberById(memberId);

//System.out.println("MemberLoginServlet.java : " + m);

// 로그인 성공시 처리할 로직 (아이디, 비번 일치)
if(m!=null && m.getMemberPw().equals(memberPw)) {
// 로그인 유지를 위한 session 정보 저장
HttpSession session=request.getSession();
session.setAttribute("loginMember", m);

// 로그인 유지 체크시 쿠키 생성
if(saveId != null) {
Cookie c = new Cookie("saveId", m.getMemberId());
c.setMaxAge(7*24*60*60);
c.setPath("/");
response.addCookie(c);
} else {
// 체크 해제시 쿠키 삭제
Cookie c = new Cookie("saveId","");
c.setMaxAge(0);
c.setPath("/");
response.addCookie(c);
}

// 메인화면으로 리다이렉트 시킴! 이전 주소 날려버리고 재요청!
response.sendRedirect(request.getContextPath()); 
} else {
// 로그인 실패
request.setAttribute("msg", "아이디와 패스워드가 일치하지 않습니다."); //실패하면 통상 alert 띄워주기 때문에 사용
request.setAttribute("loc","/"); 
request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
}
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/auth/ToFindIdAndPwServlet.java
```java
package com.ttt.controller.auth;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/auth/find")
public class ToFindIdAndPwServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
   
public ToFindIdAndPwServlet() {
super();
}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
request.getRequestDispatcher("/WEB-INF/views/enroll/findIdAndPw.jsp").forward(request, response);
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request, response);
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/auth/ToFindPwServlet.java
```java
package com.ttt.controller.auth;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/auth/findpw")
public class ToFindPwServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
   
public ToFindPwServlet() {
super();

}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
request.getRequestDispatcher("/WEB-INF/views/enroll/findPw.jsp").forward(request, response);



}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request, response);
}

}

```


# 디렉토리: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/calendar

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/calendar/ApiCalendarEventsServlet.java
```java
package com.ttt.controller.calendar;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.ttt.dto.Member3;
import com.ttt.service.CourseService;
import com.ttt.service.LectureService;

@WebServlet("/api/calendar/events")
public class ApiCalendarEventsServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
private LectureService lectureService = new LectureService();
private CourseService courseService = new CourseService();
private Gson gson = new Gson();
   
public ApiCalendarEventsServlet() {
super();
}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
try {
// 파라미터 받기
int grade = Integer.parseInt(request.getParameter("grade"));

// 응답 데이터 준비
Map<String, Object> responseData = new HashMap<>();
responseData.put("grade", grade);

// 1. 해당 학년의 전체 강의 일정 조회
List<Map<String, Object>> events = lectureService.selectEventsByGrade(responseData);
responseData.put("events", events);

// 2. 로그인한 경우 수강 중인 강좌 번호 목록 추가
HttpSession session = request.getSession();
Member3 loginMember = (Member3) session.getAttribute("loginMember");

// 회원 유형에 따라 다른 일정 조회
if(loginMember != null) {
if (loginMember.getMemberType() == 1) { // 학생
List<Integer> enrolledCourses = courseService.selectEnrolledCourseNos(loginMember.getMemberNo());
responseData.put("enrolledCourses", enrolledCourses);
} else if (loginMember.getMemberType() == 2) { // 교사
List<Integer> teachingCourses = courseService.selectTeachingCourseNos(loginMember.getMemberNo());
responseData.put("teachingCourses", teachingCourses);
}
}

// JSON 응답 설정
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");
response.getWriter().write(gson.toJson(responseData));

} catch (Exception e) {
e.printStackTrace();
response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
}
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request, response);
}

}

```


# 디렉토리: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/common

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/common/TohomePageServlet2.java
```java
package com.ttt.controller.common;

import java.io.IOException;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/homepage"})
public class TohomePageServlet2 extends HttpServlet {
private static final long serialVersionUID = 1L;
   
public TohomePageServlet2() {
super();
}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

request.getRequestDispatcher("/WEB-INF/views/template/template_version2.jsp").forward(request, response);
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/common/ToIndexPageServlet.java
```java
package com.ttt.controller.common;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ttt.dto.CourseRegister3;
import com.ttt.dto.Member3;
import com.ttt.service.CourseRegisterService;

@WebServlet(urlPatterns = {"","/home"}, name="indexPage")
public class ToIndexPageServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
   
public ToIndexPageServlet() {
super();
}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

// 세션 체크 
HttpSession session = request.getSession(false);
//Member3 m=new Member3();
//if (session != null) {
//m = (Member3) session.getAttribute("loginMember");
//System.out.println("추가전:"+m);
//}

// (더미데이터) 섹션1: 광고 슬라이드
List<Map<String, String>> mainSlides = new ArrayList<>();

// 첫 번째 슬라이드
Map<String, String> slide1 = new HashMap<>();
slide1.put("imageUrl", request.getContextPath() + "/resources/images/common/HoneyT_logo_horizontal.png");
slide1.put("title", "2026 수능 대비 얼리버드 할인!");
slide1.put("description", "5월까지 전 강좌 30% 할인된 가격으로 수강하세요.");
slide1.put("link", request.getContextPath() + "/event/early-bird");
mainSlides.add(slide1);

// 두 번째 슬라이드
Map<String, String> slide2 = new HashMap<>();
slide2.put("imageUrl", request.getContextPath() + "/resources/images/common/HoneyT_logo_horizontal.png");
slide2.put("title", "인기 강사 신규 강의 오픈!");
slide2.put("description", "수학의 신! 김수학 선생님의 새로운 강의를 만나보세요.");
slide2.put("link", request.getContextPath() + "/course/new-math");
mainSlides.add(slide2);

// request에 데이터 저장
request.setAttribute("mainSlides", mainSlides);

// (더미데이터) 학생용 수강중인 강좌
List<Map<String, Object>> studentCourses = new ArrayList<>();
// (학생 로그인 데이터)
//List<CourseRegister3> cr = new CourseRegisterService().selectIngCourse();

Map<String, Object> course1 = new HashMap<>();
course1.put("courseRegisterNo", 1); // 변경: enrollmentNo → courseRegisterNo
course1.put("courseTitle", "수학의 정석: 미적분 마스터");
course1.put("teacherName", "김수학");
course1.put("progressRate", 45);
course1.put("nextLectureNo", 8);
course1.put("nextLectureTitle", "미분 계수의 활용");
course1.put("totalLectures", 20);
course1.put("lastViewTime", new Date()); // 추가: 마지막 수강 시간
course1.put("stopAt", 720); // 추가: 마지막 재생 위치(초)
studentCourses.add(course1);

Map<String, Object> course2 = new HashMap<>();
course1.put("courseRegisterNo", 2); // 변경: enrollmentNo → courseRegisterNo
course2.put("courseTitle", "국어 독해의 비밀");
course2.put("teacherName", "박국어");
course2.put("progressRate", 75);
course2.put("nextLectureNo", 15);
course2.put("nextLectureTitle", "비문학 독해 전략");
course2.put("totalLectures", 20);
course1.put("lastViewTime", new Date()); // 추가: 마지막 수강 시간
course1.put("stopAt", 720); // 추가: 마지막 재생 위치(초)
studentCourses.add(course2);

// (더미데이터) 교사용 업로드 중인 강좌
List<Map<String, Object>> teacherCourses = new ArrayList<>();

Map<String, Object> uploadCourse1 = new HashMap<>();
uploadCourse1.put("courseNo", 3);
uploadCourse1.put("courseTitle", "2025 수능 대비 화학I");
uploadCourse1.put("uploadedLectures", 5);
uploadCourse1.put("totalLectures", 30);
uploadCourse1.put("uploadProgress", 16);
uploadCourse1.put("beginDate", "2024-03-15");
uploadCourse1.put("endDate", "2024-05-30");
teacherCourses.add(uploadCourse1);

request.setAttribute("studentCourses", studentCourses);
request.setAttribute("teacherCourses", teacherCourses);

//System.out.println("학생 강좌 데이터 설정: " + studentCourses);
//System.out.println("교사 강좌 데이터 설정: " + teacherCourses);



// (더미데이터) 대표 강사진 생성
List<Map<String, Object>> mainTeachers = new ArrayList<>();
String[] subjects = {"국어", "수학", "영어", "과학", "사회", "국어", "수학", "영어"}; // 8명

for(int i = 0; i < 8; i++) {
Map<String, Object> teacher = new HashMap<>();
teacher.put("memberNo", i + 1);
teacher.put("memberName", "강사" + (i + 1));
teacher.put("teacherSubject", subjects[i]);
teacher.put("teacherInfoTitle", "열정적인 " + subjects[i] + " 선생님");
teacher.put("imageUrl", request.getContextPath() + "/resources/images/common/HoneyT_logo_vertical.png");
mainTeachers.add(teacher);
}

request.setAttribute("mainTeachers", mainTeachers);
//System.out.println("대표 강사진 데이터 설정: " + mainTeachers);


// (더미데이터) 인기 강좌 메인 화면에 출력할 데이터

// 코스 카테고리 정보
Map<Integer, String> courseCategoryInfo = new HashMap<>();
courseCategoryInfo.put(1, "진도 강좌");
courseCategoryInfo.put(2, "내신대비 강좌");
courseCategoryInfo.put(3, "모의고사 대비 강좌");
courseCategoryInfo.put(4, "수능대비 강좌");

// 인기 강좌 더미데이터 생성
List<Map<String, Object>> popularCourses = new ArrayList<>();
/* String[] subjects = {"국어", "수학", "영어", "과학", "사회"}; */
String[] teacherNames = {"김선생", "이선생", "박선생", "정선생", "최선생"};

// 각 카테고리별로 5개씩 강좌 생성
for(int category = 1; category <= 4; category++) {
for(int i = 0; i < 5; i++) {
Map<String, Object> course = new HashMap<>();
int courseNo = (category - 1) * 5 + i + 1;

course.put("courseNo", courseNo);
course.put("courseTitle", subjects[i] + " " + courseCategoryInfo.get(category));
course.put("courseCategoryNo", category);
course.put("grade", (i % 3) + 1); // 1,2,3 학년
course.put("coursePrice", 150000 + (i * 10000));
course.put("coursePriceSale", 10 + (i * 5)); // 10~30% 할인
course.put("totalLectures", 20 + (i * 2));
course.put("teacherName", teacherNames[i]);
course.put("courseDesc", subjects[i] + "의 기초부터 실전까지! " + courseCategoryInfo.get(category));
course.put("teacherInfo", teacherNames[i] + " 선생님과 함께하는 " + subjects[i] + " 마스터");
course.put("rating", 4.5 + (Math.random() * 0.5)); // 4.5~5.0 평점
course.put("studentCount", 100 + (int)(Math.random() * 900)); // 100~1000명

popularCourses.add(course);
}
}

request.setAttribute("courseCategoryInfo", courseCategoryInfo);
request.setAttribute("popularCourses", popularCourses);

//System.out.println("인기 강좌 데이터 설정: " + popularCourses);


request.getRequestDispatcher("/index.jsp").forward(request, response);
}

}

```


# 디렉토리: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/course

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/course/ToCourseServlet.java
```java
package com.ttt.controller.course;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Course3;
import com.ttt.service.CourseService;

@WebServlet("/course/list")
public class ToCourseServlet extends HttpServlet {
private static final long serialVersionUID = 1L;

public ToCourseServlet() {
super();
}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
// 파라미터 처리
String subjectName = request.getParameter("subjectName");
if(subjectName == null) subjectName = "국어";

int gradeNum = 1;
try {
gradeNum = Integer.parseInt(request.getParameter("gradeNum"));
} catch (NumberFormatException e) {
}

// 페이징 처리를 위한 현재 페이지 정보
int cpage = 1;
try {
cpage = Integer.parseInt(request.getParameter("cpage"));
} catch (NumberFormatException e) {
}

int numPerPage = 2; // 한 페이지당 데이터 수

// 현재 페이지에 해당하는 데이터만 추출
int start = (cpage - 1) * numPerPage;
int end = start + numPerPage;

Map<String, Object> param = Map.of(
"start", start,
"end", end,
"subjectName", subjectName,
"gradeNum", gradeNum);

List<Course3> courses = new CourseService().selectCourseBySubjectNo(param);

// 전체 데이터 수
int totalData = courses.size();

// 전체 페이지 수 계산
int totalPage = (int) Math.ceil((double) totalData / numPerPage);

// 페이지 바 사이즈
int pageBarSize = 5;

// 페이지 바 시작 번호
int pageStart = (((cpage - 1) / pageBarSize) * pageBarSize) + 1;

// 페이지 바 종료 번호
int pageEnd = pageStart + pageBarSize - 1;
if (pageEnd > totalPage) {
pageEnd = totalPage;
}

// request에 데이터 저장
request.setAttribute("courses", courses);
request.setAttribute("pageStart", pageStart);
request.setAttribute("pageEnd", pageEnd);
request.setAttribute("totalPage", totalPage);
request.setAttribute("cpage", cpage);

// 사이드바 색상 전환을 위한 데이터
// 파라미터 처리 부분 아래에 추가
request.setAttribute("selectedSubject", subjectName != null ? subjectName : "국어");

request.getRequestDispatcher("/WEB-INF/views/course/courseListBySubject.jsp").forward(request, response);
}

}

```


# 디렉토리: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/enroll

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/enroll/AjaxDistrictByRegionServlet.java
```java
package com.ttt.controller.enroll;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.google.gson.Gson;
import com.ttt.common.SqlSessionTemplate;

/**
 * Servlet implementation class DistrictServlet
 */
@WebServlet("/Ajax/school/district")
public class AjaxDistrictByRegionServlet extends HttpServlet {
private static final long serialVersionUID = 1L;

public AjaxDistrictByRegionServlet() {
super();
}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
String region = request.getParameter("region");
List<String> districts = new ArrayList<>();

try {
SqlSession session = SqlSessionTemplate.getSession();
System.out.println("AjaxDistrictByRegionServlet - region.val :"+region);
districts = session.selectList("school.selectDistrictByRegion",region);

} catch (Exception e) {
e.printStackTrace();
}

response.setContentType("application/json;charset=UTF-8");
new Gson().toJson(districts, response.getWriter());
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request, response);
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/enroll/AjaxSearchSchoolServlet.java
```java
package com.ttt.controller.enroll;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.ttt.dto.School12;
import com.ttt.service.SchoolService;

@WebServlet("/Ajax/School/Search")
public class AjaxSearchSchoolServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
   
public AjaxSearchSchoolServlet() {
super();
}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
String district = request.getParameter("district");
String strSchoolType = request.getParameter("schoolType");
int schoolType=0;
switch(strSchoolType) {
case "초등학교": schoolType=1; break;
case "중학교": schoolType=2; break;
case "고등학교": schoolType=3; break;
case "기타학교": schoolType=4; break;
}

Map<String, Object> params = new HashMap<>();
params.put("district", district);
params.put("schoolType", schoolType);

List<School12> schools = new SchoolService().selectNameAndCode(params);

response.setContentType("application/json;charset=UTF-8");
new Gson().toJson(schools, response.getWriter());
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request, response);
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/enroll/EnrollFormServlet.java
```java
package com.ttt.controller.enroll;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/enroll/form")
//학생, 교사 타입 받아서 회원가입 form 에 전달
public class EnrollFormServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
   
public EnrollFormServlet() {
super();
}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
request.setAttribute("errorMessage", "잘못된 접근입니다. 회원가입 페이지로 이동합니다.");
request.getRequestDispatcher("/WEB-INF/views/enroll/termsofservice.jsp").forward(request, response);
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
// 학생, 교사 타입 받아서 회원가입 form 에 전달
String memberType = request.getParameter("memberType");
if(memberType!=null) {
request.setAttribute("memberType", memberType);
request.getRequestDispatcher("/WEB-INF/views/enroll/enrollForm.jsp").forward(request, response);
} else {
request.setAttribute("errorMessage", "잘못된 접근입니다. 회원가입 페이지로 이동합니다.");
request.getRequestDispatcher("/WEB-INF/views/enroll/termsofservice.jsp").forward(request, response);
}
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/enroll/EnrollFormSubmitServlet.java
```java
package com.ttt.controller.enroll;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Member3;
import com.ttt.dto.School12;
import com.ttt.service.MemberService;

@WebServlet(name="memberEnroll", urlPatterns="/enroll/form/submit")
public class EnrollFormSubmitServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
   
public EnrollFormSubmitServlet() {
super();
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

String memberId = request.getParameter("memberId");
String memberPw = request.getParameter("memberPw");
String memberName = request.getParameter("memberName");

String emailId = request.getParameter("emailId");
String emailDomain = request.getParameter("emailDomain");
String email = emailId + "@" + emailDomain;

String phone = request.getParameter("phone");

String addressNo = request.getParameter("addressNo");
String addressRoad = request.getParameter("addressRoad");
String addressDetail = request.getParameter("addressDetail");
String address = addressNo+":"+addressRoad+":"+addressDetail; // 나중에 주소값을 split 해서 처리하기 위한 주소값 처리

int memberType=0;
int schoolNo=0;
int grade=0;
School12 school=new School12();

// 값을 각각 받아오도록 각각 예외처리
try {memberType=Integer.parseInt(request.getParameter("memberType"));} 
catch(Exception e) {System.out.println("파싱오류");}
if(memberType==1) {
try {schoolNo=Integer.parseInt(request.getParameter("schoolNo"));}
catch(Exception e) {System.out.println("파싱오류1");}
try {grade=Integer.parseInt(request.getParameter("grade"));}
catch(Exception e) {System.out.println("파싱오류2");}
school.setSchoolNo(schoolNo);
}

// 교사인 경우 
String teacherSubject = request.getParameter("teacherSubject");

Member3 m = Member3.builder()
.memberId(memberId)
.memberPw(memberPw)
.memberName(memberName)
.email(email)
.phone(phone)
.address(address)
.memberType(memberType)
.school(school)
.grade(grade)
.teacherSubject(teacherSubject)
.build();

//db에 저장하기!
String msg, loc="/";

try {
System.out.println("디비저장시작 m : "+m.toString());
int result = new MemberService().insertMember(m);
msg="회원가입에 성공했습니다!";
}catch(Exception e) {
e.printStackTrace();
msg="회원가입에 실패하셨습니다. 다시 시도해주세요.";
loc="/enroll/termsofservice";
}

request.setAttribute("msg",msg);
request.setAttribute("loc",loc);

request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);

}
}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/enroll/EnrollIdDuplicateCheckServlet.java
```java
package com.ttt.controller.enroll;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Member3;
import com.ttt.service.MemberService;


@WebServlet("/enroll/checkid")
public class EnrollIdDuplicateCheckServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
   
public EnrollIdDuplicateCheckServlet() {
super();
}


protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
String memberId = request.getParameter("memberId");

Member3 result = new MemberService().selectMemberById(memberId);

response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");
response.getWriter().write(String.valueOf(result != null));


}


protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request, response);
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/enroll/EnrollMemberTypeServlet.java
```java
package com.ttt.controller.enroll;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/enroll/type")
//약돤 동의 여부를 체크하고 학생,교사 유형 선택 페이지로 이동
public class EnrollMemberTypeServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
   
public EnrollMemberTypeServlet() {
super();
}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
// 동의 체크 여부를 판단하는 로직
String[] values = {
// 필수항목만 확인
request.getParameter("checked1"),
request.getParameter("checked2"),
request.getParameter("checked3")
};
System.out.println("EnrollMemberTypeServlet - checked List : "+values[0]+","+values[1]+","+values[2]);

// 하나라도 null이면 동의하지 않은 것으로 처리 -> js 에서 처리하면 보안상 위험이 있을까?
int i=0;
try {
if (values[0].equals("on")) ++i;
System.out.println(values[0].equals("on")+", "+i);
if (values[1].equals("on")) ++i;
System.out.println(values[0].equals("on")+", "+i);
if (i==2) {
if(values[2] == null); // (보류) 광고성 정보 수신 동의에 대해서 정보 저장이 필요함.
request.getRequestDispatcher("/WEB-INF/views/enroll/enrollMemberType.jsp").forward(request, response);
} else {
request.setAttribute("errorMessage", "모든 필수 항목에 동의 항목에 동의해야 합니다.");
request.getRequestDispatcher("/WEB-INF/views/enroll/termsofservice.jsp").forward(request, response);
}
} catch(Exception e) {
request.setAttribute("errorMessage", "모든 필수 항목에 동의 항목에 동의해야 합니다.");
request.getRequestDispatcher("/WEB-INF/views/enroll/termsofservice.jsp").forward(request, response);
}
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request, response);
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/enroll/EnrollTermsOfServiceSevlet.java
```java
package com.ttt.controller.enroll;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/enroll/termsofservice")
public class EnrollTermsOfServiceSevlet extends HttpServlet {
private static final long serialVersionUID = 1L;
   
public EnrollTermsOfServiceSevlet() {
super();
}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
request.getRequestDispatcher("/WEB-INF/views/enroll/termsofservice.jsp").forward(request, response);
}
}

```


# 디렉토리: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/lecture


# 디렉토리: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/member

# 디렉토리: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/member/student

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/member/student/StudentMyInfoSaveServlet.java
```java
package com.ttt.controller.member.student;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Member3;
import com.ttt.dto.School12;
import com.ttt.service.MemberService;

@WebServlet("/member/student/myinfo/save")
public class StudentMyInfoSaveServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
   
public StudentMyInfoSaveServlet() {
super();
}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
HttpSession session = request.getSession(false);
Member3 loginMember = (Member3)session.getAttribute("loginMember");
if(loginMember != null) {
//Member 객체 업데이트 
Member3 m = new Member3();

// 입력받은 정보들 중 null이 있을 수 있으니까, 모든 정보를 기본 정보로 설정
m.setMemberNo(loginMember.getMemberNo());
m.setMemberId(loginMember.getMemberId());
m.setMemberName(loginMember.getMemberName());
m.setEmail(loginMember.getEmail());
m.setMemberType(loginMember.getMemberType());
m.setEnrollDate(loginMember.getEnrollDate());
m.setMemberPw(loginMember.getMemberPw());
m.setPhone(loginMember.getPhone());
m.setAddress(loginMember.getAddress());
m.setSchoolNo(loginMember.getSchoolNo());

// 수정된 정보만 업데이트
String memberPw = request.getParameter("memberPw");
if(memberPw != null && !memberPw.isEmpty()) {
m.setMemberPw(memberPw);
//password 암호화를 위한 설정
request.setAttribute("encryptPassword", true);

}
String phone = request.getParameter("phone");
if(phone != null && !phone.isEmpty()) {
m.setPhone(phone);
}

String addressNo = request.getParameter("addressNo");
String addressRoad = request.getParameter("addressRoad");
String addressDetail = request.getParameter("addressDetail");
if(addressNo != null && addressRoad != null && !addressNo.isEmpty() && !addressRoad.isEmpty()) {
String address = addressNo+":"+addressRoad+":"+addressDetail;
m.setAddress(address);
}

String schoolNo = request.getParameter("schoolNo");
try {
if(schoolNo != null && !schoolNo.trim().isEmpty()) {
int newSchoolNo = Integer.parseInt(schoolNo);
if(m.getSchool() != null) {
if(m.getSchool().getSchoolNo() != newSchoolNo) {
m.getSchool().setSchoolNo(newSchoolNo);
}
} else {
School12 school = new School12();
school.setSchoolNo(newSchoolNo);
m.setSchool(school);
System.out.println("학교번호가져옴");
}
}
} catch(Exception e) {
System.out.println("학교 번호파싱 오류");
}

// 서비스 호출하여 DB 업데이트
int result = new MemberService().updateMember(m);

String msg, loc = "/";

if(result > 0) {
session.setAttribute("loginMember", m);
msg = "회원 정보 수정에 성공하였습니다.";
loc = "/member/student/myinfo";
} else {
msg = "회원 정보 수정에 실패하였습니다.";
loc = "/member/student/myinfo";
}
request.setAttribute("msg", msg);
request.setAttribute("loc", loc);
request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
}
}
}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/member/student/StudentMyInfoServlet.java
```java
package com.ttt.controller.member.student;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Member3;

@WebServlet("/member/student/myinfo")
public class StudentMyInfoServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
   
public StudentMyInfoServlet() {
super();
}


protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
HttpSession session = request.getSession(false); //로그인 세션 가져오기(없으면 생성 하지않음)
Member3 m = new Member3();
if(session != null) {
m = (Member3)session.getAttribute("loginMember");

String address = m.getAddress();

if(address != null) {
String[] addressParts = address.split(":");

if(addressParts.length > 0) {
String addressNo = addressParts[0];
String addressRoad = addressParts[1];
String addressDetail = "";

if(addressParts.length > 2) {
addressDetail = addressParts[2];
}

request.setAttribute("addressNo", addressNo);
request.setAttribute("addressRoad", addressRoad);
request.setAttribute("addressDetail", addressDetail);
}
}
request.getRequestDispatcher("/WEB-INF/views/member/studentMyInfo.jsp").forward(request, response);
}
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request, response);
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/member/student/StudentMypageServlet.java
```java
package com.ttt.controller.member.student;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/member/student/mypage/*")
public class StudentMypageServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
   
public StudentMypageServlet() {
super();
}

// "/student/mypage/*" 으로 들어오는 모든 요청을 분기처리하여 각 페이지로 응답하기
// 각 페이지에서의 내용은 ajax 요청으로 처리하기 위한 서블릿 만들기
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
String uri = request.getRequestURI();
String path = uri.substring(request.getContextPath().length());

switch(path) {
case "/member/student/mypage/menu":
request.getRequestDispatcher("/WEB-INF/views/member/studentMypage.jsp").forward(request, response);
break;
}
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request, response);
}

}

```


# 디렉토리: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/member/teacher

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/member/teacher/TeacherManageCourseRegisterServlet.java
```java
package com.ttt.controller.member.teacher;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.ttt.dto.Course3;
import com.ttt.dto.Member3;
import com.ttt.service.CourseService;

@WebServlet("/member/teacher/course/register")
public class TeacherManageCourseRegisterServlet extends HttpServlet {
private static final long serialVersionUID = 1L;

public TeacherManageCourseRegisterServlet() {
super();
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

// 인코딩 설정
request.setCharacterEncoding("UTF-8");
response.setContentType("application/json;charset=UTF-8");
Map<String, Object> responseData = new HashMap<>();

try {
// 파라미터 로깅
System.out.println("Received parameters:");
request.getParameterMap().forEach((key, value) -> {
System.out.println(key + ": " + Arrays.toString(value));
});

// 1. 필수값 검증
String courseTitle = request.getParameter("courseTitle");
String courseDesc = request.getParameter("courseDesc");
String categoryNoStr = request.getParameter("courseCategoryNo");
String gradeStr = request.getParameter("grade");
String priceStr = request.getParameter("coursePrice");
String beginDateStr = request.getParameter("beginDate");

if (courseTitle == null || courseDesc == null || categoryNoStr == null || 
gradeStr == null || priceStr == null || beginDateStr == null) {
throw new IllegalArgumentException("필수 입력값이 누락되었습니다.");
}

// 2. 숫자 변환 (할인율은 선택값)
int courseCategoryNo = Integer.parseInt(categoryNoStr);
int grade = Integer.parseInt(gradeStr);
int coursePrice = Integer.parseInt(priceStr);
int coursePriceSale = 0;

String salePriceStr = request.getParameter("coursePriceSale");
if (salePriceStr != null && !salePriceStr.trim().isEmpty()) {
coursePriceSale = Integer.parseInt(salePriceStr);
}

// 3. 날짜 처리
LocalDate beginDate = LocalDate.parse(beginDateStr);
Date sqlDate = Date.valueOf(beginDate);

// 4. 세션에서 교사 정보 가져오기
HttpSession session = request.getSession();
Member3 loginMember = (Member3)session.getAttribute("loginMember");

if (loginMember == null) {
throw new IllegalStateException("로그인이 필요합니다.");
}

// 5. Course3 객체 생성
Course3 course = Course3.builder()
.courseTitle(courseTitle)
.courseDesc(courseDesc)
.courseCategoryNo(courseCategoryNo)
.grade(grade)
.coursePrice(coursePrice)
.coursePriceSale(coursePriceSale)
.beginDate(sqlDate)
.courseStatus(0)
.memberNo(loginMember.getMemberNo())
.build();

// 디버깅 로그
System.out.println("Creating course: " + course);

// 6. 서비스 호출
int result = new CourseService().insertNewCourse(course);

// 7. 응답 데이터 설정
responseData.put("success", result > 0);
responseData.put("message", result > 0 ? "강좌가 성공적으로 등록되었습니다." : "강좌 등록에 실패했습니다.");

} catch (Exception e) {
e.printStackTrace();
responseData.put("success", false);
responseData.put("message", e.getMessage());
response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
}

// JSON 응답 전송
response.getWriter().write(new Gson().toJson(responseData));
}
}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/member/teacher/TeacherManageCourseServlet.java
```java
package com.ttt.controller.member.teacher;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Member3;
import com.ttt.service.CourseService;

@WebServlet("/member/teacher/mypage/course")
public class TeacherManageCourseServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
   
public TeacherManageCourseServlet() {
super();
}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
// 페이징 및 필터 파라미터 처리
int cpage = 1;
int numPerPage = 10; // 기본값
String status = request.getParameter("status"); // status 유형에 따른 totalData 계산
if(status == null) status = "all"; // 기본값
System.out.println(status);

try { cpage = Integer.parseInt(request.getParameter("cpage"));
} catch (NumberFormatException e) {}
try { numPerPage = Integer.parseInt(request.getParameter("numPerPage"));
} catch (NumberFormatException e) {}

// 세션에서 교사 정보 가져오기
HttpSession session = request.getSession();
Member3 loginMember = (Member3)session.getAttribute("loginMember");

// 카테고리 목록 조회
List<String> categories = new CourseService().selectAllCategories();
request.setAttribute("categories", categories);

// 강좌 목록과 상태별 카운트 조회
Map<String, Object> result = new CourseService().selectCoursesByTeacher(loginMember.getMemberNo(), status);
// 페이징 처리
BigDecimal totalCountDecimal = (BigDecimal)result.get("totalCount"); // 전체 데이터 수
int totalData = totalCountDecimal.intValue(); // 전체 데이터 수
int totalPage = (int)Math.ceil((double)totalData/numPerPage);
int pageBarSize = 5;
int pageStart = (cpage - 1) / pageBarSize * pageBarSize + 1;
int pageEnd = pageStart + pageBarSize - 1;
if(pageEnd > totalPage) {
pageEnd = totalPage;
}

// 페이징 관련 데이터도 request에 저장
request.setAttribute("pageStart", pageStart);
request.setAttribute("pageEnd", pageEnd);
request.setAttribute("totalPage", totalPage);
// request에 데이터 저장
request.setAttribute("courses", result.get("courses"));
request.setAttribute("totalCount", result.get("totalCount"));
request.setAttribute("preparingCount", result.get("preparingCount"));
request.setAttribute("inProgressCount", result.get("inProgressCount"));
request.setAttribute("completedCount", result.get("completedCount"));
request.setAttribute("cpage", cpage);
request.setAttribute("numPerPage", numPerPage);
request.setAttribute("currentStatus", status);

request.getRequestDispatcher("/WEB-INF/views/member/teacherManageCourse.jsp").forward(request, response);

}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request, response);
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/member/teacher/TeacherManageLectureListServlet.java
```java
package com.ttt.controller.member.teacher;

import java.io.BufferedReader;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.ttt.dto.Course3;
import com.ttt.dto.Lecture3;
import com.ttt.dto.Member3;
import com.ttt.dto.ScheduleEvent3;
import com.ttt.service.CourseService;
import com.ttt.service.LectureService;

@WebServlet("/member/teacher/mypage/lecturelist")
public class TeacherManageLectureListServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
private LectureService lectureService = new LectureService();
private CourseService courseService = new CourseService();
   
public TeacherManageLectureListServlet() {
super();
}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

try {
// 1. 강좌 번호 파라미터 받기
int courseNo = Integer.parseInt(request.getParameter("courseNo"));

// 2. 세션에서 로그인한 교사 정보 가져오기
HttpSession session = request.getSession();
Member3 loginMember = (Member3)session.getAttribute("loginMember");

// 3. 강좌 정보 조회
Course3 course = courseService.selectCourseByNo(courseNo);

// 4. 권한 체크 (본인 강좌인지 확인)
if(course != null && course.getMemberNo() == loginMember.getMemberNo()) {
// 5. 강의 목록 조회
List<Lecture3> lectures = lectureService.selectLecturesByCourseNo(courseNo);

// 6. request에 데이터 저장
request.setAttribute("course", course);
request.setAttribute("lectures", lectures);

// 7. JSP로 포워딩
request.getRequestDispatcher("/WEB-INF/views/member/teacherManageLectureList.jsp")
   .forward(request, response);
} else {
// 권한이 없는 경우
response.sendError(HttpServletResponse.SC_FORBIDDEN);
}

} catch(NumberFormatException e) {
// courseNo 파라미터가 없거나 잘못된 경우
response.sendError(HttpServletResponse.SC_BAD_REQUEST);
}

//request.getRequestDispatcher("/WEB-INF/views/member/teacherManageLectureList.jsp").forward(request, response);
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

Map<String, Object> responseData = new HashMap<>();
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");  // UTF-8 인코딩 명시적 설정

try {
HttpSession session = request.getSession();
Member3 teacher = (Member3)session.getAttribute("loginMember");
System.out.println("선생님 정보 : "+teacher);

// 1. 요청 데이터 읽기
BufferedReader reader = request.getReader();
StringBuilder buffer  = new StringBuilder();
String line;
while ((line = reader.readLine()) != null) {
buffer .append(line);
}
System.out.println("받은 JSON 데이터: " + buffer .toString());

// 2. JSON 파싱
JsonObject jsonObject = new Gson().fromJson(buffer.toString(), JsonObject.class);
int courseNo = jsonObject.get("courseNo").getAsInt();
JsonArray lecturesArray = jsonObject.get("lectures").getAsJsonArray();

System.out.println("jsonObject: " + jsonObject);
System.out.println("lecturesArray: " + lecturesArray);

// 3. 데이터 변환 및 저장을 위한 리스트 준비
List<Lecture3> lectures = new ArrayList<>();
List<ScheduleEvent3> events = new ArrayList<>();
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

// 4. 각 강의 데이터 처리
for (JsonElement element : lecturesArray) {
JsonObject lecture = element.getAsJsonObject();

// 4-1. Lecture 객체 생성
Lecture3 lectureObj = Lecture3.builder()
.courseNo(courseNo)
.lectureTitle(lecture.get("lectureTitle").getAsString())
.lectureOrder(lecture.get("lectureOrder").getAsInt())
.lectureStatus('1')
.build();

// 4-2. ScheduleEvent 객체 생성
ScheduleEvent3 eventObj = ScheduleEvent3.builder()
.eventTitle(lecture.get("lectureTitle").getAsString())
.eventStart(LocalDateTime.parse(lecture.get("eventStart").getAsString(), formatter))
.eventEnd(LocalDateTime.parse(lecture.get("eventEnd").getAsString(), formatter))
.videoUrl(lecture.get("videoUrl").isJsonNull() 
? null : lecture.get("videoUrl").getAsString())
.lecture(lectureObj)
.member(teacher)
.build();

lectures.add(lectureObj);
events.add(eventObj);
}
System.out.println("lectures: "+lectures);
System.out.println("events: "+events);
// 4. 서비스 호출하여 저장
int result = lectureService.insertLecturesWithSchedules(lectures, events);

// 5. 결과 응답
// 성공/실패 여부와 메시지 포함
responseData.put("success", result == lectures.size());
responseData.put("message", result == lectures.size() ? 
"강의 일정이 성공적으로 등록되었습니다." : 
"일부 강의 일정 등록에 실패했습니다.");
responseData.put("count", result);  // 실제 등록된 개수

} catch(Exception e) {
e.printStackTrace();
// 에러 발생 시 클라이언트에 의미있는 메시지 전달
responseData.put("success", false);
responseData.put("message", "강의 일정 등록 중 오류가 발생했습니다.");
responseData.put("error", e.getMessage());
response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
}

response.getWriter().write(new Gson().toJson(responseData));
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/member/teacher/TeacherMyInfoSaveServlet.java
```java
package com.ttt.controller.member.teacher;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.ttt.common.TextNormalizer;
import com.ttt.dto.Image3;
import com.ttt.dto.Member3;
import com.ttt.service.MemberService;

@WebServlet(name="teacherInfoUpdate", urlPatterns="/member/teacher/profile/save")
public class TeacherMyInfoSaveServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
// TextNormalizer 인스턴스 생성
private final TextNormalizer textNormalizer = new TextNormalizer();
   
public TeacherMyInfoSaveServlet() {
super();
}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
// 파일 업로드 설정
String path = getServletContext().getRealPath("/resources/images/profile/");
int maxSize = 1024*1024*10;
String encoding = "UTF-8";

// 파일 저장 디렉토리 생성
File dir = new File(path);
if(!dir.exists()) dir.mkdirs();

try {
MultipartRequest mr = new MultipartRequest(
request, path, maxSize, encoding, new DefaultFileRenamePolicy()
);

// 세션에서 로그인 정보 가져오기
HttpSession session = request.getSession();
Member3 loginMember = (Member3)session.getAttribute("loginMember");

if(loginMember != null) {
// Member 객체 업데이트
Member3 m = new Member3();

// 입력받은 정보들 중 null이 있을 수 있으니까, 모든 정보를 기본 정보로 설정
m.setMemberNo(loginMember.getMemberNo());
m.setMemberId(loginMember.getMemberId());
m.setMemberName(loginMember.getMemberName());
m.setEmail(loginMember.getEmail());
m.setMemberType(loginMember.getMemberType());
m.setEnrollDate(loginMember.getEnrollDate());
m.setTeacherSubject(loginMember.getTeacherSubject());
m.setMemberPw(loginMember.getMemberPw());
m.setPhone(loginMember.getPhone());
m.setAddress(loginMember.getAddress());
m.setTeacherInfoTitle(loginMember.getTeacherInfoTitle());
m.setTeacherInfoContent(loginMember.getTeacherInfoContent());
m.setImage(loginMember.getImage());

// 수정된 정보만 업데이트
String memberName = mr.getParameter("memberName");
if(memberName != null && !memberName.isEmpty()) {
m.setMemberName(memberName);
}

String memberPw = mr.getParameter("memberPw");
if(memberPw != null && !memberPw.isEmpty()) {
m.setMemberPw(memberPw);
//password 암호화를 위한 설정
request.setAttribute("encryptPassword", true);
}

String phone = mr.getParameter("phone");
if(phone != null && !phone.isEmpty()) {
m.setPhone(phone);
}

String addressNo = mr.getParameter("addressNo");
String addressRoad = mr.getParameter("addressRoad");
String addressDetail = mr.getParameter("addressDetail");
if(addressNo != null && addressRoad != null && !addressNo.isEmpty() && !addressRoad.isEmpty()) {
String address = addressNo+":"+addressRoad+":"+addressDetail;
m.setAddress(address);
}

String teacherInfoTitle = mr.getParameter("teacherInfoTitle");
if(teacherInfoTitle != null && !teacherInfoTitle.isEmpty()) {
m.setTeacherInfoTitle(teacherInfoTitle);
}

String teacherInfoContent = mr.getParameter("teacherInfoContent");
if(teacherInfoContent != null && !teacherInfoContent.isEmpty()) {
m.setTeacherInfoContent(teacherInfoContent);
}



// 이미지 정보 설정
String originalFileName = mr.getOriginalFileName("profileImageInput");
if(originalFileName != null) {
// 파일명도 정규화 처리
String normalizedOriginalFileName = textNormalizer.normalizeText(originalFileName);
String renamedFileName = mr.getFilesystemName("profileImageInput");
String normalizedRenamedFileName = textNormalizer.normalizeText(renamedFileName);

Image3 image = new Image3();
image.setOriname(normalizedOriginalFileName);
image.setRenamed(normalizedRenamedFileName);
m.setImage(image);
} 

// 서비스 호출하여 DB 업데이트
int result = new MemberService().updateMember(m);

if(result > 0) {
session.setAttribute("loginMember", m);
request.setAttribute("msg", "회원 정보 수정에 성공하였습니다.");
} else {
request.setAttribute("msg", "회원 정보 수정에 실패하였습니다.");
}

request.setAttribute("loc", "/member/teacher/profile");
request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
}
} catch (Exception e) {
e.printStackTrace();
request.setAttribute("msg", "회원 정보 수정 중 오류가 발생하였습니다.");
request.setAttribute("loc", "/member/teacher/profile");
request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
}
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/member/teacher/TeacherMyInfoServlet.java
```java
package com.ttt.controller.member.teacher;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Member3;

@WebServlet("/member/teacher/profile")
public class TeacherMyInfoServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
   
public TeacherMyInfoServlet() {
super();
}


protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
HttpSession session = request.getSession(false); //로그인 세션 가져오기(없으면 생성 하지않음)
Member3 m = new Member3();
if(session != null) {
m = (Member3)session.getAttribute("loginMember");

String address = m.getAddress();

if(address != null) {
String[] addressParts = address.split(":");
String addressNo = addressParts[0];
String addressRoad = addressParts[1];
String addressDetail = "";

// 상세 주소가 입력되었을 경우에만 상세 주소 가져오기
if(addressParts.length > 2) {
addressDetail = addressParts[2];
}

request.setAttribute("addressNo", addressNo);
request.setAttribute("addressRoad", addressRoad);
request.setAttribute("addressDetail", addressDetail);

}

request.getRequestDispatcher("/WEB-INF/views/member/teacherMyInfo.jsp").forward(request, response);
}



}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request, response);
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/member/teacher/TeacherMypageServlet.java
```java
package com.ttt.controller.member.teacher;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/member/teacher/mypage/*")
public class TeacherMypageServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
   
public TeacherMypageServlet() {
super();
}

// "/student/mypage/*" 으로 들어오는 모든 요청을 분기처리하여 각 페이지로 응답하기
// 각 페이지에서의 내용은 ajax 요청으로 처리하기 위한 서블릿 만들기
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
String uri = request.getRequestURI();
String path = uri.substring(request.getContextPath().length());

switch(path) {
case "/member/teacher/mypage/menu":
request.getRequestDispatcher("/WEB-INF/views/member/teacherMypage.jsp").forward(request, response);
break;
}
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request, response);
}

}

```


## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/member/MemberLogoutServlet.java
```java
package com.ttt.controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/member/logout")
public class MemberLogoutServlet extends HttpServlet {
private static final long serialVersionUID = 1L;

public MemberLogoutServlet() {
super();
}

// 로그아웃 기능을 통해 쿠키 정보 삭제 로직 구현
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
HttpSession session = request.getSession(false);

// 로그인 유지용 쿠키 삭제
Cookie[] cookies = request.getCookies();
if (cookies != null) {
for (Cookie c : cookies) {
// saveId 라는 이름의 쿠키 찾기
if (c.getName().equals("saveId")) {
// 쿠키 값을 비우고 만료시간을 0으로 설정
c.setValue("");
c.setMaxAge(0);
c.setPath("/"); // 쿠키의 저장 경로도 동일하게 지정
response.addCookie(c);
break;
}
}
}

// 세션 무효화는 쿠키 삭제 후에 실행
if(session != null) {
session.invalidate();
}

//요청 처리후 주소창의 주소가 /member/logout 인 문제를 해결하기 위해 msg.jsp 로 응답
String msg="로그아웃 되었습니다.";
String loc="/";
request.setAttribute("msg", msg);
request.setAttribute("loc", loc);

request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);




}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request, response);
}

}

```


# 디렉토리: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/payment

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/payment/CartServlet.java
```java
package com.ttt.controller.payment;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Cart3;
import com.ttt.dto.Member3;
import com.ttt.service.PaymentService;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
   
public CartServlet() {
super();
}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//세션에서 로그인한 회원 정보 가져오기 
HttpSession session = request.getSession();
Member3 loginMember = (Member3)session.getAttribute("loginMember");

if (loginMember != null) {
//서비스 호출하여 데이터 조회
List<Cart3> carts = new PaymentService().selectCartListByMemberNo(loginMember.getMemberNo());

request.setAttribute("carts", carts);
}


// 사이드바 색상 전환을 위한 데이터
// 파라미터 처리 부분 아래에 추가
String subjectName = request.getParameter("subjectName");
if(subjectName == null) subjectName = "국어";
request.setAttribute("selectedSubject", subjectName != null ? subjectName : "국어");

request.getRequestDispatcher("/WEB-INF/views/payment/cart.jsp").forward(request, response);
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
// TODO Auto-generated method stub
doGet(request, response);
}

}

```


# 디렉토리: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/teacher

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/teacher/ApiTeacherProfileServlet.java
```java
package com.ttt.controller.teacher;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

// 선생님 탭에서 과목별 각 선생님을 선택하면 나타나는 선생님 프로필 출력
@WebServlet("/api/teachers")
public class ApiTeacherProfileServlet extends HttpServlet {

private static final long serialVersionUID = 1L;
private Gson gson = new Gson();
   
public ApiTeacherProfileServlet() {
super();
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

// memberNo 파라미터 받기
String memberNo = request.getParameter("memberNo");
System.out.println("Requested memberNo: " + memberNo);

// 실제 DB 연동 코드 (추후 구현)
/*
String teacherId = request.getParameter("teacherId");
TeacherDAO teacherDAO = new TeacherDAO();
Teacher teacher = teacherDAO.getTeacherById(Integer.parseInt(teacherId));
*/

// 임시 데이터를 Map으로 생성
Map<String, Object> teacher = new HashMap<>();
teacher.put("id", memberNo);
teacher.put("name", "정승제");
teacher.put("imageUrl", "https://i.namu.wiki/i/W-LhGCCNTAE3F7AJ81_DQpGg7XQbQolN76WcFDjbYgkSoOp8NnGgEj8PyGblftQNMKTTv_NJ8lfBz9XzpMlggQ.webp");
teacher.put("title", "개념과 지독한 연습이 만점을 만듭니다!");

List<String> tags = new ArrayList<>();
tags.add("개념");
tags.add("학력과 통계");
tags.add("수능 대비");
teacher.put("tags",tags);

// CORS 헤더 설정
response.setHeader("Access-Control-Allow-Origin", "*");
response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
response.setHeader("Access-Control-Allow-Headers", "Content-Type");

// 응답 설정
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");
response.getWriter().write(gson.toJson(teacher));
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/teacher/TeacherBoardServlet.java
```java
package com.ttt.controller.teacher;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 선생님 상세보기 페이지에서 각 탭별 메뉴 출력
@WebServlet("/TeacherBoardServlet")
public class TeacherBoardServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
   
public TeacherBoardServlet() {
super();
}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
String pathInfo = "국어";
String boardType = pathInfo.substring(1); // /notice, /qna 등

// 페이징 처리를 위한 파라미터
int cpage = 1;
try {
cpage = Integer.parseInt(request.getParameter("cpage"));
} catch (NumberFormatException e) {}

int numPerPage = 10;
int totalData = getTotalData(boardType); // 게시글 총 개수
int totalPage = (int)Math.ceil((double)totalData/numPerPage);

int pageBarSize = 5;
int pageStart = ((cpage-1)/pageBarSize) * pageBarSize + 1;
int pageEnd = pageStart + pageBarSize - 1;

if(pageEnd > totalPage) {
pageEnd = totalPage;
}

// 더미데이터 생성 및 페이징 처리
List<Map<String,Object>> boardList = createDummyData(boardType, cpage, numPerPage);

// request에 데이터 저장
request.setAttribute("boardList", boardList);
request.setAttribute("pageStart", pageStart);
request.setAttribute("pageEnd", pageEnd);
request.setAttribute("totalPage", totalPage);

// 각 게시판 타입별 JSP로 포워딩
String view = "/WEB-INF/views/teacher/tabs/teacher" + 
 boardType.substring(0,1).toUpperCase() + 
 boardType.substring(1) + ".jsp";
request.getRequestDispatcher(view).forward(request, response);
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request, response);
}

// 랜덤 날짜 생성 유틸리티 메서드
// 특정 기간 내의 랜덤 날짜 생성
private java.sql.Date getRandomDate(int startDaysAgo, int endDaysAgo) {
long currentTime = System.currentTimeMillis();
long start = currentTime - ((long)startDaysAgo * 24 * 60 * 60 * 1000);
long end = currentTime - ((long)endDaysAgo * 24 * 60 * 60 * 1000);  // 최근 startDaysAgo일에서 endDaysAgo까지 ex 최근 10일 이내에서 1 어제까지
long randomTime = start + (long)(Math.random() * (start - end));
return new java.sql.Date(randomTime);
}

private int getTotalData(String boardType) {
// 각 게시판 타입별 전체 데이터 수 반환
switch(boardType) {
case "notice": return 50;  // 공지사항 
case "qna": return 100;// Q&A  
case "resources": return 30; // 자료실
case "reviews": return 80;  // 후기
default: return 0;
}
}

private List<Map<String,Object>> createDummyData(String boardType, int cpage, int numPerPage) {
switch(boardType) {
case "notice": return createNoticeDummyData(cpage, numPerPage);
case "qna": return createQnaDummyData(cpage, numPerPage);
case "resources": return createResourcesDummyData(cpage, numPerPage);
case "reviews": return createReviewsDummyData(cpage, numPerPage);
default: return new ArrayList<>();
}
}

// 공지사항 더미데이터
private List<Map<String,Object>> createNoticeDummyData(int cpage, int numPerPage) {
List<Map<String,Object>> list = new ArrayList<>();

// 시작 번호 계산
int start = (cpage - 1) * numPerPage + 1;

// 더미데이터 생성
for(int i = 0; i < numPerPage; i++) {
Map<String,Object> notice = new HashMap<>();
notice.put("postNo", start + i);
notice.put("postTitle", "공지사항 테스트 " + (start + i));
notice.put("memberName", "관리자");
notice.put("createdAt", getRandomDate(10, -10));
notice.put("viewCount", (int)(Math.random() * 100));
list.add(notice);
}

return list;
}

// Q&A 더미데이터
private List<Map<String,Object>> createQnaDummyData(int cpage, int numPerPage) {
List<Map<String,Object>> list = new ArrayList<>();
int start = (cpage - 1) * numPerPage + 1;

for(int i = 0; i < numPerPage; i++) {
Map<String,Object> qna = new HashMap<>();
qna.put("postNo", start + i);
qna.put("postTitle", "Q&A 질문입니다 " + (start + i));
qna.put("memberName", "학생" + (int)(Math.random() * 100));
qna.put("createdAt", getRandomDate(10, -10));
qna.put("viewCount", (int)(Math.random() * 100));
qna.put("answerStatus", Math.random() > 0.5 ? "답변완료" : "대기중");
list.add(qna);
}
return list;
}

// 자료실 더미데이터
private List<Map<String,Object>> createResourcesDummyData(int cpage, int numPerPage) {
List<Map<String,Object>> list = new ArrayList<>();
int start = (cpage - 1) * numPerPage + 1;

for(int i = 0; i < numPerPage; i++) {
Map<String,Object> resource = new HashMap<>();
resource.put("postNo", start + i);
resource.put("postTitle", "학습자료 " + (start + i));
resource.put("memberName", "선생님");
resource.put("createdAt", getRandomDate(10, -10));
resource.put("viewCount", (int)(Math.random() * 100));
resource.put("fileCount", (int)(Math.random() * 3) + 1); // 첨부파일 수
list.add(resource);
}
return list;
}

// 수강후기 더미데이터
private List<Map<String,Object>> createReviewsDummyData(int cpage, int numPerPage) {
List<Map<String,Object>> list = new ArrayList<>();
int start = (cpage - 1) * numPerPage + 1;

for(int i = 0; i < numPerPage; i++) {
Map<String,Object> review = new HashMap<>();
review.put("postNo", start + i);
review.put("courseName", "2024 수능대비 강좌 " + ((int)(Math.random() * 5) + 1));
review.put("memberName", "학생" + (int)(Math.random() * 100));
review.put("createdAt", getRandomDate(10, -10));
review.put("rating", ((int)(Math.random() * 50) + 1) / 10.0); // 1.0-5.0
review.put("reviewContent", "강의가 너무 좋았습니다. " + (start + i));
list.add(review);
}
return list;
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/controller/teacher/ToTeacherServlet.java
```java
package com.ttt.controller.teacher;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Member3;
import com.ttt.service.MemberService;

@WebServlet("/teacher/list_and_detail")
public class ToTeacherServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
   
public ToTeacherServlet() {
super();
}

// "/Teacher/*" 로 들어오는 모든 요청을 분기처리하여 각 페이지로 응답하기
// 각 페이지에서의 내용은 ajax(post) 요청으로 다른 servlet 으로 재요청 후 응답하기 
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

try {
String teacherSubject = request.getParameter("subject");
if (teacherSubject==null) {
teacherSubject="국어";
}

List<Member3> allTeachers = new MemberService().selectAllTeachers();
System.out.println("선생님 목록"+ allTeachers.toString());

// 과목 목록
List<String> subjectData = new MemberService().selectSubjects();
int i=0;
for(Member3 m : allTeachers) {
++i;
System.out.println("image renamed[i]: "+m.getImage());
}
request.setAttribute("teachers", allTeachers);
request.setAttribute("subjectData", subjectData);

} catch(Exception e) {
e.printStackTrace();
}

request.getRequestDispatcher("/WEB-INF/views/teacher/teacherListAndDetail.jsp")
   .forward(request, response);
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
// https://chatgpt.com/share/6773646f-9694-8008-a797-51f0f057bde9
}
}

```



# 디렉토리: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/dao

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/dao/CourseDao.java
```java
package com.ttt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Course3;

public class CourseDao {

// 코스 번호로 해당 코스 전체 정보 조회
public Course3 selectCourseByNo(SqlSession session, int courseNo) {
return session.selectOne("course.selectCourseByNo",courseNo);
}

public List<Course3> selectCourseBySubjectNo(SqlSession session, Map<String, Object> param) {
return session.selectList("course.selectCourseBySubjectNo", param);
}

/* 강좌 필수 로직 다음을 항상 포함시켜서 트랜잭션 처리 하시오 */
// 전체 상태 업데이트
public int updateAllCoursesStatus(SqlSession session, int memberNo) {
return session.update("course.updateAllCoursesStatus", memberNo);
}
// 개별 상태 업데이트
public int updateCourseStatus(SqlSession session, int courseNo) {
return session.update("cousre.updateCourseStatus",courseNo);
}

// 상태별 강좌 목록 조회
public List<Course3> selectCoursesByStatus(SqlSession session, Map<String, Object> params){
return session.selectList("course.selectCoursesByStatus",params);
}
// 상태별 강좌 수 조회
public Map<String,Object> selectCourseStatusCount(SqlSession session, int memberNo){
return session.selectOne("course.selectCourseStatusCount",memberNo);
}

// 교사의 강좌 목록 조회 (상태별 필터링 포함)
public List<Course3> selectCoursesByTeacher(SqlSession session, Map<String, Object> params) {
return session.selectList("course.selectCoursesByTeacher", params);
}

// 새 강좌 등록
public int insertNewCourse(SqlSession session, Course3 c) {
return session.insert("course.insertNewCourse",c);
}

//카테고리 목록 조회
public List<String> selectAllCategories(SqlSession session) {
return session.selectList("course.selectAllCategories");
}

// 학생이 수강 중인 강좌 번호 목록 조회
public List<Integer> selectEnrolledCourseNos(SqlSession session, int memberNo) {
return session.selectList("course.selectEnrolledCourseNos", memberNo);
}

// 교사가 가르치는 강좌 번호 목록 조회
public List<Integer> selectTeachingCourseNos(SqlSession session, int memberNo) {
return session.selectList("course.selectTeachingCourseNos", memberNo);
}
}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/dao/CourseRegisterDao.java
```java
package com.ttt.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.CourseRegister3;

public class CourseRegisterDao {

public List<CourseRegister3> selectIngCourse(SqlSession session) {
return session.selectList("courseRegister.selectIngCourse");
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/dao/LectureDao.java
```java
package com.ttt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Lecture3;
import com.ttt.dto.ScheduleEvent3;

public class LectureDao {

// 강좌별 강의 목록 조회
public List<Lecture3> selectLecturesByCourseNo(SqlSession session, int courseNo) {
return session.selectList("lecture.selectLecturesByCourseNo", courseNo);
}

// 강의 일괄 등록
public int insertLecturesBatch(SqlSession session, List<Lecture3> lectures) {
return session.insert("lecture.insertLecturesBatch", lectures);
}

// 일정 일괄 등록
public int insertScheduleEventsBatch(SqlSession session, List<ScheduleEvent3> events) {
return session.insert("lecture.insertScheduleEventsBatch", events);
}

// 강의 등록 (트랜잭션 처리를 위해 반환값 int)
public int insertLecture(SqlSession session, Lecture3 lecture) {
return session.insert("lecture.insertLecture", lecture);
}

// 강의 일정 등록 (일정 포함)
public int insertScheduleEvent(SqlSession session, ScheduleEvent3 event) {
return session.insert("lecture.insertScheduleEvent", event);
}

// 강의 수정 (일정 포함)
public int updateLecture(SqlSession session, Lecture3 lecture) {
return session.update("lecture.updateLecture", lecture);
}

// 강의 일정 수정
public int updateScheduleEvent(SqlSession session, ScheduleEvent3 event) {
return session.update("lecture.updateScheduleEvent", event);
}

// 강의 삭제 (lecture_status 를 이용 1공개, 2삭제, 0비공개)
public int updateDeleteLecture(SqlSession session, int lectureNo) {
return session.delete("lecture.deleteLecture", lectureNo);
}

// 강의와 연결된 일정 조회
public ScheduleEvent3 selectScheduleEventByLectureNo(SqlSession session, int lectureNo) {
return session.selectOne("lecture.selectScheduleEventByLectureNo", lectureNo);
}

// 학생의 수강 강좌 일정 조회 (학년 필터 포함)
public List<Map<String, Object>> selectEventsByStudentNo(SqlSession session, Map<String, Object> params) {
return session.selectList("lecture.selectEventsByStudentNo");
}
// 교사의 강좌 일정 조회 (학년 필터 포함)
public List<Map<String, Object>> selectEventsByTeacherNo(SqlSession session, Map<String, Object> params) {
return session.selectList("lecture.selectEventsByTeacherNo");
}
// 학년별 강의 일정 조회
public List<Map<String, Object>> selectEventsByGrade(SqlSession session, Map<String, Object> params) {
return session.selectList("lecture.selectEventsByGrade"); 
}
}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/dao/MemberDao.java
```java
package com.ttt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Member3;

public class MemberDao {

/* 회원 등록 */
public int insertMember(SqlSession session, Member3 m) {
return session.insert("member.insertMember",m);
}
public int insertStudent(SqlSession session, Member3 m) {
return session.insert("member.insertStudent",m);
}
public int insertTeacher(SqlSession session, Member3 m) {
return session.insert("member.insertTeacher",m);
}

/* 회원정보 조회-업데이트 관련 */
public Member3 selectMemberById(SqlSession session, String memberId) {
Member3 member = session.selectOne("member.selectMemberById", memberId);

if(member != null) {
if(member.getMemberType() == 1) { //학생
Member3 student = session.selectOne("member.selectStudentById", memberId);
if(student != null && student.getSchool() != null) {
member.setSchool(student.getSchool());
member.setGrade(student.getGrade());
}
} else if (member.getMemberType() == 2) { //교사
Member3 teacher = session.selectOne("member.selectTeacherById", memberId);
if(teacher != null) {
member.setTeacherInfoTitle(teacher.getTeacherInfoTitle());
member.setTeacherInfoContent(teacher.getTeacherInfoContent());
member.setImage(teacher.getImage());
member.setTeacherSubject(teacher.getTeacherSubject());
}
}
} 

return member;
}
public int updatePassword(SqlSession session, Member3 m) {
return session.update("member.updatePassword", m);
}
public int updateMember(SqlSession session, Member3 m) {
System.out.println("m : "+m);
return session.update("member.updateMember", m);
}
public int updateStudent(SqlSession session,Member3 m) {
return session.update("member.updateStudent", m);
}
public int updateTeacher(SqlSession session,Member3 m) {
return session.update("member.updateTeacher", m);
}
//이미지 업로드
public int insertImage(SqlSession session, Member3 m) {
return session.insert("image.insertImage", m);
}


/* teacherListAndDetail 페이지의 리스트에 교사 출력용 */
public List<Member3> selectTeachersBySubject(SqlSession session, Map<String, Object> param){
return session.selectList("member.selectTeachersBySubject", param);
}
public int selectTeachersCount(SqlSession session, Map<String, Object> param){
return session.selectOne("member.selectTeachersCount", param);
}
public List<String> selectSubjects(SqlSession session){
return session.selectList("member.selectSubjects");
}
public List<Member3> selectAllTeachers(SqlSession session){
return session.selectList("member.selectAllTeachers");
}


/* 이메일 인증 관련 */
public Member3 checkEmailDuplicateByEmail(SqlSession session, Member3 m) {
return session.selectOne("member.checkEmailDuplicateByEmail",m);
}

public Member3 selectMemberByNameAndEmail(SqlSession session, Member3 m) {
return session.selectOne("member.selectMemberByNameAndEmail",m);
}

// 관리자 메뉴 : 전체 멤버 리스트 출력
public List<Member3> selectAllMember(SqlSession session){
System.out.println("DAO - 전체 멤버 리스트 출력 시작");
return session.selectList("member.selectAllMember");
}
//사용자 메뉴 : 아이디 찾기
public String selectMemberIdByNameAndEmail(SqlSession session, Member3 m) {
return session.selectOne("member.selectMemberIdByNameAndEmail", m);
}
//사용자 메뉴 : 비밀번호 찾기
public Member3 selectMemberByIdAndEmail(SqlSession session, Member3 m) {
   return session.selectOne("member.selectMemberByIdAndEmail", m);
}


}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/dao/PaymentDao.java
```java
package com.ttt.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Cart3;

public class PaymentDao {

//장바구니에 들어갈 리스트 가져오기
public List<Cart3> selectCartListByMemberNo(SqlSession session, int memberNo) {
return session.selectList("cart.selectCartListByMemberNo", memberNo);
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/dao/SchoolDao.java
```java
package com.ttt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.School12;

/* 서비스 클래스로부터 session 을 넘겨받아 쿼리문을 실행하는 클래스 */
public class SchoolDao {

public List<School12> selectNameAndCode(SqlSession session, Map<String,Object> inputSchoolInfo){
System.out.println(inputSchoolInfo);
return session.selectList("school.selectNameAndCode",inputSchoolInfo);
}

public School12 selectSchoolInfoBySchoolNo(SqlSession session, int schoolNo) {
return session.selectOne("school.selectSchoolInfoBySchoolNo",schoolNo);
}

public List<String> selectDistrictByRegion(SqlSession session, String region) {
return session.selectList("school.selectDistrictByRegion",region);
}
}

```


# 디렉토리: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/dto

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/dto/Cart3.java
```java
package com.ttt.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Cart3 {
private int cartNo;// 장바구니고유번호sequence
private Member3 member;// 로그인세션정보
private Date cartAddedAt;// 자동부여 날짜
private int isPaid;// 결제전0결제완료1장바구니에서삭제2
private int paymentNo;// 결제고유번호,결제완료와함께부여
private Course3 course;// 수강신청 고유 번호
}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/dto/Course3.java
```java
package com.ttt.dto;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Course3 {
private int courseNo;// 강좌고유번호sequence
private String courseTitle;// 강좌명
private String courseDesc;// 강좌요약
private int courseCategoryNo;// 강좌카테고리
private int grade;// 강좌대상학년
private int coursePrice;// 강좌가격
private int coursePriceSale;// 강좌할인율
private int coursePeriod;// 수강가능기간(일수)
private int courseStatus;// 최초개설시비공개0,촬영중1,촬영완료2
private Date createdAt;// 강좌등록날짜
private Date updatedAt;// 강좌마지막수정날짜
private Date beginDate;// 공개시작날짜
private Date endDate;// 강좌촬영완료날짜(예정날짜)
private int totalLectures;// 총강의수
private int memberNo;// 자동부여

private List<Lecture3> lectures;

// 교사 정보 연관 관계 추가
private Member3 member;  // 교사 정보 포함
private String teacherSubject;  // 교사 과목
private String teacherSubjectName;  // 교사 과목
private String teacherName; // 교사 이름

// 조회 결과를 담기 위한 추가 필드들
private int totalCount; // 전체 강좌 수
private int preparingCount; // 준비중인 강좌 수
private int inProgressCount; // 진행중인 강좌 수
private int completedCount; // 완료된 강좌 수

// 카테고리를 join 해서 사용할 정보들
private String courseCategoryTitle;
private String courseCategoryDesc;
}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/dto/CourseRegister3.java
```java
package com.ttt.dto;

import java.sql.Date;

public class CourseRegister3 {
private int courseRegisterNo;  // 수강신청고유번호
private Date courseRegisterDate; // 수강신청일
private int progressRate; // 학습진도율
private Date lastViewTime;// 마지막수강날짜
private int completionStatus; // 수료상태
private int courseNo; // 강좌참조키
private int courseScore;  // 수강평점
private String reviewContent;  // 진도율80%이상만작성가능
private int memberNo; // 자동부여

private Course3 course;
}
```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/dto/EmailAuthenticationResult.java
```java
package com.ttt.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

//인증 결과를 담을 클래스
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class EmailAuthenticationResult {

private boolean success;
private String message;
}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/dto/Files3.java
```java
package com.ttt.dto;

import java.sql.Date;

public class Files3 {
private int fileNo;// 첨부파일고유번호
private String oriname;// 첨부파일명
private String rename; // 저장된파일명
private Date createdAt;// 자료추가날짜
private int postNo;// 게시글고유번호참조키
}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/dto/Image3.java
```java
package com.ttt.dto;


import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Image3 {
private int imgNo;
private int imgType;
private String oriname;
private String renamed;
private Date createdAt;
private int memberNo;
private int imgOrder;
}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/dto/Lecture3.java
```java
package com.ttt.dto;

import java.sql.Date;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Lecture3 {
private int lectureNo; // 강의고유번호
private String lectureTitle;   // 강의제목
private int lectureOrder;  // 강의순서(차시)
private int lectureDuration;   // 강의재생시간(길이)
private String lectureDesc;// 강의요약설명 
private char lectureStatus;// 공개:1 비공개또는삭제:2
private Date createdAt;// 강의등록날짜
private Date updatedAt;// 강의최종수정날짜
private int courseNo;  // 연결된강좌번호

private ScheduleEvent3 scheduleEvent; // 이벤트 연결 객체
private LocalDateTime eventStart;
private LocalDateTime eventEnd;
}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/dto/Member3.java
```java
package com.ttt.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Member3 {
private int memberNo;
private String memberId;
private String memberPw;
private String memberName;
private String email;
private String phone;
private int memberType; // 관리자 0, 학생: 1, 선생님: 2
private Date enrollDate;
private String address;
private int schoolNo;

/* Student3, Teacher3 클래스 만들지 않고 Member3 만 사용 */

/* 학생인 경우 포함 필드 */
private int grade;
private School12 school;

/* 교사인 경우 포함 필드 */
private String teacherSubject;
private String teacherSubjectName;
private String teacherInfoTitle;
private String teacherInfoContent;
private Image3 image;
}
```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/dto/MemberLecture3.java
```java
package com.ttt.dto;

import java.sql.Date;

public class MemberLecture3 {
private int lectureNo; // 강의고유번호
private int memberNo;  // 자동부여
private int complete;  // 수강완료여부
private int stopAt;// 마지막재생위치
private Date currentViewDate; //최근시청날짜
private double LECTURE_PER; //강의 진행률

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/dto/Post3.java
```java
package com.ttt.dto;

import java.sql.Date;

public class Post3 {
private int postNo;   // 게시글고유번호
private String postTitle;  // 게시글제목
private String postContent;// 게시글내용
private int viewCount;// 조회수
private int likeCount;// 좋아요수
private int isNotice; // 게시판상단고정여부
private int isPublic; // 기본값1공개/0비공개
private int status;   // 공개:1,비공개:0
private Date createdAt;   // 자동부여
private Date updatedAt;   // 자동부여
private int memberNo; // 자동부여
private int parentPostNo; // 답글인경우원글NO
private int boardCategoryNo;  // 1,2,3,4,5나중에추가가능
}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/dto/ScheduleEvent3.java
```java
package com.ttt.dto;

import java.sql.Date;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ScheduleEvent3 {
private int eventNo;
private String calendarId;
private String eventCategory; // 기본값 'time'
private String eventTitle;
private LocalDateTime eventStart;
private LocalDateTime eventEnd;
private int lectureNo;
private int courseNo;
private String eventType;
private int subjectCode;
private int grade;
private int eventStatus;
private String videoUrl;
private Date createdAt;

// 연관 객체
private Member3 member;
private Lecture3 lecture;
private Course3 course;

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/dto/School12.java
```java
package com.ttt.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class School12 {
private int schoolNo; /* 키값으로 사용하기 위해 새로 부여해준 번호 */
private String region;
private String district;
private String schoolName;
private int schoolType; /* 3:고등학교 4:기타학교 */ 
private String regionCode; /* 지역 교육청 표준 코드 */
private int standardCode; /* 학교 표준 코드 중복되는 경우가 있음 */

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/dto/Video3.java
```java
package com.ttt.dto;

import java.sql.Date;

public class Video3 {
private int lectureNo; // 강의고유번호
private String oriname;// 영상오리지널파일명
private String rename; // 영상저장된파일명
private Date createdAt;// 영상자료등록날짜
private int isDeleted; //삭제여부, 삭제0, 기본1
}

```


# 디렉토리: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/service

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/service/AdminMemberService.java
```java
package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.MemberDao;
import com.ttt.dto.Member3;

public class AdminMemberService {

private MemberDao dao=new MemberDao();

public List<Member3> selectAllMember() {
SqlSession session = getSession();
try {
return dao.selectAllMember(session);
} finally {
if (session != null) session.close();
}
}
}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/service/CourseRegisterService.java
```java
package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.CourseRegisterDao;
import com.ttt.dto.CourseRegister3;

public class CourseRegisterService {
private CourseRegisterDao dao = new CourseRegisterDao();

public List<CourseRegister3> selectIngCourse() {
SqlSession session = getSession();
return dao.selectIngCourse(session);
}
}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/service/CourseService.java
```java
package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.CourseDao;
import com.ttt.dto.Course3;

public class CourseService {
private CourseDao dao = new CourseDao();

// 코스 번호로 해당 코스 전체 정보 조회
public Course3 selectCourseByNo(int courseNo) {
SqlSession session = getSession();
return dao.selectCourseByNo(session, courseNo);
}

public List<Course3> selectCourseBySubjectNo(Map<String, Object> param) {
SqlSession session = getSession();
List<Course3> courses = dao.selectCourseBySubjectNo(session, param);
session.close();

return courses;
}

// 트랜잭션을 통한 강좌 상태 업데이트
public int updateCourseStatus(int courseNo) {
SqlSession session = getSession();
int result = 0;
try {
result = dao.updateCourseStatus(session, courseNo);
if (result >= 1) {
session.commit();
} else {
session.rollback();
}
} catch (Exception e) {
session.rollback();
e.printStackTrace();
} finally {
session.close();
}
return result;
}

// 상태별 강좌 목록 조회
public List<Course3> selectCoursesByStatus(Map<String, Object> params, int memberNo) {
SqlSession session = getSession();
List<Course3> courses = null;
try {
// 모든 강좌의 상태를 먼저 업데이트
dao.updateAllCoursesStatus(session, memberNo);

courses = dao.selectCoursesByStatus(session, params);
session.commit();
} catch (Exception e) {
session.rollback();
e.printStackTrace();
} finally {
session.close();
}
return courses;
}

// 교사의 강좌 목록 조회 (상태별 필터링 포함)
public Map<String, Object> selectCoursesByTeacher(int memberNo, String status) {
SqlSession session = getSession();
try {
Map<String, Object> params = new HashMap<>();
params.put("memberNo", memberNo);
params.put("status", status);

Map<String, Object> result = new HashMap<>();
// 강좌 목록 조회
List<Course3> courseList = dao.selectCoursesByStatus(session, params);
result.put("courses", courseList);

// 상태별 카운트 조회
Map<String, Object> countMap = dao.selectCourseStatusCount(session, memberNo);

// 각 상태별 카운트를 result에 추가
result.put("totalCount", countMap.get("TOTAL"));
result.put("preparingCount", countMap.get("PREPARING"));
result.put("inProgressCount", countMap.get("INPROGRESS"));
result.put("completedCount", countMap.get("COMPLETED"));

session.commit();
return result;
} catch (Exception e) {
session.rollback();
e.printStackTrace();
throw e;
} finally {
session.close();
}
}

// 새 강좌 등록
public int insertNewCourse(Course3 c) {
SqlSession session = getSession();
int result = 0;
try {
result = dao.insertNewCourse(session, c);
if (result >= 1) {
session.commit();
} else {
session.rollback();
}
} catch (Exception e) {
session.rollback();
e.printStackTrace();
} finally {
session.close();
}
return result;
}

// 회원의 강의 존재여부 확인 - 보류
public boolean checkEnrollment(int memberNo, int courseNo) {
SqlSession session = getSession();
// int result = dao.checkEnrollment(session, memberNo);
return false;
}

//카테고리 목록 조회
public List<String> selectAllCategories() {
SqlSession session = getSession();
return dao.selectAllCategories(session);
}


// 학생이 수강 중인 강좌 번호 목록 조회
public List<Integer> selectEnrolledCourseNos(int memberNo) {
SqlSession session = getSession();
try {
return dao.selectEnrolledCourseNos(session, memberNo);
} finally {
session.close();
}
}

// 교사가 가르치는 강좌 번호 목록 조회
public List<Integer> selectTeachingCourseNos(int memberNo) {
SqlSession session = getSession();
try {
return dao.selectTeachingCourseNos(session, memberNo);
} finally {
session.close();
}
}
}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/service/EmailAuthenticationService.java
```java
package com.ttt.service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Random;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import com.ttt.common.SqlSessionTemplate;
import com.ttt.dao.MemberDao;
import com.ttt.dto.EmailAuthenticationResult;
import com.ttt.dto.Member3;

public class EmailAuthenticationService {
private static final int AUTH_NUMBER_LENGTH = 6;
private static final int MAX_ATTEMPTS = 5;
private static final int EXPIRY_MINUTES = 5;
private MemberDao dao=new MemberDao();

// 인증번호 생성
public String generateAuthNumber() {
Random random = new Random();
StringBuilder builder = new StringBuilder();
for (int i = 0; i < AUTH_NUMBER_LENGTH; i++) {
builder.append(random.nextInt(10));
}
return builder.toString();
}

// 인증번호 해시화
public String hashAuthNumber(String authNumber) {
try {
MessageDigest md = MessageDigest.getInstance("SHA-512");
byte[] bytes = authNumber.getBytes();
md.update(bytes);
byte[] digest = md.digest();
return Base64.getEncoder().encodeToString(digest);
} catch(NoSuchAlgorithmException e) {
throw new RuntimeException("해시 알고리즘 오류", e);
}
}

// 이메일 전송
public void sendAuthEmail(String email, String authNumber) 
throws MessagingException {
EmailSenderService sender = new EmailSenderService();
String subject = "이메일 인증번호";
String content = "인증번호는 [" + authNumber + "] 입니다.";
sender.sendEmail(email, subject, content);
}

// 세션에 인증 정보 저장
public void setAuthenticationInfo(HttpSession session, String email, 
String hashedAuthNumber) {
session.setAttribute("hashedAuthNumber", hashedAuthNumber);
session.setAttribute("authCreateTime", System.currentTimeMillis());
session.setAttribute("email", email);
session.setAttribute("failCount", 0);
session.setMaxInactiveInterval(EXPIRY_MINUTES * 60);
}

// 인증번호 검증
public EmailAuthenticationResult verifyAuthNumber(HttpSession session, 
String inputAuthNumber) {
Long authCreateTime = (Long) session.getAttribute("authCreateTime");
Integer failCount = (Integer) session.getAttribute("failCount");
String hashedAuthNumber = (String) session.getAttribute("hashedAuthNumber");

if (authCreateTime == null || hashedAuthNumber == null) {
return new EmailAuthenticationResult(false, "인증 정보가 없습니다.");
}

// 만료 시간 체크
if (System.currentTimeMillis() - authCreateTime > 
EXPIRY_MINUTES * 60 * 1000) {
clearAuthenticationInfo(session);
return new EmailAuthenticationResult(false, "인증번호가 만료되었습니다.");
}

// 실패 횟수 체크
if (failCount != null && failCount >= MAX_ATTEMPTS) {
clearAuthenticationInfo(session);
return new EmailAuthenticationResult(false, "인증 시도 횟수를 초과했습니다.");
}

// 인증번호 검증
String hashedInput = hashAuthNumber(inputAuthNumber);
if (hashedAuthNumber.equals(hashedInput)) {
return new EmailAuthenticationResult(true, "인증이 완료되었습니다.");
} else {
session.setAttribute("failCount", 
(failCount == null ? 1 : failCount + 1));
return new EmailAuthenticationResult(false, "인증번호가 일치하지 않습니다.");
}
}

// 세션 정보 초기화
public void clearAuthenticationInfo(HttpSession session) {
session.removeAttribute("hashedAuthNumber");
session.removeAttribute("authCreateTime");
session.removeAttribute("failCount");
session.removeAttribute("email");
}

// 이메일 중복 검사
public Member3 checkEmailDuplicateByEmail(Member3 m) {
SqlSession session = new SqlSessionTemplate().getSession();
//MemberDao 의 메소드 이용해서 이메일 중복 체크해서 결과 유무 체크하기 count(*)
return dao.checkEmailDuplicateByEmail(session, m);
}
// 회원 인증 by (이름, 이메일)
public Member3 selectMemberByNameAndEmail(Member3 m) {
SqlSession session = new SqlSessionTemplate().getSession();
//MemberDao 의 메소드 이용해서 이메일 중복 체크해서 결과 유무 체크하기 count(*)
return dao.selectMemberByNameAndEmail(session, m);
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/service/EmailSenderService.java
```java
package com.ttt.service;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

// 이메일 정보를 호출해서 메일을 보내주는 서비스, 실제 이메일 전송을 담당하는 서비스 클래스 (SMTP 설정 및 메일 발송 처리)
public class EmailSenderService {
private Properties emailProps;

public EmailSenderService() {
loadProperties();
}

//email.properties 에 보안 정보 저장해서 호출해서 사용하기
private void loadProperties() {
try {
emailProps = new Properties();
String path = EmailSenderService.class.getResource("/email.properties").getPath();
emailProps.load(new FileInputStream(path));
} catch (IOException e) {
e.printStackTrace();
}
}

public void sendEmail(String to, String subject, String content) throws MessagingException {
Properties props = new Properties();
props.put("mail.smtp.host", emailProps.getProperty("mail.smtp.host"));
props.put("mail.smtp.port", emailProps.getProperty("mail.smtp.port"));
props.put("mail.smtp.auth", emailProps.getProperty("mail.smtp.auth"));
props.put("mail.smtp.starttls.enable", emailProps.getProperty("mail.smtp.starttls.enable"));

Session session = Session.getInstance(props, new Authenticator() {
@Override
protected PasswordAuthentication getPasswordAuthentication() {
return new PasswordAuthentication(
emailProps.getProperty("mail.username"),
emailProps.getProperty("mail.password")
);
}
});

Message message = new MimeMessage(session);
message.setFrom(new InternetAddress(emailProps.getProperty("mail.username")));
message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
message.setSubject(subject);
message.setText(content);

Transport.send(message);
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/service/LectureService.java
```java
package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.LectureDao;
import com.ttt.dto.Lecture3;
import com.ttt.dto.ScheduleEvent3;

public class LectureService {

private LectureDao dao = new LectureDao();

// 강의와 일정 일괄 리스트로 받아와서 일괄 등록하도록 설정
public int insertLecturesWithSchedules(List<Lecture3> lectures, List<ScheduleEvent3> events) {
SqlSession session = getSession();
try {
// 1. 강의 일괄 등록
int result = dao.insertLecturesBatch(session, lectures);
if (result != lectures.size()) {
throw new RuntimeException("강의 등록 중 오류 발생");
}

// 2. 일정 일괄 등록
result = dao.insertScheduleEventsBatch(session, events);
if (result != events.size()) {
throw new RuntimeException("일정 등록 중 오류 발생");
}

session.commit();
return result;
} catch (Exception e) {
session.rollback();
throw e;
} finally {
session.close();
}
}

// 강좌별 강의 목록 조회
public List<Lecture3> selectLecturesByCourseNo(int courseNo) {
SqlSession session = getSession();
List<Lecture3> lectures = dao.selectLecturesByCourseNo(session, courseNo);
session.close();
return lectures;
}

// 강의 등록 (일정 포함)
public int insertLectureWithSchedule(Lecture3 lecture, ScheduleEvent3 event) {
SqlSession session = getSession();
int result = 0;
try {
result = dao.insertLecture(session, lecture);
if(result > 0 && event != null) {
event.setLectureNo(lecture.getLectureNo()); // 생성된 lectureNo 설정
result = dao.insertScheduleEvent(session, event);
if(result > 0) {
session.commit();
} else {
session.rollback();
}
}
} catch(Exception e) {
session.rollback();
throw e;
} finally {
session.close();
}
return result;
}

// 강의 수정 (일정 포함)
public int updateLectureWithSchedule(Lecture3 lecture, ScheduleEvent3 event) {
SqlSession session = getSession();
int result = 0;
try {
result = dao.updateLecture(session, lecture);
if(result > 0 && event != null) {
result = dao.updateScheduleEvent(session, event);
if(result > 0) {
session.commit();
} else {
session.rollback();
}
}
} catch(Exception e) {
session.rollback();
throw e;
} finally {
session.close();
}
return result;
}

// 강의 삭제 (lecture_status 를 이용 1공개, 2삭제, 0비공개)
public int updateDeleteLecture(int lectureNo) {
SqlSession session = getSession();
int result = dao.updateDeleteLecture(session, lectureNo);
if(result > 0) {
session.commit();
} else {
session.rollback();
}
session.close();
return result;
}

// 학생의 수강 강좌 일정 조회 (학년 필터 포함)
public List<Map<String, Object>> selectEventsByStudentNo(Map<String, Object> params) {
SqlSession session = getSession();
try {
return dao.selectEventsByStudentNo(session, params);
} finally {
session.close();
}
}

// 교사의 강좌 일정 조회 (학년 필터 포함)
public List<Map<String, Object>> selectEventsByTeacherNo(Map<String, Object> params) {
SqlSession session = getSession();
try {
return dao.selectEventsByTeacherNo(session, params);
} finally {
session.close();
}
}

// 학년별 강의 일정 조회
public List<Map<String, Object>> selectEventsByGrade(Map<String, Object> params) {
SqlSession session = getSession();
try {
return dao.selectEventsByGrade(session, params);
} finally {
session.close();
}
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/service/MemberService.java
```java
package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.MemberDao;
import com.ttt.dto.Member3;

/* Connection 과 MemberDao 객체를 만들어서 서버와 db 서버가 서로 통신할 수 있게 서비스를 제공하는 클래스 */
public class MemberService {

private MemberDao dao=new MemberDao();

/* 회원가입 서비스 */
public int insertMember(Member3 m) {
SqlSession session=getSession();
int result = dao.insertMember(session, m);
try {
System.out.println("db에 기본값 저장 후 객체 정보 m : "+m.toString());
if(result > 0) {
if(m.getMemberType() == 1) {  // 학생
result = dao.insertStudent(session, m);

} else if(m.getMemberType() == 2) {  // 교사
result = dao.insertTeacher(session, m);
}
session.commit();
} else {
session.rollback();
}
} catch(Exception e) {
e.printStackTrace();
session.rollback();
throw e;
} finally {
session.close();
}
return result;
}

/* Id 값으로 회원 정보 조회 서비스 */
public Member3 selectMemberById(String memberId) {
SqlSession session=getSession();
return dao.selectMemberById(session, memberId);
}

/* teacherListAndDetail 페이지의 리스트에 교사 출력용 */
public List<Member3> selectAllTeachers(){
SqlSession session=getSession();
return dao.selectAllTeachers(session);
}
public List<Member3> selectTeachersBySubject(Map<String, Object> param){
SqlSession session=getSession();
return dao.selectTeachersBySubject(session, param);
}
public int selectTeachersCount(Map<String, Object> param){
SqlSession session=getSession();
return dao.selectTeachersCount(session, param);
}

/* 학생의 회원 정보 수정 서비스*/
public int updateMember(Member3 m) {
SqlSession session=getSession();
int result = 0;
try {
result = dao.updateMember(session, m);
System.out.println(result);
System.out.println(m);
if(result > 0) {
if(m.getMemberType() == 1) {  // 학생
result = dao.updateStudent(session, m);

} else if(m.getMemberType() == 2) {  // 교사
if(m.getImage() != null) {
int imageResult = dao.insertImage(session, m);
if(imageResult > 0) {
result = dao.updateTeacher(session, m);
}
} else {
result = dao.updateTeacher(session, m);
}
}
session.commit();
} else {
session.rollback();
}
} catch(Exception e) {
e.printStackTrace();
session.rollback();
throw e;
} finally {
session.close();
}
return result;
}
// 과목을 distinct 로 리스트 출력
public List<String> selectSubjects(){
SqlSession session=getSession();
return dao.selectSubjects(session);
}
//아이디 찾기
public String selectMemberIdByNameAndEmail(Member3 m) {
SqlSession session = getSession();
String memberId = dao.selectMemberIdByNameAndEmail(session, m);
return memberId;
}

//비밀번호 찾기 
public Member3 selectMemberByIdAndEmail(Member3 m) {
SqlSession session=getSession();
Member3 result = dao.selectMemberByIdAndEmail(session, m);
System.out.println("Service layer result: " + result);
return result;
}

}


```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/service/PaymentService.java
```java
package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.PaymentDao;
import com.ttt.dto.Cart3;

public class PaymentService {
private PaymentDao dao = new PaymentDao();

//장바구니에 들어갈 리스트 가져오기
public List<Cart3> selectCartListByMemberNo(int memberNo) {
SqlSession session = getSession();
List<Cart3> carts = dao.selectCartListByMemberNo(session, memberNo);
session.close();

return carts;
}

}

```

## 파일: C:/GitHub/EduTech_Full_Stack/Teachers_Project/Teachers_Project_3_lecture/Teachers_3_eleraning/src/main/java/com/ttt/service/SchoolService.java
```java
package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.SchoolDao;
import com.ttt.dto.School12;

/* Connection 과 dao 객체를 만들어서 서버와 db 서버가 서로 통신할 수 있게 서비스를 제공하는 클래스 */
public class SchoolService {

private SchoolDao dao=new SchoolDao();

public List<School12> selectNameAndCode(Map<String,Object> inputSchoolInfo) {
SqlSession session=getSession();
List<School12> result=dao.selectNameAndCode(session,inputSchoolInfo);
session.close();
return result;

}

public School12 selectSchoolInfoBySchoolNo(int schoolNo) {
SqlSession session=getSession();
return dao.selectSchoolInfoBySchoolNo(session,schoolNo);

}

public List<String> selectDistrictByRegion(String region){
SqlSession session=getSession();
return dao.selectDistrictByRegion(session,region);
}
}

```



