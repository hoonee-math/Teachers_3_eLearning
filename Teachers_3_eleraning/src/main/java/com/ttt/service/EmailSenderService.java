package com.ttt.service;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

// 이메일 정보를 호출해서 메일을 보내주는 서비스, 실제 이메일 전송을 담당하는 서비스 클래스 (SMTP 설정 및 메일 발송 처리)
public class EmailSenderService {
    private Properties emailProps;

    public EmailSenderService() {
        loadProperties();
    }

    //email.properties 에 보안 정보 저장해서 호출해서 사용하기
    private void loadProperties() {
        try {
            emailProps = new Properties();
            String path = EmailSenderService.class.getResource("/email.properties").getPath();
            emailProps.load(new FileInputStream(path));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    public void sendEmail(String to, String subject, String content) throws MessagingException {
    	Properties props = new Properties();
        props.put("mail.smtp.host", emailProps.getProperty("mail.smtp.host"));
        props.put("mail.smtp.port", emailProps.getProperty("mail.smtp.port"));
        props.put("mail.smtp.auth", emailProps.getProperty("mail.smtp.auth"));
        props.put("mail.smtp.starttls.enable", emailProps.getProperty("mail.smtp.starttls.enable"));

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(
                    emailProps.getProperty("mail.username"),
                    emailProps.getProperty("mail.password")
                );
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(emailProps.getProperty("mail.username")));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject);
        message.setText(content);

        Transport.send(message);
    }

}
