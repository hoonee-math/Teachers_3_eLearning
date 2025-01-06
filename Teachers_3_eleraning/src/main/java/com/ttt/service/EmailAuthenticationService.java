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

public class EmailAuthenticationService {
    private static final int AUTH_NUMBER_LENGTH = 6;
    private static final int MAX_ATTEMPTS = 5;
    private static final int EXPIRY_MINUTES = 5;
    private MemberDao dao=new MemberDao();

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
        String subject = "이메일 인증번호";
        String content = "인증번호는 [" + authNumber + "] 입니다.";
        sender.sendEmail(email, subject, content);
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
    public int checkEmailDuplicate(String email) {
    	SqlSession session = new SqlSessionTemplate().getSession();
    	//MemberDao 의 메소드 이용해서 이메일 중복 체크해서 결과 유무 체크하기 count(*)
    	return dao.checkEmailDuplicate(session, email);
    }

}
