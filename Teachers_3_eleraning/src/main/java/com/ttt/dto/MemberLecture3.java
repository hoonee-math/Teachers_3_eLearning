package com.ttt.dto;

import java.sql.Date;

public class MemberLecture3 {
	private int lectureNo;         // 강의고유번호
	private int memberNo;          // 자동부여
	private int complete;          // 수강완료여부
	private int stopAt;            // 마지막재생위치
	private Date currentViewDate; //최근시청날짜
	private double LECTURE_PER; //강의 진행률

}
