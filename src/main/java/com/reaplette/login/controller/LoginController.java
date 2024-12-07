package com.reaplette.login.controller;

import com.reaplette.domain.UserVO;
import com.reaplette.login.service.LoginService;
import lombok.extern.log4j.Log4j2;
import org.apache.catalina.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;

import java.util.HashMap;
import java.util.Map;

@Log4j2
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
        log.info("/enterEmail");
        String id = request.get("id");
        log.info(id);

        //logger.info("이메일 입력 처리: id={}", id);

        Map<String, Object> response = new HashMap<>();

        //try {  -- DB 조회할 때 로그 주석 해제
        // 이메일이 비어있는지 확인
        if (id == null || id.trim().isEmpty()) {
            response.put("error", "이메일을 입력하지 않았습니다.");
            return response;
        }

        // 이메일 유효성 검증
        if (!isValidEmail(id)) {
            response.put("error", "올바른 이메일 형식이 아닙니다.");
            return response;
        }

        // 이메일 DB 조회
        try {
            //logger.info("DB 조회 시작: id={}", id);
            UserVO user = loginService.getUserById(id);
            //logger.info("DB 조회 결과: {}", user);

            if (user != null) {
                if ("naver".equals(user.getLoginType())) {
                    response.put("error", "소셜 가입자입니다. 네이버로 로그인하세요.");
                } else {
                    session.setAttribute("id", id);
                    response.put("isRegistered", true);
                    response.put("redirect", "/login/enterPassword");
                    //logger.info("기존 사용자 처리: id={}", id);
                }
            } else {
                // 미가입자일 경우 이메일을 세션에 저장하고, verifyEmail 페이지로 리디렉션
                session.setAttribute("id", id);
                response.put("isRegistered", false);  // 미가입자
                response.put("canSendVerification", true);  // 인증 코드 발송 가능
                response.put("redirect", "/login/verifyEmail"); // 인증 코드 발송 페이지로 리디렉션
                //logger.info("미가입자 처리: id={}", id);
            }
        } catch (Exception e) {
            //logger.error("예외 발생 메시지: {}", e.getMessage());
            response.put("error", "서버 처리 중 문제가 발생했습니다. 다시 시도하세요.");
        }
        //logger.info("최종 응답 데이터: {}", response);
        return response;
    }

    // 이메일 유효성 검증
    private boolean isValidEmail(String id) {
        String emailRegex = "^(?!.*\\.\\.)(?!\\.)[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
        return id.matches(emailRegex);
    }

    // 비밀번호 입력 화면
    @GetMapping("/enterPassword")
    public String showEnterPassword(HttpSession session) {
        if (session.getAttribute("id") == null) {
            return "redirect:/login/enterEmail"; // 세션에 ID가 없을 경우 로그인 페이지로 리다이렉트
        }
        return "login/enterPassword"; // 비밀번호 입력 화면으로 이동
    }

    // 입력된 비밀번호 검증 및 로그인 처리
    @PostMapping("/enterPassword")
    @ResponseBody
    public Map<String, Object> handleLogin(@RequestBody Map<String, String> request, HttpSession session) {
        String pw = request.get("pw");
        Map<String, Object> response = new HashMap<>();
        // 세션에서 아이디 가져오기
        String id = (String) session.getAttribute("id");
        if (id == null) {
            response.put("error", "아이디 세션이 만료되었습니다. 다시 입력하세요.");
            response.put("redirect", "/login/enterEmail");
            return response;
        }

        // 비밀번호가 비어있는지 확인
        if (pw == null || pw.trim().isEmpty()) {
            response.put("error", "비밀번호를 입력하지 않았습니다.");
            return response;
        }

        try {
            // 로그인 시도 제한 및 비밀번호 검증
            boolean isPasswordValid = loginService.validatePassword(id, pw, session);

            if (isPasswordValid) {
                // 사용자 조회
                UserVO user = loginService.getUserById(id);


                session.setAttribute("user", user); // 로그인 성공 시 사용자 정보를 세션에 저장

                session.removeAttribute("id"); // 세션에서 ID 제거
                response.put("redirect", "/"); // index
            } else {
                // 로그인 시도 제한 응답 처리
                Integer attemptCount = (Integer) session.getAttribute("attemptCount");
                if (attemptCount != null && attemptCount >= 10) {
                    response.put("error", "10회 이상 잘못된 비밀번호 입력으로 로그인을 제한합니다. 잠시 후 다시 시도하세요.");
                } else {
                    response.put("error", "비밀번호가 일치하지 않습니다. 다시 입력하세요.");
                }
            }
        } catch (Exception e) {
            logger.error("로그인 처리 중 오류 발생: {}", e.getMessage());
            response.put("error", "서버 처리 중 문제가 발생했습니다. 다시 시도하세요.");
        }

        return response;
    }


    // 비밀번호 찾기
    @GetMapping("/findPassword")
    public String handleFindPassword(HttpSession session) {
        if (session.getAttribute("id") == null) {
            return "redirect:/login/enterEmail"; // 세션에 ID가 없을 경우 로그인 페이지로 리다이렉트
        }
        return "login/findPassword"; // 비밀번호 찾기 화면으로 이동
    }

    // 비밀번호 재설정 처리
//    @PostMapping("/findPassword")
//    public ResponseEntity<Map<String, Object>> handleFindPassword(@RequestBody String id,
//                                                             HttpSession session) {
//        log.info("/findPassword");
//        Map<String, Object> response = new HashMap<>();
//
//        // 세션에 ID가 없으면 에러 반환
//        if (id == null) {
//            log.info("아이디 값 없음 ㅜㅜ {}", id);
//            response.put("error", "아이디 세션이 만료되었습니다. 다시 입력하세요.");
//            response.put("redirect", "/login/enterEmail");
//            return response;
//        } else {
//            log.info("아이디 값 있음 !! {}", id);
//            session.setAttribute("id", id); // 세션에 ID 저장
//        }
//
//        try {
//            // 임시 비밀번호 생성 및 이메일 발송
//
////            UserVO user = (UserVO) session.getAttribute("user");
//
//            loginService.resetPasswordAndSendEmail(id);
//
//            response.put("success", true);
//
//        } catch (IllegalArgumentException e) {
//            log.info("사용자 정보 확인 실패: {}", e.getMessage());
//            response.put("error", "해당 사용자 정보를 찾을 수 없습니다.");
//        } catch (Exception e) {
//            log.info("비밀번호 재설정 중 오류 발생: {}", e.getMessage());
//            response.put("error", "비밀번호 재설정 중 문제가 발생했습니다. 다시 시도하세요.");
//        }
//
//        log.info(response);
//        log.info(response.toString());
//
//        return response;
//    }

    @PostMapping("/findPassword")
    public ResponseEntity<Map<String, Object>> handleFindPassword(@RequestBody String id,
                                                                  HttpSession session) {
        log.info("/findPassword");
        Map<String, Object> response = new HashMap<>();

        // 세션에 ID가 없으면 에러 반환
        if (id == null || id.trim().isEmpty()) {
            log.info("아이디 값 없음 ㅜㅜ {}", id);
            response.put("error", "아이디 세션이 만료되었습니다. 다시 입력하세요.");
            response.put("redirect", "/login/enterEmail");

            // 400 Bad Request 상태 코드와 함께 응답
            return ResponseEntity.badRequest().body(response);
        } else {
            log.info("아이디 값 있음 !! {}", id);
            session.setAttribute("id", id); // 세션에 ID 저장
        }

        try {
            // 임시 비밀번호 생성 및 이메일 발송
            loginService.resetPasswordAndSendEmail(id);

            response.put("success", true);
            // 200 OK 상태 코드와 함께 성공 응답
            return ResponseEntity.ok().body(response);

        } catch (IllegalArgumentException e) {
            log.info("사용자 정보 확인 실패: {}", e.getMessage());
            response.put("error", "해당 사용자 정보를 찾을 수 없습니다.");

            // 404 Not Found 상태 코드와 함께 응답
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);

        } catch (Exception e) {
            log.info("비밀번호 재설정 중 오류 발생: {}", e.getMessage());
            response.put("error", "비밀번호 재설정 중 문제가 발생했습니다. 다시 시도하세요.");

            // 500 Internal Server Error 상태 코드와 함께 응답
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }


}
