package com.ttt.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Cart3 {
	private int cartNo;				// 장바구니고유번호sequence
	private Member3 member;			// 로그인세션정보
	private Date cartAddedAt;		// 자동부여 날짜
	private int isPaid;				// 결제전0결제완료1장바구니에서삭제2
	private int paymentNo;			// 결제고유번호,결제완료와함께부여
	private Course3 course;			// 수강신청 고유 번호
}
