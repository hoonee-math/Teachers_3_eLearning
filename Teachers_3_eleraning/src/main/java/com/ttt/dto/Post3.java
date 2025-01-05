package com.ttt.dto;

import java.sql.Date;

public class Post3 {
	private int postNo;           // 게시글고유번호
	private String postTitle;      // 게시글제목
	private String postContent;    // 게시글내용
	private int viewCount;        // 조회수
	private int likeCount;        // 좋아요수
	private int isNotice;         // 게시판상단고정여부
	private int isPublic;         // 기본값1공개/0비공개
	private int status;           // 공개:1,비공개:0
	private Date createdAt;       // 자동부여
	private Date updatedAt;       // 자동부여
	private int memberNo;         // 자동부여
	private int parentPostNo;     // 답글인경우원글NO
	private int boardCategoryNo;  // 1,2,3,4,5나중에추가가능
}
