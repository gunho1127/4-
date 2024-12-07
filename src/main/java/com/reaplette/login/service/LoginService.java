package com.reaplette.login.service;

import com.reaplette.domain.UserVO;
import com.reaplette.login.mappers.LoginMapper;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import jakarta.servlet.http.HttpSession;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
//import software.amazon.awssdk.regions.Region;
//import software.amazon.awssdk.services.ses.model.*;
//import software.amazon.awssdk.services.ses.SesClient;
//import org.mindrot.jbcrypt.BCrypt; // 비밀번호 해시화

import java.security.SecureRandom;
import java.util.Collections;
import java.util.List;
import java.util.Properties;
import java.util.stream.Collectors;

@Service
@Log4j2
public class LoginService {

    private final LoginMapper loginMapper;
    private final HttpSession session;

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

    // 생성자 주입
    public LoginService(LoginMapper loginMapper, HttpSession session) {
        this.loginMapper = loginMapper;
        this.session = session;
    }

    // 이메일로 사용자 조회
    public UserVO getUserById(String id) {
        return loginMapper.getUserById(id);
    }

    // 로그인 시도 제한 및 비밀번호 검증 -- 해시화는 나중에 고려하기
    public boolean validatePassword(String id, String pw, HttpSession session) {
        if (id == null || pw == null || pw.trim().isEmpty()) {
            return false; // 유효하지 않은 입력
        }

        // 비밀번호 검증
        boolean isPasswordValid = loginMapper.validatePassword(id, pw);

        // 로그인 시도 횟수 및 제한 시간 정보 가져오기
        Integer attemptCount = (Integer) session.getAttribute("attemptCount");
        Long lockStartTime = (Long) session.getAttribute("lockStartTime");

        final int MAX_ATTEMPTS = 10;  // 최대 로그인 시도 횟수
        final long LOCK_TIME = 300000; // 5분 잠금

        if (lockStartTime != null && System.currentTimeMillis() - lockStartTime > LOCK_TIME) {
            attemptCount = 0; // 제한 해제
            session.removeAttribute("lockStartTime");
        }

        if (!isPasswordValid) {
            if (attemptCount == null) attemptCount = 0;
            attemptCount++;
            session.setAttribute("attemptCount", attemptCount);

            if (attemptCount >= MAX_ATTEMPTS) {
                session.setAttribute("lockStartTime", System.currentTimeMillis());
            }
            return false;
        }

        session.setAttribute("attemptCount", 0); // 성공 시 시도 횟수 초기화
        return true;
    }

    // 임시 비밀번호 생성
    public String generateTemporaryPassword() {
        SecureRandom random = new SecureRandom();
        int passwordLength = random.nextInt(13) + 8; // 8자 이상 20자 이하 랜덤 길이
        String upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String lowerCase = "abcdefghijklmnopqrstuvwxyz";
        String digits = "0123456789";
        String specialChars = "!@#$%^&*()-_+=<>?";
        String allChars = upperCase + lowerCase + digits + specialChars;

        StringBuilder password = new StringBuilder();

        // 필수 구성 요소 포함
        password.append(upperCase.charAt(random.nextInt(upperCase.length())));
        password.append(lowerCase.charAt(random.nextInt(lowerCase.length())));
        password.append(digits.charAt(random.nextInt(digits.length())));
        password.append(specialChars.charAt(random.nextInt(specialChars.length())));

        // 나머지 랜덤 생성
        for (int i = 4; i < passwordLength; i++) {
            password.append(allChars.charAt(random.nextInt(allChars.length())));
        }

        // 비밀번호 섞기 (순서를 랜덤화)
        return shufflePassword(password.toString(), random);
    }

    // 비밀번호 문자 섞기
    private String shufflePassword(String pw, SecureRandom random) {
        List<Character> characters = pw.chars()
                .mapToObj(c -> (char) c)
                .collect(Collectors.toList());
        Collections.shuffle(characters, random);
        StringBuilder shuffledPassword = new StringBuilder();
        for (char c : characters) {
            shuffledPassword.append(c);
        }
        return shuffledPassword.toString();
    }

    // 비밀번호 재설정 및 이메일 발송 처리
    public int resetPasswordAndSendEmail(String id) {
        UserVO user = loginMapper.getUserById(id);

        if (user == null) {
            throw new IllegalArgumentException("해당 사용자 정보를 찾을 수 없습니다.");
        }

        // 임시 비밀번호 생성
        String tempPassword = generateTemporaryPassword();

        // 비밀번호 DB 업데이트
//        try {
        user.setPw(tempPassword);

        if (loginMapper.updatePassword(user) == 0) {
            log.error("비밀번호 업데이트 실패");
            return 0;
        } else {
            log.info("비밀번호 업데이트 성공");
        }

        sendTemporaryPasswordEmail(user.getId(), tempPassword);

        log.info("임시 비밀번호 이메일 발송 성공: ID={}", user.getId());


//        } catch (Exception e) {
//            log.error("비밀번호 재설정 및 이메일 발송 실패: {}", e.getMessage());
//
//        }
        return 1;
    }

    @Async
    // 네이버 SMTP로 임시 비밀번호 발송
    public void sendTemporaryPasswordEmail(String id, String tempPassword) {
        log.info("sendTemporaryPasswordEmail - - -");
//        log.info(smtpHost);
//        log.info(smtpPort);
//        log.info(smtpAuth);
//        log.info(smtpSsl);

        // SMTP 설정
        Properties props = new Properties();
        props.put("mail.smtp.host", smtpHost);
        props.put("mail.smtp.port", smtpPort);
        props.put("mail.smtp.auth", smtpAuth);
        props.put("mail.smtp.ssl.enable", smtpSsl);
//        props.put("mail.smtp.starttls.enable", "true"); // TLS 활성화



        // 인증 객체 생성
        Session mailSession = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        try {
            // 이메일 작성
            MimeMessage message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(senderEmail));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(id)); // 수신자 이메일
            message.setSubject("[REAPLETTE] 임시 비밀번호 안내");

            // 이메일 본문 작성
            String content = """
                    <html>
                    <body>
                        <h2>임시 비밀번호 발급 안내</h2>
                        <p>안녕하세요,</p>
                        <p>귀하의 임시 비밀번호는 <strong>%s</strong> 입니다.</p>
                        <p>로그인 후 반드시 비밀번호를 변경하세요.</p>
                        <p>감사합니다.</p>
                    </body>
                    </html>
                    """.formatted(tempPassword);
            message.setContent(content, "text/html; charset=utf-8");

            // 이메일 전송
            Transport.send(message);
            // log.info("임시 비밀번호 이메일 전송 성공");

        } catch (MessagingException e) {
            log.error("임시 비밀번호 이메일 전송 실패", e);
            throw new RuntimeException("이메일 발송 실패", e);
        }
    }

    public boolean isNaver(String id) {
        log.info("isNaver - - -");
        return loginMapper.isNaver(id);
    }
}

    /* 임시 비밀번호 이메일 발송 (AWS SES)
    private void sendTemporaryPasswordEmail(String id, String tempPassword) {
        Region region = Region.AP_NORTHEAST_2; // 서울 리전
        SesClient sesClient = SesClient.builder()
                .region(region)
                .build();

        try {
            // 이메일 내용 구성
            String subject = "Your Temporary Password";
            String body = "Hello,\n\nYour temporary password is: " + tempPassword +
                    "\n\nPlease log in and reset your password immediately.";

            // SES 요청 생성
            SendEmailRequest emailRequest = SendEmailRequest.builder()
                    .source("your_verified_email@example.com") // AWS SES에 인증된 발신 이메일
                    .destination(Destination.builder()
                            .toAddresses(id) // 수신 이메일
                            .build())
                    .message(Message.builder()
                            .subject(Content.builder().data(subject).build()) // 제목
                            .body(Body.builder()
                                    .text(Content.builder().data(body).build()) // 본문
                                    .build())
                            .build())
                    .build();

            // 이메일 발송
            sesClient.sendEmail(emailRequest);
            System.out.println("Email sent successfully to " + id);
        } catch (SesException e) {
            System.err.println("Email failed: " + e.awsErrorDetails().errorMessage());
            throw new RuntimeException("이메일 발송에 실패했습니다.", e);
        } finally {
            sesClient.close();
        }
    } */


    /*
        // 인증 코드 생성 및 세션에 저장
        public void sendVerificationCodeWithSession (String id){
            String verificationCode = generateVerificationCode();  // 인증 코드 생성

            // 세션에 인증 코드 저장
            session.setAttribute("verificationCode", verificationCode);
            session.setAttribute("verificationCodeEmail", id);

            // 인증 코드 이메일 발송 (AWS SES로 이메일 보내는 로직이 이곳에 포함)
            sendVerificationCodeEmail(id, verificationCode);
        }

        // 6자리 인증 코드 생성 (보안 강화)
        private String generateVerificationCode () {
            SecureRandom random = new SecureRandom();  // 보안성을 강화한 랜덤 생성기
            return String.format("%06d", random.nextInt(1000000));  // 6자리 랜덤 인증 코드 생성
        }

        // 인증 코드 확인
        public boolean validateVerificationCode (String inputCode, String id){
            String storedCode = (String) session.getAttribute("verificationCode");
            String storedEmail = (String) session.getAttribute("verificationCodeEmail");

            // 인증 코드와 이메일을 비교
            if (storedCode != null && storedCode.equals(inputCode) && storedEmail != null && storedEmail.equals(id)) {
                return true;  // 코드 일치
            }
            return false;  // 코드 불일치
        }
    }
    */
