package com.ttt.dto;

import java.sql.Date;

public class Video3 {
	private int lectureNo;         // 강의고유번호
	private String oriname;        // 영상오리지널파일명
	private String rename;         // 영상저장된파일명
	private Date createdAt;        // 영상자료등록날짜
	private int isDeleted; //삭제여부, 삭제0, 기본1
}
