<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>REAPLETTE - 취향 선택</title>
    <!-- <link rel="stylesheet" href="/resources/css/bootstrap.min.css"> -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">

    <link rel="stylesheet" href="/resources/css/signup/setPreferences.css">
    <link rel="stylesheet" href="/resources/css/headerstyle.css">
</head>
<body>

    

    <div class="container-fluid">
        <div class="row">
            <div class="col-2 border-end border-light"></div> <!-- 왼쪽 구분선 -->
            <div class="col-8 d-flex justify-content-center align-items-center min-vh-100">
                <div class="login-box">
                    <h4 class="text-left">REAPLETTE</h4>
                    <form id="username-form" class="w-100" action="/signup/signUpcomplete" post="">
                        <!-- 활동명 입력란 -->
                        <div class="mb-3">
                            <label for="username" class="form-label">활동명</label>
                            <div class="input-container">
                                <input type="text" class="form-control" id="username" name="username" placeholder="활동명을 입력하세요." maxlength="10" aria-label="활동명 입력란">
                                <span class="clear-icon" id="clear-icon">
                                    <img src="../../../resources/images/signup/clear-icon.png" alt="지우기 아이콘" class="clear-icon-img">
                                </span>
                            </div>
                            <!-- 오류 메시지 텍스트 -->
                            <span id="username-error" class="text-danger mt-2"></span>
                            <!-- 확인 버튼을 오른쪽으로 정렬 -->
                            <div class="d-flex justify-content-end">
                                <button type="button" id="verify-button" class="btn btn-primary">확인</button>
                            </div>
                        </div>

                        <div class="border-top mt-3" style="border-color: #DDE1E6;"></div>

                        <!-- 취향 선택란 -->
                        <div class="mb-3">
                            <label for="genres" class="form-label">취향 탐색 (최대 3개 선택 가능)</label>
                            
                            <div class="checkbox-container">
                                <div class="">
                                    <div class="badge" data-selected="false" value="가정" onclick="append()">가정/요리/뷰티</div>
                                    <div class="badge" data-selected="false">경제경영</div>
                                    <div class="badge" data-selected="false">과학</div>
                                    <div class="badge" data-selected="false">고전</div>
                                    <div class="badge" data-selected="false">대학교/전문서적</div>
                                    
                                </div>
                                <div class="badge-row">
                                    <div class="badge" data-selected="false">문화</div>
                                    <div class="badge" data-selected="false">사회과학</div>
                                    <div class="badge" data-selected="false">소설/시/희곡</div>
                                    <div class="badge" data-selected="false">수험서/자격증</div>
                                    <div class="badge" data-selected="false">어린이</div>
                                    
                                </div>
                                <div class="badge-row">
                                    <div class="badge" data-selected="false">예술/대중문화</div>
                                    <div class="badge" data-selected="false">역사</div>
                                    <div class="badge" data-selected="false">외국어</div>
                                    <div class="badge" data-selected="false">유아</div>
                                    <div class="badge" data-selected="false">인문학</div>
                                    
                                </div>                               
                            </div>



                            <!-- 오류 메시지 텍스트 -->
                            <span id="genre-error" class="text-danger mt-2" style="display: none;"></span>
                            <!-- 버튼들 나란히 배치 -->
                            <div class="d-flex justify-content-end gap-2">
                                <!-- 취소 버튼 -->
                                <button type="button" id="cancel-button" class="btn btn-secondary" onclick="window.location.href='/previous-page'">취소</button>
                                <!-- 확인 버튼 -->
                                <button type="submit" id="submit-button" class="btn btn-primary">확인</button>
                            </div>
                        </div>
                    </form>

                    
                </div>
            </div>
            <div class="col-2 border-start border-light"></div> <!-- 오른쪽 구분선 -->
        </div>
    </div>

    <footer class="footer"></footer>

    <!-- JS 파일 -->
    <script src="../../../resources/js/bootstrap.bundle.min.js" defer></script>
    <script src="../../../resources/js/signup/setPreferences.js" defer></script>
</body>
</html>
