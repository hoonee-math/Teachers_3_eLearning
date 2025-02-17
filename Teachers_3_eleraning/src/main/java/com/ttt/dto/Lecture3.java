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
public class Lecture3 {
	private int lectureNo;         // 강의고유번호
	private String lectureTitle;   // 강의제목
	private int lectureOrder;      // 강의순서(차시)
	private int lectureDuration;   // 강의재생시간(길이)
	private String lectureDesc;    // 강의요약설명 
	private char lectureStatus;    // 공개:1 비공개또는삭제:2
	private Date createdAt;        // 강의등록날짜
	private Date updatedAt;        // 강의최종수정날짜
	private int courseNo;          // 연결된강좌번호
	
	private ScheduleEvent3 scheduleEvent; // 이벤트 연결 객체
	private LocalDateTime eventStart;
	private LocalDateTime eventEnd;
}
