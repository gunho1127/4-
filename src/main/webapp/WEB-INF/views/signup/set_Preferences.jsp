<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>REAPLETTE - 취향 선택</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/css/signup/setPreferences.css">
    <link rel="stylesheet" href="/resources/css/headerstyle.css">
</head>
<body>

    <header>
        <jsp:include page="/WEB-INF/views/includes/header.jsp" />
    </header>

    <div class="container-fluid">
        <div class="row">
            <div class="col-2 border-end border-light"></div> <!-- 왼쪽 구분선 -->
            <div class="col-8 d-flex justify-content-center align-items-center min-vh-100">
                <div class="login-box">
                    <h4 class="text-left">REAPLETTE</h4>
                    <form id="username-form" class="w-100">
                        <!-- 활동명 입력란 -->
                        <div class="mb-3">
                            <label for="username" class="form-label">활동명</label>
                            <div class="input-container">
                                <input type="text" class="form-control" id="username" placeholder="활동명을 입력하세요." maxlength="10" aria-label="활동명 입력란">
                                <span class="clear-icon" id="clear-icon">
                                    <img src="resources/images/signup/clear-icon.png" alt="지우기 아이콘" class="clear-icon-img">
                                </span>
                            </div>
                            <!-- 오류 메시지 텍스트 -->
                            <span id="username-error" class="text-danger mt-2" style="display: none;"></span>
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
                                <!-- Badge 목록 반복 처리 -->
                                <c:forEach var="genreRow" items="${genres}">
                                    <div class="badge-row">
                                        <c:forEach var="genre" items="${genreRow}">
                                            <div class="badge" data-selected="false">${genre}</div>
                                        </c:forEach>
                                    </div>
                                </c:forEach>
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
    <script src="resources/js/bootstrap.bundle.min.js"></script>
    <script src="resources/js/signup/setPreferences.js"></script>
</body>
</html>
