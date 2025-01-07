package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.PaymentDao;
import com.ttt.dto.Cart3;

public class PaymentService {
	private PaymentDao dao = new PaymentDao();
	
	//장바구니에 들어갈 리스트 가져오기
	public List<Cart3> selectCartListByMemberNo(int memberNo) {
		SqlSession session = getSession();
		List<Cart3> carts = dao.selectCartListByMemberNo(session, memberNo);
		session.close();
		
		return carts;
	}

}
