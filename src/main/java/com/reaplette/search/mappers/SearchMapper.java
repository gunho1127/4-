package com.reaplette.search.mappers;

import com.reaplette.domain.BoardVO;
import com.reaplette.domain.FollowVO;
import com.reaplette.domain.UserVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface SearchMapper {
    List<UserVO> getAllUsers(String username); // 모든 사용자 목록 가져오기  getUserList
    List<FollowVO> getFollowList(String id);
    List<UserVO> searchUsersByKeyword(Map<String, Object> params);

}
