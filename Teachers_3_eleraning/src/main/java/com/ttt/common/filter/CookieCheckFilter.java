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
