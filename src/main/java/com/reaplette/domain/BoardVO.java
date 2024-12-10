package com.reaplette.domain;

import lombok.Data;

@Data
public class BoardVO {
    private int postId; // 게시글 ID
    private String id; // 사용자 ID (게시글 작성자)
    private String title; // 게시글 제목
    private String content; // 게시글 내용
    private String postImagePath; // 게시글 이미지 1
    private String date;  // 게시글 날짜 (YY/MM/DD 형식)
    private int likeCount = 0; // 좋아요 수
    private int commentCount = 0; // 댓글 수
    private int viewCount = 0; // 조회수
    private int isDelete = 1; // 삭제 여부 (기본값 1: 삭제되지 않음)
    private String username; // 사용자 이름
    private String profileImagePath; // 프로필 이미지 경로

    private String type = "커뮤니티"; // 게시글 유형 (커뮤니티: "board", 독서 리뷰: "review")
}

