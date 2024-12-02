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
    private int followerCount = 0; // 팔로워 수
    private int followingCount = 0; // 팔로잉 수
}

