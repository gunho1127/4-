package com.reaplette.search.mappers;

import com.reaplette.domain.BoardVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BoardMapper {
    /**
     * 검색어로 게시글을 조회
     * @param
     * @return 게시글 및 사용자 정보 리스트
     */
    List<BoardVO> getAllBoards();
    List<BoardVO> searchBoards (@Param("keyword") String keyword);//키워드로 게시글 조회
    List<BoardVO> getBoardsByPage(@Param("offset") int offset,@Param("pageSize") int pageSize);
    List<BoardVO> searchBoardsByKeywordAndSort(@Param("keyword") String keyword,
                                               @Param("offset") int offset,
                                               @Param("pageSize") int pageSize,
                                               @Param("sort") String sort);
    List<BoardVO> getBoardsBySort(@Param("offset") int offset,
                                  @Param("pageSize") int pageSize,
                                  @Param("sort") String sort);


    List<BoardVO> searchPostsByKeyword(String keyword);//@Param("keyword")
}
