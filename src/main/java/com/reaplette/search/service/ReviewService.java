package com.reaplette.search.service;

import com.reaplette.domain.ReviewVO;
import com.reaplette.search.enums.ReviewResultCd;
import com.reaplette.search.mappers.ReviewMapper;
import com.reaplette.search.model.ReviewModel;
import com.reaplette.search.model.ReviewResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ReviewService {

  private final ReviewMapper reviewMapper;

  public List<ReviewVO> getReviewList(String bookId) {
    List<ReviewVO> reviews = reviewMapper.selectReview(bookId);
    return reviews;
  }

  public ReviewResponseDto addReview(ReviewModel.ReviewRequest request, String userId) {

    Map<String, Object> param1 = new HashMap<>();
    param1.put("bookId", request.getBookId());
    param1.put("id", userId);

    if(reviewMapper.existReview(param1) > 0) {
      return new ReviewResponseDto(ReviewResultCd.ERR_ALREADY_EXIST);
    }
    //현재 시간
    LocalDateTime now = LocalDateTime.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    String formattedDate = now.format(formatter);

    //리뷰 등록 데이터 생성
    Map<String, Object> param = new HashMap<>();
    param.put("bookId", request.getBookId());
    param.put("id", userId);
    param.put("rating", request.getRating());
    param.put("content", request.getReviewContent());
    param.put("bookImage", request.getBookImage());
    param.put("bookTitle", request.getBookTitle());
    param.put("date", formattedDate);

    reviewMapper.insertReview(param); //리뷰등록

    // 삭제되지 않은 리뷰 목록 조회
    List<ReviewVO> activeReviews = reviewMapper.selectActiveReviews(request.getBookId());

    // 응답에 삭제되지 않은 리뷰 목록 포함
    return new ReviewResponseDto(ReviewResultCd.SUCCESS, activeReviews);

    //return new ReviewResponseDto(ReviewResultCd.SUCCESS);
  }

  public ReviewResponseDto addReviewLike(String userId, int reviewId) {
    Map<String, Object> param = new HashMap<>();
    param.put("reviewId", reviewId);
    param.put("id", userId);
    if(reviewMapper.existReviewLike(param) > 0) {
      reviewMapper.deleteReviewLike(param);
      reviewMapper.decreseReviewLikeCount(param);
    } else {
      reviewMapper.insertReviewLike(param);
      reviewMapper.increseReviewLikeCount(param);
    }

    return new ReviewResponseDto(ReviewResultCd.SUCCESS);
  }

  public Float getReviewAverage(String isbn) {
    return reviewMapper.selectReviewAverage(isbn);
  }

  public boolean deleteReview(String userId, int reviewId) {
    // 리뷰 가져오기
    ReviewVO review = reviewMapper.getReviewById(reviewId);

    if (review == null || !review.getId().equals(userId)) {
      // 리뷰가 없거나, 사용자가 작성한 리뷰가 아니면 삭제 불가
      return false;
    }
    // 논리 삭제 처리
    reviewMapper.updateIsDelete(reviewId, 0);
    // 삭제 후 평균 평점 계산
//    Float newAverage = getReviewAverage(review.getBookId()); // 기존 메서드 활용
//    if (newAverage == null) {
//      newAverage = 0.0f; // 리뷰가 없으면 평점을 0으로 초기화
//    }
//
//    // 평균 평점을 반환
//    System.out.println("New Average Rating: " + newAverage);
    return true;
  }

  // 삭제되지 않은 리뷰 목록 가져오기
  public List<ReviewVO> getActiveReviews(String bookId) {
    return reviewMapper.selectActiveReviews(bookId); // 삭제되지 않은 리뷰만 조회
  }
}
