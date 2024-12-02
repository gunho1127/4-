package com.reaplette.mypage.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/myPage")
public class MyPageController {
    @GetMapping("/info")
    public String getMyPageInfo() {
        System.out.println("test log");
        return "myPage/myPageInfo";
    }

    @PostMapping("/editInfo")
    public String postEditInfo() {
        return "myPage/myPageInfo";
    }

    @GetMapping("/myGoalsList")
    public String getMyGoalsList() {
        return "myPage/myGoalsList";
    }

    @GetMapping("/myGoalsAddBooks")
    public String getMyGoalsAddBooks() {
        return "myPage/myGoalsAddBooks";
    }

    @GetMapping("/myGoalsAddBooksModal")
    public String getMyGoalsAddBooksModal() {
        return "myPage/myGoalsAddBooksModal";
    }

    @GetMapping("/myGoals/search")
    public String getSearchMyGoals() {
        return "myPage/searchMyGoals";
    }

    @PostMapping("/myGoals/select")
    public String postSelectMyGoals() {
        return "myPage/myGoalsAddBooks";
    }

    @PostMapping("/myGoals/register")
    public String postRegisterMyGoals() {
        return "myPage/myGoalsList";
    }

    @GetMapping("/myGoals/bookInfo")
    public String getMyGoalBookInfo() {
        return "myPage/myGoalBookInfo";
    }

    @PostMapping("/myGoals/bookInfoRecord")
    public String postBookInfoRecord() {
        return "myPage/myGoals/bookInfo";
    }

    @GetMapping("/myGoals/myGoalsBookInfo")
    public String getMyGoalsBookInfo() {
        return "myPage/myGoals/myGoalsBookInfo";
    }

    @GetMapping("/myGoals/bookInfo/delete")
    public String getDeleteBookInfo() {
        return "myPage/myGoalsList";
    }

    @PostMapping("/myGoals/bookInfo/postTrans")
    public String postTransBookInfo() {
        return "myPage/myGoalBookInfo";
    }

    @PostMapping("/myGoals/bookInfo/editTrans")
    public String postEditTransBookInfo() {
        return "myPage/myGoalBookInfo";
    }

    @GetMapping("/myGoals/bookInfo/deleteTrans")
    public String getDeleteTransBookInfo() {
        return "myPage/myGoalBookInfo";
    }

    @GetMapping("/bookmarkBooks")
    public String getBookmarkBooks() {
        return "myPage/bookmarkBooks";
    }

    @GetMapping("/following")
    public String getFollowing() {
        return "myPage/following";
    }

    @GetMapping("/follower")
    public String getFollower() {
        return "myPage/follower";
    }

    @GetMapping("/community")
    public String getCommunityList() {
        return "myPage/communitylist";
    }

    @GetMapping("/communityDetail")
    public String getCommunityDetail() {
        return "myPage/communityDetail";
    }

    @GetMapping("/deleteUserGuide")
    public String getDeleteUserGuide() {
        return "myPage/deleteUserGuide";
    }
}
