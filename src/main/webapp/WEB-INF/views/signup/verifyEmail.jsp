<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>REAPLETTE - 인증코드 입력</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/css/signup/verifyEmail.css">
    <link rel="stylesheet" href="/resources/css/headerstyle.css">
</head>
<body>



    <div class="container-fluid">
        <div class="row">
            <div class="col-2 border-end border-light"></div> <!-- 왼쪽 구분선 -->
            <div class="col-8 d-flex justify-content-center align-items-center min-vh-100">
                <div class="login-box">
                    <h2 class="text-center">REAPLETTE</h2>
                    
                    
                    <form id="verify-form" class="w-100" action="/signup/setPassword" method="get">
                        <!-- 고정된 이메일 (사용자 수정 불가) -->
                        <div class="mb-3">
                            <label for="id" class="form-label">아이디</label>
                            <!-- 서버에서 전달된 email 속성 값 출력 -->
                            <input type="text" class="form-control" id="id" value="${sessionScope.id != null ? sessionScope.id : ''}" readonly>
                            <input type="hidden" id="verificationCode" value="${sessionScope.verificationCode}">
                            <!-- 인증코드 발송 메시지를 표시할 공간 -->
                            <p id="verify-email-msg" class="message">귀하의 계정으로 인증번호가 포함된 이메일을 발송했습니다.</p>
                        </div>

                        <!-- 인증코드 입력란 -->
                        <div id="verification-section" class="mt-3">
                            <label for="verification-code" class="form-label">인증번호</label>
                            <div class="d-flex align-items-center">
                                <!-- 입력란 및 클리어 아이콘 -->
                                <div class="position-relative flex-grow-1 me-2">
                                    <input type="text" id="verification-code" class="form-control" value="${sessionScope.verificationCode}" placeholder="인증번호를 입력하세요" maxlength="6" vaaria-label="인증코드 입력란">
                                    <span class="clear-icon" id="clear-icon">
                                        <img src="/resources/images/signup/clear-icon.png" alt="지우기 아이콘" class="clear-icon-img">
                                    </span>
                                </div>
                                <!-- 타이머 -->
                                <span id="timer" class="me-2">1:00</span>
                                <!-- 확인 버튼 -->
                                <button type="button" id="verify-button" class="btn btn-primary" onclick="verifyChecking()">확인</button>
                            </div>
                        </div>

                        <!-- 인증코드 입력 에러 메시지 -->
                        <span id="verification-error" class="error-message" style="display: none;">인증번호를 입력하세요.</span>

                        <!-- 회원가입 버튼 -->
                        <div id="start-button" class="mt-3">
                            <button type="submit" class="w-100 mt-2" id="signup-button" value="회원가입">회원가입</button>
                        </div>

                        <div class="border-top mt-3" style="border-color: #DDE1E6;"></div>
                    </form>

                    
                </div>
            </div>
            <div class="col-2 border-start border-light"></div> <!-- 오른쪽 구분선 -->
        </div>
    </div>

    <footer class="footer"></footer>

    <script src="/resources/js/bootstrap.bundle.min.js" defer></script>
    <script src="/resources/js/signup/verifyEmail.js" defer></script>
    
</body>
</html>
