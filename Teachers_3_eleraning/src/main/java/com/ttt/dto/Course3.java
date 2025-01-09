package com.ttt.dto;

import java.sql.Date;
import java.util.List;

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

	private List<Lecture3> lectures;

    // 교사 정보 연관 관계 추가
	private Member3 member;  // 교사 정보 포함
    private String teacherSubject;  // 교사 과목
    private String teacherSubjectName;  // 교사 과목
    private String teacherName;     // 교사 이름
	
	// 조회 결과를 담기 위한 추가 필드들
	private int totalCount; 		// 전체 강좌 수
	private int preparingCount; 	// 준비중인 강좌 수
	private int inProgressCount; 	// 진행중인 강좌 수
	private int completedCount; 	// 완료된 강좌 수
	
	// 카테고리를 join 해서 사용할 정보들
	private String courseCategoryTitle;
	private String courseCategoryDesc;
}
