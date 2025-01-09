package com.ttt.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class CourseRegister3 {
	private int courseRegisterNo;  // 수강신청고유번호
	private Date courseRegisterDate; // 수강신청일
	private int progressRate;     // 학습진도율
	private Date lastViewTime;    // 마지막수강날짜
	private int completionStatus; // 수료상태
	private int courseNo;         // 강좌참조키
	private int courseScore;      // 수강평점
	private String reviewContent;  // 진도율80%이상만작성가능
	private int memberNo;         // 자동부여
	
	private Course3 course;
	private String teacherSubjectName;
	private String teacherName;
}