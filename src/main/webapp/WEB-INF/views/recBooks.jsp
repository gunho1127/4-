<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
      <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>리플렛 - 개인 도서 추천</title>

      <script src="../../resources/js/community/communityMain.js"></script>
      <style>
        .container {
          max-width: 1600px;
          margin: 0 auto;
          padding: 20px;
          
          border-radius: 20px;
        }

        .post-slider {
          position: relative;
          overflow: hidden;
          width: 100%;
          height: fit-content;
          /* 컨테이너 너비 */
          margin: 0 auto;
          display: flex;
          justify-content: start;
          /* 가운데 정렬 */
        }

        .post-grid {
          /* border: 3px red solid; */
          display: flex;
          transition: transform 0.5s ease;
          will-change: transform;
          width: 100%;
          height: fit-content;
          /* 정확히 필요한 크기만 사용 */
        }

        .post-card {
          display: flex;
          /* border: 3px blue solid; */
          flex: 0 0 calc(25% - 10px);
          /* 컨테이너의 4분의 1 크기에서 마진 보정 */
          box-sizing: border-box;
          margin: 5px;
          width: fit-content;
          /* 카드 간격을 조절 */
          background: white;

          overflow: hidden;
          transition: transform 0.2s;

          /* 클릭할 수 있도록 커서 추가 */
          justify-content: center;
          align-items: center;
        }

        .post-card:hover {
          cursor: pointer;
          transform: translateY(-5px);
        }

        .image-placeholder {
          border-radius: 8px;
          box-shadow: 0 8px 8px rgba(0, 0, 0, 0.1);
          /* border: rgb(0, 0, 0) 3px solid; */
          height: 29rem;
          width: 18rem;

        }

        .post-info {
          padding: 15px;
        }

        .category {
          font-size: 0.9rem;
          color: #007bff;
        }

        .title {
          font-size: 1.2rem;
          color: #333;
          margin: 10px 0;
        }

        .description {
          font-size: 0.9rem;
          color: #666;
        }

        .author {
          display: flex;
          align-items: center;
          margin-top: 15px;
        }

        .avatar-placeholder {
          width: 40px;
          height: 40px;
          background-color: #ccc;
          border-radius: 50%;
          margin-right: 10px;
        }

        .name {
          font-size: 0.9rem;
          font-weight: bold;
          color: #333;
        }

        .role {
          font-size: 0.8rem;
          color: #666;
        }

        /* 초기에는 버튼을 숨김 */
        .slider-btn {
          display: none;
        }

        /* 슬라이더에 마우스가 올라갔을 때 버튼을 표시 */
        .post-slider:hover .slider-btn {
          display: block;
        }

        .slider-btn {
          position: absolute;
          top: 50%;
          transform: translateY(-50%);
          background-color: rgba(0, 0, 0, 0.5);
          color: white;
          border: none;
          padding: 10px;
          cursor: pointer;
          z-index: 10;
        }

        .slider-btn.prev {
          left: 0;
        }

        .slider-btn.next {
          right: 0;
        }

        .sort-dropdown {
          text-align: right;
          margin-bottom: 10px;
        }

        .sort-dropdown select {
          padding: 5px 10px;
          border: 1px solid #ccc;
          border-radius: 5px;
          font-size: 14px;
        }

        .post-list {
          display: flex;
          flex-direction: column;
          gap: 15px;
        }

        .post-item {
          display: flex;
          padding: 15px;
          border: 1px solid #ddd;
          border-radius: 8px;
          background: #fff;
          transition: transform 0.2s;
          cursor: pointer;
          /* 클릭할 수 있도록 커서 추가 */
        }

        .post-item:hover {
          transform: translateY(-2px);
        }

        .post-image img {
          width: 80px;
          height: 80px;
          border-radius: 5px;
          object-fit: cover;
        }

        .post-content {
          flex: 1;
          margin-left: 15px;
          margin-right: 15px;
          border-right: solid 1px #bababa;
        }

        .post-category {
          font-size: 12px;
          color: #999;
          margin-bottom: 5px;
        }

        .post-id {
          font-size: 15px;
          position: relative;
          left: 700px;
          font-weight: bold;
        }

        .post-title {
          font-size: 18px;
          margin: 0 0 10px;
          color: #333;
        }

        .post-snippet {
          font-size: 14px;
          color: #666;
          overflow: hidden;
          text-overflow: ellipsis;
          white-space: nowrap;
        }

        .post-meta {
          display: flex;
          width: 100px;
          text-align: left;
          font-size: 15px;
          font-weight: 550;
          color: #464646;
          margin-left: 15px;
          flex-direction: column;
          justify-content: space-evenly;
        }

        .post-meta span {
          display: block;
        }

        .div2 {
          color: var(--coolgray-90, #21272a);
          text-align: left;
          font-family: var(--other-menu-m-font-family, "Roboto-Bold", sans-serif);
          font-size: var(--other-menu-m-font-size, 1rem);
          line-height: var(--other-menu-m-line-height, 100%);
          font-weight: var(--other-menu-m-font-weight, 700);
          position: relative;
        }

        .div3 {
          color: var(--coolgray-90, #21272a);
          text-align: left;
          font-family: var(--other-menu-m-font-family, "Roboto-Bold", sans-serif);
          font-size: var(--other-menu-m-font-size, 1rem);
          line-height: var(--other-menu-m-line-height, 100%);
          font-weight: var(--other-menu-m-font-weight, 700);
          position: relative;
          flex: 1;
        }

        .type-primary-size-large-status-enable {
          width: fit-content;
          margin-left: 5rem;
          background: var(--color-clickable-color, #2b73ff);
          border-radius: var(--space-space-4, 0.25rem);
          padding: 0rem var(--space-space-24, 1.5rem) 0rem var(--space-space-24, 1.5rem);
          display: flex;
          flex-direction: row;
          gap: var(--space-space-12, 0.75rem);
          align-items: center;
          justify-content: center;
          flex-shrink: 0;
          height: var(--space-space-56, 3.5rem);
          position: relative;
          margin-top: 5rem;
        }
      </style>
    </head>

    <body>

      <jsp:include page="/WEB-INF/views/includes/header.jsp" />

      <div class="div">


        <div class="auto-layout-vertical">
          <div class="auto-layout-horizontal">
            <div class="auto-layout-vertical2">
              <div class="auto-layout-vertical3">
                <h1 style="margin-left: 5rem; margin-top: 2rem;">${user.username} 님께 추천하는 책이에요</h1>
              </div>
              <div style="margin-left: 5rem;"> 취향 선택과 도서 찜을 통해 분석된 추천 도서 리스트입니다 !</div>
            </div>
          </div>
        </div>

        

        <!-- 카테고리 1순위 도서 리스트 -->
        
        <div class="type-primary-size-large-status-enable" style="color: white;"><b>관심 카테고리 1위</b> : ${firstCategory}</div>

        <div class="container">
          <div class="post-slider">
            <button class="slider-btn prev">‹</button>
            <div class="post-grid">
              <a href=""></a>
              <c:forEach var="goal" items="${firstPreferenceList}">
                <div class="post-card"
                  onclick="window.location.href='/search/total/book/detail?isbn=${goal.bookId}&keyword='">
                  <img class="image-placeholder" src="${goal.bookImageUrl}">
                </div>
              </c:forEach>

            </div>
            <button class="slider-btn next">›</button>
          </div>
        </div>

        <!-- 카테고리 1순위 도서 리스트 -->

        <!-- 카테고리 2순위 도서 리스트 -->
        <div class="type-primary-size-large-status-enable" style="color: white;"><b>관심 카테고리 2위</b> : ${secondCategory}</div>

        <div class="container">
          <div class="post-slider">
            <button class="slider-btn prev">‹</button>
            <div class="post-grid">
              <a href=""></a>
              <c:forEach var="goal" items="${secondPreferenceList}">
                <div class="post-card"
                  onclick="window.location.href='/search/total/book/detail?isbn=${goal.bookId}&keyword='">
                  <img class="image-placeholder" src="${goal.bookImageUrl}">
                </div>
              </c:forEach>

            </div>
            <button class="slider-btn next">›</button>
          </div>
        </div>
        <!-- 카테고리 2순위 도서 리스트 -->

        <!-- 선호 작가 도서 리스트 -->
        <div class="type-primary-size-large-status-enable" style="color: white;"><b>관심 작가</b> : ${authorCategory}</div>

        <div class="container">
          <div class="post-slider">
            <button class="slider-btn prev">‹</button>
            <div class="post-grid">
              <a href=""></a>
              <c:forEach var="goal" items="${authorPreferenceList}">
                <div class="post-card"
                  onclick="window.location.href='/search/total/book/detail?isbn=${goal.bookId}&keyword='">
                  <img class="image-placeholder" src="${goal.bookImageUrl}">
                </div>
              </c:forEach>

            </div>
            <button class="slider-btn next">›</button>
          </div>
        </div>
        <!-- 선호 작가 도서 리스트 -->

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
            const visibleCards = 4 // 한 화면에 표시할 카드 개수
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