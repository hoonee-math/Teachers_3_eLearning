package com.ttt.dto;

import java.sql.Date;

public class Files3 {
	private int fileNo;            // 첨부파일고유번호
	private String oriname;        // 첨부파일명
	private String rename;         // 저장된파일명
	private Date createdAt;        // 자료추가날짜
	private int postNo;            // 게시글고유번호참조키
}
