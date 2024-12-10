package com.reaplette.config;

import feign.codec.Decoder;
import feign.jackson.JacksonDecoder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


@Configuration
public class DefaultFeignClientConfig {

    @Bean
    public Decoder feignDecoder() {
        // JSON 데이터를 처리하기 위한 Jackson 디코더 설정
        return new JacksonDecoder();
    }

}
