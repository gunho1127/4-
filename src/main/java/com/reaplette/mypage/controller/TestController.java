package com.reaplette.mypage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller // @Controller + @ResponseBody
public class TestController {

    @GetMapping("/test")
    public String testEndpoint() {
        System.out.println("test controller");
        return "Test endpoint is working!";
    }
}
