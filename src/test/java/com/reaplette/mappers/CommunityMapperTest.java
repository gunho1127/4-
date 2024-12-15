package com.reaplette.mappers;

import org.junit.jupiter.api.Test;
import com.reaplette.community.mappers.CommunityMapper;
import com.reaplette.mypage.mappers.MyPageMapper;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

@SpringBootTest
@ExtendWith(SpringExtension.class)
@Log4j2
public class CommunityMapperTest {

    @Autowired
    private CommunityMapper communityMapper;

    @Test
    public void testselectFollowingPosts()    {

        log.info(communityMapper.selectFollowingPosts("reaplette@naver.com"));
    }

}
