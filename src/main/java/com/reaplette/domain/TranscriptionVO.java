package com.reaplette.domain;

import lombok.Data;

@Data
public class TranscriptionVO {
    private int transcriptionId; // 전사 ID
    private String id; // 사용자 ID
    private String bookId; // 책 ID
    private String transcriptionSentence; // 전사 문장
    private String transcriptionContent; // 전사 내용
    private String transcriptionDate;  // 전사 날짜 (YY/MM/DD 형식)
    private int isDelete = 0; // 삭제 여부 (기본값 0: 삭제되지 않음)
}
