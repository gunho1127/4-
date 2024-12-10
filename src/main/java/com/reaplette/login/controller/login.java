package com.reaplette.login.controller;/* 메서드 변수명 email, password
package com.reaplette.login.controller;

import com.reaplette.domain.UserVO;
import com.reaplette.login.service.LoginService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/login")
public class LoginController {

    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
    private final LoginService loginService;

    public LoginController(LoginService loginService) {
        this.loginService = loginService;
    }

    // 이메일 입력 화면
    @GetMapping("/enterEmail")
    public String showEnterEmailForm() {
        return "login/enterEmail";
    }

    // 입력된 이메일 검증 및 상태 확인
    @PostMapping("/enterEmail")
    @ResponseBody
    public Map<String, Object> handleEnterEmail(@RequestBody Map<String, String> request, HttpSession session) {
        String email = request.get("id");  // 'id' -> 'email'로 변경
        //logger.info("이메일 입력 처리: email={}", email);

        Map<String, Object> response = new HashMap<>();

        //try {  -- DB 조회할 때 로그 주석 해제
        // 이메일이 비어있는지 확인
        if (email == null || email.trim().isEmpty()) {
            response.put("error", "이메일을 입력하지 않았습니다.");
            return response;
        }

        // 이메일 유효성 검증
        if (!isValidEmail(email)) {
            response.put("error", "올바른 이메일 형식이 아닙니다.");
            return response;
        }

        // 이메일 DB 조회
        try {
            //logger.info("DB 조회 시작: email={}", email);
            UserVO user = loginService.getUserById(email);  // 'id' -> 'email'로 변경
            //logger.info("DB 조회 결과: {}", user);

            if (user != null) {
                if ("naver".equals(user.getLoginType())) {
                    response.put("error", "소셜 가입자입니다. 네이버로 로그인하세요.");
                } else {
                    session.setAttribute("id", email);  // 'id' -> 'email'로 변경
                    response.put("isRegistered", true);
                    response.put("redirect", "/login/enterPassword");
                    //logger.info("기존 사용자 처리: email={}", email);
                }
            } else {
                // 미가입자일 경우 이메일을 세션에 저장하고, verifyEmail 페이지로 리디렉션
                session.setAttribute("id", email);  // 'id' -> 'email'로 변경
                response.put("isRegistered", false);  // 미가입자
                response.put("canSendVerification", true);  // 인증 코드 발송 가능
                response.put("redirect", "/login/verifyEmail"); // 인증 코드 발송 페이지로 리디렉션
                //logger.info("미가입자 처리: email={}", email);
            }
        } catch (Exception e) {
            //logger.error("예외 발생 메시지: {}", e.getMessage());
            response.put("error", "서버 처리 중 문제가 발생했습니다. 다시 시도하세요.");
        }
        //logger.info("최종 응답 데이터: {}", response);
        return response;
    }

    // 이메일 유효성 검증
    private boolean isValidEmail(String email) {  // 'id' -> 'email'로 변경
        String emailRegex = "^(?!.*\\.\\.)(?!\\.)[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
        return email.matches(emailRegex);  // 'id' -> 'email'로 변경
    }

    // 비밀번호 입력 화면 (enterPassword)
    @GetMapping("/enterPassword")
    public String showEnterPasswordForm() {
        return "login/enterPassword"; // 비밀번호 입력 화면으로 이동
    }

    // 로그인 처리
    @PostMapping("/enterPassword")
    @ResponseBody
    public Map<String, Object> handleLogin(@RequestBody Map<String, String> request, HttpSession session) {
        String email = request.get("id");  // 'id' -> 'email'로 변경
        String password = request.get("pw");  // 'pw' -> 'password'로 변경
        //logger.info("로그인 요청: email={}, password={}", email, password);

        Map<String, Object> response = new HashMap<>();

        // 비밀번호가 비어있는지 확인
        if (password == null || password.trim().isEmpty()) {  // 'pw' -> 'password'로 변경
            response.put("error", "비밀번호를 입력하지 않았습니다.");
            return response;
        }

        try {
            // 사용자 조회 후 비밀번호 검증
            UserVO user = loginService.getUserById(email);  // 'id' -> 'email'로 변경
            if (user != null && loginService.validatePassword(user, password)) {  // 'pw' -> 'password'로 변경
                session.setAttribute("id", email);  // 'id' -> 'email'로 변경
                session.setAttribute("user", user);  // 로그인 성공 시 세션에 사용자 정보 저장
                response.put("redirect", "/index");  // 로그인 성공 시 홈 페이지로 리디렉션
            } else {
                response.put("error", "이메일 또는 비밀번호가 일치하지 않습니다.");
            }
        } catch (Exception e) {
            logger.error("로그인 처리 중 오류 발생: {}", e.getMessage());
            response.put("error", "서버 처리 중 문제가 발생했습니다. 다시 시도하세요.");
        }

        return response;
    }
}

// 인증 코드 발송 후 verifyEmail 페이지로 이동
@GetMapping("/verifyEmail")
public String verifyEmailPage(HttpSession session, Model model) {
    String email = (String) session.getAttribute("id");

    // 인증 코드 발송 로직 (예시: 서비스 호출)
    if (email != null) {
        loginService.sendVerificationCodeWithSession(email); // 'id' -> 'email'로 변경
        model.addAttribute("email", email); // 이메일 값을 뷰에 전달
    }

    return "login/verifyEmail"; // 인증 코드 입력 페이지로 이동
}

*/


