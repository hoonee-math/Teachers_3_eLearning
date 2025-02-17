package com.ttt.dto;

import java.sql.Date;
import java.time.LocalDateTime;

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
	private LocalDateTime eventStart;
	private LocalDateTime eventEnd;
	private int lectureNo;
	private int courseNo;
	private String eventType;
	private int subjectCode;
	private int grade;
	private int eventStatus;
	private String videoUrl;
	private Date createdAt;
	
	// 연관 객체
	private Member3 member;
	private Lecture3 lecture;
	private Course3 course;

}
