package com.ttt.common.filter;

import java.io.IOException;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;

import com.ttt.dto.Member3;
import com.ttt.service.MemberService;

@WebFilter("/MegaMenuFilter")
public class MegaMenuFilter extends HttpFilter implements Filter {
       
    public MegaMenuFilter() {
        super();
    }

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// place your code here
		try {
			// 교사 목록과 과목 데이터를 가져옴
			List<Member3> teachers = new MemberService().selectAllTeachers();
			List<String> subjects = new MemberService().selectSubjects();

			// request에 데이터 저장
			request.setAttribute("megaMenuTeachers", teachers);
			request.setAttribute("megaMenuSubjects", subjects);

		} catch (Exception e) {
			e.printStackTrace();
		}
        
		chain.doFilter(request, response);
	}

}
