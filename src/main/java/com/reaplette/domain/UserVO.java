package com.reaplette.domain;

import lombok.Data;

@Data
public class UserVO {
    private String id; // 사용자 ID
    private String pw; // 비밀번호
    private String username; // 사용자 이름
    private String profileImagePath; // 프로필 이미지 경로
    private String signInDate; // 가입 날짜 (YY/MM/DD 형식)
    private int isDelete = 1; // 삭제 여부 (기본값 1: 삭제된 상태)

    private String isFollowing ; // 검색 할때 (팔로우 여부 판별)변수

    private String loginType;
    private String idKey;

}

