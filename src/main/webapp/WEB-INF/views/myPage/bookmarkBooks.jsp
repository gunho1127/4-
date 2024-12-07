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
                  <span class="div-22-span2">
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
                <!-- <c:forEach var="goal" items="${goalList}"> -->
                  <a href="/myPage/myGoals/bookInfo?id=${goal.id}&bookId=${goal.bookId}">
                    <div class="book-card-view">   
                                       
                      <img class="style-square" src="${goal.bookImageUrl}" />
                      <div class="auto-layout-vertical3">
                        <div class="div6">
                          <span>
                            <span class="div-6-span">${goal.bookTitle}<br></span>
                            <span class="div-6-span2">${goal.author}</span>
                          </span>
                        </div>
                        <div class="div7" data-pages-read="${goal.pagesRead}" data-total-page="${goal.totalPage}">
                        </div>
                      </div>
                    </div>
                    <br><br>
                  </a>
                <!-- </c:forEach> -->
              </div>
              <!-- End of Book Card Views -->
            </div>
          </div>

        </div>
      </div>

    </body>

    </html>