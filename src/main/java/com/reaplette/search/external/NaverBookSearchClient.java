package com.reaplette.search.external;

import com.reaplette.config.DefaultFeignClientConfig;
import com.reaplette.search.model.NaverSearchModel.BookSearch;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;

// 네이버 API
@FeignClient(name = "NaverBookSearchCleint", url = "https://openapi.naver.com/v1/search", configuration = DefaultFeignClientConfig.class) //네이버API와 통신
public interface NaverBookSearchClient {

  @GetMapping("book.json") //검색어
  BookSearch getBookList(
      @RequestHeader("X-Naver-Client-Id") String clientId, //네이버 API 인증을 위한 클라이언트 ID
      @RequestHeader("X-Naver-Client-Secret") String secretKey,// 네이버 API 인증을 위한 클라이언트 비밀번호.
      @RequestParam("query") String query,//검색어
      @RequestParam("display") Integer display ,//검색 결과 수.
      @RequestParam("start") Integer start, //한페이지에 몇개
      @RequestParam("sort") String sort //관련도순
  );

  @GetMapping("book.json")
  BookSearch getBookDetail(
      @RequestHeader("X-Naver-Client-Id") String clientId,
      @RequestHeader("X-Naver-Client-Secret") String secretKey,
      @RequestParam("query") String query, // query 파라미터로 ISBN 전달
      @RequestParam("display") int display
      //@RequestParam("d_isbn") String isbn
  );
}
