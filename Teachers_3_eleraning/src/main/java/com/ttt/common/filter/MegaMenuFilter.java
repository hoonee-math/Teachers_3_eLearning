package com.ttt.common.filter;

import java.io.IOException;
import java.util.ArrayList;
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

@WebFilter("/*")
public class MegaMenuFilter extends HttpFilter implements Filter {
       
    public MegaMenuFilter() {
        super();
    }

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// place your code here
		try {
        	if (request.getAttribute("megaMenuTeachers") == null) {
				// 교사 목록과 과목 데이터를 가져옴
				List<Member3> teachers = new MemberService().selectAllTeachersOnMegaMenu();
				request.setAttribute("megaMenuTeachers", teachers);
        	}

            if (request.getAttribute("megaMenuSubjects") == null) {
            	// request에 데이터 저장
				List<String> subjects = new MemberService().selectSubjects();
				request.setAttribute("megaMenuSubjects", subjects);
            }

		} catch (Exception e) {
            // 오류 발생시 빈 리스트로 초기화
            request.setAttribute("megaMenuTeachers", new ArrayList<>());
            request.setAttribute("megaMenuSubjects", new ArrayList<>());
			//e.printStackTrace();
		}
        
		chain.doFilter(request, response);
	}

}
