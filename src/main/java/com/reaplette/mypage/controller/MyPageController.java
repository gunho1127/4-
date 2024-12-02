package com.reaplette.mypage.controller;

import com.reaplette.domain.GoalVO;
import com.reaplette.domain.UserVO;
import com.reaplette.mypage.service.MyPageService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.apache.catalina.User;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Mod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/myPage")

public class MyPageController {

    private final MyPageService myPageService;

    @GetMapping("/info")
    public String getMyPageInfo(Model model,
                                HttpSession session) {
        log.info("GET /myPage/info - Accessing MyPage Info");
        //테스트 볼 때만 넣는 test@naver.com

        UserVO user = myPageService.getUser("test@naver.com");

        log.info(user);

        model.addAttribute("user", user);

        session.setAttribute("user",user); // 나는 로그인 상태가 되어있다.

        return "myPage/myPageInfo";
    }

    @PostMapping("/editInfo")
    public String postEditInfo(UserVO user,
                               Model model,
                               @RequestParam("profileImagePathForm") MultipartFile profileImagePathForm) {

        log.info("POST /myPage/editInfo - Editing MyPage Info");
        log.info(user);
        log.info("MultipartFile ? : " + profileImagePathForm.getOriginalFilename());

        // 파일을 저장해야하게 때문에 파일 자체 또한 파라미터로 넘긴다.
        myPageService.setUser(user, profileImagePathForm);

        // 리다이렉트
        return "redirect:/myPage/info";
    }

    @GetMapping("/checkUsername")
    public ResponseEntity<Map<String, Object>> checkUsername(@RequestParam String username) {
        log.info("GET /myPage/checkUsername - Check User Name");
        Map<String, Object> response = new HashMap<>();

        // 결과를 맵에 추가
        //false면 중복
        response.put("exists", myPageService.isUsernameExists(username));

        // 응답 반환
        return ResponseEntity.ok(response);
    }


    @GetMapping("/myGoalsList")
    public String getMyGoalsList() {
        log.info("GET /myPage/myGoalsList - Fetching My Goals List");
        return "myPage/myGoals/myGoalsList";
    }

    @GetMapping("/myGoalsAddBooks")
    public String getMyGoalsAddBooks() {
        log.info("GET /myPage/myGoalsAddBooks - Accessing My Goals Add Books");
        return "myPage/myGoals/myGoalsAddBooks";
    }

    @GetMapping("/myGoalsAddBooksModal")
    public String getMyGoalsAddBooksModal() {
        log.info("GET /myPage/myGoalsAddBooksModal - Accessing My Goals Add Books Modal");
        return "myPage/myGoals/myGoalsAddBooksModal";
    }

    @ResponseBody
    @GetMapping("/myGoals/search")
    public List<GoalVO> getSearchMyGoals(@RequestParam("keyword")String keyword) {
        log.info("GET /myPage/myGoals/search - Searching My Goals");
        log.info("keyword : {}", keyword);
        List<GoalVO> searchGoalList = myPageService.getSearchGoalList(keyword);
        return searchGoalList;
    }

    @PostMapping("/myGoals/select")
    public String postSelectMyGoals() {
        log.info("POST /myPage/myGoals/select - Selecting My Goals");
        return "myPage/myGoals/myGoalsAddBooks";
    }

    @PostMapping("/myGoals/register")
    public String postRegisterMyGoals() {
        log.info("POST /myPage/myGoals/register - Registering My Goals");
        return "myPage/myGoals/myGoalsList";
    }

//    @GetMapping("/myGoals/bookInfo")
//    public String getMyGoalBookInfo() {
//        log.info("GET /myPage/myGoals/bookInfo - Fetching My Goal Book Info");
//        return "myPage/myGoalBookInfo";
//    }

    @PostMapping("/myGoals/bookInfoRecord")
    public String postBookInfoRecord() {
        log.info("POST /myPage/myGoals/bookInfoRecord - Recording Book Info");
        return "myPage/myGoals/bookInfo";
    }

    @GetMapping("/myGoals/bookInfo")
    public String getMyGoalsBookInfo() {
        log.info("GET /myPage/myGoals/bookInfo - Fetching My Goals Book Info");
        return "myPage/myGoals/myGoalsBookInfo";
    }

    @GetMapping("/myGoals/bookInfo/delete")
    public String getDeleteBookInfo() {
        log.info("GET /myPage/myGoals/bookInfo/delete - Deleting Book Info");
        return "myPage/myGoals/myGoalsList";
    }

    @GetMapping("/myGoals/myGoalsWriteTranscription")
    public String getMyGoalsWriteTranscription() {
        log.info("GET /myPage//myGoals/myGoalsWriteTranscription - Fetching MyGoals Write Transcription");
        return "/myPage/myGoals/myGoalsWriteTranscription";
    }

    @PostMapping("/myGoals/bookInfo/postTrans")
    public String postTransBookInfo() {
        log.info("POST /myPage/myGoals/bookInfo/postTrans - Posting Translated Book Info");
        return "myPage/myGoals/myGoalBookInfo";
    }

    @PostMapping("/myGoals/bookInfo/editTrans")
    public String postEditTransBookInfo() {
        log.info("POST /myPage/myGoals/bookInfo/editTrans - Editing Translated Book Info");
        return "myPage/myGoals/myGoalBookInfo";
    }

    @GetMapping("/myGoals/bookInfo/deleteTrans")
    public String getDeleteTransBookInfo() {
        log.info("GET /myPage/myGoals/bookInfo/deleteTrans - Deleting Translated Book Info");
        return "myPage/myGoals/myGoalBookInfo";
    }

    @GetMapping("/bookmark")
    public String getBookmarkBooks() {
        log.info("GET /myPage/bookmark - Fetching Bookmark");
        return "myPage/bookmarkBooks";
    }

    @GetMapping("/following")
    public String getFollowing() {
        log.info("GET /myPage/following - Fetching Following List");
        return "myPage/following";
    }

    @GetMapping("/follower")
    public String getFollower() {
        log.info("GET /myPage/follower - Fetching Follower List");
        return "myPage/follower";
    }

    @GetMapping("/community")
    public String getCommunityList() {
        log.info("GET /myPage/community - Fetching Community List");
        return "myPage/communityList";
    }

    @GetMapping("/communityDetail")
    public String getCommunityDetail() {
        log.info("GET /myPage/communityDetail - Fetching Community Detail");
        return "myPage/communityDetail";
    }

    @GetMapping("/logout")
    public String logout() {
        log.info("GET /myPage/logout - logout");
        return "/index";
    }

    @GetMapping("/deleteUserGuide")
    public String getDeleteUserGuide() {
        log.info("GET /myPage/deleteUserGuide - Accessing Delete User Guide");
        return "myPage/deleteUserGuide";
    }
}
