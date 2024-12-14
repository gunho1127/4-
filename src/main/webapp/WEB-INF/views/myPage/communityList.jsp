<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
      <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">

      <link rel="stylesheet" href="../../../resources/css/myPage/communitystyle.css">


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


        .a {
          text-decoration: none;
          /* Removes underline */
          color: inherit;
          /* Inherits the color from the parent */
          background: none;
          /* Removes background */
          border: none;
          /* Removes borders */
          outline: none;
          /* Removes the outline on focus */
        }
      </style>
      <title>리플렛 - 커뮤니티</title>
    </head>

    <body>
      <div class="div">

        <!-- nav -->
        <jsp:include page="/WEB-INF/views/includes/mypagenav/myPageNav.jsp" />
        <!-- nav -->


        <div class="table">
          <div class="header"> <span>
              <span class="div-22-span">
                커뮤니티 / 리뷰
                <br />
              </span>
              <span class="div-22-span2">
                작성한 게시물과 리뷰를 볼 수 있습니다.
              </span>
            </span>
          </div>




          <div class="div3">

            <div class="post-list">

              <c:if test="${empty postList}">
                <div>작성하신 커뮤니티 / 리뷰가 없습니다!</div>
              </c:if>

              <c:forEach var="post" items="${postList}">
                <c:choose>
                  <c:when test="${post.type == '커뮤니티'}">
                    <a href="/community/viewPost/${post.postId}">
                  </c:when>
                  <c:when test="${post.type == '독서 리뷰'}">
                    <a href="/community/viewPost/${post.postId}">
                  </c:when>
                  <c:otherwise>
                    <!-- Default link or behavior for other types -->
                    <a href="">
                  </c:otherwise>
                </c:choose>

                <div class="post-item" data-post-id="${post.postId}" data-post-type="${post.type}">
                  <div class="post-image">
                    <img src="${post.postImagePath}">
                  </div>
                  <div class="post-content">
                    <div>
                      <span class="post-category">${post.type}</span>
                      <span class="post-id">no. ${post.postId}&nbsp;</span>
                    </div>
                    <h2 class="post-title">${post.title}</h2>
                    <p class="post-snippet">
                      <c:choose>
                        <c:when test="${post.content != null && post.content.length() > 20}">
                          ${post.content.substring(0, 20)}...
                        </c:when>
                        <c:otherwise>
                          ${post.content != null ? post.content : "내용 없음"}
                        </c:otherwise>
                      </c:choose>
                    </p>
                  </div>
                  <div class="post-meta">
                    <span class="post-author">${post.username}</span>
                    <span class="post-date">${post.date}</span>
                    <span class="post-likes">❤️${post.likeCount}</span>
                  </div>
                </div>
                </a> <!-- Closing the link -->
              </c:forEach>



          </div>

          </div>
        </div>
      </div>
      </div>

    </body>

    </html>