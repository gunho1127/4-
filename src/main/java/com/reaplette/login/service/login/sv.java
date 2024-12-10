package com.reaplette.login.service.login;/*
package com.reaplette.login.service;

import com.reaplette.domain.UserVO;
import com.reaplette.login.mappers.LoginMapper;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import jakarta.servlet.http.HttpSession;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.ses.model.*;
import software.amazon.awssdk.services.ses.SesClient;
// import org.mindrot.jbcrypt.BCrypt; -- 비밀번호 해시화


import java.security.SecureRandom;

@Service
@Log4j2
public class LoginService {

    private final LoginMapper loginMapper;
    private final HttpSession session;

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
    public boolean validatePassword(UserVO user, String pw, HttpSession session) {

        if (user == null || pw == null || pw.trim().isEmpty()) {
            return false; // 유효하지 않은 입력
        }

        // 로그인 시도 횟수 및 제한 시간 정보 가져오기
        Integer attemptCount = (Integer) session.getAttribute("attemptCount");
        Long lockStartTime = (Long) session.getAttribute("lockStartTime");
        final int MAX_ATTEMPTS = 10;  // 최대 로그인 시도 횟수
        final long LOCK_TIME = 300000; // 5분 잠금

        // 초기화
        if (attemptCount == null) {
            attemptCount = 0; // 초기화된 로그인 시도 횟수
        }

        // 제한 시간이 지났는지 확인
        if (lockStartTime != null && System.currentTimeMillis() - lockStartTime > LOCK_TIME) {
            attemptCount = 0; // 제한 해제
            session.removeAttribute("lockStartTime"); // 제한 시간 정보 제거
        }

        // 로그인 시도 횟수 초과 시 제한
        if (attemptCount >= MAX_ATTEMPTS) {
            if (lockStartTime == null) {
                session.setAttribute("lockStartTime", System.currentTimeMillis()); // 제한 시작 시간 설정
            }
            return false; // 제한 상태 반환
        }

        // 비밀번호 검증
        boolean isPasswordValid = pw.equals(user.getPw()); // 평문 비밀번호 비교

        if (isPasswordValid) { // 비밀번호가 맞을 경우
            session.setAttribute("attemptCount", 0); // 성공 시 시도 횟수 초기화
            return true;
        } else { // 비밀번호가 틀릴 경우
            attemptCount++;
            session.setAttribute("attemptCount", attemptCount); // 실패 시 시도 횟수 증가
        }

        return false; // 비밀번호 검증 실패 반환
    }

    // 비밀번호 재설정 및 임시 비밀번호 발송
    public void resetPasswordAndSendEmail(String id) {
        UserVO user = loginMapper.getUserById(id);
        if (user == null) {
            throw new IllegalArgumentException("존재하지 않는 사용자입니다.");
        }

        // 임시 비밀번호 생성
        String tempPassword = generateTemporaryPassword();

        // 기존 비밀번호 필드에 임시 비밀번호 저장
        user.setPw(tempPassword);
        loginMapper.updatePassword(user);

        // 이메일로 임시 비밀번호 발송
        sendTemporaryPasswordEmail(id, tempPassword);
    }

    // 임시 비밀번호 생성
    private String generateTemporaryPassword() {
        SecureRandom random = new SecureRandom();
        int passwordLength = 8;
        String charSet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%";
        StringBuilder password = new StringBuilder(passwordLength);
        for (int i = 0; i < passwordLength; i++) {
            password.append(charSet.charAt(random.nextInt(charSet.length())));
        }
        return password.toString();
    }

    // 임시 비밀번호 이메일 발송
    private void sendTemporaryPasswordEmail(String id, String tempPassword) {
        try {
            SesClient sesClient = SesClient.builder()
                    .region(Region.of("ap-northeast-2"))
                    .build();

            SendEmailRequest request = SendEmailRequest.builder()
                    .source("reaplette@example.com")
                    .destination(Destination.builder()
                            .toAddresses(id)
                            .build())
                    .message(Message.builder()
                            .subject(Content.builder().data("Your Temporary Password").build())
                            .body(Body.builder()
                                    .text(Content.builder().data("Your temporary password is: " + tempPassword).build())
                                    .build())
                            .build())
                    .build();

            sesClient.sendEmail(request);
        } catch (Exception e) {
            log.error("AWS SES 이메일 발송 실패", e);
            throw new RuntimeException("이메일 발송에 실패했습니다.");
        }
    }
}

























    // 인증 코드 생성 및 세션에 저장
    public void sendVerificationCodeWithSession(String id) {
        String verificationCode = generateVerificationCode();  // 인증 코드 생성

        // 세션에 인증 코드 저장
        session.setAttribute("verificationCode", verificationCode);
        session.setAttribute("verificationCodeEmail", id);

        // 인증 코드 이메일 발송 (AWS SES로 이메일 보내는 로직이 이곳에 포함)
        sendEmailUsingAWS(id, verificationCode);
    }

    // 6자리 인증 코드 생성 (보안 강화)
    private String generateVerificationCode() {
        SecureRandom random = new SecureRandom();  // 보안성을 강화한 랜덤 생성기
        return String.format("%06d", random.nextInt(1000000));  // 6자리 랜덤 인증 코드 생성
    }

    // 이메일 발송 (AWS SES)
    private void sendEmailUsingAWS(String id, String code) {
        try {
            // AWS SES 연동 코드 작성 (서울 리전 설정)
            SesClient sesClient = SesClient.builder() // AWS SES 클라이언트 생성
                    .region(Region.of("ap-northeast-2"))
                    .build();

            // 이메일 메시지 구성
            SendEmailRequest request = SendEmailRequest.builder()
                    .source("reaplette@example.com") // 발신 이메일 주소
                    .destination(Destination.builder()
                            .toAddresses(id) // 수신자 이메일 주소
                            .build())
                    .message(Message.builder()
                            .subject(Content.builder().data("Your verification code").build()) // 제목
                            .body(Body.builder()
                                    .text(Content.builder().data("Your verification code is: " + code).build()) // 본문
                                    .build())
                            .build())
                    .build();

            // 이메일 발송
            sesClient.sendEmail(request);
            System.out.println("AWS SES를 통해 인증 코드 [" + code + "]가 이메일 [" + id + "]로 발송되었습니다.");
        } catch (Exception e) {
            log.error("AWS SES 이메일 발송 실패", e);
            throw new RuntimeException("이메일 발송에 실패했습니다.");
        }
    }

    // 인증 코드 확인
    public boolean validateVerificationCode(String inputCode, String id) {
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
