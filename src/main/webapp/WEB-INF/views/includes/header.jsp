<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <header>
      <link rel="stylesheet" href="../../../../resources/css/headerstyle.css">


      <div class="desktop-horizontal-logo-left-not-logged-menu-bottom-search-icons-right">
        <div class="top">
          <div class="logo">

            <!-- 메인 이동 -->
            <a href="/myPage/logout">
              <div class="text">
                <div class="webby-frames">REAPLETTE</div>
                <div class="for-figma"></div>
              </div>
            </a>
          </div>

          <!-- 검색창 -->
          <form class="field" action="/search/total">
            <div>

              <input class="text2" placeholder="검색어를 입력하세요 . . .">
              <img class="icon-jam-icons-outline-logos-search"
                src="../../../../resources/images/icon-jam-icons-outline-logos-search0.svg" />
            </div>
          </form>


          <!-- 커뮤니티 버튼 -->
          <a href="/community/main">
            <div class="buttons-group">
              <img class="icon-heroicons-outline-user-group"
                src="../../../../resources/images/icon-heroicons-outline-user-group0.svg" />
            </div>
          </a>

          <!-- 알람버튼 -->
          <a href="/notification/list">
            <div class="button">
              <img class="icon-jam-icons-outline-logos-bell"
                src="../../../../resources/images/icon-jam-icons-outline-logos-bell0.svg" />
            </div>
          </a>

          <!-- 유저프로필 -->
          <a href="/myPage/info">
            <div class="user-thumb">
              <img class="icon-jam-icons-outline-logos-user"
                src="../../../../resources/images/icon-jam-icons-outline-logos-user0.svg" />
            </div>

          </a>


          <!-- 로그인/회원가입버튼 -->
          <a href="/login.jsp">
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

          <a href="/rec/recBooks">
            <div class="menu-item">
              <div class="menu-item2">도서 추천</div>
            </div>
          </a>


          <a href="/myPage/info">
            <div class="menu-item">
              <div class="menu-item2">마이 컨텐츠</div>
            </div>
          </a>

          <a href="/community/main">
            <div class="menu-item">
              <div class="menu-item2">커뮤니티</div>
            </div>
          </a>

        </div>
      </div>
      </div>

    </header>