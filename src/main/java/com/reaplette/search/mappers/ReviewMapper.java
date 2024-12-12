package com.reaplette.search.mappers;

import com.reaplette.domain.ReviewVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface ReviewMapper {
  // 리뷰 테이블
  Integer insertReview(Map<String, Object> param);
  Integer existReview(Map<String, Object> param);
  List<ReviewVO> selectReview(String bookId);
  Integer increseReviewLikeCount(Map<String, Object> param);
  Integer decreseReviewLikeCount(Map<String, Object> param);
  Float selectReviewAverage(String bookId);

  // 리뷰 좋아요 테이블
  Integer existReviewLike(Map<String, Object> param);
  Integer insertReviewLike(Map<String, Object> param);
  Integer deleteReviewLike(Map<String, Object> param);

  // 리뷰 ID로 리뷰 가져오기
  ReviewVO getReviewById(@Param("reviewId") int reviewId);
  // 리뷰 논리 삭제
  void updateIsDelete(@Param("reviewId") int reviewId, @Param("isDelete") int isDelete);
  // 리뷰 목록 가져오기 (isDelete = 1인 경우만)
  List<ReviewVO> selectActiveReviews(@Param("bookId") String bookId);

}
