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
public class Image3 {
	private int imgNo;
	private int imgType;
	private String oriname;
	private String Renamed;
	private Date creatdAt;
	private int memberNo;
	private int imgOrder;
}
