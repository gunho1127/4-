<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html lang="ko">

    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>리플렛 - 통합검색</title>
      <link rel="stylesheet" href="<c:url value='/resources/css/search/style.css' />" />
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
      <link rel="stylesheet" href="/resources/css/headerstyle.css" />

      <script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
      <style>
        a {
          text-decoration: none;
          /* 밑줄 제거 */
          color: inherit;
          /* 기본 텍스트 색상으로 설정 */
          background: none;
          /* 배경 제거 */
          border: none;
          /* 테두리 제거 */
        }
      </style>
    </head>

    <body>
      <header>
        <jsp:include page="/WEB-INF/views/includes/header.jsp" />
      </header>

      <div id="wrapper" class="py-3">
        <div class="tab_menu">
          <ul class="d-flex justify-content-center gap-4 fw-bold">
            <li class="active"><a class="tm_a py-2" href="#">Overview</a></li>
            <li><a class="tm_a py-2" href="/search/total/book?keyword=${param.keyword}&page=1">Book</a></li>
            <%--<li><a class="tm_a py-2" href="/search/total/author?keyword=${param.keyword}">Author</a></li>--%>
              <li><a class="tm_a py-2" href="/search/total/post?keyword=${param.keyword}">Post</a></li>
              <li><a class="tm_a py-2" href="/search/total/user?keyword=${param.keyword}">User</a></li>
          </ul>
        </div>
        <!-- /tab_menu-->

        <div class="container py-5 px-0 overflow-hidden">
          <section class="overview totalSearch py-5_py5">
            <!-- Books -->
            <div class="ts-book border border-dark-subtle mb-4 px-3 py-2 rounded-4">
              <h4 class="fw-bold"><a href="/search/total/book?keyword=${param.keyword}&page=1"
                  style="color: var(--color-black);"> 책 </a></h4>
              <ul>
                <c:if test="${empty bookList}">
                  <li>
                    <p>'${keyword}' 검색 결과가 없습니다.</p>
                  </li>
                </c:if>
                <c:forEach var="book" items="${bookList}">
                  <li class="row py-5_book">
                    <%-- <div class="col-1 fw-bold book_num">${book.index}.</div--%>
                      <%-- <div class="col-1 fw-bold book_num">${book.num}.
            </div>--%>
            <div class="col-2 book_img">
              <a href="/search/total/book/detail?isbn=${book.isbn}&keyword=${param.keyword}">
                <img src="${book.image}" alt="${book.title}의 표지" />
              </a>
            </div>
            <div class="col">
              <h3 class="fw-bold">
                <a href="/search/total/book/detail?isbn=${book.isbn}&keyword=${param.keyword}" id="book_title"
                  class="book_title" style="color: var(--color-blue)">${book.title}</a>
              </h3>
              <p class="book_info"> 저자 : ${book.author}
                <%-- <p class="book_desc" class="book_desc">${book.description}
              </p> --%>
            </div>
            </li>
            </c:forEach>
            </ul>
        </div>

        <!-- Authors -->
        <%--<div class="ts-author border border-dark-subtle mb-4 px-3 py-2 rounded-4">
          <h4 class="fw-bold"><a href="<c:url value='/search/total/author' />" style="color: var(--color-black);"> 작가
            </a></h4>
          <ul>
            <c:if test="${empty authorList}">
              <li>
                <p>'${keyword}' 검색 결과가 없습니다.</p>
              </li>
            </c:if>
            <c:forEach var="author" items="${authorList}">
              <li>
                <p>이름: ${author.name}</p>
                <p>대표작: ${author.mainWork}</p>
              </li>
            </c:forEach>
          </ul>
      </div> --%>

      <!-- Posts -->
      <div class="ts-post border border-dark-subtle mb-4 px-3 py-2 rounded-4">
        <h4 class="fw-bold"><a href="/search/total/post?keyword=${param.keyword}" style="color: var(--color-black);">
            게시글 </a></h4>
        <ul>
          <c:if test="${empty boardList}">
            <li>
              <p> '${keyword}' 검색 결과가 없습니다.</p>
            </li>
          </c:if>
          <c:forEach var="board" items="${boardList}">
            <a href="/community/viewPost/${board.postId}">
              <div class="col_colpost">
                <div class="d-flex gap-4 align-items-center mb-1_mb1">
                  <img src="${board.profileImagePath}" alt="프로필 이미지" class="profile-image" />
                  <p class="mb-0 me-5_username">${board.username}</p>
                  <p class="mb-0">${board.date}</p>
                </div>

                <p class="fw-bold fs-5 px-4 mb-2 rounded-4" style="background: var(--color-f4f4f4)">
                  ${board.title}
                </p>
                <p class="fw-bold fs-5 px-4 py-1 mb-0 rounded-4 cont_desc" style="background: var(--color-f4f4f4)">
                  ${board.content}
                </p>
              </div>
            </a>

          </c:forEach>
        </ul>
      </div>

      <!-- Users -->
      <div class="ts-users border border-dark-subtle mb-4 px-3 py-2 rounded-4">
        <h4 class="fw-bold"><a href="/search/total/user?keyword=${param.keyword}" style="color: var(--color-black);">
            사용자 </a></h4>
        <ul class="mainUser">
          <c:if test="${empty userList}">
            <li>
              <p>'${keyword}' 검색 결과가 없습니다.</p>
            </li>
          </c:if>
          <c:forEach var="user" items="${userList}">
            <li class="row align-items-center mb-5_mb5" style="margin-bottom: 0.5rem;">
              <!-- 프로필 사진 -->
              <div class="col-2 ul_icon col2">
                <img src="${user.profileImagePath}" class="mainProfileImage" />
              </div>
              <!-- 활동자명 -->
              <p class="col ul_title mb-0 fs-5_fs5">${user.username}</p>
            </li>
          </c:forEach>
        </ul>
      </div>

      <!-- pagination -->
      <%-- <div class="mt-5">
        <ul class="pagination d-flex justify-content-center gap-4 fw-bold">
          <!-- Previous 버튼 -->
          <li class="${currentPage == 1 ? 'disabled' : ''}">
            <a class="px-2 py-1" href="?page=${currentPage - 1}" ${currentPage==1 ? 'onclick="return false;"' : ''
              }>Previous</a>
          </li>

          <!-- 동적 페이지 번호 버튼 -->
          <c:forEach begin="1" end="${totalPages}" var="page">
            <li class="${currentPage == page ? 'active' : ''}">
              <a class="px-2 py-1" href="?page=${page}">${page}</a>
            </li>
          </c:forEach>

          <!-- Next 버튼 -->
          <li class="${currentPage == totalPages ? 'disabled' : ''}">
            <a class="px-2 py-1" href="?page=${currentPage + 1}" ${currentPage==totalPages ? 'onclick="return false;"'
              : '' }>Next</a>
          </li>
        </ul>
        </div> --%>
        </section>
        <!-- /overview -->
        </div>
        <!-- /container -->
        </div>
        <!-- /wrapper -->
    </body>

    </html>