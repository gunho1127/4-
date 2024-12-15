package com.reaplette.admin.mappers;

import com.reaplette.domain.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface AdminMapper {
    List<BoardVO> getBoardList();
    void deleteMember(String id);
    List<UserVO> getMemberList();

    List<Map<String, Object>> getReviewCounts();
}