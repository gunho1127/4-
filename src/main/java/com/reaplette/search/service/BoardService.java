package com.reaplette.search.service;

import com.reaplette.domain.BoardVO;
import com.reaplette.search.mappers.BoardMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class BoardService {
    private final BoardMapper boardMapper;

    /**
     * 검색어로 게시글을 검색
     * @param keyword 검색어
     * @return 게시글 리스트
     */
    public List<BoardVO> getAllBoards() {
        return boardMapper.getAllBoards();
        //System.out.println("Profile Image Path: " + .getProfileImagePath());
    }

    public List<BoardVO> searchBoards(String keyword) {
        return boardMapper.searchBoards(keyword);
    }

    public List<BoardVO> getBoardsByPage(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return boardMapper.getBoardsByPage(offset, pageSize);
    }

    public List<BoardVO> getBoardsByPageAndSort(int page, int pageSize, String sort) {
        int offset = (page - 1) * pageSize;
        return boardMapper.getBoardsBySort(offset, pageSize, sort);
    }

    public List<BoardVO> searchBoardsByKeywordAndSort(String keyword, int page, int pageSize, String sort) {
        int offset = (page - 1) * pageSize;
        return boardMapper.searchBoardsByKeywordAndSort(keyword, offset, pageSize, sort);
    }

    public List<BoardVO> searchPostsByKeyword(String keyword) {
            return boardMapper.searchPostsByKeyword(keyword); // Mapper 호출
        }

}
