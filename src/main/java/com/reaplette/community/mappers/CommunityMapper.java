package com.reaplette.community.mappers;

import com.reaplette.domain.BoardVO;
import com.reaplette.domain.CommentVO;
import com.reaplette.domain.ReviewVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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
    BoardVO selectPostById(int postId);

    // 게시글 삭제
    void deletePost(int postId);

    // 게시글 수정
    void editPost(BoardVO board);

    // 게시글 조회수 증가
    void updateViewCount(int postId);

    // 게시글 좋아요 버튼
    void likePost(@Param("postId") int postId, @Param("userId") String userId);

    // 1. 좋아요 상태 체크 (해당 userId와 postId에 대한 좋아요 여부 확인)
    Integer checkLikeStatus(@Param("postId") int postId, @Param("userId") String userId);

    // 2. 좋아요 취소 (좋아요 삭제 및 likeCount 감소)
    void unlikePost(@Param("userId") String userId, @Param("postId") int postId);

    // 3. 좋아요 추가 (좋아요 삽입 및 likeCount 증가)
    void likePost(@Param("userId") String userId, @Param("postId") int postId);

    // 4. likeCount 감소 (좋아요 취소 시)
    void decreaseLikeCount(@Param("postId") int postId);

    // 5. likeCount 증가 (좋아요 추가 시)
    void increaseLikeCount(@Param("postId") int postId);

    // 댓글 목록 조회
    List<CommentVO> selectCommentsByPostId(int postId);

    // 댓글 작성
    void saveComment(CommentVO comment);

    // 댓글 수 증가 처리
    void increaseCommentCount(int postId);

    // 댓글 삭제
    void deleteComment(int commentId);

    // 댓글 수 감소 처리
    void decreaseCommentCount(int commentId);
}
