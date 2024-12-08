package com.reaplette.search.service;

import com.reaplette.search.external.NaverBookSearchClient;
import com.reaplette.search.model.NaverSearchModel.BookItem;
import com.reaplette.search.model.NaverSearchModel.BookSearch;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;

// 신규추가
@Service
@RequiredArgsConstructor
public class BookService {
  @Value("${client.id}") private String clientId;
  @Value("${client.secret}") private String clientSecret;

  private final NaverBookSearchClient naverBookSearchClient;

  public List<BookItem> getBookList(String query) {
    BookSearch bookList = naverBookSearchClient.getBookList(clientId, clientSecret, query, 5);

    return bookList.getItems();
  }
}
