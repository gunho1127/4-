package com.reaplette.search.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import java.util.List;

// 도서 DTO 추가
public class NaverSearchModel {

  @Getter
  @Builder
  @AllArgsConstructor
  @NoArgsConstructor
  public static class BookDetail { //도서 상세페이지
    private String title;  // 책 제목
    private String author; // 저자
    private String publisher; // 출판사
    private String description; // 책 설명
    private String image; //이미지
    private String isbn; //도서 번호
    private String pubdate; //출간일
  }

  @Getter
  @Builder
  @AllArgsConstructor
  @NoArgsConstructor
  public static class BookSearch {  //네이버 도서 검색 API의 전체 응답 데이터를 매핑한 객체
    private String lastBuildDate; // 응답 생성 날짜 및 시간
    private int total; // 검색 결과의 총 개수
    private int start; // 검색 시작 위치
    private int display; // 한 번에 반환된 검색 결과 개수
    private List<BookItem> items; // 개별 책 정보를 담은 리스트
  }

  @Getter
  @Builder
  @AllArgsConstructor
  @NoArgsConstructor
  public static class BookItem { //개별 책 정보를 매핑하는 객체
    private int num;
    private String title;        // 책 제목
    private String link;         // 네이버 책 상세 페이지 링크
    private String image;        // 책 표지 이미지 URL
    private String author;       // 저자
    private String discount;     // 책 할인 가격
    private String publisher;    // 출판사
    private String isbn;         // ISBN
    private String description;  // 책 설명
    private String pubdate;
    public void setBookNum(int num) {
      this.num = num;
    }
  }

  @Getter
  @Builder
  @AllArgsConstructor
  @NoArgsConstructor
  public static class Pagination<T> {
    private int totalPage;
    private int currentPage;
    private int pageSize;
    private int beginPage;
    private int endPage;
    private T data;

    public static <T> Pagination<T> of(T data, int totalPage, int currentPage, int pageSize) {
      int beginPage = ((currentPage - 1) / pageSize ) * pageSize + 1;
//      int endPage = Math.min(beginPage + pageSize - 1, totalPage);
//
//      return new Pagination<>(totalPage, currentPage, pageSize, beginPage, endPage, data);
      int endPage = beginPage + pageSize;
      if(beginPage + 5 > totalPage) {
        endPage = totalPage;
      }
      return new Pagination<>(totalPage, currentPage, pageSize, beginPage, endPage, data);
    }
  }
}
