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
public class Course3 {
	private int courseNo;			// 강좌고유번호sequence
	private String courseTitle;		// 강좌명
	private String courseDesc;		// 강좌요약
	private int courseCategoryNo;	// 강좌카테고리
	private int grade;				// 강좌대상학년
	private int coursePrice;		// 강좌가격
	private int coursePriceSale;	// 강좌할인율
	private int coursePeriod;		// 수강가능기간(일수)
	private int courseStatus;		// 최초개설시비공개0,촬영중1,촬영완료2
	private Date createdAt;			// 강좌등록날짜
	private Date updatedAt;			// 강좌마지막수정날짜
	private Date beginDate;			// 공개시작날짜
	private Date endDate;			// 강좌촬영완료날짜(예정날짜)
	private int totalLectures;		// 총강의수
	private int memberNo;			// 자동부여
	private Member3 member;
}
