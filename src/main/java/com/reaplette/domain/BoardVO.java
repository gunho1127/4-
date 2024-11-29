package com.reaplette.domain;

import lombok.Data;

@Data
public class BoardVO {
    private int postId; // 게시글 ID
    private String id; // 사용자 ID (게시글 작성자)
    private String title; // 게시글 제목
    private String content; // 게시글 내용
    private String postImagePath; // 게시글 이미지
    private String date;  // 게시글 날짜 (YY/MM/DD 형식)
    private int likeCount = 0; // 좋아요 수
    private int commentCount = 0; // 댓글 수
    private int viewCount = 0; // 조회수
    private int isDelete = 0; // 삭제 여부 (기본값 0: 삭제되지 않음)
}

