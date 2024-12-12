package com.reaplette.search.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

public class ReviewModel {

  @Getter
  @Builder
  @AllArgsConstructor
  @NoArgsConstructor
  public static class Review {
    private String reviewId;
    private String username;
    private String reviewRating;
    private String reviewContent;
    private int likeCount;
    private String date;
  }

  @Getter
  public static class ReviewRequest {
    private String bookId;
    private String rating;
    private String reviewContent;
    private String bookImage;
    private String bookTitle;

    @Builder
    public ReviewRequest(String bookId, String rating, String reviewContent, String bookImage, String bookTitle) {
      this.bookId = bookId;
      this.rating = rating;
      this.reviewContent = reviewContent;
      this.bookImage = bookImage;
      this.bookTitle = bookTitle;
    }
  }
}
