package com.reaplette.config;  // 실제 패키지 경로에 맞게 수정하세요.

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

//    @Value("file.upload-dir")
//    String Location;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // D:/reapletteImages 경로에서 이미지를 서빙하도록 설정 (Windows 환경)
        registry.addResourceHandler("/images/**")
                .addResourceLocations("file:/Users/seuo/Desktop/reapletteImages/");

        // 리눅스 환경에서 '/var/reaplette/images' 경로에서 이미지를 서빙하도록 설정
        // registry.addResourceHandler("/images/**")
        //         .addResourceLocations("file:/var/reaplette/images/");
    }
}
