package com.reaplette.mappers;

import com.reaplette.domain.UserVO;
import com.reaplette.login.mappers.LoginMapper;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

@SpringBootTest
@ExtendWith(SpringExtension.class)
@Log4j2
public class LoginMapperTests {
    private static final Logger logger = LoggerFactory.getLogger(LoginMapperTests.class);

    @Autowired
    private LoginMapper loginMapper;

    @Test
    public void testGetUserById() {
        String id = "aaa@example.com"; // 테스트용 이메일
        UserVO user = loginMapper.getUserById(id);  // 'id'를 통해 사용자 조회

        // 'user'가 null이 아닌지, 이메일이 일치하는지 확인
        assertNotNull(user, "User should not be null");
        assertEquals(id, user.getId(), "Email ID should match");

        logger.info("User: {}", user); // 로깅을 통해 user 정보를 출력
    }

    @Test
    public void testUpdateVerificationCode() {
        String id = "aaa@example.com";
        String verificationCode = "123456";

        // Map을 사용하여 파라미터 전달
        Map<String, Object> params = new HashMap<>();
        params.put("id", id);
        params.put("verificationCode", verificationCode);

        // 인증 코드 업데이트 메서드 호출
        int rowsAffected = loginMapper.updateVerificationCode(params);

        // 업데이트된 행 수가 1이어야 한다.
        assertEquals(1, rowsAffected, "The verification code should be updated.");

        logger.info("Rows affected: {}", rowsAffected); // 로깅을 통해 업데이트된 행 수 출력
    }

    @Test

    public void testUpdatePassword() {

        log.info("testUpdatePassword . . .");
        UserVO user = new UserVO();
        user.setId("reaplette@naver.com");
        user.setPw("1_x)0nQVHXA5");

        loginMapper.updatePassword(user);

    }
}
