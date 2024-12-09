package com.reaplette.search.service;

import com.reaplette.domain.FollowVO;
import com.reaplette.domain.UserVO;
import com.reaplette.search.mappers.SearchMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Log4j2
@RequiredArgsConstructor
@Transactional
public class SearchService {
    private final SearchMapper searchMapper;

    public List<UserVO> getAllUsers(String userName) {
        List<UserVO> userList = searchMapper.getAllUsers(userName);
        if (userList== null || userList.isEmpty()) {
            throw new IllegalStateException("사용자 목록이 비어 있습니다.");
        }
        log.info("getAllUsers 호출...");
        return searchMapper.getAllUsers(userName);
    }

    public List<FollowVO> getFollowList(String userId){
        log.info("getFollowList 호출...");
        return searchMapper.getFollowList(userId);
    }

    public List<UserVO> searchUsersByKeyword(String keyword, String id) {
        String sanitizedKeyword = keyword.replaceAll("\\s+", "");
        log.info("searchUsersByKeyword 호출...");
        System.out.println("ID: " + id + ", Keyword: " + keyword);

        // 파라미터를 Map으로 구성
        Map<String, Object> params = new HashMap<>();
        params.put("id", id);        // 'id'를 맵에 넣음
        params.put("keyword", keyword);  // 'keyword'를 맵에 넣음

        // Mapper 호출 (Map으로 파라미터 전달)
        List<UserVO> userList = searchMapper.searchUsersByKeyword(params);

        // 검색 결과가 없을 경우 예외 처리
        if (userList == null || userList.isEmpty()) {
            log.info("검색 결과가 없습니다.");
            return new ArrayList<>();  // 빈 리스트 반환
        }

        return userList;
    }


//    private final SearchMapper userMapper; // 자동 주입
//
//    public UserVO getUser(String id) {
//        log.info("getUser....." + id);
//        return userMapper.getUser(id);
//    }
}