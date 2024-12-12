package com.reaplette.mappers;

import com.reaplette.domain.GoalVO;
import com.reaplette.domain.PreferenceVO;
import com.reaplette.domain.TranscriptionVO;
import com.reaplette.domain.UserVO;
import com.reaplette.mypage.mappers.MyPageMapper;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.Arrays;
import java.util.List;

@Log4j2
@ExtendWith(SpringExtension.class)
@SpringBootTest
public class MyPageMapperTests {

    private static final Logger logger = LoggerFactory.getLogger(MyPageMapperTests.class);

    @Autowired
    private MyPageMapper myPageMapper;

    @Test
    public void testGetUser() {
        // 테스트용 데이터 ID (데이터베이스에 존재하는 ID 사용)
        String testId = "test2@naver.com";
        // 메서드 호출
        UserVO user = myPageMapper.getUser(testId);
        log.info(user);
    }

    @Test
    public void testIsUsernameExists() {
        String id = "test@naver.com";
        // test@naver.com 의 이름은 리플렛

        // 내 이름은 true가 나와야 함.
        String username = "서승권";

        // 중복 시 false 가 나와야 함.
//        String username = "리플렛";

        // 안 중복 시 true 가 나와야 함.
//         String username = "고양이입니다.";

        log.info("result {}",myPageMapper.isUsernameExists(id,username));
    }

    @Test
    public void testSetGoal() {

        GoalVO goal = new GoalVO();
        goal.setId("test@naver.com");
        goal.setBookId("9791168944473");
        goal.setBookTitle("나루토 3");
        goal.setAuthor("마사시 키시모토");
        goal.setPagesRead(0);
        goal.setTotalPage(100);
        goal.setBookImageUrl("https://shopping-phinf.pstatic.net/main_3380562/33805623708.20221019150443.jpg");
        goal.setStartDate("2024-12-03");
        goal.setGoalDate("2024-12-03");
        goal.setIsDelete(0);

        myPageMapper.setGoal(goal);
    }

    @Test
    public void testGetUserGoalList() {
        String id="test@naver.com";
        log.info(myPageMapper.getUserGoalList(id));
    }

    @Test
    public void testGetTranscriptionList() {
        String id="test@naver.com";
        String bookId="9788986621136";
        log.info(myPageMapper.getTranscriptionList(id,bookId));
    }

    @Test
    public void testSetTranscriptionList() {
        TranscriptionVO transcription = new TranscriptionVO();
        transcription.setId("test@naver.com"); // 사용자 ID
        transcription.setBookId("9788926770054"); // 책 ID (더미 값)
        transcription.setTranscriptionSentence("이 문장은 테스트 필사 문장입니다."); // 필사 문장
        transcription.setTranscriptionContent("이 내용은 테스트 생각 내용입니다."); // 나의 생각
        transcription.setTranscriptionDate("2024-12-08"); // 오늘 날짜
        transcription.setIsDelete(1); // 삭제 여부 기본값
        myPageMapper.setTranscription(transcription);
    }

    @Test
    public void testGetBookmarkList() {
        String id = "test@naver.com";
        log.info(myPageMapper.getBookmarkList(id));
    }

    @Test
    public void testGetFollowingList() {
        String id = "test@naver.com";
        log.info(myPageMapper.getFollowingList(id));
    }

    @Test
    public void testGetFollowerList() {
        String id = "test@naver.com";
        log.info(myPageMapper.getFollowerList(id));
    }

    @Test
    public void testDeleteUser() {
        String id = "test2@naver.com";
        myPageMapper.deleteUser(id);
        myPageMapper.deleteUserPreference(id);
        myPageMapper.deleteUserBookmark(id);
        myPageMapper.deleteUserBookmark(id);
        myPageMapper.deleteUserBoard(id);
        myPageMapper.deleteUserTranscription(id);
        myPageMapper.deleteUserGoal(id);
        myPageMapper.deleteUserComment(id);
        myPageMapper.deleteUserReview(id);
//        myPageMapper.deleteFollow(id);
    }

    @Test
    public void testGetPostList() {
        String id = "test@naver.com";
        log.info(myPageMapper.getPostList(id));
    }

    @Test
    public void testGetGoal() {
        String id = "test2@naver.com";
        String bookId = "9788936434120";
        log.info(myPageMapper.getGoal(id,bookId));
    }

    @Test
    public void testGetPreferenceList() {
        String id = "test@naver.com";
        log.info(myPageMapper.getPreferenceCategoryList(id));
        log.info(myPageMapper.getAuthorBookPreferenceList(id));
    }


}
