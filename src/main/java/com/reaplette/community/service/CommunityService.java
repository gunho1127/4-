package com.reaplette.community.service;

import com.reaplette.domain.BoardVO;
import com.reaplette.domain.CommentVO;
import com.reaplette.domain.ReviewVO;
import com.reaplette.community.mappers.CommunityMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

    // 댓글 목록 조회
    public List<CommentVO> getCommentsByPostId(int postId) {
        return communityMapper.selectCommentsByPostId(postId);
    }

//    // 게시글 좋아요 추가
//    public void addPostLike(Long postId, String userId) {
//        communityMapper.insertPostLike(postId, userId);
//    }
//
//    // 게시글 좋아요 삭제
//    public void removePostLike(Long postId, String userId) {
//        communityMapper.deletePostLike(postId, userId);
//    }
//
//    // 게시글 작성자 확인
//    public boolean isPostAuthor(Long postId, String userId) {
//        return communityMapper.selectPostAuthor(postId).equals(userId);
//    }


}
