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
      </style>
      <title>리플렛 방문을 환영합니다.</title>
    </head>

    <body>

      <jsp:include page="/WEB-INF/views/includes/header.jsp" />

      <div class="div">

        <div class="section">
          <div class="content">
            <div class="section-text" id="zero">
              <div class="top2">
                <div class="main-headline">당신의 독서 목표를 달성하세요</div>
              </div>
              <div class="paragraph">
                REAPLETTE 은 여러분에게 맞춤형 도서를 추천해주고<br>지속적인 독서 습관을 형성할 수 있도록 돕습니다.
                <br />
                독서 커뮤니티를 통해 독서를 즐길 수 있는 환경을 제공합니다.
              </div>
            </div>
          </div>
          <div class="right">
            <div class="screen-phone">
              <img class="image" src="image0.png" />
              <div class="dynamic-island"></div>
            </div>
          </div>
        </div>

        <div class="section2" id="one">
          <div class="section-text2">
            <div class="top2">
              <div class="secondary-headline">개인 맞춤형 독서관리 및 커뮤니티</div>
            </div>
            <div class="paragraph2">
              본 웹 서비스는 사용자 개인의 독서 취향 분석을 기반으로<br>맞춤형 도서를 추천하고 독서 성취를 독려하는 웹 서비스 입니다.<br>다양한 Open API를 사용하여 사용자가 좀 더 효과적인
              독서활동을 할 수 있도록 지원합니다.
            </div>
          </div>
          <div class="row">
            <div class="stats-card">
              <div class="content2">
                <div class="icon-container">
                  <img class="icon-jam-icons-outline-logos-smiley"
                    src="/resources/images/icon-jam-icons-outline-logos-smiley0.svg" />
                </div>
                <div class="text4">
                  <div class="title-container">
                    <div class="title">독서 습관</div>
                  </div>

                </div>
              </div>
            </div>
            <div class="stats-card">
              <div class="content2">
                <div class="icon-container">
                  <img class="icon-jam-icons-outline-logos-files"
                    src="/resources/images/icon-jam-icons-outline-logos-files0.svg" />
                </div>
                <div class="text4">
                  <div class="title-container">
                    <div class="title">맞춤 도서</div>
                  </div>

                </div>
              </div>
            </div>
            <div class="stats-card">
              <div class="content2">
                <div class="icon-container">
                  <img class="icon-jam-icons-outline-logos-pizza-slice"
                    src="/resources/images/icon-jam-icons-outline-logos-pizza-slice0.svg" />
                </div>
                <div class="text4">
                  <div class="title-container">
                    <div class="title">독서 정착</div>
                  </div>
                </div>
              </div>
            </div>
            <div class="stats-card">
              <div class="content2">
                <div class="icon-container">
                  <img class="icon-jam-icons-outline-logos-users"
                    src="/resources/images/icon-jam-icons-outline-logos-users0.svg" />
                </div>
                <div class="text4">
                  <div class="title-container">
                    <div class="title">커뮤니티</div>
                  </div>

                </div>
              </div>
            </div>
          </div>
        </div>


        <div class="section3" id="two">
          <div class="auto-layout-vertical">
            <div class="auto-layout-horizontal">
              <div class="auto-layout-vertical2">
                <div class="auto-layout-vertical3">

                  <div class="div2">금주의 베스트 셀러</div>
                </div>
                <div class="div3">알라딘에서 제공하는 베스트 셀러를 둘러보세요</div>
              </div>
            </div>

            <div class="auto-layout-horizontal2">
              <div class="auto-layout-horizontal3">
                <div class="banner-list banner-list1">
                  <c:forEach var="bookmark" items="${bestsallerList}">
                    <!-- 카드뷰 시작 -->
                    <a href="/search/total/book/detail?isbn=${bookmark.bookId}&keyword=''">
                      <div class="card-view">
                        <img class="bookImage" src="${bookmark.bookImageUrl}">
                      </div>
                    </a>
                    <!-- 카드뷰 끝 -->
                  </c:forEach>
                </div>

                <div class="banner-list banner-list2">
                  <c:forEach var="bookmark" items="${bestsallerList}">
                    <!-- 카드뷰 시작 -->
                    <a href="/search/total/book/detail?isbn=${bookmark.bookId}&keyword=''">
                      <div class="card-view">
                        <img class="bookImage" src="${bookmark.bookImageUrl}">
                      </div>
                    </a>
                    <!-- 카드뷰 끙 -->

                  </c:forEach>
                </div>
              </div>
            </div>

          </div>

        </div>


        <div class="section3" id="three">
          <div class="auto-layout-vertical">
            <div class="auto-layout-horizontal">
              <div class="auto-layout-vertical2">
                <div class="auto-layout-vertical3">

                  <div class="div2">신작 리스트</div>
                </div>
                <div class="div3">알라딘에서 제공하는 신작 리스트를 둘러보세요</div>
              </div>
            </div>

            <div class="auto-layout-horizontal2">
              <div class="auto-layout-horizontal3">
                
                <div class="banner-list banner-list1">
                  <c:forEach var="bookmark" items="${itemnewList}">
                    <!-- 카드뷰 시작 -->
                    <!-- <a href="/search/total/book/detail?isbn=${bookmark.bookId}&keyword=''"> -->
                      <div class="card-view">
                        <img class="bookImage" src="${bookmark.bookImageUrl}">
                      </div>
                    <!-- </a> -->
                    <!-- 카드뷰 끝 -->
                  </c:forEach>
                </div>

                <div class="banner-list banner-list2">
                  <c:forEach var="bookmark" items="${itemnewList}">
                    <!-- 카드뷰 시작 -->
                    <!-- <a href="/search/total/book/detail?isbn=${bookmark.bookId}&keyword=''"> -->
                      <div class="card-view">
                        <img class="bookImage" src="${bookmark.bookImageUrl}">
                      </div>
                    <!-- </a> -->
                    <!-- 카드뷰 끙 -->

                  </c:forEach>
                </div>
                
              </div>
            </div>


          </div>
        </div>


      </div>


    </body>

    <script>
      // Intersection Observer 초기화
      let observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            // 요소가 보이는 경우 애니메이션 처리
            entry.target.style.opacity = 1;
            entry.target.style.transform = 'translateY(0)';
          } else {
            // 요소가 보이지 않을 때 원래 상태로 복귀
            entry.target.style.opacity = 0;
            entry.target.style.transform = 'translateY(100px)';
          }
        });
      });

      // 대상 요소들 선택
      let zero = document.getElementById("zero");
      let one = document.getElementById("one");
      let two = document.getElementById("two");
      let three = document.getElementById("three");



      // Observer로 요소 관찰
      observer.observe(zero);
      observer.observe(one);
      observer.observe(two);
      observer.observe(three);

    </script>


    </html>