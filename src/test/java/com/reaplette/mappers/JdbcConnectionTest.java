package com.reaplette.mappers;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.jupiter.api.Assertions.assertNotNull;

//@Transactional
@SpringBootTest
public class JdbcConnectionTest {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Test
    public void testDatabaseConnection() {
        // 간단한 쿼리 실행을 통해 연결 테스트
        String result = jdbcTemplate.queryForObject("SELECT 1", String.class);
        assertNotNull(result, "Database connection should be successful");
    }
}
