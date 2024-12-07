package com.reaplette.signup.controller;

import com.reaplette.domain.UserVO;
import com.reaplette.mypage.service.MyPageService;
import com.reaplette.signup.service.SignUpService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.server.Session;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Log4j2
@Controller
@RequestMapping("/signup")
public class SignUpController {

    @Autowired
    SignUpService signUpService;
    MyPageService myPageService;

    @GetMapping("/verifyEmail")
    public String showVerifyEamil() { return "signup/verifyEmail";}

    @GetMapping("/setPassword")
    public String toSetPassWordPage() {return "/signup/setPassword";}

    @PostMapping("/setPassword")
    public  String setPassword(UserVO fakeuser,
                               HttpSession session) {

        log.info("/setPassword");
        log.info("user {}",fakeuser);

        UserVO user = (UserVO) session.getAttribute("user");
        user.setPw(fakeuser.getPw());
        session.setAttribute("pw",user.getPw());

        return "/signup/setPreferences";
    }

    @GetMapping("/checkUsername")
    public ResponseEntity<Map<String, Object>> checkUsername(@RequestParam String username,
                                                             HttpSession session) {
        log.info("GET /signup/checkUsername - Check User Name");
        Map<String, Object> response = new HashMap<>();

        log.info("username{} ", username);

        // 결과를 맵에 추가
        //false면 중복
        boolean plag = myPageService.isUsernameExists(username);

        if(plag) {
            UserVO user = (UserVO)session.getAttribute("user");
            user.setUsername(username);
            session.setAttribute("username",user.getUsername());
            response.put("exists",true);

        } else {
            response.put("exists",false);
        }


        // 응답 반환
        return ResponseEntity.ok(response);
    }

//    @PostMapping("/complete") {
//        user.url ="../../../reas"
//                r
//
//    }


}




