package com.reaplette.mypage;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 로그인 인터셉터를 특정 경로에 적용
        registry.addInterceptor(new LoginInterceptor())
                .addPathPatterns("/myPage/**")  // /myPage 경로 아래 모든 요청에 적용
                .excludePathPatterns("/myPage/main"); // 로그인 페이지나 공개된 경로는 제외
    }
}
