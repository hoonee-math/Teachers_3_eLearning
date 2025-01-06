package com.ttt.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

//인증 결과를 담을 클래스
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class EmailAuthenticationResult {

    private boolean success;
    private String message;
}
