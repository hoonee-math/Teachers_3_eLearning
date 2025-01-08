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
	private String memberId;
	private String memberPw;
	private String memberName;
	private String email;
	private String phone;
	private int memberType; // 관리자 0, 학생: 1, 선생님: 2
	private Date enrollDate;
	private String address;
	private int schoolNo;
	
	/* Student3, Teacher3 클래스 만들지 않고 Member3 만 사용 */
	
	/* 학생인 경우 포함 필드 */
	private int grade;
	private School12 school;
	
	/* 교사인 경우 포함 필드 */
	private String teacherSubject;
	private String teacherInfoTitle;
	private String teacherInfoContent;
	private Image3 image;
}