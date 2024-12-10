<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
      <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">

      <link rel="stylesheet" href="../../../resources/css/myPage/bookmarkBooksstyle.css">

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
      <title>리플렛 - 찜 도서</title>
    </head>

    <body>


      <div class="div">
        <!-- 아이콘 섹션 -->
        <!-- nav -->
        <jsp:include page="/WEB-INF/views/includes/mypagenav/myPageNav.jsp" />
        <!-- nav -->



        <!-- 카드뷰 컨테이너 -->
        <div class="table">
          <!-- 헤더 섹션 -->
          <div class="header">
            <div class="auto-layout-vertical">
              <div class="div22">
                <span>
                  <span class="div-22-span">
                    찜 도서
                    <br />
                  </span>
                  <span class="div-4-span2">
                    내가 찜한 도서를 확인할 수 있어요 !
                    <br />
                    나의 개인 맞춤 추천에 반영됩니다 !
                  </span>
                </span>
              </div>
            </div>
          </div>

          <!-- 첫 번째 카드뷰 행 -->
          <div class="auto-layout-horizontal">

            <div class="frame-2">


              <!-- Book Card Views -->
              <div class="auto-layout-horizontal4">


                <!-- 반복 -->
                <c:if test="${not empty bookmarkList}">
                  <c:forEach var="bookmark" items="${bookmarkList}">
                    <a href="/search/total/book/detail?isbn=${bookmark.bookId}&keyword=''">
                      <!-- 해당 도서 정보로 : 승연님 도서 정보 조회 요청 코드 가져올 것-->
                      <div class="book-card-view">
                        <img class="style-square" src="${bookmark.bookImageUrl}">
                        <div class="auto-layout-vertical3">
                          <div class="div6">
                            <span>
                              <span class="div-6-span">${bookmark.bookTitle}</span><br>
                              <span class="div-6-span2">${bookmark.author}</span>
                            </span>
                          </div>
                        </div>
                      </div>
                      <br><br>
                    </a>
                  </c:forEach>
                </c:if>
                <c:if test="${empty bookmarkList}">
                  찜 도서가 없습니다!
                </c:if>

                <!-- 반복 -->


              </div>
              <!-- End of Book Card Views -->
            </div>
          </div>

        </div>
      </div>

    </body>

    </html>