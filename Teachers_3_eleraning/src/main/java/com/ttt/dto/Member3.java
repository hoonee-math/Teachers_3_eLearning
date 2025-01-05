package com.ttt.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Member3 {
	private int memberNo;
	private String memberName;
	private String memberId;
	private String memberPw;
	private String email;
	private String phone;
	private int isDeleted;
	private String address;
	private int birthday;
	private int eduType;
	private int subjectNo;
	private Date enrollDate;
	
	/* 계산해서 받아올 값 */
	private int warningCount; // 신고5,10,15 에 의해 발생한 경고 횟수
	private int reportCheckCount; // 관리자가 처리하지 않은 신고접수
	private int reportValidCount; // 처리된 신고중에서 유효한 신고
}
