package com.ttt.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class School12 {
	private int schoolNo; /* 키값으로 사용하기 위해 새로 부여해준 번호 */
	private String region;
	private String district;
	private String schoolName;
	private int schoolType; /* 3:고등학교 4:기타학교 */ 
	private String regionCode; /* 지역 교육청 표준 코드 */
	private int standardCode; /* 학교 표준 코드 중복되는 경우가 있음 */

}
