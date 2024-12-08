package com.reaplette.signup.service;

import com.reaplette.signup.mappers.SignUpMapper;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.security.SecureRandom;
import java.util.Properties;

@RequiredArgsConstructor
@Service
public class SignUpService {

    private final SignUpMapper signUpMapper;

    // application.properties에서 SMTP 설정값 주입
    @Value("${spring.mail.username}")
    private String senderEmail;

    @Value("${spring.mail.password}")
    private String senderPassword;

    @Value("${spring.mail.host}")
    private String smtpHost;

    @Value("${spring.mail.port}")
    private String smtpPort;

    @Value("${spring.mail.properties.mail.smtp.auth}")
    private String smtpAuth;

    @Value("${spring.mail.properties.mail.smtp.ssl.enable}")
    private String smtpSsl;


    public String generateVerificationCode () {
        SecureRandom random = new SecureRandom();  // 보안성을 강화한 랜덤 생성기
        return String.format("%06d", random.nextInt(1000000));  // 6자리 랜덤 인증 코드 생성
    }

    public void sendVerificationEmail(String id, String code) {
        // SMTP 설정
        Properties props = new Properties();
        props.put("mail.smtp.host", smtpHost);
        props.put("mail.smtp.port", smtpPort);
        props.put("mail.smtp.auth", smtpAuth);
        props.put("mail.smtp.ssl.enable", smtpSsl);

        // 인증 객체 생성
        Session mailSession = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        try {
            // 이메일 작성
            MimeMessage message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(senderEmail));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(id)); // 수신자 이메일
            message.setSubject("[REAPLETTE] 회원가입 인증코드");

            // 이메일 본문 작성
            String content = """
                    <html>
                    <body>
                        <h2>회원가입 인증코드 안내</h2>
                        <p>안녕하세요,</p>
                        <p>귀하의 인증코드는 <strong>%s</strong> 입니다.</p>
                        <p>유효 시간은 5분입니다.</p>
                        <p>감사합니다.</p>
                    </body>
                    </html>
                    """.formatted(code);
            message.setContent(content, "text/html; charset=utf-8");

            // 이메일 전송
            Transport.send(message);
            System.out.println("Sending email to: " + id + " with code: " + code);
        } catch (MessagingException e) {
            System.err.println("인증코드 전송 실패 " + e.getMessage());
            throw new RuntimeException("이메일 발송 실패", e);
        }
    }

    // 세션에 인증코드 저장
    public void saveVerificationCodeToSession(String id, String code, HttpSession session) {
        session.setAttribute("verificationCode", code);
        session.setAttribute("verificationCodeEmail", id);
        System.out.println("세션에 인증코드 저장: ID=" + id + ", Code=" + code);
    }

    // 세션에서 인증코드 검증
    public boolean validateVerificationCode(String id, String inputCode, HttpSession session) {
        String sessionCode = (String) session.getAttribute("verificationCode");
        String sessionEmail = (String) session.getAttribute("verificationCodeEmail");
        Long expirationTime = (Long) session.getAttribute("verificationCodeExpiration");

        if (sessionCode == null || sessionEmail == null || expirationTime == null) {
            System.out.println("세션 정보가 유효하지 않습니다.");
            return false;
        }

        // 유효 시간 초과 확인
        if (System.currentTimeMillis() > expirationTime) {
            System.out.println("인증코드가 만료되었습니다.");
            return false;
        }

        boolean isValid = sessionEmail.equals(id) && sessionCode.equals(inputCode);
        System.out.println("인증코드 검증 결과: " + isValid);
        return isValid;
    }

    // 인증 성공 후 세션에서 인증코드 제거
    public void removeVerificationCodeFromSession(HttpSession session) {
        session.removeAttribute("verificationCode");
        session.removeAttribute("verificationCodeEmail");
        session.removeAttribute("verificationCodeExpiration");
        System.out.println("세션에서 인증코드 제거 완료.");
    }
}
