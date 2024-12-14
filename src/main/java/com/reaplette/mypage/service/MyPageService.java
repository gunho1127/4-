package com.reaplette.mypage.service;

import com.reaplette.domain.*;
import com.reaplette.mypage.mappers.MyPageMapper;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.net.*;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
@Log4j2
@RequiredArgsConstructor
@Transactional
public class MyPageService {

    private final MyPageMapper myPageMapper; // 자동 주입
    private final ServletContext servletContext;

    @Value("${client.id}")
    private String CLIENT_ID;

    @Value("${client.secret}")
    private String CLIENT_SECRET;

    @Value("${client.ttb}")
    private String TTB;

    public UserVO getUser(String id) {
        log.info("getUser....." + id);
        return myPageMapper.getUser(id);
    }

    // 정보 수정
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
        myPageMapper.setUser(user);
    }

    // 활동명 중복검사
    public boolean isUsernameExists(String id,String username) {
        log.info("isUsernameExists....." + username);
        //false 면 중복
        return myPageMapper.isUsernameExists(id,username);
    }

    // 도서 검색
    public List<GoalVO> getSearchGoalList(String keyword,String count) {
//        private final String CLIENT_ID;  // 불변의 값
//        private String CLIENT_SECRET;    // 변경 가능한 값
        // 네이버 도서 검색 API 서비스를 사용할 예정.
        // keyword 는 도서명 이 들어갑니다   .


        URL url;
        StringBuffer response;
        List<GoalVO> searchGoalList;
        try {
            // 요청 URL 작성
            String encodedKeyword = URLEncoder.encode(keyword, "UTF-8");
            String apiURL = "https://openapi.naver.com/v1/search/book.json?query=" + encodedKeyword + "&sort=sim&display="+count;
            url = new URL(apiURL);

            //HttpURLConnection 으로 데이터 요청
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("X-Naver-Client-Id", CLIENT_ID);
            con.setRequestProperty("X-Naver-Client-Secret", CLIENT_SECRET);


            int responseCode = con.getResponseCode();
            BufferedReader br;
            if (responseCode == 200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();


            //검색 결과 확인
            log.info(response.toString());


            String searchGoalListJson = response.toString();
            // 필요한 정보 추출
            // JSON 파싱
            JSONObject jsonObject = new JSONObject(searchGoalListJson);
            // items 배열 가져오기
            JSONArray itemsArray = jsonObject.getJSONArray("items");

            searchGoalList = new ArrayList<>();

            for (int i = 0; i < itemsArray.length(); i++) {
                JSONObject item = itemsArray.getJSONObject(i);
                GoalVO goal = new GoalVO();

                // ISBN 코드
                goal.setBookId(item.getString("isbn"));
                // 책 제목
                goal.setBookTitle(item.getString("title"));
                // 작가
                goal.setAuthor(item.getString("author"));
                // 이미지 URL
                goal.setBookImageUrl(item.getString("image"));

                searchGoalList.add(goal);
            }

            log.info("searchGoalList {}", searchGoalList);

        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        } catch (MalformedURLException e) {
            throw new RuntimeException(e);
        } catch (ProtocolException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (JSONException e) {
            throw new RuntimeException(e);
        }
        return searchGoalList;
    }

    public void setGoal(GoalVO goal) {
        log.info("setGoal....." + goal);
        myPageMapper.setGoal(goal);
    }

    public List<GoalVO> getUserGoalList(String id) {
        log.info("getUserGoalList....." + id);
        return myPageMapper.getUserGoalList(id);
    }

    public GoalVO getGoal(String id, String bookId) {
        log.info("getGoal....." + id);
        log.info("getGoal....." + bookId);
        return myPageMapper.getGoal(id, bookId);
    }

    public void updateGoal(GoalVO goal) {
        log.info("updateGoal....." + goal);
        myPageMapper.updateGoal(goal);
    }

    public List<TranscriptionVO> getTranscriptionList(String id, String bookId) {
        log.info("getTranscriptionList....." + id);
        log.info("getTranscriptionList....." + bookId);
        return myPageMapper.getTranscriptionList(id, bookId);
    }

    public void setTranscription(TranscriptionVO transcription) {
        log.info("setTranscription....." + transcription);
        myPageMapper.setTranscription(transcription);
    }

    public void deleteTranscription(String transcriptionId) {
        log.info("deleteTranscription....." + transcriptionId);
        myPageMapper.deleteTranscription(transcriptionId);
    }

    public void deleteGoal(String id, String bookId) {
        log.info("deleteGoal....." + id);
        log.info("deleteGoal....." + bookId);
        myPageMapper.deleteGoal(id, bookId);
    }

    public List<BookmarkVO> getBookmarkList(String id) {
        log.info("getBookmarkList....." + id);
        return myPageMapper.getBookmarkList(id);
    }

    public Map<String, List> getFollowList(String id) {
        log.info("getFollowList....." + id);

        Map<String, List> followList = new HashMap<>();

        // followingID을 기준으로 계정을 필터링
        List<FollowVO> followinglist = myPageMapper.getFollowingList(id);
        List<UserVO> followingUserList = new ArrayList<>();

        for (FollowVO follow : followinglist) {
            //User리스트에 내가 팔로우 하고 있는 유저의 정보 주입.
            followingUserList.add(myPageMapper.getUser(follow.getFollowerId()));
        }
        followList.put("following", followingUserList);

        // followerId를 기준으로 계정을 필터링
        List<FollowVO> followerList = myPageMapper.getFollowerList(id);
        List<UserVO> followerUserList = new ArrayList<>();

        for (FollowVO follow : followerList) {
            //User리스트에 나를 팔로우 하고 있는 유저의 정보 주입.
            followerUserList.add(myPageMapper.getUser(follow.getFollowingId()));
        }

        followList.put("follower", followerUserList);

        return followList;
    }


    public List<BoardVO> getPostList(String id) {
        log.info("getPostList....." + id);
        List<BoardVO> posts = myPageMapper.getPostList(id);

        for (BoardVO post : posts) {
            if ("board".equals(post.getType())) {
                post.setType("커뮤니티");
            } else {
                post.setType("독서 리뷰");
            }
        }

        return posts;
    }

    public void deleteUser(String id) {
        log.info("deleteUser....." + id);
        myPageMapper.deleteUser(id);
        myPageMapper.deleteUserPreference(id);
        myPageMapper.deleteUserBookmark(id);
        myPageMapper.deleteUserBookmark(id);
        myPageMapper.deleteUserBoard(id);
        myPageMapper.deleteUserTranscription(id);
        myPageMapper.deleteUserGoal(id);
        myPageMapper.deleteUserComment(id);
        myPageMapper.deleteUserReview(id);
        myPageMapper.deleteUserFollow(id);
    }

    public List<BookmarkVO> getAladinBestsallerList() {
        log.info("getAladinBestsallerList.....");
        List<BookmarkVO> bestsellers = new ArrayList<>();

        String apiURL = "http://www.aladin.co.kr/ttb/api/ItemList.aspx?"
                + "TTBKey=" + TTB
                + "&QueryType=Bestseller"
                + "&SearchTarget=Book"
                + "&MaxResults=20"
                + "&Cover=Big"
                + "&Output=JS"
                + "&Version=20131101";

        try {
            // URL 연결
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");

            // 응답 코드 확인
            int responseCode = con.getResponseCode();
            if (responseCode != 200) {
                System.out.println("HTTP 요청 실패: " + responseCode);
            }

            // 응답 데이터 읽기
            BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            StringBuilder response = new StringBuilder();
            String inputLine;
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();

            // JSON 데이터 파싱
            JSONObject jsonResponse = new JSONObject(response.toString());
            JSONArray items = jsonResponse.getJSONArray("item");

            // 결과 출력
            for (int i = 0; i < items.length(); i++) {
                JSONObject item = items.getJSONObject(i);

                BookmarkVO bookmark = new BookmarkVO();

                // ISBN 코드
                bookmark.setBookId(item.getString("isbn13"));
                // 책 제목
                bookmark.setBookTitle(item.getString("title"));
                // 작가
                bookmark.setAuthor(item.getString("author"));
                // 책 이미지 URL
                bookmark.setBookImageUrl(item.getString("cover"));

                log.info("bookmark{}", bookmark);
                bestsellers.add(bookmark);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bestsellers;
    }

    public List<BookmarkVO> getAladiItemNewAllList() {
        log.info("getAladiItemNewAllList.....");

        List<BookmarkVO> newalliList = new ArrayList<>();

        String apiURL = "http://www.aladin.co.kr/ttb/api/ItemList.aspx?"
                + "TTBKey=" + TTB
                + "&QueryType=ItemNewAll"
                + "&SearchTarget=Book"
                + "&MaxResults=20"
                + "&Cover=Big"
                + "&Output=JS"
                + "&Version=20131101";

        try {
            // URL 연결
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");

            // 응답 코드 확인
            int responseCode = con.getResponseCode();
            if (responseCode != 200) {
                System.out.println("HTTP 요청 실패: " + responseCode);

            }

            // 응답 데이터 읽기
            BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            StringBuilder response = new StringBuilder();
            String inputLine;
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();

            // JSON 데이터 파싱
            JSONObject jsonResponse = new JSONObject(response.toString());
            JSONArray items = jsonResponse.getJSONArray("item");

            // 결과 출력
            for (int i = 0; i < items.length(); i++) {
                JSONObject item = items.getJSONObject(i);

                BookmarkVO bookmark = new BookmarkVO();

                // ISBN 코드
                bookmark.setBookId(item.getString("isbn13"));
                // 책 제목
                bookmark.setBookTitle(item.getString("title"));
                // 작가
                bookmark.setAuthor(item.getString("author"));
                // 책 이미지 URL
                bookmark.setBookImageUrl(item.getString("cover"));

                log.info("bookmark{}", bookmark);
                newalliList.add(bookmark);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return newalliList;
    }

    public Map<String,List> getPreferenceList(String id, HttpSession session) {

        Map<String, List> preferenceList = new HashMap<>();

        // 해당하는 카테고리 리스트를 가져온다.
        List<PreferenceVO> getPreferenceCategoryList = myPageMapper.getPreferenceCategoryList(id);
        String[] pb = new String[getPreferenceCategoryList.size()];
        for(int i=0; i<getPreferenceCategoryList.size(); i++) {
            pb[i] = getPreferenceCategoryList.get(i).getCategory();
        }
        String[] bookResult = getMostCommonKeywords(pb);

        String bookFirst = bookResult[0];
        String bookSecond = bookResult[1];
        // 세션에 저장
        session.setAttribute("firstCategory",bookFirst);
        session.setAttribute("secondCategory",bookSecond);
        List<GoalVO> fpb = getSearchGoalList(bookFirst,"8");
        List<GoalVO> spb = getSearchGoalList(bookSecond,"8");
        log.info("fpb {}",fpb);
        log.info("spb {}",spb);
        preferenceList.put("firstPreferenceList",fpb);
        preferenceList.put("secondPreferenceList",spb);


        // 리스트 형태를 문자열로 . 부득이하게 필요
        List<PreferenceVO> getPreferenceAuthorList = myPageMapper.getAuthorBookPreferenceList(id);
        if(getPreferenceAuthorList.isEmpty()) {
            session.setAttribute("authorCategory","아직 선호 작가가 없습니다 !");
        }
        else {
            String[] pa = new String[getPreferenceAuthorList.size()];
            for(int i=0; i<getPreferenceAuthorList.size(); i++) {
                pa[i] = getPreferenceAuthorList.get(i).getAuthor();
            }
            String[] authorResult = getMostCommonKeywords((pa));
            String authorFirst = authorResult[0];
            // 카테고리 변수들 중 공통된 키워드가 가장 많은 단어를 추출한다. 1위 2위.
            session.setAttribute("authorCategory",authorFirst);
            List<GoalVO> ap = getSearchGoalList(authorFirst,"8");
            log.info("ap {}",ap);
            preferenceList.put("authorPreferenceList",ap);
        }






        return preferenceList;
    }

    public String[] getMostCommonKeywords(String[] categories) {
        // 키워드 빈도를 저장할 맵
        Map<String, Integer> wordCount = new HashMap<>();

        // 카테고리에서 키워드 추출
        for (String category : categories) {
            Set<String> words = extractWords(category);
            for (String word : words) {
                wordCount.put(word, wordCount.getOrDefault(word, 0) + 1);
            }
        }

        // 단어 빈도를 내림차순으로 정렬
        List<Map.Entry<String, Integer>> sortedEntries = new ArrayList<>(wordCount.entrySet());
        sortedEntries.sort((entry1, entry2) -> entry2.getValue() - entry1.getValue());

        // 첫 번째 키워드: 가장 많이 등장한 키워드
        String first = sortedEntries.isEmpty() ? categories[0] : sortedEntries.get(0).getKey();

        // 첫 번째 키워드와 겹치지 않는 두 번째 키워드를 찾아야 함
        String second = null;

        for (Map.Entry<String, Integer> entry : sortedEntries) {
            if (!entry.getKey().contains(first) && (second == null || !entry.getKey().equals(first))) {
                second = entry.getKey();
                break;
            }
        }

        // 두 번째 키워드가 없으면, 랜덤으로 선택
        if (second == null) {
            second = categories.length > 1 ? categories[1] : categories[0];
        }

        return new String[]{first, second};
    }

    // 주어진 문자열에서 단어를 추출하는 메서드
    public Set<String> extractWords(String text) {
        Set<String> words = new HashSet<>();

        // 한글, 숫자, 그리고 '/'로 구분된 단어들을 추출하는 정규식
        String regex = "[가-힣0-9]+";
        Matcher matcher = Pattern.compile(regex).matcher(text);

        while (matcher.find()) {
            words.add(matcher.group());
        }

        // '/' 구분 단어 추가
        String[] extraWords = text.split("[\\s/]+");
        for (String word : extraWords) {
            if (!word.isEmpty() && word.matches("[가-힣0-9]+")) {
                words.add(word);
            }
        }

        return words;
    }





}