package com.reaplette.domain;

import lombok.Data;

@Data
public class UserVO {
    private String id; // 사용자 ID
    private String pw; // 비밀번호
    private String username; // 사용자 이름
    private String profileImagePath; // 프로필 이미지 경로
    private String signInDate; // 가입 날짜 (YY/MM/DD 형식)
    private int isDelete; // 삭제 여부 (기본값 1: 실존 상태)
    private String loginType; // 로그인 타입 (local, naver, admin)
    private String idKey; // 네이버 고유 ID
}

