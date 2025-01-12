package com.ttt.service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Random;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import com.ttt.common.SqlSessionTemplate;
import com.ttt.dao.MemberDao;
import com.ttt.dto.EmailAuthenticationResult;
import com.ttt.dto.Member3;

public class EmailAuthenticationService {
	private static final int AUTH_NUMBER_LENGTH = 6;
	private static final int MAX_ATTEMPTS = 5;
	private static final int EXPIRY_MINUTES = 5;
	private MemberDao dao=new MemberDao();

	// Base64 인코딩된 로고 이미지 상수
	private static final String LOGO_BASE64 = "data:image/jpeg;base64,iVBORw0KGgoAAAANSUhEUgAAAt8AAAD5CAMAAADIvqn0AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAKmUExURQAAAO+rNPCsN/CtN/CuN++rNvCrNfCrNvCsNvCsN++pNPCrNe+nNO+qNfCqNe+qNO+pNO+pNe+oNO+oNO2lMu+nM++rOO+jNO+mM++jMO+mMe+mMu+mM+2jMu+lMu+kMe+kMuujMO6jMe6jMeufMO6jMO6jMO+nNO2fMO6iMO+jMe6iL+6hL+6hMO6gL+6gL+2dLu6fLu6eLuubLO6eLe6eLe2dLeubLO2cLO6bLO6fL+uXLO6aK+2aK+2bK+2bLOuZKuuXKu2ZKuuXKO6YKe2YKuyXKe2XKe2YKeuVKOyXKeuTKOyWKOyWKOyVKOuTJuyUJ+yVJ+2eLeuRJuyTJuyTJ+uPJOySJeySJumPJOyRJeySJeuQJOuQJeuRJeuPJOuPJOuQJOuOI+uOI+mNIuyUJ+uTKOuLIOuOIeuNI+uOJOuMIeuMIuuNIuuTJO2jMOuLIeuLIeuRJOmJIOuLIuuSJeyWJ+2hMOqKIeqLIeqKIOqKIemNJOqKIO+pNuqJIOuLJOufLO6aKeuXKOeDHOeDHOeAGOd+GumLIu6fLe6dLe2dLOyTJeqIIOqIH+qHH+qHHeqGHemFHuqEHemEHemDHOeBHOp/Gel/Gul/Ged+GOqLIemHHuqIIO6iMOuPJOqIH+qHH+qHHuqGHuqFHul+Ge+nM+2pNOeHIOqFHemCHOeAHOh+Geh9GeyRJuuQJemCG+qCG+h9GOd8GO2nNOmHIOmBG+h8GOd8GOmJIumDHeqDHOeAGueHHO+kMe6gLumAG+h8F+mAGuqAGed8FuqEHeh7F+qAG+d6FuqEHOqCHOeLIOyWKep9GemEHOmDHuh9Geh8GOmDHOuPI+6cLOh7F+h8F+2fLu6bK+eBGuh9GOudLO6XKeuZLOyXKOyTJ+qGH+mBGhhR2cQAAADgdFJOUwBAv/+/gL////+A/0D//7///7//gP9AQL9Av///gP///0C//0C///+A//+///+//4D//0C///+A/7//QL////+AgP9Av/+///+A/0C///+A////gP//QL//gP//v///v///v/+Av4BAv///v///QIC//4CA/7+/gL//v/+A/4D/QEC/gECAQICAv/+Av7+/v7+/gL///4C///+Av4D/v4D///////+/gED//0D///+//7//QICA//+AgP+/gEC//////7+A//+/gL+/QP+//4C/v4C/v7+/gL+Av4C/gL+/jv+UsQAAAAlwSFlzAAAywAAAMsABKGRa2wAAJJdJREFUeF7tnfmjXVV1x59S62xtxVZxRBC1KiIiakEUmWdomMs8BRQsFBXIM8Xh8UAFQkJCBowypc1YSV4hqcQhCYFIFQGFCh1s/5OutfZ3nz2ec/a97953371vfX6Bu859J3f4vPXW2WvvfcYURVEURVEURVEURVEURVEURVEURVEURVEURVEURVEURVEURVEURVEURVEURVEURVEURVEURVEURVEURVEURVEURVEURVEURVEURVEURVEURVEURVEUZZbwqle/eq8/eQ0eKMpI8ao/fe3rXve61++1lxqujB5veOMbX/taY7jmcGXEeNOb3/yWt7DgZPjrX68pXBkl3vRnb/1zFrwyXIsUZWR401+87W1vfatnuJbhyuiw99vfxpDgYrhXpPwlnqEow8pfvePthDX8zb7hmsKVIeed+7zrXe9+tzU8KFLUcGXYec973/teFpwNtylcy3BlNHjn+973fhJcDK8tUnSsUBlK9v3Afu8j2PB3NRquKVwZOvb/4AEH7LcfG/5+Y7gpUj5kBNcyXBlqPvwRgg3/a6TwfBmuLXtlCNn/ox/72MdFcDLcFilahisjwf4HfuITHyPBjeFBkaJluDLsHPTJT36CYMNtkSKGZ4oUrwzXsUJlGDjo4E8yRnBneFCkNJTh2rJXZjGfOuTTn64E94oULcOV4edThxx66KeJnOF1ZbiOFSpDwmc++9nPHhoZHhQpWoYrQ8unPkd6i+Bs+MFi+N/EhgdFSlqGa5GizE4OO/zzRxzxhcBwm8LzZbiOFSrDwxc/TxzhGR4UKWJ4UKRoGa4MD0d+6UtfYsE5hYvhSOEdluHxzNnXqOHK4Dnq6GOOIcErw20KLy3Da4sULcOVgXPUsccdf/wxDYbbFK5luDJ8nHAicRwLzoZD8A7LcFOk6MxZZbZx0smnnHJKzvCSMjwoUpIy3GvZ4x9TlBnlpJNPPfVUEpwNP04Mry1SxHCkcDFcW/bKLOe0008/gwRnw4MULob7RcrfJkWKMbxurNAYrkWKMkDmnXnW6UTWcKTw4jI8U6R4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";
			
	// 인증번호 생성
	public String generateAuthNumber() {
		Random random = new Random();
		StringBuilder builder = new StringBuilder();
		for (int i = 0; i < AUTH_NUMBER_LENGTH; i++) {
			builder.append(random.nextInt(10));
		}
		return builder.toString();
	}

	// 인증번호 해시화
	public String hashAuthNumber(String authNumber) {
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-512");
			byte[] bytes = authNumber.getBytes();
			md.update(bytes);
			byte[] digest = md.digest();
			return Base64.getEncoder().encodeToString(digest);
		} catch(NoSuchAlgorithmException e) {
			throw new RuntimeException("해시 알고리즘 오류", e);
		}
	}

	// 이메일 전송
	public void sendAuthEmail(String email, String authNumber) 
		throws MessagingException {
		EmailSenderService sender = new EmailSenderService();
		String subject = "HoneyT 이메일 인증번호";
		
		// HTML 템플릿으로 인증번호 메시지 생성
		String htmlContent = getAuthEmailTemplate(authNumber);
		
		// HTML 이메일 발송
		sender.sendHtmlEmail(email, subject, htmlContent);
	}
	
	// 새로 추가된 HTML 템플릿 생성 함수
	private String getAuthEmailTemplate(String authNumber) {
		return String.format(
			"<!DOCTYPE html>" +
			"<html>" +
			"<head>" +
			"<meta charset='UTF-8'>" +
			"</head>" +
			"<body style='margin: 0; padding: 0; font-family: Arial, sans-serif;'>" +
			"<div style='max-width: 600px; margin: 0 auto; padding: 20px;'>" +
			"  <div style='text-align: center; margin-bottom: 20px;'>" +
			"	<img src='%s' alt='HoneyT Logo' style='width: 200px; height: auto;'/>" +
			"  </div>" +
			"  <div style='background-color: #FAB350; padding: 10px; text-align: center; border-radius: 10px 10px 0 0;'>" +
			"	<h1 style='color: white; margin: 0;'>이메일 인증</h1>" +
			"  </div>" +
			"  <div style='background-color: #ffffff; padding: 30px; border: 1px solid #e1e1e1; border-top: none; border-radius: 0 0 10px 10px;'>" +
			"	<p style='font-size: 16px; color: #333;'>안녕하세요,</p>" +
			"	<p style='font-size: 16px; color: #333;'>HoneyT 계정 인증을 위한 인증번호입니다.</p>" +
			"	<div style='background-color: #f8f9fa; padding: 20px; margin: 20px 0; text-align: center; border-radius: 5px;'>" +
			"	  <span style='font-size: 32px; font-weight: bold; color: #FAB350; letter-spacing: 3px;'>%s</span>" +
			"	</div>" +
			"	<p style='font-size: 14px; color: #666;'>인증번호는 5분간 유효합니다.</p>" +
			"	<p style='font-size: 14px; color: #666;'>요청하지 않은 인증번호라면 이 메일을 무시해주세요.</p>" +
			"  </div>" +
			"  <div style='text-align: center; margin-top: 20px;'>" +
			"	<p style='font-size: 12px; color: #999;'>문의사항이 있는 고객께서는 본 메일로 회신해 주세요.</p>" +
			"	<p style='font-size: 12px; color: #999;'>&copy; 2024 HoneyT. All rights reserved.</p>" +
			"  </div>" +
			"</div>" +
			"</body>" +
			"</html>",
			LOGO_BASE64,  // 로고 이미지 URL
			authNumber	// 인증번호
		);
	}

	// 세션에 인증 정보 저장
	public void setAuthenticationInfo(HttpSession session, String email, 
		String hashedAuthNumber) {
		session.setAttribute("hashedAuthNumber", hashedAuthNumber);
		session.setAttribute("authCreateTime", System.currentTimeMillis());
		session.setAttribute("email", email);
		session.setAttribute("failCount", 0);
		session.setMaxInactiveInterval(EXPIRY_MINUTES * 60);
	}

	// 인증번호 검증
	public EmailAuthenticationResult verifyAuthNumber(HttpSession session, 
		String inputAuthNumber) {
		Long authCreateTime = (Long) session.getAttribute("authCreateTime");
		Integer failCount = (Integer) session.getAttribute("failCount");
		String hashedAuthNumber = (String) session.getAttribute("hashedAuthNumber");

		if (authCreateTime == null || hashedAuthNumber == null) {
			return new EmailAuthenticationResult(false, "인증 정보가 없습니다.");
		}

		// 만료 시간 체크
		if (System.currentTimeMillis() - authCreateTime > 
			EXPIRY_MINUTES * 60 * 1000) {
			clearAuthenticationInfo(session);
			return new EmailAuthenticationResult(false, "인증번호가 만료되었습니다.");
		}

		// 실패 횟수 체크
		if (failCount != null && failCount >= MAX_ATTEMPTS) {
			clearAuthenticationInfo(session);
			return new EmailAuthenticationResult(false, "인증 시도 횟수를 초과했습니다.");
		}

		// 인증번호 검증
		String hashedInput = hashAuthNumber(inputAuthNumber);
		if (hashedAuthNumber.equals(hashedInput)) {
			return new EmailAuthenticationResult(true, "인증이 완료되었습니다.");
		} else {
			session.setAttribute("failCount", 
				(failCount == null ? 1 : failCount + 1));
			return new EmailAuthenticationResult(false, "인증번호가 일치하지 않습니다.");
		}
	}

	// 세션 정보 초기화
	public void clearAuthenticationInfo(HttpSession session) {
		session.removeAttribute("hashedAuthNumber");
		session.removeAttribute("authCreateTime");
		session.removeAttribute("failCount");
		session.removeAttribute("email");
	}
	
	// 이메일 중복 검사
	public Member3 checkEmailDuplicateByEmail(Member3 m) {
		SqlSession session = new SqlSessionTemplate().getSession();
		//MemberDao 의 메소드 이용해서 이메일 중복 체크해서 결과 유무 체크하기 count(*)
		return dao.checkEmailDuplicateByEmail(session, m);
	}
	// 회원 인증 by (이름, 이메일)
	public Member3 selectMemberByNameAndEmail(Member3 m) {
		SqlSession session = new SqlSessionTemplate().getSession();
		//MemberDao 의 메소드 이용해서 이메일 중복 체크해서 결과 유무 체크하기 count(*)
		return dao.selectMemberByNameAndEmail(session, m);
	}

}
