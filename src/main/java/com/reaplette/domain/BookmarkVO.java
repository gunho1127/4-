package com.reaplette.domain;

import lombok.Data;

@Data
public class BookmarkVO {
    private String id; // 사용자 ID
    private String bookId; // 책 ID
    private String bookTitle; // 책 제목
    private String category; // 카테고리
    private int isDelete; // 삭제 여부 (기본값 1: 삭제되지 않음)

    private String bookImageUrl; // 이미지 URL 주소
}

