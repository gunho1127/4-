package com.reaplette.community.service;

import com.reaplette.domain.BoardVO;
import com.reaplette.domain.CommentVO;
import com.reaplette.domain.ReviewVO;
import com.reaplette.community.mappers.CommunityMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CommunityService {

    @Autowired
    private CommunityMapper communityMapper;

    // 실시간 인기 게시글 가져오기
    public List<BoardVO> getPopularPosts() {
        List<BoardVO> posts = communityMapper.selectPopularPosts();
        for (BoardVO post : posts) {
            if ("board".equals(post.getType())) {
                post.setType("커뮤니티");
            } else {
                post.setType("독서 리뷰");
            }
        }

        return posts;
    }

    // 팔로우한 게시글 가져오기
    public List<BoardVO> getFollowingPosts(String loggedInUserId) {
        List<BoardVO> posts = communityMapper.selectFollowingPosts(loggedInUserId);
        for (BoardVO post : posts) {
            if ("board".equals(post.getType())) {
                post.setType("커뮤니티");
            } else {
                post.setType("독서 리뷰");
            }
        }

        return posts;
    }
    // 도서 리뷰 가져오기
    public List<ReviewVO> getBookReviews() {
        return communityMapper.selectBookReviews();
    }

    // 커뮤니티 게시글 가져오기
    public List<BoardVO> getCommunityPosts() {
        return communityMapper.selectCommunityPosts();
    }

    // 새 게시글 작성
    public void savePost(BoardVO board) {
        // 게시글 작성자는 로그인된 사용자 ID로 설정
        communityMapper.insertPost(board);
    }

    // 게시글 조회
    public BoardVO getPostById(int postId) {
        return communityMapper.selectPostById(postId);
    }

    // 게시글 삭제
    public void deletePost(int postId) {
        try {
            communityMapper.deletePost(postId);  // 삭제 작업
        } catch (Exception e) {
            // 예외가 발생하면 실패로 간주하고 로그를 남김
            throw new RuntimeException("삭제 실패", e);
        }
    }

    // 게시글 수정
    public void editPost(BoardVO board) { communityMapper.editPost(board); }


    // 게시글 조회수 증가
    public void incrementViewCount(int postId) { communityMapper.updateViewCount(postId); }

    // 게시글 좋아요 버튼
    @Transactional
    public void likePost(int postId, String userId) {
        // 1. 좋아요 상태 체크 (이미 좋아요를 누른 상태인지 확인)
        int likeCheck = communityMapper.checkLikeStatus(postId, userId);

        if (likeCheck > 0) {
            // 2. 이미 좋아요가 눌린 상태라면, 좋아요 취소
            communityMapper.decreaseLikeCount(postId);  // likeCount -1
            communityMapper.unlikePost(userId, postId);  // postlike에서 삭제
        } else {
            // 3. 좋아요가 눌리지 않았다면, 좋아요 추가
            communityMapper.likePost(userId, postId);  // postlike에 삽입
            communityMapper.increaseLikeCount(postId);  // likeCount +1
        }
    }

    // 특정 게시글에 대해 사용자가 좋아요를 눌렀는지 확인
    public boolean isLikedByUser(int postId, String userId) {
        Integer count = communityMapper.checkLikeStatus(postId, userId);
        return count != null && count > 0;
    }


    // 댓글 목록 조회
    public List<CommentVO> getCommentsByPostId(int postId) {
        return communityMapper.selectCommentsByPostId(postId);
    }

    // 댓글 작성
    @Transactional
    public void saveComment(CommentVO commentVO) {
        // 댓글을 저장
        communityMapper.saveComment(commentVO);

        // 댓글 수 증가
        communityMapper.increaseCommentCount(commentVO.getPostId());
    }
    // 댓글 삭제
    @Transactional
    public void deleteComment(int commentId) {
        // 댓글 삭제
        communityMapper.deleteComment(commentId);

        // 해당 게시물의 commentCount 감소
        communityMapper.decreaseCommentCount(commentId);
    }
}
