package com.reaplette.signup.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.reaplette.domain.PreferenceVO;
import com.reaplette.domain.UserVO;
import com.reaplette.signup.service.SignUpService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Log4j2
@Controller
@RequiredArgsConstructor
@RequestMapping("/signup")
public class SignUpController {

    @Autowired
    SignUpService signUpService;

    @GetMapping("/verifyEmail")
    public String showVerifyEmail(HttpSession session) {
        signUpService.checkAndInvalidateExpiredCode(session); // 인증번호 만료 확인
        String id = (String) session.getAttribute("id"); // 세션에 저장된 아이디 확인
        String verificationCode = (String) session.getAttribute("verificationCode");

        if (id == null) {
            id = "example@email.com"; // 디버깅용
            session.setAttribute("id", id); // 아이디 세션에 저장
        }

        log.info("세션에서 가져온 사용자 정보: id={}", id);
        return "signup/verifyEmail";
    }

    @PostMapping("/resendVerification") // 경로 signup/signup/ 경로 겹치면 오류
    public ResponseEntity<Map<String, String>> resendVerification(HttpSession session) {
        String id = (String) session.getAttribute("id"); // 세션에서 ID 확인
        if (id == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .header("Cache-Control", "no-store, no-cache") // 캐싱 방지
                    .body(Map.of("message", "세션에서 사용자 정보를 찾을 수 없습니다."));
        }
        // 인증번호 재발송 처리
//        System.out.println("인증번호를 재발송합니다.");
        signUpService.handleResendVerification(id, session);
        String newCode = (String) session.getAttribute("verificationCode");
//        System.out.println("새로 발송된 인증번호: " + newCode); // 인증번호 확인
//        signUpService.saveVerificationCodeToSession(id, newCode, session);
        return ResponseEntity.ok(Map.of("message", "새로운 인증번호를 발송했습니다.", "newCode", newCode // 새 인증번호를 반환
        ));
    }

    @PostMapping("/expireVerificationCode")
    @ResponseBody
    public ResponseEntity<String> expireVerificationCode(HttpSession session) {
        signUpService.removeVerificationCodeFromSession(session);
        return ResponseEntity.ok("인증번호가 유효하지 않습니다. 새 인증번호를 요청하세요.");
    }

    @GetMapping("/setPassword")
    public String toSetPasswordPage(HttpSession session) {
        String id = (String) session.getAttribute("id");
        if (id == null) {
            return "redirect:/signup/enterEmail";
        }
        return "signup/setPassword";
    }


    @PostMapping("/setPassword")
    public String setPassword(@RequestParam String pw, HttpSession session) {
        signUpService.setPasswordForSession(session, pw);
        return "redirect:/signup/setPreference";
    }

    /*
    public String setPassword(@RequestParam("pw") String pw, HttpSession session) {
        String id = (String) session.getAttribute("id");
        if (id == null) {
//            log.warn("세션에서 가져온 사용자 정보: id={}", id);
            return "redirect:/signup/enterEmail";
        }

        session.setAttribute("pw", pw);
        session.setAttribute("profileImagePath", "../../../resources/images/myPage/icon-jam-icons-outline-logos-user1.svg");
        session.setAttribute("loginType", "local");

        log.info("세션 정보: id={}, pw={}, loginType={}, profileImagePath={}",
                id, pw, "local", session.getAttribute("profileImagePath"));
        return "redirect:/signup/setPreference";
    }
    */

    /*
    @GetMapping("/socialLogin")
    public String handleSocialLogin(HttpSession session) {
        String id = "social_user@example.com"; // 네이버에서 가져온 사용자 이메일
        session.setAttribute("id", id);
        session.setAttribute("loginType", "naver");

        log.info("세션에서 가져온 정보: id={}", id);
        return "redirect:/signup/setPreference";
    }
    */

    @GetMapping("/setPreference")
    public String toSetPreferencePage(HttpSession session) {
        try {
            signUpService.prepareSessionForPreference(session);
            return "signup/setPreference";
        } catch (IllegalArgumentException e) {
            log.warn(e.getMessage());
            return "redirect:/signup/enterEmail";
        }
    }

    @PostMapping("/checkUsername")
    @ResponseBody
    public ResponseEntity<Boolean> checkUsername(@RequestParam String username) {
        boolean isDuplicate = signUpService.checkUsernameDuplicate(username);
        log.info("활동명 중복 확인: {} -> {}", username, isDuplicate);
        return ResponseEntity.ok(isDuplicate);
    }

    @PostMapping("/setPreference")
    public ResponseEntity<String> insertPreference(@RequestParam String username, @RequestParam String categories, HttpSession session) {
        try {
            String id = (String) session.getAttribute("id");
            String idKey = (String) session.getAttribute("idKey");

            String loginType = (String) session.getAttribute("loginType");
            log.info("세션에서 가져온 값: id={}, idKey={}, loginType={}", id, idKey, loginType);

            if (id == null || loginType == null) {
                log.error("세션 정보 누락: id={}, loginType={}", id, loginType);
                throw new IllegalStateException("세션 정보가 누락되었습니다. 이전 단계로 돌아가세요.");
            }

            if ("naver".equalsIgnoreCase(loginType) && idKey == null) {
                log.error("네이버 로그인 타입인데 idKey가 없습니다.");
                throw new IllegalStateException("네이버 로그인 데이터가 누락되었습니다.");
            }
            // 회원가입 정보 저장
            signUpService.saveUserAndPreferences(session, username, categories);

            return ResponseEntity.ok("회원가입 성공!");
        } catch (Exception e) {
            log.error("회원가입 정보 저장 중 오류 발생", e);
            return ResponseEntity.badRequest().body("회원가입 정보 저장 중 문제가 발생했습니다.");
        }
    }
}
