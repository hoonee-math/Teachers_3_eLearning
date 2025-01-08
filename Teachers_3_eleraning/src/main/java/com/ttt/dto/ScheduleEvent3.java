package com.ttt.dto;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ScheduleEvent3 {
	private int eventNo;
	private String calendarId;
	private String eventCategory; // 기본값 'time'
	private String eventTitle;
	private Timestamp eventStart;
	private Timestamp eventEnd;
	private int lectureNo;
	private int courseNo;
	private int memberNo;
	private String eventType;
	private int subjectCode;
	private int grade;
	private int eventStatus;
	private String videoUrl;
	private Date createdAt;
	
	// 연관 객체
	private Lecture3 lecture;
	private Course3 course;

}
