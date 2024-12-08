package com.reaplette.search.controller;

//import com.reaplette.dao.BoardDAO;
//import com.reaplette.dao.UserDAO;
import com.reaplette.domain.BoardVO;
import com.reaplette.domain.FollowVO;
import com.reaplette.domain.UserVO;
import com.reaplette.search.model.NaverSearchModel.BookItem;
import com.reaplette.search.service.BoardService;
import com.reaplette.search.service.BookService;
import com.reaplette.search.service.FollowService;
import com.reaplette.search.service.SearchService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.*;
import java.util.stream.Stream;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/search")
public class SearchController {

    private final SearchService searchService;
    private final FollowService followService;
    private final BoardService boardService;
    private final BookService bookService;  //bookService 책정보



    private final List<FollowVO> followList = new ArrayList<>();  // 임시 팔로우 상태 저장

    // /search/total -> search/searchMain.jsp로 이동
    @GetMapping("/total")
    public String searchMain(@RequestParam("keyword") String keyword, HttpSession session,
                             Model model) {
        // 로그인된 사용자 정보를 세션에서 가져오기
        //UserVO userVO = (UserVO) session.getAttribute("user");
        UserVO userVO = (UserVO)session.getAttribute("user");
        log.info(userVO);

        if( userVO == null) {
            userVO = new UserVO();
            userVO.setId("guest");
            session.setAttribute("user", userVO);
        }
        String nowUserId = userVO.getId();
        System.out.println(nowUserId);

        model.addAttribute("user", userVO);

        // 세션에 사용자 정보가 없는 경우 (비로그인 상태)
//        if (userVO == null) {
//            // 기본 사용자 정보 설정 (로그인 기능 구현 전 가짜 데이터)
//            userVO = new UserVO();
//            userVO.setId("aaaaa@gmail.com");
//            session.setAttribute("user", userVO); // 세션에 저장
//        }
//        model.addAttribute("user", userVO); // JSP에서 사용할 사용자 정보를 Model에 추가

        // 공백 검색어 처리
        if (keyword == null || keyword.trim().isEmpty() || !isValidKeyword(keyword)) {
            model.addAttribute("message", "올바른 검색어를 입력하세요.");
            model.addAttribute("keyword", keyword);
            return "search/searchException"; // 공백일 때 noKeyword.jsp로 이동
        }
        // 사용자 검색 결과 처리
        List<UserVO> userList = new ArrayList<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            try {
                System.out.println("검색어: " + keyword);// 검색어 출력 (디버깅 용도)
                userList = searchService.searchUsersByKeyword(keyword, nowUserId);// 사용자 검색 서비스 호출

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

        // 검색 결과와 키워드를 Model에 추가
        model.addAttribute("userList", userList);
        System.out.println(userList);
        model.addAttribute("boardList" , boardList);
        model.addAttribute("keyword", keyword);

        /*
        BookItem 책의 정보를 담고있는 DTO
        스프링이라는 단어를 검색했을때 키워드가 포함된 책 나열
         */
        List<BookItem> bookList = bookService.getBookList("스프링");
        model.addAttribute("bookList", bookList);

        // 세션 사용자 정보 디버깅 출력
        System.out.println("Session user: " + session.getAttribute("user"));
        return "search/searchMain"; // JSP 경로에 맞게 수정
    }

    // /search/total/book -> search/total/searchBook.jsp로 이동
    @GetMapping("/total/book")
    public String searchBook() {
        //System.out.println("ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ");
        return "search/total/searchBook";
    }

    // /search/total/author -> search/total/searchAuthor.jsp로 이동
    @GetMapping("/total/author")
    public String searchAuthor(){//Model model
        //model.addAttribute("authorBooks", new ArrayList<>());
        //System.out.println("ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ");
        return "search/total/searchAuthor";
    }

    // /search/total/post -> search/total/searchPost.jsp로 이동
    @GetMapping("/total/post")
    public String searchPost(@RequestParam("keyword") String keyword,
                             @RequestParam(value = "page", defaultValue = "1") int page,
                             @RequestParam(value = "sort", defaultValue = "recent") String sort,
                             Model model) {//@RequestParam("keyword") String keyword,Model model

        int pageSize = 5;
        //List<BoardVO> boardList = boardService.searchPosts(keyword);
        List<BoardVO> boardList = new ArrayList<>();
        if (keyword == null || keyword.trim().isEmpty()|| !isValidKeyword(keyword)) {
            model.addAttribute("message", "검색어를 입력하지 않았습니다.");
            model.addAttribute("keyword", keyword);
            return "search/total/searchExceptionPost"; // 공백 안내 JSP 경로
            // 검색어가 없을 경우 전체 게시글 반환
            //4boardList = boardService.getBoardsByPageAndSort(page, pageSize, sort);
            //boardList = boardService.getBoardsByPage(page, pageSize);
            //System.out.println("Profile Image Path: " + board.getProfileImagePath());

        } else {
            // 검색어가 있을 경우 해당 게시글 반환
            boardList = boardService.searchBoardsByKeywordAndSort(keyword, page, pageSize, sort);
            //boardList = boardService.searchBoards(keyword);
        }
        model.addAttribute("boardList", boardList);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("sort", sort); // 현재 정렬 기준 (recent or popular)
        model.addAttribute("keyword", keyword); // 현재 검색어

        return "search/total/searchPost";
        //model.addAttribute("keyword", keyword); // 입력한 키워드 전달
        //BoardDAO boardDAO = new BoardDAO();
        //UserDAO userDAO = new UserDAO();

        // 게시글 데이터 가져오기
        //List<BoardVO> boardList = boardDAO.getBoardList(sort);


        // model.addAttribute("boardList", boardList); // 게시글 리스트 전달
        // model.addAttribute("userMap", userMap); // 사용자 ID와 UserVO의 매핑 전달
        //  model.addAttribute("totalResults", boardList.size()); // 결과 개수
        //   model.addAttribute("sort", sort); // 정렬 기준


    }

    //search/7total/user -> search/total/searchUser.jsp로 이동
    @GetMapping("/total/user")
    public String searchUser(@RequestParam("keyword") String keyword, Model model,
                             HttpSession session) {

        // 로그인된 사용자 정보를 세션에서 가져오기
        UserVO user = (UserVO)session.getAttribute("user");
        if (user == null) {
            throw new IllegalStateException("세션에 사용자 정보가 없습니다.");
        }

        // 공백 키워드 처리
        if (keyword == null || keyword.trim().isEmpty()|| !isValidKeyword(keyword)) {
            model.addAttribute("message", "올바른 검색어를 입력하세요.");
            model.addAttribute("userList", new ArrayList<>()); // 빈 사용자 목록 전달
            model.addAttribute("keyword", keyword); // 검색어 유지
            return "search/total/searchExceptionUser"; // 공백일 때 noKeyword.jsp로 이동
        }

        // 검색 키워드에 따라 사용자 목록 가져오기 (검색 서비스 호출)
        List<UserVO> userList = searchService.searchUsersByKeyword(keyword, user.getId());

        //현재 로그인한 사용자 제거(팔로우 관련)
        List<UserVO> myData = userList.stream().filter(it -> user.getId().equals(it.getId())).toList();
        if(!myData.isEmpty()) {
            userList.remove(myData.get(0));
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

        // 현재 팔로우 상태 조회
        //model.addAttribute("followingSet", followingSet);

//        // 팔로우 상태 업데이트
//        followService.updateFollow(followingId, followerId);
//
//        // 팔로우 상태 다시 조회
//        Map<String, String> param = new HashMap<>();
//        param.put("followerId", followerId);
//        param.put("followingId", followingId);

//        FollowVO followStatus = followService.getFollowStatus(param);
//        // 세션 업데이트 또는 모델에 반영
//        session.setAttribute("followStatus", followStatus);
        //List<FollowVO> followList = searchService.getFollowList(followingId);
        //model.addAttribute("followList", followList);
        //followService.updateFollow(followerId, followingId);

        return result;
    }

    // /search/total/book/detail -> search/total/searchBook/bookDetail.jsp로 이동
    @GetMapping("/total/book/detail")
    public String bookDetail() {
        System.out.println("ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ");
        return "search/total/searchBook/bookDetail";
    }

    // /search/total/book/bookMark -> search/total/searchBook/bookDetail.jsp로 이동 (POST 요청)
    @PostMapping("/total/book/bookMark")
    public String bookMark() {
        return "search/total/searchBook/bookDetail";
    }

    // /search/total/book/review -> search/total/searchBook/bookDetail.jsp로 이동 (POST 요청)
    @PostMapping("/total/book/review")
    public String addReview() {
        return "search/total/searchBook/bookDetail";
    }

    // /search/total/book/reviewLike -> search/total/searchBook/bookDetail.jsp로 이동 (POST 요청)
    @PostMapping("/total/book/reviewLike")
    public String likeReview() {
        return "search/total/searchBook/bookDetail";
    }

    // /search/total/book/reviewDelete -> search/total/searchBook/bookDetail.jsp로 이동 (POST 요청)
    @PostMapping("/total/book/reviewDelete")
    public String deleteReview() {
        return "search/total/searchBook/bookDetail";
    }

    // 컨트롤러 내부에서 공통적으로 사용하는 키워드 검증 메서드
    private boolean isValidKeyword(String keyword) {
        String validPattern = "^[가-힣a-zA-Z0-9]{1,}$";
        return keyword != null && keyword.matches(validPattern);
    }
}