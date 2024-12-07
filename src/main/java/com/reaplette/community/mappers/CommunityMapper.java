package com.reaplette.community.mappers;

import com.reaplette.domain.BoardVO;
import com.reaplette.domain.CommentVO;
import com.reaplette.domain.ReviewVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CommunityMapper {

    // 실시간 인기 게시글
    List<BoardVO> selectPopularPosts();

    // 팔로우한 게시글
    List<BoardVO> selectFollowingPosts(String loggedInUserId);

    // 도서 리뷰
    List<ReviewVO> selectBookReviews();

    // 커뮤니티 게시글
    List<BoardVO> selectCommunityPosts();

    // 게시글 작성
    void insertPost(BoardVO board);

    // 게시글 조회
    BoardVO selectPostById(int postId) ;

    // 댓글 목록 조회
    List<CommentVO> selectCommentsByPostId(int postId) ;
}