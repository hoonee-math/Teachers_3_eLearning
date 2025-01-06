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

import com.google.gson.Gson;

//GSON을 사용하여 응답에 필터 적용
@WebFilter("/JsonResponseFilter")
public class JsonResponseFilter extends HttpFilter implements Filter {
    
	private Gson gson = new Gson();
	
    public JsonResponseFilter() {
        super();
    }

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        String requestedWith = httpRequest.getHeader("X-Requested-With");
        
        if ("XMLHttpRequest".equals(requestedWith)) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            System.out.println("Json Filter 적영됨.");
        }
        
		// pass the request along the filter chain
		chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
