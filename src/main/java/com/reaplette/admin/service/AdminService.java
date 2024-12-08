package com.reaplette.admin.service;

import com.reaplette.admin.mappers.AdminMapper;
import com.reaplette.domain.BoardVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.List;

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



}
