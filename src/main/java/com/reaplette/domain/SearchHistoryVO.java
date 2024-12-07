package com.reaplette.domain;

import lombok.Data;

@Data
public class SearchHistoryVO {
    private String id; // 사용자 ID
    private String searchHistory; // 검색 기록
}
