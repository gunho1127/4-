package com.reaplette.domain;

import lombok.Data;

@Data
public class GoalVO {
    private String id; // 사용자 ID (USER.id)
    private String bookId; // 책 ID
    private int pagesRead = 0; // 읽은 페이지 수
    private int totalPage = 0; // 전체 페이지 수
    private String startDate;  // 시작 날짜 (YY/MM/DD 형식)
    private String goalDate;   // 목표 날짜 (YY/MM/DD 형식)
    private int isDelete = 0;  // 삭제 여부 (기본값 0: 삭제되지 않음)
}
