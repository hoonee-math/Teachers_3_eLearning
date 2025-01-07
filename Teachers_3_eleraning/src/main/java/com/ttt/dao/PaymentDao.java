package com.ttt.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Cart3;

public class PaymentDao {
	
	//장바구니에 들어갈 리스트 가져오기
	public List<Cart3> selectCartListByMemberNo(SqlSession session, int memberNo) {
		return session.selectList("cart.selectCartListByMemberNo", memberNo);
	}

}
