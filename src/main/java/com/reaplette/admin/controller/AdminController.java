package com.reaplette.admin.controller;


import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {
    @GetMapping("/postList")
        public String postList(){
            return "admin/adminPostList";
    }
    @GetMapping("/member/post/delete")
        public String deletePost(){
        return "redirect:admin/adminPostList";
    }//redirect: postList, post상세 페이지
    //delete : 다중삭제, 개별삭제 따로
//    @GetMapping("/member/post")
//    public String postView(){
//        return "post상세페이지";
//    }
    @GetMapping("/member")
    public String memberList(){
        return "admin/adminMemberList";
    }
    @PostMapping("/member/memberInfo")
    public String memberInfo(){
        return "admin/adminMemberInfo";
    }
    @PostMapping("/member/delete")
    public String memberDelete(){
        return "redirect:admin/adminMemberList";//adminmemberlist, adminmemberinfo
    }
    @GetMapping("/member/review/delete")
    public String reviewDelete(){
        return "redirect:admin/adminMemberReview";//adminMemberReview, review상세 페이지

    }
    @GetMapping("/member/review")
    public String reviewList(){
        return "admin/adminMemberReview";
    }
    @GetMapping("/member/postList")
    public String memberpostList(){
        return "admin/adminMemberPost";
    }
    @GetMapping("/member/following")
    public String memberFollowing(){
        return "admin/adminMemberFollowing";
    }
    @GetMapping("/member/follower")
        public String memberFollower(){
        return "admin/adminMemberFollower";
    }
    @PostMapping("/adminInfo")
    public String adminInfo(){
        return "admin/adminInfo";
    }
    @PostMapping("/adminEdit")
    public String adminEdit(){
        return "redirect:admin/adminInfo";
    }


}
