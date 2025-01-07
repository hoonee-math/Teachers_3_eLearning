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
		
		request.getRequestDispatcher("/WEB-INF/views/payment/cart.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
