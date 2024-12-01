package com.reaplette.mypage.service;

import com.reaplette.domain.UserVO;
import com.reaplette.mypage.mappers.MyPageMapper;
import jakarta.servlet.ServletContext;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

@Service
@Log4j2
@RequiredArgsConstructor
@Transactional
public class MyPageService {

    private final MyPageMapper userMapper; // 자동 주입

    @Autowired
    private ServletContext servletContext;

    public UserVO getUser(String id) {
        log.info("getUser....." + id);
        return userMapper.getUser(id);
    }

    public void setUser(UserVO user, MultipartFile profileImagePathForm) {
        log.info("setUser....." + user);
        log.info("User : " + user);
        log.info("ProfileImagePathForm : " + profileImagePathForm.getOriginalFilename());

        String defaultProfilePath = "../../../resources/images/myPage/icon-jam-icons-outline-logos-user1.svg";

        // 1. 프로필 사진 변경
        // form 존재 , 경로 x
        // 폼 값이 있을 때 그리고 폼 값이 비어있지 않을 때 그리고 사진 경로가 없을 때
        // 프로필 사진을 설졍하면 폼 값은 차 있고, 사진 경로는 없다.
        if (!profileImagePathForm.isEmpty() && user.getProfileImagePath().isEmpty()) {
            // 기존 사진 삭제 로직
            // 사용자 ID를 기반으로 파일 접두사를 생성 (특수 문자 '@', '.'를 '_'로 변경)
            String filePrefix = user.getId().replaceAll("[@.]", "_");


            // 파일 저장 경로 설정
            String uploadDir = servletContext.getRealPath("/resources/images/myPage/users/");
            String filePath = uploadDir + filePrefix + "_"; // 접두사를 붙인 경로

            // 디렉터리 내의 파일 목록 가져오기
            File dir = new File(uploadDir);
            if (dir.exists() && dir.isDirectory()) {
                // 디렉터리 내의 파일 중 접두사와 일치하는 파일 가져오기
                File[] files = dir.listFiles((d, name) -> name.startsWith(filePrefix));
                if (files != null && files.length > 0) {
                    for (File file : files) {
                        if (file.delete()) {
                            // 파일 삭제 성공 시 로그 출력
                            log.info("Profile image deleted: " + file.getAbsolutePath());
                        } else {
                            // 파일 삭제 실패 시 오류 로그 출력
                            log.error("Failed to delete profile image: " + file.getAbsolutePath());
                        }
                    }
                } else {
                    // 접두사와 일치하는 파일이 없을 경우 무시
                    log.info("No files found with prefix: " + filePrefix);
                }
            } else {
                // 디렉터리가 존재하지 않을 경우 경고 로그 출력
                log.warn("Directory not found: " + uploadDir);
            }


            // 새로운 사진 저장 및 경로 설정
            String randomCode = String.valueOf(System.currentTimeMillis());
            String originalFileName = profileImagePathForm.getOriginalFilename();
            String fileName = user.getId().replaceAll("[@.]", "_") + "_" + randomCode + "_" + originalFileName;
            File file = new File(uploadDir + fileName);

            try {
                profileImagePathForm.transferTo(file);
                log.info("File saved to: " + file.getAbsolutePath());
            } catch (IOException e) {
                log.error("Error while saving file", e);
            }

            user.setProfileImagePath("/resources/images/myPage/users/" + fileName);

            log.info("Profile image changed and saved: " + fileName);
        }

        // 2. 기본 프로필 사용
        // form x , 경로 기본 프로필 사진 경로
        // 프로필 폼이 없고 프로필 폼이 비어있을 때
        // 프로필 사진을 삭제하면 Form 값은 비어있다.
        // 경로는 기본 프로필이 적용되어 있다.
        // 프로필 사진 삭제 또는 기본 프로필 경로 설정
        else if (profileImagePathForm.isEmpty()) {
            if (!user.getProfileImagePath().isEmpty()) {
                if (user.getProfileImagePath().equals(defaultProfilePath)) {
                    // 기본 프로필 경로로 설정
                    // 기존 사진 삭제 로직
                    // 사용자의 프로필 사진 경로가 null이 아니고 기본 경로가 아닐 때만 삭제 로직을 실행

                    // 사용자 ID를 기반으로 파일 접두사를 생성 (특수 문자 '@', '.'를 '_'로 변경)
                    String filePrefix = user.getId().replaceAll("[@.]", "_");

                    // 파일 저장 경로 설정
                    String uploadDir = servletContext.getRealPath("/resources/images/myPage/users/");
                    String filePath = uploadDir + filePrefix + "_"; // 접두사를 붙인 경로

                    // 디렉터리 내의 파일 목록 가져오기
                    File dir = new File(uploadDir);
                    if (dir.exists() && dir.isDirectory()) {
                        // 디렉터리 내의 파일 중 접두사와 일치하는 파일 가져오기
                        File[] files = dir.listFiles((d, name) -> name.startsWith(filePrefix));
                        if (files != null && files.length > 0) {
                            for (File file : files) {
                                if (file.delete()) {
                                    // 파일 삭제 성공 시 로그 출력
                                    log.info("Profile image deleted: " + file.getAbsolutePath());
                                } else {
                                    // 파일 삭제 실패 시 오류 로그 출력
                                    log.error("Failed to delete profile image: " + file.getAbsolutePath());
                                }
                            }
                        } else {
                            // 접두사와 일치하는 파일이 없을 경우 무시
                            log.info("No files found with prefix: " + filePrefix);
                        }
                    } else {
                        // 디렉터리가 존재하지 않을 경우 경고 로그 출력
                        log.warn("Directory not found: " + uploadDir);
                    }
                    user.setProfileImagePath(defaultProfilePath);
                    log.info("Profile image deleted and set to default.");
                }
                // 3. 프로필 사진 유지 ( 기존 프로필 사용 )
                // form X , 경로 기존 프로필 사진 경로
                // 기존 프로필 경로가 null이 아니면 그대로 사용
                else {
                    //프로필 사진 삭제 X
                    log.info("Profile image remains unchanged.");
                }
            }
        }
//            서버 파일 시스템 경로는 개발자가 파일을 물리적으로 저장하거나 관리하기 위한 로컬 경로입니다.
//            반면, 웹 경로는 클라이언트가 리소스에 접근하기 위한 HTTP 기반 경로입니다.
//            예를 들어:
//            서버 파일 시스템 경로: src/main/webapp/resources/images/myPage/users/sample.jpg
//            웹 경로: /resources/images/myPage/users/sample.jpg
        userMapper.setUser(user);
    }

    public boolean isUsernameExists(String username) {
        log.info("isUsernameExists....." + username);
        //false 면 중복
        return userMapper.isUsernameExists(username);
    }
}
