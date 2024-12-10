package com.reaplette.domain;

import lombok.Data;

@Data
public class CommentVO {
    private int commentId; // 댓글 ID
    private String id; // 사용자 ID (댓글 작성자)
    private int postId; // 게시글 ID
    private String comment; // 댓글 내용
    private String date;  // 댓글 날짜 (YY/MM/DD 형식)
    private int isDelete = 1; // 삭제 여부 (기본값 1: 삭제되지 않음)
    private String username; // 사용자 이름

}


