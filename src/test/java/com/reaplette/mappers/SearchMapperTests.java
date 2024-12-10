package com.reaplette.mappers;

import com.reaplette.domain.FollowVO;
import com.reaplette.domain.UserVO;
import com.reaplette.search.mappers.SearchMapper;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertNotNull;

@ExtendWith(SpringExtension.class)
@SpringBootTest
@Log4j2
public class SearchMapperTests {
    private static final Logger logger = LoggerFactory.getLogger(SearchMapperTests.class);

    @Autowired
    private SearchMapper SearchMapper;

    @Test
    public void testGetAllUsers() {
        // 테스트용 데이터 ID (데이터베이스에 존재하는 ID 사용)
        String userName = "테스트";

        // 메서드 호출
        List<UserVO> userList = SearchMapper.getAllUsers(userName);

        log.info(userList);

    }

    @Test
    public void testGetFollowList(){
        String userId = "test@naver.com";
        List<FollowVO> followList = SearchMapper.getFollowList(userId);
        log.info(followList);
    }
}
