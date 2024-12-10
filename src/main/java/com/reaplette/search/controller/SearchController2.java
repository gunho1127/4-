//package com.reaplette.search.controller;
//
//
//import com.reaplette.domain.BoardVO;
//import com.reaplette.domain.UserVO;
//import com.reaplette.search.model.NaverSearchModel.BookItem;
//import com.reaplette.search.model.NaverSearchModel.Pagination;
//import com.reaplette.search.service.BoardService;
//import com.reaplette.search.service.BookService;
//import com.reaplette.search.service.FollowService;
//import com.reaplette.search.service.SearchService;
//import jakarta.servlet.http.HttpSession;
//import lombok.RequiredArgsConstructor;
//import lombok.extern.log4j.Log4j2;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.*;
//
//import java.net.URLDecoder;
//import java.nio.charset.StandardCharsets;
//import java.util.List;
//
//    @Controller
//    @Log4j2
//    @RequiredArgsConstructor
//    @RequestMapping("/search")
//    public class SearchController2 {
//
//        private final SearchService searchService;
//        private final FollowService followService;
//        private final BoardService boardService;
//        private final BookService bookService;
//
//        // /search/total -> search/searchMain.jsp로 이동
//        @GetMapping("/total")
//        public String searchMain(@RequestParam("keyword") String keyword, HttpSession session, Model model) {
//            String processedKeyword = processKeyword(keyword);
//            if (processedKeyword == null) {
//                model.addAttribute("message", "검색 규칙을 확인하세요.");
//                return "search/searchException"; // 예외 처리 페이지로 이동
//            }
//
//            // 로그인된 사용자 정보를 세션에서 가져오기
//            UserVO userVO = (UserVO) session.getAttribute("user");
//            if (userVO == null) {
//                userVO = new UserVO();
//                userVO.setId("guest");
//                session.setAttribute("user", userVO);
//            }
//
//            String nowUserId = userVO.getId();
//            model.addAttribute("user", userVO);
//
//            // 사용자 검색
//            List<UserVO> userList = searchService.searchUsersByKeyword(processedKeyword, nowUserId);
//            userList.removeIf(user -> nowUserId.equals(user.getId())); // 현재 사용자 제거
//
//            // 게시물 검색
//            List<BoardVO> boardList = boardService.searchPostsByKeyword(processedKeyword);
//
//            // 책 검색
//            Pagination<List<BookItem>> bookList = bookService.getBookList(processedKeyword, 5, 1);
//
//            model.addAttribute("userList", userList);
//            model.addAttribute("boardList", boardList);
//            model.addAttribute("bookList", bookList.getData());
//            model.addAttribute("keyword", processedKeyword);
//
//            return "search/searchMain";
//        }
//
//        // /search/total/book -> search/total/searchBook.jsp로 이동
//        @GetMapping("/total/book")
//        public String searchBook(Model model, @RequestParam("keyword") String keyword, @RequestParam("page") Integer page) {
//            String processedKeyword = processKeyword(keyword);
//            if (processedKeyword == null) {
//                model.addAttribute("message", "검색 규칙을 확인하세요.");
//                return "search/total/searchExceptionBook"; // 예외 처리 페이지로 이동
//            }
//
//            Pagination<List<BookItem>> bookList = bookService.getBookList(processedKeyword, 6, page);
//            model.addAttribute("bookList", bookList);
//            model.addAttribute("keyword", processedKeyword);
//
//            return "search/total/searchBook";
//        }
//
//        // /search/total/post -> search/total/searchPost.jsp로 이동
//        @GetMapping("/total/post")
//        public String searchPost(@RequestParam("keyword") String keyword,
//                                 @RequestParam(value = "page", defaultValue = "1") int page,
//                                 @RequestParam(value = "sort", defaultValue = "recent") String sort,
//                                 Model model) {
//            String processedKeyword = processKeyword(keyword);
//            if (processedKeyword == null) {
//                model.addAttribute("message", "검색 규칙을 확인하세요.");
//                return "search/total/searchExceptioPost"; // 예외 처리 페이지로 이동
//            }
//
//            List<BoardVO> boardList = boardService.searchBoardsByKeywordAndSort(processedKeyword, page, 5, sort);
//            model.addAttribute("boardList", boardList);
//            model.addAttribute("currentPage", page);
//            model.addAttribute("sort", sort);
//            model.addAttribute("keyword", processedKeyword);
//
//            return "search/total/searchPost";
//        }
//
//        // /search/total/user -> search/total/searchUser.jsp로 이동
//        @GetMapping("/total/user")
//        public String searchUser(@RequestParam("keyword") String keyword, Model model, HttpSession session) {
//            String processedKeyword = processKeyword(keyword);
//            if (processedKeyword == null) {
//                model.addAttribute("message", "검색 규칙을 확인하세요.");
//                return "search/total/searchExceptionUser"; // 예외 처리 페이지로 이동
//            }
//
//            UserVO user = (UserVO) session.getAttribute("user");
//            if (user == null) {
//                throw new IllegalStateException("세션에 사용자 정보가 없습니다.");
//            }
//
//            List<UserVO> userList = searchService.searchUsersByKeyword(processedKeyword, user.getId());
//            userList.removeIf(it -> user.getId().equals(it.getId()));
//
//            model.addAttribute("userList", userList);
//            model.addAttribute("keyword", processedKeyword);
//
//            return "search/total/searchUser";
//        }
//
//        // 검색어를 처리하는 공통 메서드
//        private String processKeyword(String keyword) {
//            if (keyword == null || keyword.trim().isEmpty()) {
//                return null; // 공백만 있는 경우
//            }
//
//            // 디코딩 후 허용되지 않는 특수문자 제거
//            try {
//                keyword = URLDecoder.decode(keyword, StandardCharsets.UTF_8.toString());
//            } catch (Exception e) {
//                throw new RuntimeException("키워드 디코딩 중 오류 발생", e);
//            }
//
//            String validPattern = "^[가-힣a-zA-Z0-9\\s]+$";
//            if (keyword.matches(validPattern)) {
//                return keyword.trim(); // 유효한 검색어
//            }
//
//            // 특수문자 제거
//            String sanitizedKeyword = keyword.replaceAll("[^가-힣a-zA-Z0-9\\s]", "").trim();
//            return sanitizedKeyword.isEmpty() ? null : sanitizedKeyword;
//        }
//
//        // 예외 처리 화면으로 이동하는 공통 메서드
//
//    }
//
//
