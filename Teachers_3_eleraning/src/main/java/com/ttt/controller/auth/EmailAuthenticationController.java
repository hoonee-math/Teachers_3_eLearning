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
                "/WEB-INF/views/register/checkEmail.jsp" :
                "/WEB-INF/views/register/checkEmailForFindPassword.jsp";
            
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
        String returnPath = "/WEB-INF/views/register/" + 
            (authType.equals("reset") ? "checkEmailForFindPassword.jsp" : "checkEmail.jsp");
           
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
