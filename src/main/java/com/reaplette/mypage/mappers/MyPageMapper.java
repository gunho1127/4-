package com.reaplette.mypage.mappers;

import com.reaplette.domain.GoalVO;
import com.reaplette.domain.TranscriptionVO;
import com.reaplette.domain.UserVO;
import org.apache.catalina.User;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Mapper
public interface MyPageMapper {
    // User 정보 가져오기
    UserVO getUser(String id);
    void setUser(UserVO user);
    boolean isUsernameExists(String username);
    void setGoal(GoalVO goal);
    List<GoalVO> getUserGoalList(String id);
    GoalVO getGoal(String id, String bookId);
    void updateGoal(GoalVO goal);
    List<TranscriptionVO> getTranscriptionList(String id, String bookId);
    void setTranscription(TranscriptionVO transcription);
}


