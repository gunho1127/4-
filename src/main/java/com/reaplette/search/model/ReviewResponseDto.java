package com.reaplette.search.model;

import com.reaplette.search.enums.ReviewResultCd;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ReviewResponseDto {
  private String resultCode;
  private String message;
  private Object data;

  public ReviewResponseDto(ReviewResultCd reviewResultCd, Object data) {
    this.resultCode = reviewResultCd.getResultCode();
    this.message = reviewResultCd.getMessage();
    this.data = data;

  }


  public ReviewResponseDto(ReviewResultCd reviewResultCd) {
    this.resultCode = reviewResultCd.getResultCode();
    this.message = reviewResultCd.getMessage();
    this.data = null; // 데이터가 없는 경우 null로 설정
  }
}
