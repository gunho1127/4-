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


    // 회원 탈퇴 부분
    void deleteUser(String id);
    void deleteUserPreference(String id);
    void deleteUserBookmark(String id);
    void deleteUserBoard(String id);
    void deleteUserTranscription(String id);
    void deleteUserGoal(String id);
    void deleteUserComment(String id);
    void deleteUserReview(String id);
    void deleteUserFollow(String id);




    // 카테고리 값들 불러오기
    List<PreferenceVO> getPreferenceCategoryList(String id);



    // 작가 정보 불러오기
    List<PreferenceVO> getAuthorBookPreferenceList(String id);
}


