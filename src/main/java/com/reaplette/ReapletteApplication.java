package com.reaplette;


import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@MapperScan("com.reaplette") // 매퍼가 위치한 패키지
public class ReapletteApplication {
	public static void main(String[] args) {

		SpringApplication.run(ReapletteApplication.class, args);
	}
}

