package com.reaplette.search.service;

import com.reaplette.domain.BookmarkVO;
import com.reaplette.domain.FollowVO;
import com.reaplette.domain.PreferenceVO;
import com.reaplette.domain.UserVO;
import com.reaplette.search.mappers.SearchMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Log4j2
@RequiredArgsConstructor
@Transactional
public class SearchService {
    private final SearchMapper searchMapper;

    public List<UserVO> getAllUsers(String userName) {
        List<UserVO> userList = searchMapper.getAllUsers(userName);
        if (userList == null || userList.isEmpty()) {
            throw new IllegalStateException("사용자 목록이 비어 있습니다.");
        }
        log.info("getAllUsers 호출...");
        return searchMapper.getAllUsers(userName);
    }

    public List<FollowVO> getFollowList(String userId) {
        log.info("getFollowList 호출...");
        return searchMapper.getFollowList(userId);
    }

    public List<UserVO> searchUsersByKeyword(String keyword, String id) {
        String sanitizedKeyword = keyword.replaceAll("\\s+", "");
        log.info("searchUsersByKeyword 호출...");
        System.out.println("ID: " + id + ", Keyword: " + keyword);

        // 파라미터를 Map으로 구성
        Map<String, Object> params = new HashMap<>();
        params.put("id", id);        // 'id'를 맵에 넣음
        params.put("keyword", keyword);  // 'keyword'를 맵에 넣음

        // Mapper 호출 (Map으로 파라미터 전달)
        List<UserVO> userList = searchMapper.searchUsersByKeyword(params);

        // 검색 결과가 없을 경우 예외 처리
        if (userList == null || userList.isEmpty()) {
            log.info("검색 결과가 없습니다.");
            return new ArrayList<>();  // 빈 리스트 반환
        }

        return userList;
    }


    //    찜 도서 승연님 여기 추가 !!
    public void setBookmark(BookmarkVO bookmark) {
        searchMapper.setBookmark(bookmark);
    }

    public void deleteBookmark(BookmarkVO bookmark) {
        searchMapper.deleteBookmark(bookmark);
    }

    public void setPreference(PreferenceVO preference) {
        searchMapper.setPreference(preference);
    }


    public String getBookCategoryInfo(String isbn) {
        try {
            String encodedQuery = URLEncoder.encode(isbn, StandardCharsets.UTF_8);

            // 알라딘 검색 URL로 요청
            String searchUrl = "https://www.aladin.co.kr/search/wsearchresult.aspx?SearchTarget=All&SearchWord=" + encodedQuery;
            System.out.println(searchUrl);
            Document doc = Jsoup.connect(searchUrl).get();

            // 검색 결과에서 책의 링크 찾기
            Elements bookLinks = doc.select(".bo3");
            if (bookLinks.isEmpty()) {
                return null; // 책 링크가 없으면 null 반환
            }

            // 책의 상세 페이지 링크 가져오기
            Element firstBookLink = bookLinks.first();
            String bookUrl = firstBookLink.attr("href");

            // 책 상세 페이지에서 카테고리 추출
            Document bookPage = Jsoup.connect(bookUrl).get();
            Elements categoryElements = bookPage.select(".conts_info_list2 #ulCategory li a:nth-of-type(3)");

            if (!categoryElements.isEmpty()) {
                return categoryElements.first().text(); // 카테고리 문자열 반환
            } else {
                return null; // 카테고리 정보가 없으면 null 반환
            }
        } catch (IOException e) {
            e.printStackTrace();
            return null; // 예외 발생 시 null 반환
        }
    }
//    private final SearchMapper userMapper; // 자동 주입
//
//    public UserVO getUser(String id) {
//        log.info("getUser....." + id);
//        return userMapper.getUser(id);
//    }
}