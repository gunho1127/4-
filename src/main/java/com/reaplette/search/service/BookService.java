package com.reaplette.search.service;

import com.reaplette.search.external.NaverBookSearchClient;
//import com.reaplette.search.external.NaverBookSearchXmlClient;
import com.reaplette.search.model.NaverSearchModel;
import com.reaplette.search.model.NaverSearchModel.BookItem;
import com.reaplette.search.model.NaverSearchModel.BookSearch;
import com.reaplette.search.model.NaverSearchModel.Pagination;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@Service
@RequiredArgsConstructor
public class BookService {
  @Value("${client.id}") private String clientId;
  @Value("${client.secret}") private String clientSecret;

  private final NaverBookSearchClient naverBookSearchClient;

  public Pagination<List<BookItem>> getBookList(String query, int display, int start) {
//    // 검색어 정리
//    String sanitizedQuery = sanitizeKeywordForNaver(query);
//
//    // 검색어가 유효하지 않으면 예외 발생
//    if (sanitizedQuery.isEmpty()) {
//      throw new IllegalArgumentException("유효하지 않은 검색어입니다.");
//    }

    //String encodedQuery = URLEncoder.encode(query, StandardCharsets.UTF_8);//추가
    // display 값을 100으로 제한
    display = Math.min(display, 100);

    // start 값을 100 이하로 제한
    if (start > 100) {
      start = 100;
    }
    //네이버 API 호출
    BookSearch bookList = naverBookSearchClient.getBookList(clientId, clientSecret, query, display, start, "sim");

    List<BookItem> bookItems = bookList.getItems();
    for(int i = 0; bookList.getItems().size() > i; i++) {
      bookItems.get(i).setBookNum((i + 1) + display * (start - 1));
    }
    //return Pagination.of(bookItems, bookList.getTotal()/display, bookList.getStart(), 5);
      return Pagination.of(bookItems, Math.min(100, bookList.getTotal()), bookList.getStart(), 5);
  }

  public BookItem getBookDetail(String isbn) {
    // JSON 응답 처리
    BookSearch bookDetail = naverBookSearchClient.getBookDetail(clientId, clientSecret, isbn, 1);

    // 첫 번째 책 정보를 반환
    return bookDetail.getItems().get(0);
  }
  // 검색어 정리 함수
  private String sanitizeKeywordForNaver(String keyword) {
    // 네이버 API에서 허용된 문자: 한글, 영어, 숫자, 공백
    return keyword.replaceAll("[^가-힣a-zA-Z0-9\\s]", "").trim();
  }

}


