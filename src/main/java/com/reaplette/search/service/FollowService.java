package com.reaplette.search.service;

import com.reaplette.domain.FollowVO;
import com.reaplette.search.mappers.FollowerMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class FollowService {

  private final FollowerMapper followerMapper;

  public Map<String, String> updateFollow(Map<String, String> param) {
    Map<String, String> result = new HashMap<String, String>();
    FollowVO followVO = followerMapper.searchFollow(param);
    if(followVO != null) {
      int num = followerMapper.deleteFollow(param);
      result.put("result", "팔로우");
    } else {
      int num = followerMapper.insertFollow(param);
      result.put("result", "팔로잉");
    }
    return result;
  }
}