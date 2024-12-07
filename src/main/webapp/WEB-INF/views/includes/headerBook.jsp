<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header>
  <link rel="stylesheet" href="<c:url value='/resources/css/headerstyle.css' />">

  <div class="desktop-horizontal-logo-left-not-logged-menu-bottom-search-icons-right">
    <div class="top">
      <div class="logo">
        <!-- 메인 이동 -->
        <a href="<c:url value='/index' />">
          <div class="text">
            <div class="webby-frames">REAPLETTE</div>
            <div class="for-figma"></div>
          </div>
        </a>
      </div>

      <!— 검색창 —>
        <form class="field" action="/search/total/book" method="get">
          <div>

            <input type="text" class="text2" name="keyword" value="${param.keyword}" placeholder="검색어를 입력하세요 . . .">
            <img class="icon-jam-icons-outline-logos-search"
              src="../../../../resources/images/icon-jam-icons-outline-logos-search0.svg" />
          </div>
        </form>

      <!-- 커뮤니티 버튼 -->
      <a href="<c:url value='/community/main' />">
        <div class="buttons-group">
          <img class="icon-heroicons-outline-user-group" src="<c:url value='/resources/images/icon-heroicons-outline-user-group0.svg' />" />
        </div>
      </a>

      <!-- 알람버튼 -->
      <a href="<c:url value='/notification/list' />">
        <div class="button">
          <img class="icon-jam-icons-outline-logos-bell" src="<c:url value='/resources/images/icon-jam-icons-outline-logos-bell0.svg' />" />
        </div>
      </a>

      <!-- 유저프로필 -->
      <a href="<c:url value='/myPage/info' />">
        <div class="user-thumb">
          <img class="icon-jam-icons-outline-logos-user" src="<c:url value='/resources/images/icon-jam-icons-outline-logos-user0.svg' />" />
        </div>
      </a>

      <!-- 로그인/회원가입버튼 -->
      <a href="<c:url value='/login.jsp' />">
        <div class="button2">
          <div class="text-container">
            <div class="button-text">시작하기</div>
          </div>
        </div>
      </a>
    </div>
  </div>

  <div class="menu">
    <div class="left">
      <a href="<c:url value='/rec/recBooks' />">
        <div class="menu-item">
          <div class="menu-item2">도서 추천</div>
        </div>
      </a>

      <a href="<c:url value='/myPage/info' />">
        <div class="menu-item">
          <div class="menu-item2">마이 컨텐츠</div>
        </div>
      </a>

      <a href="<c:url value='/community/main' />">
        <div class="menu-item">
          <div class="menu-item2">커뮤니티</div>
        </div>
      </a>
    </div>
  </div>
</header>