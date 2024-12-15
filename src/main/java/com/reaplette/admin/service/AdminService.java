package com.reaplette.admin.service;

import com.reaplette.admin.mappers.AdminMapper;
import com.reaplette.domain.BoardVO;
import com.reaplette.domain.UserVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Log4j2
@RequiredArgsConstructor
public class AdminService {
    private final AdminMapper adminMapper;

    public List<BoardVO> getBoardList() {
        return adminMapper.getBoardList();
    }
    public void deleteMember(String id){

    }


//    public List<UserVO> getMemberList() {
//    }
//
//    public UserVO getUserById(String id) {
//    }

    public void deletePost(String id) {
    }



    public List<UserVO> getMemberList() {
        List<UserVO> user = new ArrayList<>();
        return user;
    }

    public UserVO getUserById(String id) {
        UserVO user = new UserVO();
        return user;
    }

    public class ReviewService {
        @Autowired


        public Map<String, Integer> getReviewCounts() {
            List<Map<String, Object>> result = adminMapper.getReviewCounts();
            Map<String, Integer> reviewCounts = new HashMap<>();
            for (Map<String, Object> row : result) {
                reviewCounts.put((String) row.get("id"), ((Long) row.get("reviewCount")).intValue());
            }
            return reviewCounts;
        }
    }
}
