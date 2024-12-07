package com.reaplette.domain;

import lombok.Data;

@Data
public class ReviewLikeVO {
    private int reviewId; // 리뷰 ID
    private String id; // 사용자 ID (좋아요 누른 사람)
}

