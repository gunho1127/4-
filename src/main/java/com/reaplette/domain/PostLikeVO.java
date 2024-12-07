package com.reaplette.domain;

import lombok.Data;

@Data
public class PostLikeVO {
    private String id; // 사용자 ID
    private int postId; // 게시글 ID
}


