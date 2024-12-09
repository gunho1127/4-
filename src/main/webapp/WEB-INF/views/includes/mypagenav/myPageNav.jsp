<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav>
    <link rel="stylesheet" href="../../../../resources/css/myPage/navstyle.css">
    <style>
        a,
        button,
        input,
        select,
        h1,
        h2,
        h3,
        h4,
        h5,
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            border: none;
            text-decoration: none;
            background: none;

            -webkit-font-smoothing: antialiased;
        }

        menu,
        ol,
        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }
    </style>

    <!-- user.id가 없을 경우 로그인 페이지로 리디렉션 -->
    <!-- <c:if test="${empty user}">
        <script type="text/javascript">
            window.location = "/login/enterEmail";
        </script>
    </c:if> -->

    <div class="desktop-vertical-logged-in-buttons-bottom">
        <div class="logo-container">
            <div class="logo">
                <a href="/myPage/main">
                    <div class="text">
                        <div class="webby-frames">REAPLETTE</div>
                    </div>
                </a>
            </div>
        </div>
        <div class="buttons-group">
            <img class="user-thumb" src="${user.profileImagePath}" />
        </div>

        

        <div class="menu">
            <a href="/myPage/info" class="menu-item4">
                <img class="icon-jam-icons-outline-logos-users" src="../../../../resources/images/myPage/icon0.svg" />
                <div class="div2">내 정보</div>
            </a>
            <a href="/myPage/myGoalsList" class="menu-item4">
                <img class="icon-jam-icons-outline-logos-users" src="../../../../resources/images/myPage/icon-heroicons-outline-sparkles0.svg" />
                <div class="div2">내 목표</div>
            </a>
            <a href="/myPage/bookmark" class="menu-item4">
                <img class="icon-jam-icons-outline-logos-users" src="../../../../resources/images/myPage/icon-jam-icons-outline-logos-tags0.svg" />
                <div class="div2">찜 도서</div>
            </a>
            <a href="/myPage/following" class="menu-item4">
                <img class="icon-jam-icons-outline-logos-users" src="../../../../resources/images/myPage/icon-jam-icons-outline-logos-users0.svg" />
                <div class="div2">팔로우</div>
            </a>
            <a href="/myPage/community" class="menu-item4">
                <img class="icon-jam-icons-outline-logos-users" src="../../../../resources/images/myPage/icon-jam-icons-outline-logos-pictures0.svg" />
                <div class="div2">커뮤니티 / 리뷰</div>
            </a>
            <a href="/myPage/logout" class="menu-item4">
                <img class="icon-jam-icons-outline-logos-users" src="../../../../resources/images/myPage/icon1.svg" />
                <div class="div2">로그아웃</div>
            </a>
            <a href="/myPage/deleteUserGuide" class="menu-item4">
                <img class="icon-jam-icons-outline-logos-users" src="../../../../resources/images/myPage/icon-jam-icons-outline-logos-plane0.svg" />
                <div class="div2">회원 탈퇴</div>
            </a>
        </div>
    </div>

</nav>
