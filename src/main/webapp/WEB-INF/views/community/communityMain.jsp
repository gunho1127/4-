<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
      <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>리플렛 - 개인 도서 추천</title>
      <link rel="stylesheet" href="../../resources/css/community/communityMain.css">
      <script src="../../resources/js/community/communityMain.js"></script>
    </head>

    <body>

      <jsp:include page="/WEB-INF/views/includes/header.jsp" />

      <div class="div">


        <div class="auto-layout-vertical">
          <div class="auto-layout-horizontal">
            <div class="auto-layout-vertical2">
              <div class="auto-layout-vertical3">
                <div class="div2">${user.username} 님이 관심있는 카테고리</div>
              </div>
              <div class="div3"> 취향 선택과 도서 찜을 통해 분석된 추천 도서 리스트입니다 !</div>
            </div>
          </div>
        </div>

        <!-- 카테고리 1순위 도서 리스트 -->
        <div class="type-primary-size-large-status-enable" style="color: white;">${firstCategory}</div>

        <div class="container">
            <header class="header">
                <h1>
                    <img src="../../../resources/images/community/fire-icon.svg" class="header-icon">
                    실시간 인기 게시글
                </h1>
            </header>

            <div class="post-slider">
              <button class="slider-btn prev">‹</button>
              <div class="post-grid">
                <c:forEach var="goal" items="${firstPreferenceList}">
                  <a href="/search/total/book/detail?isbn=${goal.bookId}&keyword=''">
                    <div class="post-card" data-post-id="${post.postId}" data-post-type="${post.type}">
                      <img class="image-placeholder" src="${goal.bookImageUrl}">
                    </div>
                  </a>
                </c:forEach>
              </div>
              <button class="slider-btn next">›</button>
            </div>

        </div>

        <!-- 카테고리 1순위 도서 리스트 -->

        <!-- 카테고리 2순위 도서 리스트 -->
        <div class="type-primary-size-large-status-enable" style="color: white;">${secondCategory}</div>

        <div class="post-slider">
          <button class="slider-btn prev">‹</button>
          <div class="post-grid">
            <c:forEach var="goal" items="${secondPreferenceList}">
              <a href="/search/total/book/detail?isbn=${goal.bookId}&keyword=''">
                <div class="post-card" data-post-id="${post.postId}" data-post-type="${post.type}">
                  <img class="image-placeholder" src="${goal.bookImageUrl}">
                </div>
              </a>
            </c:forEach>
          </div>
          <button class="slider-btn next">›</button>
        </div>
        <!-- 카테고리 2순위 도서 리스트 -->

        <!-- 선호 작가 도서 리스트 -->
        <div class="type-primary-size-large-status-enable" style="color: white;">${authorCategory} 작가</div>

        <div class="post-slider">
          <button class="slider-btn prev">‹</button>
          <div class="post-grid">
            <c:forEach var="goal" items="${authorPreferenceList}">
              <a href="/search/total/book/detail?isbn=${goal.bookId}&keyword=''">
                <div class="post-card" data-post-id="${post.postId}" data-post-type="${post.type}">
                  <img class="image-placeholder" src="${goal.bookImageUrl}">
                </div>
              </a>
            </c:forEach>
          </div>
          <button class="slider-btn next">›</button>
        </div>
        <!-- 선호 작가 도서 리스트 -->

      </div>
      </div>

       <section>
              <div class="container">
                  <header class="header">
                      <h1>
                          <img src="../../../resources/images/community/fire-icon.svg" class="header-icon">
                          실시간 인기 게시글
                      </h1>
                  </header>

                  <div class="post-slider">
                      <button class="slider-btn prev">‹</button>
                      <div class="post-grid">
                          <!-- 반복문을 사용하여 게시글 정보를 동적으로 출력 -->
                          <c:forEach var="goal" items="${firstPreferenceList}">
                              <div class="post-card" >
                                  <img class="image-placeholder" src="${goal.bookImageUrl}" >
                                  <div class="post-info">
                                      <!-- 카테고리 (BoardVO에 type) -->
                                      <p class="category">${goal.bookId}</p>
                                      <!-- 제목 -->
                                      <h3 class="title">${goal.bookId}</h3>
                                      <!-- 내용 일부 (content의 앞부분을 표시) -->
                                      <p class="description">
                                          <c:choose>
                                              <c:when test="${goal.bookId != null && goal.bookId.length() > 20}">
                                                  ${post.content.substring(0, 20)}...
                                              </c:when>
                                              <c:otherwise>
                                                  ${goal.bookId != null ? goal.bookId : "내용 없음"}
                                              </c:otherwise>
                                          </c:choose>
                                      </p>
                                      <div class="author">
                                          <div class="avatar-placeholder"></div>
                                          <div>
                                              <!-- 작성자 이름 -->
                                              <p class="name">${goal.bookId}</p>
                                          </div>
                                      </div>
                                  </div>
                              </div>
                          </c:forEach>
                      </div>
                      <button class="slider-btn next">›</button>
                  </div>
              </div>
              <div class="container3">
              </div>

          </section>

    </body>


    </html>