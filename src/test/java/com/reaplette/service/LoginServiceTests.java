package com.reaplette.service;

import com.reaplette.domain.UserVO;
import com.reaplette.login.mappers.LoginMapper;
import com.reaplette.login.service.LoginService;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import lombok.extern.log4j.Log4j2;
import org.apache.catalina.User;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

@SpringBootTest
@ExtendWith(SpringExtension.class)
@Log4j2
public class LoginServiceTests {

    @Autowired
    LoginService loginService;

    @Autowired
    LoginMapper LoginMapper;

//    @Test
//    public void testSendTemporaryPasswordEmail() {
//        String id = "reaplette@naver.com";
//        String tempPassword = loginService.generateTemporaryPassword();
//        log.info("tempPassword {}", tempPassword);
//
//        loginService.sendTemporaryPasswordEmail(id,tempPassword);
//    }

    @Test
    public void testResetPasswordAndSendEmail() {
        log.info("testResetPasswordAndSendEmail . . .");

        //객체 생성
        UserVO user = new UserVO();

        // 객체에 id, tempPassword 주입
        user.setId("reaplette@naver.com");
        user.setPw(loginService.generateTemporaryPassword());

        //로그로 확인
        log.info("id {}", user.getId());
        log.info("tempPassword {}", user.getPw());

        // 비밀번호 변경
        int result = LoginMapper.updatePassword(user);

        // 변경된 비밀번호 고지 메일 전송
        loginService.sendTemporaryPasswordEmail(user.getId(),user.getPw());

    }

}
