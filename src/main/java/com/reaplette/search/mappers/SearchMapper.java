package com.reaplette.search.mappers;

import com.reaplette.domain.BookmarkVO;
import com.reaplette.domain.FollowVO;
import com.reaplette.domain.PreferenceVO;
import com.reaplette.domain.UserVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface SearchMapper {
    List<UserVO> getAllUsers(String username); // 모든 사용자 목록 가져오기  getUserList
    List<FollowVO> getFollowList(String id);
    List<UserVO> searchUsersByKeyword(Map<String, Object> params);


//  찜 도서 승연님 여기 추가 !!
    void setBookmark(BookmarkVO bookmark);

    void deleteBookmark(BookmarkVO bookmark);

    void setPreference(PreferenceVO preference);
}
