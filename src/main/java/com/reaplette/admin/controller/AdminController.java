package com.reaplette.admin.controller;


import com.reaplette.admin.service.AdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.reaplette.domain.BoardVO;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import jakarta.servlet.http.HttpServletRequest;


import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {

    private final AdminService adminService;

    //관리자 페이지 게시글 리스트
    @GetMapping("/postList")
        public String postList(Model model){
            List<BoardVO> boardVOList = this.adminService.getBoardList();
            model.addAttribute("list", boardVOList);
            return "admin/adminPostList";
    }
    //view-> list 객체

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
    public String memberDelete(@RequestParam("id") String id, HttpServletRequest request){
        adminService.deleteMember(id);

        //현재 페이지 경로 확인
        String currentPage = request.getServletPath();

        //현재 페이지에 따라 adminmemberlist, adminmemberinfo로 리다이렉트 분기
        if(currentPage.contains("adminMemberInfo")){
            return "redirect:/admin/admin/MemberInfo";
        }else{
            return "redirect:/admin/adminMemberList";

        }

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
