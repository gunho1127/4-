package com.reaplette.search.controller;

//import com.reaplette.dao.BoardDAO;
//import com.reaplette.dao.UserDAO;
import com.reaplette.domain.*;
import com.reaplette.mypage.mappers.MyPageMapper;
import com.reaplette.mypage.service.MyPageService;
import com.reaplette.search.enums.ReviewResultCd;
import com.reaplette.search.model.ReviewModel;
import com.reaplette.search.model.ReviewResponseDto;
import com.reaplette.search.service.ReviewService;
import com.reaplette.search.model.NaverSearchModel.BookItem;
import com.reaplette.search.model.NaverSearchModel.Pagination;
import com.reaplette.search.service.BoardService;
import com.reaplette.search.service.BookService;
import com.reaplette.search.service.FollowService;
import com.reaplette.search.service.SearchService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;
import java.util.regex.Pattern;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/search")
public class SearchController {

    private final SearchService searchService;
    private final FollowService followService;
    private final BoardService boardService;
    private final BookService bookService;  //bookService 책정보
    // 추가
    private final ReviewService reviewService;
    private final MyPageService myPageService;



    private final List<FollowVO> followList = new ArrayList<>();  // 임시 팔로우 상태 저장

    // /search/total -> search/searchMain.jsp로 이동
    @GetMapping("/total")
    public String searchMain(@RequestParam("keyword") String keyword, HttpSession session,
                             Model model) {

        // 로그인된 사용자 정보를 세션에서 가져오기
        UserVO userVO = (UserVO)session.getAttribute("user");

        if( userVO == null) {
//            userVO = new UserVO();
//            userVO.setId("guest");
            session.setAttribute("user", userVO);
        }
        //String nowUserId = userVO.getId();


        model.addAttribute("user", userVO);
        model.addAttribute("keyword", keyword);
//
//        // 검색어 정리 및 검증
//        String sanitizedKeyword = sanitizeKeyword(keyword);
//        if (sanitizedKeyword.isEmpty()) {
//            model.addAttribute("message", "검색어에 허용되지 않는 문자가 포함되어 있습니다.");
//            return "search/searchException";
//        }
//
//        model.addAttribute("keyword", sanitizedKeyword);
//
//        // 사용자 검색 로직
//        List<UserVO> userList = searchService.searchUsersByKeyword(sanitizedKeyword, userVO.getId());
//        model.addAttribute("userList", userList);
//
//        // 게시물 검색 로직
//        List<BoardVO> boardList = boardService.searchPostsByKeyword(sanitizedKeyword);
//        model.addAttribute("boardList", boardList);
//
//        // 책 검색 로직
//        try {
//            Pagination<List<BookItem>> bookList = bookService.getBookList(sanitizedKeyword, 5, 1);
//            model.addAttribute("bookList", bookList.getData());
//        } catch (Exception e) {
//            model.addAttribute("message", "책 검색 중 오류가 발생했습니다.");
//            return "search/searchException";
//        }
//
//        return "search/searchMain";
//    }

//        // 공백 검색어 처리 여기서부터 주석처리
        if (keyword == null || keyword.trim().isEmpty() || !isValidKeyword(keyword)) {
            model.addAttribute("message", "올바른 검색어를 입력하세요.");
            model.addAttribute("keyword", keyword);
            return "search/searchException"; // 공백일 때  이동
        }

        // 특수 문자를 포함하는지 확인하는 정규식
        String specialCharsRegex = "[!@#$%^&*(),.?\":{}|<>]";
        // keyword가 빈 문자열이거나 특수 문자를 포함하는지 확인
        if (keyword.isEmpty() || Pattern.compile(specialCharsRegex).matcher(keyword).find()) {
            // 특수 문자를 포함하거나 keyword가 빈 문자열인 경우 처리
            model.addAttribute("message", "특수문자는 포함될 수 없습니다.");
            model.addAttribute("keyword", keyword);
            return "search/searchException"; // 특수 문자 예외 처리
        }
        // 사용자 검색 결과 처리
        List<UserVO> userList = new ArrayList<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            try {
                //System.out.println("검색어: " + keyword);// 검색어 출력 (디버깅 용도)
                //userList = searchService.searchUsersByKeyword(keyword, nowUserId);// 사용자 검색 서비스 호출

                // 현재 로그인된 사용자를 검색 결과에서 제거
                String currentUserId = userVO.getId(); // 현재 사용자의 ID
                userList.removeIf(user -> currentUserId.equals(user.getId()));
                // 검색 결과가 없을 때 처리
                if (userList.isEmpty()) {
                    model.addAttribute("message", "검색 결과가 없습니다.");
                }
            } catch (Exception e) {
                System.err.println("검색 중 오류 발생: " + e.getMessage());
                model.addAttribute("message", "검색 중 오류가 발생했습니다.");
            }
        }
        // 게시물 검색 로직
        List<BoardVO> boardList = new ArrayList<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            boardList = boardService.searchPostsByKeyword(keyword);
        }


        /*
        BookItem 책의 정보를 담고있는 DTO
        스프링이라는 단어를 검색했을때 키워드가 포함된 책 나열
         */
        Pagination<List<BookItem>> bookList = bookService.getBookList(keyword, 5, 1);

        // 검색 결과와 키워드를 Model에 추가
        model.addAttribute("userList", userList);
        System.out.println(userList);
        model.addAttribute("boardList" , boardList);
        model.addAttribute("keyword", keyword);
        model.addAttribute("bookList", bookList.getData());

        // 세션 사용자 정보 디버깅 출력
        System.out.println("Session user: " + session.getAttribute("user"));
        return "search/searchMain"; // JSP 경로에 맞게 수정
    }

    // /search/total/book -> search/total/searchBook.jsp로 이동
    @GetMapping("/total/book")
    public String searchBook(Model model, @RequestParam("keyword") String keyword, @RequestParam(value = "page", defaultValue = "1") Integer page) {
        //String encodedKeyword = URLEncoder.encode(keyword, StandardCharsets.UTF_8.toString());
        //String encodedKeyword = encodeKeyword(keyword); // URL 인코딩
//        try {
//            // 서비스 호출
//            Pagination<List<BookItem>> bookList = bookService.getBookList(keyword, 6, page);
//            model.addAttribute("bookList", bookList);
//            model.addAttribute("keyword", keyword);
//            return "search/total/searchBook";
//        } catch (IllegalArgumentException e) {
//            // 예외 발생 시 예외 처리 화면으로 이동
//            model.addAttribute("message", "검색어에 허용되지 않는 문자가 포함되어 있습니다.");
//            model.addAttribute("keyword", keyword);
//            return "search/total/searchExceptionBook";
//        }

        // 특수 문자를 포함하는지 확인하는 정규식
        String specialCharsRegex = "[!@#$%^&*(),.?\":{}|<>]";
        // keyword가 빈 문자열이거나 특수 문자를 포함하는지 확인
        if (keyword.isEmpty() || Pattern.compile(specialCharsRegex).matcher(keyword).find()) {
            // 특수 문자를 포함하거나 keyword가 빈 문자열인 경우 처리
            model.addAttribute("message", "특수문자는 포함될 수 없습니다.");
            model.addAttribute("keyword", keyword);
            return "search/total/searchExceptionBook"; // 특수 문자 예외 처리
        }

//        if (keyword.trim().isEmpty() || !isValidKeyword(keyword)) {
//            model.addAttribute("message", "검색어를 입력하지 않았습니다.");
//            model.addAttribute("keyword", keyword);
//            return "search/total/searchExceptionBook";
//        }
//
        // 검색어가 유효한 경우
        Pagination<List<BookItem>> bookList = bookService.getBookList(keyword, 6, page); //keyword를 sanitizedKeyword로 수정

        model.addAttribute("bookList", bookList);
        model.addAttribute("keyword", keyword); //keyword였음
        return "search/total/searchBook";

//        Pagination<List<BookItem>> bookList = bookService.getBookList(keyword, 6, page);
//
//        model.addAttribute("bookList", bookList);
//        model.addAttribute("keyword", keyword);
//        return "search/total/searchBook";
    }

    // /search/total/post -> search/total/searchPost.jsp로 이동
    @GetMapping("/total/post")
    public String searchPost(@RequestParam("keyword") String keyword,
                             @RequestParam(value = "sort", defaultValue = "recent") String sort,
                             Model model) {//@RequestParam("keyword") String keyword,Model model

        // 검색어 디코딩
        //keyword = URLDecoder.decode(keyword, StandardCharsets.UTF_8);


        // 공백 키워드 처리
//        if (keyword == null || keyword.trim().isEmpty()|| !isValidKeyword(keyword)) {
//            model.addAttribute("message", "올바른 검색어를 입력하세요.");
//            //model.addAttribute("userList", new ArrayList<>()); // 빈 사용자 목록 전달
//            model.addAttribute("keyword", keyword); // 검색어 유지
//            return "search/total/searchExceptionPost"; // 공백일 때 noKeyword.jsp로 이동
//        }
//
//        // 게시물 검색 로직
//        int pageSize = 5;
//        List<BoardVO> boardList = boardService.searchBoardsByKeywordAndSort(keyword, page, pageSize, sort);
//
//        // 데이터 추가
//        model.addAttribute("boardList", boardList);
//        model.addAttribute("currentPage", page);
//        model.addAttribute("pageSize", pageSize);
//        model.addAttribute("sort", sort);
//        model.addAttribute("keyword", keyword);
//
//        return "search/total/searchPost";


        //List<BoardVO> boardList = new ArrayList<>();
        if (keyword == null || keyword.trim().isEmpty()|| !isValidKeyword(keyword)) {
            model.addAttribute("message", "검색어를 입력하지 않았습니다.");
            model.addAttribute("keyword", keyword);
            return "search/total/searchExceptionPost"; // 공백 안내 JSP 경로

        }
//        else {
//            // 검색어가 있을 경우 해당 게시글 반환
//            boardList = boardService.searchBoardsByKeywordAndSort(keyword, sort);
//        }
        // 공백을 제거한 검색어
        String sanitizedKeyword = keyword.replaceAll("\\s+", "");

        // 검색 수행
        List<BoardVO> boardList = boardService.searchBoardsByKeywordAndSort(sanitizedKeyword, sort);

        model.addAttribute("boardList", boardList);
        //model.addAttribute("currentPage", page);
       // model.addAttribute("pageSize", pageSize);
        model.addAttribute("sort", sort); // 현재 정렬 기준 (recent or popular)
        model.addAttribute("keyword", keyword); // 현재 검색어

        return "search/total/searchPost";
    }

    //search/total/user -> search/total/searchUser.jsp로 이동
    @GetMapping("/total/user")
    public String searchUser(@RequestParam("keyword") String keyword, Model model,
                             HttpSession session) {

        //사용자 정보를 세션에서 가져오기
        UserVO user = (UserVO)session.getAttribute("user");
        if (user == null) {
            session.setAttribute("user", user);
        }
        // 공백 키워드 처리
        if (keyword == null || keyword.trim().isEmpty() || !isValidKeyword(keyword)) {
            model.addAttribute("message", "올바른 검색어를 입력하세요.");
            model.addAttribute("userList", new ArrayList<>()); // 빈 사용자 목록 전달
            model.addAttribute("keyword", keyword); // 검색어 유지
            return "search/total/searchExceptionUser"; // 공백일 때 noKeyword.jsp로 이동
        }

        // 특수 문자를 포함하는지 확인하는 정규식
//        String specialCharsRegex = "[!@#$%^&*(),.?\":{}|<>]";
//        // keyword가 빈 문자열이거나 특수 문자를 포함하는지 확인
//        if (keyword.isEmpty() || Pattern.compile(specialCharsRegex).matcher(keyword).find()) {
//            // 특수 문자를 포함하거나 keyword가 빈 문자열인 경우 처리
//            model.addAttribute("message", "특수문자는 포함될 수 없습니다.");
//            model.addAttribute("keyword", keyword);
//            return "search/total/searchExceptionBook"; // 특수 문자 예외 처리
//        }
        // 공백을 제거한 검색어
        String sanitizedKeyword = keyword.replaceAll("\\s+", "");

        // 비로그인 사용자는 user가 null로 설정됨
        List<UserVO> userList = searchService.searchUsersByKeyword(keyword, user != null ? user.getId() : null);

        // 현재 로그인한 사용자 제거 (비로그인 상태에서는 제거하지 않음)
        if (user != null && user.getId() != null) {
            List<UserVO> myData = userList.stream().filter(it -> user.getId().equals(it.getId())).toList();
            if (!myData.isEmpty()) {
                userList.remove(myData.get(0));
            }
        }


        // JSP에 전달
        model.addAttribute("userList", userList);
        model.addAttribute("keyword", keyword); //추가

        log.info("검색된 사용자 수: " + userList.size());
        log.info("검색 키워드 :" + keyword);

        return "search/total/searchUser"; // JSP 파일로 이동
    }

    // /search/total/user/follow -> search/total/searchUser.jsp로 이동 (POST 요청)
    @PostMapping("/total/user/follow")
    public @ResponseBody Map<String, String> toggleFollow (@RequestBody Map<String, String> data) {
        // 팔로우 상태 업데이트 추가
        Map<String, String> result = followService.updateFollow(data);
        return result;
    }

    // 추가
    // /search/total/book/detail -> search/total/searchBook/bookDetail.jsp로 이동
    @GetMapping("/total/book/detail")
    public String bookDetail(Model model, @RequestParam(name = "isbn") String isbn, HttpSession session) {
        UserVO user = (UserVO)session.getAttribute("user");
        if (user == null) {
            session.setAttribute("user", user);
        } else {
            List<BookmarkVO> bookmarkList = myPageService.getBookmarkList(user.getId());

            log.info("bookmarkList {}", bookmarkList);
            model.addAttribute("bookmarkList", bookmarkList);
        }

        BookItem bookDetail = bookService.getBookDetail(isbn);//책 상세 정보 가져오기
        List<ReviewVO> reviewList = reviewService.getActiveReviews(isbn);// 삭제되지 않은 리뷰 목록 가져오기
        // 평균 평점 계산
        float totalRating = 0;
        int validRatingsCount = 0; // 유효한 평점 개수만 카운트
        for (ReviewVO review : reviewList) {
           // if (review.getReviewRating() > 0 && review.getReviewRating() <= 5) {
            //if (review.getReviewRating() > 0 && review.getIsDelete() == 1) { // 삭제되지 않은 리뷰만 포함
            // 삭제되지 않은 리뷰(isDelete = 1) + 평점이 0~5 범위 내
//            if (review.getIsDelete() == 1 && review.getReviewRating() > 0 && review.getReviewRating() <= 5) {
//                totalRating += review.getReviewRating(); // reviewRating은 0~5점
//                validRatingsCount++;
//            }
            if (review.getIsDelete() == 1) { // 삭제되지 않은 리뷰만 포함
                totalRating += review.getReviewRating(); // 평점 합산
                validRatingsCount++;
            }
        }

        //float averageRating = reviewList.isEmpty() ? 0 : totalRating / reviewList.size();

        // 평균 점수 계산 및 2로 나누어 1~5로 변환
        float averageRating = validRatingsCount == 0 ? 0 : totalRating / validRatingsCount / 2.0f;
        BigDecimal roundedAverage = new BigDecimal(averageRating).setScale(1, RoundingMode.HALF_UP);
        //double starCount = averageRating; // 소수점 포함 별 개수
        // 별 개수 계산
        //double starCount = averageRating; // 소수점 포함 별 개수
        //int starCount = (int) Math.floor(averageRating / 2);
        int starCount = (int) Math.floor(averageRating); // 정수로 변환하여 별 개수 계산
        //Float reviewAverage = reviewService.getReviewAverage(isbn); // 리뷰 평균계산
        model.addAttribute("user", user);
        model.addAttribute("book", bookDetail);
        model.addAttribute("reviewList", reviewList);//활성화된 리뷰만 전달
        model.addAttribute("reviewAverage", roundedAverage);
        model.addAttribute("starCount", starCount);
        //model.addAttribute("reviewAverage", reviewAverage != null ? Math.round(reviewAverage) : 0);
        return "search/total/searchBook/bookDetail";
    }

    // 승연님 찜 도서 수정
    // /search/total/book/bookMark -> search/total/searchBook/bookDetail.jsp로 이동 (POST 요청)
    @PostMapping("/total/book/bookMark")
    public ResponseEntity<Map<String, String>> bookMark(HttpSession session,
                                                        @RequestBody BookmarkVO bookmark) {
        log.info("POST : /total/book/bookMark");

        // 세션에 user가 없으면 로그인 페이지로 리디렉션
        if ((UserVO) session.getAttribute("user") == null) {
            Map<String, String> response = new HashMap<>();
            response.put("redirectUrl", "/login/enterEmail");  // 리디렉션 URL 응답
            return ResponseEntity.ok(response);  // 200 OK로 리디렉션 URL 보내기
        } else {

            // 만약 bookImageUrl 값이 없다면 찜 해제
            if (bookmark.getBookImageUrl() == null) {
                log.info("deleteBookmark");
                searchService.deleteBookmark(bookmark);
            } else {
                log.info("setBookmark");
                bookmark.setIsDelete(1);

                bookmark.setCategory(searchService.getBookCategoryInfo(bookmark.getAuthor(),bookmark.getBookTitle())); // 크롤링 함수를 통해 카테고리 정보 수집

                log.info("bookmark {}", bookmark);

                // 취향 테이블에 정보 삽입
                PreferenceVO preference = new PreferenceVO();
                preference.setId(bookmark.getId());
                preference.setBookId(bookmark.getBookId());
                preference.setAuthor(bookmark.getAuthor());
                preference.setCategory(bookmark.getCategory());
                preference.setIsDelete(1);
                searchService.setPreference(preference);

                // 북마크 테이블에 정보 삽입
                searchService.setBookmark(bookmark);
            }

            // 북마크 등록 후 리디렉션 URL을 응답으로 보내기
            Map<String, String> response = new HashMap<>();
            response.put("redirectUrl", "/search/total/book/detail?keyword=''&isbn=" + bookmark.getBookId());
            return ResponseEntity.ok(response);  // 리디렉션 URL 반환
        }
    }

    // /search/total/book/review -> search/total/searchBook/bookDetail.jsp로 이동 (POST 요청)
    @PostMapping("/total/book/detail/review")
    @ResponseBody
    public ReviewResponseDto addReview(
            @ModelAttribute ReviewModel.ReviewRequest request,
            HttpSession session) {
        UserVO user = (UserVO)session.getAttribute("user");
        if (user == null) {
            return new ReviewResponseDto(ReviewResultCd.ERR_LOGIN);
        }

        return reviewService.addReview(request, user.getId());

    }

    // /search/total/book/reviewLike -> search/total/searchBook/bookDetail.jsp로 이동 (POST 요청)
    @PostMapping("/total/book/detail/review/like")
    @ResponseBody
    public ReviewResponseDto addReviewLike(
            @RequestParam("reviewId") int reviewId,
            HttpSession session) {
        UserVO user = (UserVO)session.getAttribute("user");
        if (user == null) {
            return new ReviewResponseDto(ReviewResultCd.ERR_LOGIN);
        }

        return reviewService.addReviewLike(user.getId(), reviewId);
    }

    // /search/total/book/reviewDelete -> search/total/searchBook/bookDetail.jsp로 이동 (POST 요청)
    @PostMapping("/total/book/detail/review/delete")
    @ResponseBody
    public ReviewResponseDto deleteReview(@RequestParam("reviewId") int reviewId,
                                          HttpSession session) {
        UserVO user = (UserVO) session.getAttribute("user"); // 로그인 사용자 정보 가져오기
        if (user == null) {
            return new ReviewResponseDto(ReviewResultCd.ERR_LOGIN); // 로그인하지 않은 사용자 처리
        }

        boolean isDeleted = reviewService.deleteReview(user.getId(), reviewId);
        if (!isDeleted) {
            return new ReviewResponseDto(ReviewResultCd.ERR_INVALID_PERMISSION); // 권한 없음 처리
        }
        // 삭제 후 평균 평점 계산
//        ReviewVO review = reviewMapper.getReviewById(reviewId); // 삭제된 리뷰의 bookId 가져오기
//        Float newAverage = reviewService.getReviewAverage(review.getBookId());
//        if (newAverage == null) {
//            newAverage = 0.0f; // 리뷰가 없으면 0.0으로 초기화
//        }
        return new ReviewResponseDto(ReviewResultCd.SUCCESS); // 삭제 성공
    }

    // URL 인코딩 메서드
//    private String encodeKeyword(String keyword) {
//        try {
//            return URLEncoder.encode(keyword, StandardCharsets.UTF_8.toString());
//        } catch (Exception e) {
//            throw new RuntimeException("키워드 인코딩 중 오류 발생", e);
//        }
//    }

    // 컨트롤러 내부에서 공통적으로 사용하는 키워드 검증 메서드
//    private boolean isValidKeyword(String keyword) {
//        String validPattern = "^[가-힣a-zA-Z0-9\\s]+$"; // 띄어쓰기 포함
//        return keyword != null && keyword.matches(validPattern);
//    }
    /**
     * 키워드에서 네이버 API에서 허용되지 않는 특수문자를 제거
     * @param keyword 원본 키워드
     * @return 허용된 문자만 포함된 키워드
     */
//    private String sanitizeKeyword(String keyword) {
//        // 네이버 API에서 허용되는 문자: 한글, 영어, 숫자, 공백, 일부 특수문자
//        String validPattern = "[^가-힣a-zA-Z0-9\\s]";
//        return keyword.replaceAll(validPattern, ""); // 허용되지 않는 문자를 제거
//    }

    // 검색어 정리 함수
//    private String sanitizeKeyword(String keyword) {
//        if (keyword == null || keyword.trim().isEmpty()) {
//            return "";
//        }
//        // 허용된 문자만 남기고 나머지 제거
//        return keyword.replaceAll("[^가-힣a-zA-Z0-9\\s]", "").trim();
//    }
    // 컨트롤러 내부에서 공통적으로 사용하는 키워드 검증 메서드
//    private boolean isValidKeyword(String keyword) {
//        String validPattern = "^[가-힣a-zA-Z0-9\\-_.!~*'()@#$%^&+=]*$";
//        return keyword != null && !keyword.trim().isEmpty() && keyword.matches(validPattern);
//    }

    private boolean isValidKeyword(String keyword) {
        String validPattern = "^[가-힣a-zA-Z0-9\\-_.!~*'()@#$%^&+=\\s]+$"; // 공백 포함
        return keyword != null && !keyword.trim().isEmpty() && keyword.matches(validPattern);
    }
}