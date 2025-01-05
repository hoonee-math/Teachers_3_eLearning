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
	            request.getParameter("checked1"),
	            request.getParameter("checked2")
	        };
		System.out.println(request.getParameter("checked1"));
		// 하나라도 null이면 동의하지 않은 것으로 처리 -> js 에서 처리하면 보안상 위험이 있을까?
		for (String value : values) {
            if (value == null) {
                request.setAttribute("errorMessage", "모든 동의 항목에 동의해야 합니다.");
                request.getRequestDispatcher("/WEB-INF/views/enroll/termsofservice.jsp").forward(request, response);
                return;
            }
        }
		request.getRequestDispatcher("/WEB-INF/views/enroll/enrollMemberType.jsp").forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
