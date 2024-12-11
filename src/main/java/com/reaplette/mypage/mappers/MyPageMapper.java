package com.reaplette.mypage.mappers;

import com.reaplette.domain.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MyPageMapper {
    // User 정보 가져오기
    UserVO getUser(String id);
    void setUser(UserVO user);
    boolean isUsernameExists(@Param("id") String id,@Param("username") String username);
    void setGoal(GoalVO goal);
    List<GoalVO> getUserGoalList(String id);
    GoalVO getGoal(@Param("id") String id,@Param("bookId") String bookId);
    void updateGoal(GoalVO goal);
    List<TranscriptionVO> getTranscriptionList(@Param("id") String id, @Param("bookId") String bookId);
    void setTranscription(TranscriptionVO transcription);
    void deleteTranscription(String transcriptionId);
    void deleteGoal(@Param("id") String id,@Param("bookId") String bookId);
    List<BookmarkVO> getBookmarkList(String id);
    List<FollowVO> getFollowingList(String id);
    List<FollowVO> getFollowerList(String id);
    List<BoardVO> getPostList(String id);
    void deleteUser(String id);
    void deleteFollow(String id);
}


