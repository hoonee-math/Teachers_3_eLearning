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
        String email = request.getParameter("email");  // 이메일 파라미터 받기
        Gson gson = new Gson();
        
        try {
            // ContentType 설정 추가
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
        	// System.out.println("EmailAuthenticationController.handleDuplicateCheck() : 이메일 서비스로부터 이메일 중복 여부 체크 시작 email : "+email);
        	int result = new EmailAuthenticationService().checkEmailDuplicate(email);
        	System.out.println("result : "+result);

            Map<String, Object> jsonResponse = new HashMap<>();
            // json 데이터로 "existss" : "결과를 불린값으로 변환하여" 전달
            jsonResponse.put("exists", result == 1);
            String jsonString = gson.toJson(jsonResponse);

            // 여기에 JSON 응답 로그 추가
            System.out.println("JSON response: " + jsonString);
            response.getWriter().write(jsonString);
            
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
