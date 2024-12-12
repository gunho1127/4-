package com.reaplette.mypage.controller;

import com.reaplette.domain.*;
import com.reaplette.mypage.service.MyPageService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Collections;
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
        //병합시엔 코드를 지우세요
        // test@naver.com 으로 세션 등록해주는 코드.
        // session.setAttribute("user", myPageService.getUser("test@naver.com"));
        //병합시엔 코드를 지우세요

        UserVO user = (UserVO) session.getAttribute("user");
        log.info("user {}", user);
        model.addAttribute("user", user);
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
    public ResponseEntity<Map<String, Object>> checkUsername(@RequestParam String username,
                                                             HttpSession session) {
        log.info("GET /myPage/checkUsername - Check User Name");
        Map<String, Object> response = new HashMap<>();
        UserVO user = (UserVO) session.getAttribute("user");
        // 결과를 맵에 추가

        boolean plag = myPageService.isUsernameExists(user.getId(), username);
        //false면 중복
        //true면 안중복

        if (plag) {
            user.setUsername(username);
            session.setAttribute("username", user.getUsername());
            response.put("exists", true);

        } else {
            response.put("exists", false);
        }
        // 응답 반환
        return ResponseEntity.ok(response);
    }


    @GetMapping("/myGoalsList")
    public String getMyGoalsList(Model model,
                                 HttpSession session) {
        log.info("GET /myPage/myGoalsList - Fetching My Goals List");
        UserVO user = (UserVO) session.getAttribute("user");
        List<GoalVO> goalList = myPageService.getUserGoalList(user.getId());
        Collections.reverse(goalList);
        log.info(model.addAttribute("goalList", goalList));

        return "myPage/myGoals/myGoalsList";
    }

    @GetMapping("/myGoals/AddBooks")
    public String getMyGoalsAddBooks() {
        return "/myPage/myGoals/myGoalsAddBooks";
    }


    @ResponseBody
    @GetMapping("/myGoals/search")
    public List<GoalVO> getSearchMyGoals(@RequestParam("keyword") String keyword) {
        log.info("GET /myPage/myGoals/search - Searching Goals");
        log.info("keyword : {}", keyword);
        return myPageService.getSearchGoalList(keyword,"100");
    }

//    @PostMapping("/myGoals/select")
//    public String postSelectMyGoals() {
//        log.info("POST /myPage/myGoals/select - Selecting My Goals");
//
//        return "myPage/myGoals/myGoalsAddBooks";
//    }

    @PostMapping("/myGoals/register")
    public String postRegisterMyGoals(GoalVO goal,
                                      HttpSession session) {
        log.info("POST /myPage/myGoals/register - Registering My Goals");

        //현재 로그인 한 계정 가져오기
        UserVO user = (UserVO) session.getAttribute("user");
        log.info(user);

        //현재 로그인 한 계정ID 를 goal 객체에 주입
        goal.setId(user.getId());
        //pagesRead 는 DB 초기 값이 0이기에 따로 설정하지 않는다.
        log.info("register {} ", goal);

        myPageService.setGoal(goal);
        return "redirect:/myPage/myGoalsList";
    }

    @GetMapping("/myGoals/bookInfo")
    public String getMyGoalBookInfo(@RequestParam("id") String id,
                                    @RequestParam("bookId") String bookId,
                                    Model model) {
        log.info("GET /myPage/myGoals/bookInfo - Fetching My Goal Book Info");

        GoalVO goal = myPageService.getGoal(id, bookId);
        log.info("goal {}", goal);

        List<TranscriptionVO> transcriptionList = myPageService.getTranscriptionList(id, bookId);
        log.info("transcription {}", transcriptionList);

        model.addAttribute("goal", goal);
        model.addAttribute("transcriptionList", transcriptionList);

        return "myPage/myGoals/myGoalsBookInfo";
    }

    @PostMapping("/myGoals/bookInfoRecord")
    public String postBookInfoRecord(GoalVO goal) {
        log.info("POST /myPage/myGoals/bookInfoRecord - Recording Book Info");
        log.info(goal);
        myPageService.updateGoal(goal);
        return "redirect:/myPage/myGoals/bookInfo?id=" + goal.getId() + "&bookId=" + goal.getBookId();
    }

    @GetMapping("/myGoals/bookInfo/delete")
    public String getDeleteBookInfo(@RequestParam("id") String id,
                                    @RequestParam("bookId") String bookId) {

        log.info("GET /myPage/myGoals/bookInfo/delete - Deleting Book Info");
        log.info("id {}", id);
        log.info("bookId {}", bookId);

        myPageService.deleteGoal(id, bookId);

        return "redirect:/myPage/myGoalsList";
    }

//    @GetMapping("/myGoals/myGoalsWriteTranscription")
//    public String getMyGoalsWriteTranscription() {
//        log.info("GET /myPage/myGoals/myGoalsWriteTranscription - Fetching MyGoals Write Transcription");
//        return "/myPage/myGoals/myGoalsWriteTranscription";
//    }

    @PostMapping("/myGoals/bookInfo/postTrans")
    public String postTransBookInfo(TranscriptionVO transcription) {
        log.info("POST /myPage/myGoals/bookInfo/postTrans - Posting Translated Book Info");
        log.info("transcription {}", transcription);
        myPageService.setTranscription(transcription);

        return "redirect:/myPage/myGoals/bookInfo?id=" + transcription.getId() + "&bookId=" + transcription.getBookId();
    }

//    @PostMapping("/myGoals/bookInfo/editTrans")
//    public String postEditTransBookInfo() {
//        log.info("POST /myPage/myGoals/bookInfo/editTrans - Editing Translated Book Info");
//        return "myPage/myGoals/myGoalBookInfo";
//    }

    @GetMapping("/myGoals/bookInfo/deleteTrans")
    public String getDeleteTransBookInfo(@RequestParam("transcriptionId") String transcriptionId,
                                         @RequestParam("id") String id,
                                         @RequestParam("bookId") String bookId) {
        log.info("GET /myPage/myGoals/bookInfo/deleteTrans - Deleting Translated Book Info");
        myPageService.deleteTranscription(transcriptionId);
        return "redirect:/myPage/myGoals/bookInfo?id=" + id + "&bookId=" + bookId;
    }

    @GetMapping("/bookmark")
    public String getBookmarkBooks(Model model,
                                   HttpSession session) {
        log.info("GET /myPage/bookmark - Fetching Bookmark");
        UserVO user = (UserVO) session.getAttribute("user");
        List<BookmarkVO> bookmarkList = myPageService.getBookmarkList(user.getId());
        Collections.reverse(bookmarkList);// 역순으로 보여주기 위해서

        log.info("bookmarkList{}", bookmarkList);
        model.addAttribute("bookmarkList", bookmarkList);

        return "myPage/bookmarkBooks";
    }

    @GetMapping("/following")
    public String getFollowing(HttpSession session,
                               Model model) {
        log.info("GET /myPage/following - Fetching Following List");

        UserVO user = (UserVO) session.getAttribute("user");

        Map<String, List> followList = myPageService.getFollowList(user.getId());

        log.info("followList {}", followList);

        List<UserVO> followingUserList = followList.get("following");
        List<UserVO> followerUserList = followList.get("follower");

        session.setAttribute("followingUserList", followingUserList);
        session.setAttribute("followerUserList", followerUserList);

        return "myPage/following";
    }

    @GetMapping("/follower")
    public String getFollower() {
        log.info("GET /myPage/follower - Fetching Follower List");
        return "myPage/follower";
    }

    @GetMapping("/community")
    public String getCommunityList(Model model,
                                   HttpSession session) {
        log.info("GET /myPage/community - Fetching Community List");
        UserVO user = (UserVO) session.getAttribute("user");

        List<BoardVO> postList = myPageService.getPostList(user.getId());

        log.info("post {}", postList);

        model.addAttribute("postList", postList);

        return "myPage/communityList";
    }

    @GetMapping("/communityDetail")
    public String getCommunityDetail() {
        log.info("GET /myPage/communityDetail - Fetching Community Detail");
        return "myPage/communityDetail";
    }

    @GetMapping("/deleteUserGuide")
    public String getDeleteUserGuide() {
        log.info("GET /myPage/deleteUserGuide - Accessing Delete User Guide");
        return "myPage/deleteUserGuide";
    }

    @PostMapping("/deleteUser")
    public String deleteUser(UserVO user) {
        log.info("POST /myPage/deleteUser - Delete User");
        log.info("user {}", user);

        myPageService.deleteUser(user.getId());

        return "myPage/deleteUserDone";
    }

    @GetMapping("/main")
    public String getMain(Model model,
                          HttpSession session) {
        log.info("GET /myPage/main - Fetching main");

        model.addAttribute("bestsallerList", myPageService.getAladinBestsallerList());
        model.addAttribute("itemnewList", myPageService.getAladiItemNewAllList());


        return "index";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session, HttpServletResponse response) {
        log.info("GET /myPage/logout - Fetching Logout main");
        // 세션 무효화
        session.invalidate();
        return "logout";
    }

    @GetMapping("recBooks")
    public String getRecBooks(HttpSession session,Model model) {
        log.info("GET /myPage/recBooks - Fetching recBooks");
        UserVO user = (UserVO) session.getAttribute("user");
        Map<String,List> preferenceList = myPageService.getPreferenceList(user.getId(),session);

        // 1. first
        log.info("First Preference List {}",preferenceList.get("firstPreferenceList"));
        model.addAttribute("firstPreferenceList",preferenceList.get("firstPreferenceList"));
        // 2. second
        log.info("Second Preference List {}",preferenceList.get("secondPreferenceList"));
        model.addAttribute("secondPreferenceList",preferenceList.get("secondPreferenceList"));
        // 3. author
        log.info("Author Preference List {}",preferenceList.get("authorPreferenceList"));
        model.addAttribute("authorPreferenceList",preferenceList.get("authorPreferenceList"));

        return "recBooks";
    }
}