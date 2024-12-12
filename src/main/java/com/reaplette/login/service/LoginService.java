package com.reaplette.login.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.reaplette.domain.UserVO;
import com.reaplette.login.mappers.LoginMapper;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
//import software.amazon.awssdk.regions.Region;
//import software.amazon.awssdk.services.ses.model.*;
//import software.amazon.awssdk.services.ses.SesClient;
//import org.mindrot.jbcrypt.BCrypt; // 비밀번호 해시화

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.util.*;
import java.util.stream.Collectors;


@Log4j2
@Transactional
@RequiredArgsConstructor
@Service
public class LoginService {

    private final LoginMapper loginMapper;
//    private final HttpSession session;

    // SMTP 설정값 주입
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

    // 네이버 API 설정값 주입
    @Value("${naver.client.id}")
    private String clientId;

    @Value("${naver.client.secret}")
    private String clientSecret;

    @Value("${naver.redirect.uri}")
    private String redirectUri;

//    // 생성자 주입
//    public LoginService(LoginMapper loginMapper, HttpSession session) {
//        this.loginMapper = loginMapper;
//        this.session = session;
//    }

    // 이메일로 사용자 조회
    public UserVO getUserById(String id) {
        return loginMapper.getUserById(id);
    }

    // id와 idKey로 조회
    public UserVO getUserByIdAndIdKey(String id, String idKey) {
        UserVO user = loginMapper.getUserByIdAndIdKey(id, idKey);
        if (user == null) {
            log.warn("id와 idKey가 일치하지 않음: id={}, idKey={}", id, idKey);
        }
        return user;
    }

    // 네이버 가입자 조회
    public Boolean isNaver(String id) {
        return loginMapper.isNaver(id);
    }

    // 네이버 로그인 URL 생성
    public String getNaverLoginUrl(String state) {
        return "https://nid.naver.com/oauth2.0/authorize?response_type=code"
                + "&client_id=" + clientId
                + "&redirect_uri=" + URLEncoder.encode(redirectUri, StandardCharsets.UTF_8)
                + "&state=" + state;
    }

    // 네이버 로그인 state 생성
    public String generateState(HttpSession session) {
        String state = UUID.randomUUID().toString();
        session.setAttribute("naverState", state);
        return state;
    }

    // 네이버 API로 Access Token 요청 및 state 검증
    public String getNaverAccessToken(String code, String receivedState, HttpSession session) throws Exception {
        String sessionState = (String) session.getAttribute("naverState");
        if (sessionState == null || !sessionState.equals(receivedState)) {
//            log.error("State mismatch: received={}, session={}", receivedState, sessionState);
            throw new IllegalStateException("Invalid state parameter");
        }

        String tokenUrl = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
                + "&client_id=" + clientId
                + "&client_secret=" + clientSecret
                + "&code=" + code
                + "&state=" + receivedState;

        HttpURLConnection connection = (HttpURLConnection) new URL(tokenUrl).openConnection();
        connection.setRequestMethod("GET");

        try (BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()))) {
            String response = br.lines().collect(Collectors.joining());
            log.info("Access Token 응답: {}", response);

            Map<String, Object> tokenData = new ObjectMapper().readValue(response, Map.class);
            if (tokenData.containsKey("error")) {
                throw new IllegalStateException("Access Token 요청 실패");
            }
            return (String) tokenData.get("access_token");
        }
    }

    // 네이버 API로 사용자 정보 요청
    public Map<String, Object> getNaverUserInfo(String accessToken) throws Exception {
        String apiUrl = "https://openapi.naver.com/v1/nid/me";

        HttpURLConnection connection = (HttpURLConnection) new URL(apiUrl).openConnection();
        connection.setRequestMethod("GET");
        connection.setRequestProperty("Authorization", "Bearer " + accessToken);

        try (BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()))) {
            String response = br.lines().collect(Collectors.joining());
//            log.info("사용자 정보 응답: {}", response);

            Map<String, Object> user = new ObjectMapper().readValue(response, Map.class);
            if (user.containsKey("error")) {
//                log.error("사용자 정보 요청 실패: {}", user.get("error_description"));
                throw new IllegalStateException("사용자 정보 요청 실패");
            }
            return (Map<String, Object>) user.get("response");
        }
    }

    /*
    // 사용자 이메일 추출
    public String extractEmail(Map<String, Object> user) {
        String email = (String) user.get("email");
        if (email == null || email.isEmpty()) {
            String naverId = (String) user.get("id");
            email = naverId + "@naver.com";
            log.info("네이버 사용자 이메일 생성: {}", email);
        }
        return email;
    }

    // 입력된 이메일을 네이버 고유 ID로 변환
    public UserVO getUserByEmailOrEncodedId(String inputEmail) {
        String decodedId = decodeEmailToNaverId(inputEmail);

        if (decodedId != null) {
            return loginMapper.getUserById(decodedId); // 네이버 `id`로 검색
        }
        return loginMapper.getUserById(inputEmail); // 일반 이메일로 검색
    }

    private String decodeEmailToNaverId(String encodedEmail) {
        if (!encodedEmail.endsWith("@naver.com")) {
            return null; // 인코딩된 네이버 ID 이메일 형식이 아님
        }
        String encodedPart = encodedEmail.split("@")[0];
        return new String(Base64.getUrlDecoder().decode(encodedPart), StandardCharsets.UTF_8);
    }
    */

    // 로그인 정보를 세션에 저장
    public void saveUserInfoToSession(Map<String, Object> user, HttpSession session) {
        if (session.getAttribute("id") == null) {
            log.error("이메일(ID)이 세션에 없습니다. 이전 단계에서 이메일이 제대로 저장되지 않았습니다.");
            return;
        }
        session.setAttribute("idKey", user.get("id")); // 네이버 고유 ID 저장
        session.setAttribute("username", user.get("nickname"));
        session.setAttribute("profileImagePath", user.get("profile_image"));
        session.setAttribute("loginType", "naver");
        log.info("세션에 사용자 정보 저장: {}", user);
    }

    // 로그인 시도 제한 및 비밀번호 검증 -- 해시화는 나중에 고려
    public boolean validatePassword(String id, String pw, HttpSession session) {
        final int MAX_ATTEMPTS = 10;  // 최대 로그인 시도 횟수
        final long LOCK_TIME = 300000; // 5분 잠금
        // 로그인 시도 횟수 및 제한 시간
        Integer attemptCount = (Integer) session.getAttribute("attemptCount");
        Long lockStartTime = (Long) session.getAttribute("lockStartTime");

        if (lockStartTime != null && System.currentTimeMillis() - lockStartTime > LOCK_TIME) {
            attemptCount = 0; // 제한 해제
            session.removeAttribute("lockStartTime");
        }

        if (id == null || pw == null || pw.trim().isEmpty()) {
            return false; // 유효하지 않은 입력
        }

        // 비밀번호 검증
        boolean isPasswordValid = loginMapper.validatePassword(id, pw);
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
        user.setPw(tempPassword);

        if (loginMapper.updatePassword(user) == 0) {
//            log.error("비밀번호 업데이트 실패");
            return 0;
        } else {
//            log.info("비밀번호 업데이트 성공");
        }
        sendTemporaryPasswordEmail(user.getId(), tempPassword);
//        log.info("임시 비밀번호 이메일 발송 성공: ID={}", user.getId());

        return 1;
    }

    @Async
    // 네이버 SMTP로 임시 비밀번호 발송
    public void sendTemporaryPasswordEmail(String id, String tempPassword) {
//        log.info("sendTemporaryPasswordEmail - - -");

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
                        <p>안녕하세요.</p>
                        <p>귀하의 임시 비밀번호는 <strong>%s</strong> 입니다.</p>
                        <p>로그인 후 반드시 비밀번호를 변경하세요.</p>
                        <p>감사합니다.</p>
                    </body>
                    </html>
                    """.formatted(tempPassword);
            message.setContent(content, "text/html; charset=utf-8");

            // 이메일 전송
            Transport.send(message);
            System.out.println("Sending email to: " + id + " with tempPassword: " + tempPassword);

        } catch (MessagingException e) {
//            log.error("임시 비밀번호 이메일 전송 실패", e);
            throw new RuntimeException("이메일 발송 실패", e);
        }
    }

}
