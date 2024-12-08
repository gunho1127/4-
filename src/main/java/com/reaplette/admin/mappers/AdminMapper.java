package com.reaplette.admin.mappers;

import com.reaplette.domain.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AdminMapper {
    List<BoardVO> getBoardList();
}