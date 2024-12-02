package com.reaplette.domain;

import lombok.Data;

@Data
public class FollowVO {
    private String followingId; // 팔로잉하는 사용자 ID
    private String followerId;  // 팔로우하는 사용자 ID
}
