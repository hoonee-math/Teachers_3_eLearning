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
		"indexPage"
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
		
		// 세션이 없는 경우 쿠키 체크
	    if(loginMember == null) {
	        Cookie[] cookies = ((HttpServletRequest)request).getCookies();
	        if(cookies != null) {
	            for(Cookie c : cookies) {
	                if(c.getName().equals("saveId")) {
	                    String memberId = c.getValue();
	                    // 저장된 ID로 회원정보 조회
	                    Member3 m = new MemberService().selectMemberById(memberId); 
	                    if(m != null) {
	                        session.setAttribute("loginMember", m);
	                        loginMember = m;
	                        break;
	                    }
	                }
	            }
	        }
	    }
		
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
