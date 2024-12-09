package com.reaplette.mypage;


import com.reaplette.domain.UserVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 세션에서 사용자 정보 확인
        UserVO user = (UserVO) request.getSession().getAttribute("user");

        // 사용자 정보가 없으면 로그인 페이지로 리디렉션
        if (user == null) {
            response.sendRedirect("/login/enterEmail");
            return false;  // 요청을 중단하고 로그인 페이지로 리디렉션
        }

        // 로그인된 사용자라면 요청을 계속 진행
        return true;
    }
}

