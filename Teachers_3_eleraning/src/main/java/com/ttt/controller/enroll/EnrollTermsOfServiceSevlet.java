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
