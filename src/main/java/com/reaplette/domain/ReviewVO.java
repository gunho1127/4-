package com.reaplette.domain;

import lombok.Data;

@Data
public class ReviewVO {
    private int reviewId; // 리뷰 ID
    private String bookId; // 책 ID
    private String bookTitle; // 책 제목
    private String id; // 사용자 ID (리뷰 작성자)
    private int reviewRating = 0;  // 리뷰 점수 (1, 2, 3, 4, 5 점)
    private String reviewContent; // 리뷰 내용
    private String date;  // 리뷰 작성 날짜 (YY/MM/DD 형식)
    private int isDelete = 1; // 삭제 여부 (기본값 1: 삭제되지 않음)
    private int likeCount ;
    private String bookImage;
    private String username; // 사용자 이름

    private String type = "독서 리뷰"; // 게시글 유형 (커뮤니티: "board", 독서 리뷰: "review")
}



