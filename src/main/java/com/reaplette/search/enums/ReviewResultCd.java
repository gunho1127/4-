package com.reaplette.search.enums;

import lombok.Getter;



@Getter
public enum ReviewResultCd {
  SUCCESS("SUCCESS", "성공"),
  ERR_ALREADY_EXIST("ERR_ALREADY_EXIST", "이미 등록되어 있습니다."),
  ERR_LOGIN("ERR_LOGIN", "로그인이 필요합니다."),
  ERR_INVALID_PERMISSION("ERR_INVALID_PERMISSION", "삭제 권한이 없습니다");


  ReviewResultCd(String resultCode, String message) {
    this.resultCode = resultCode;
    this.message = message;
  }

  private final String resultCode;
  private final String message;
}

