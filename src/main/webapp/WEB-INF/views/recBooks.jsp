<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
      <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">

      <link rel="stylesheet" href="../../resources/css/indexstyle.css">

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

        .post-slider {
          position: relative;
          overflow: hidden;
          width: 100%;
          /* 컨테이너 너비 */
          margin: 0 auto;
          display: flex;
          justify-content: center;
          /* 가운데 정렬 */
        }


        .post-card {
          flex: 0 0 calc(25% - 10px);
          /* 컨테이너의 4분의 1 크기에서 마진 보정 */
          box-sizing: border-box;
          margin: 5px;
          /* 카드 간격을 조절 */
          background: white;
          border-radius: 8px;
          box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
          overflow: hidden;
          transition: transform 0.2s;
          cursor: pointer;
          /* 클릭할 수 있도록 커서 추가 */
        }

        .image-placeholder {
          width: 100%;
          height: 150px;
          background-color: #ddd;
          object-fit: contain;
        }



        .post-grid {
          display: flex;
          transition: transform 0.5s ease;
          will-change: transform;
          width: fit-content;
          /* 정확히 필요한 크기만 사용 */
        }
      </style>




      <title>리플렛 - 개인 도서 추천</title>
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

      <script>
        document.addEventListener("DOMContentLoaded", function () {


          // 슬라이더 기능
          const sliders = document.querySelectorAll(".post-slider"); // 모든 슬라이더 선택


          sliders.forEach(slider => {
            const postGrid = slider.querySelector(".post-grid");
            const prevBtn = slider.querySelector(".slider-btn.prev");
            const nextBtn = slider.querySelector(".slider-btn.next");
            const postCards = slider.querySelectorAll(".post-card");


            // 컨테이너 및 카드 크기 계산
            const sliderWidth = slider.clientWidth; // 슬라이더 컨테이너 너비
            const cardWidth = postCards[0].offsetWidth + 10; // 카드 너비
            const visibleCards = Math.floor(sliderWidth / cardWidth); // 한 화면에 표시할 카드 개수
            const totalCards = postCards.length;

            let currentIndex = 0;

            function updateSlider() {
              const translateX = -(currentIndex * cardWidth);  // 슬라이드 이동 거리
              postGrid.style.transform = `translateX(${translateX}px)`; // 이동
            }

            prevBtn.addEventListener("click", () => {
              if (currentIndex > 0) {
                currentIndex -= visibleCards; // 화면에 보이는 카드만큼 이동
                if (currentIndex < 0) currentIndex = 0; // 범위 초과 방지
                updateSlider();
              }
            });

            nextBtn.addEventListener("click", () => {
              if (currentIndex + visibleCards < totalCards) {
                currentIndex += visibleCards; // 화면에 보이는 카드만큼 이동
                if (currentIndex + visibleCards > totalCards) {
                  currentIndex = totalCards - visibleCards; // 마지막 슬라이드 조정
                }
                updateSlider();
              }
            });

            // 초기 슬라이더 위치 업데이트
            updateSlider();
          });
        });

      </script>
    </body>


    </html>