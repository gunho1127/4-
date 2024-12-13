<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>리플렛 - 도서 검색</title>
    <link rel="stylesheet" href="/resources/css/search/style.css" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
      crossorigin="anonymous"
    />
    <link rel="stylesheet" href="/resources/css/headerstyle.css">

    <script
      src="https://code.jquery.com/jquery-3.7.1.min.js"
      integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
      crossorigin="anonymous"
    ></script>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"
    ></script>
    <script src="/resources/js/search/cookie.js"></script>
    <script src="/resources/js/search/book.js"></script>
    <style>
          .book_desc {
          font-size: 15px;
          max-height: 40px;
          overflow: hidden;
          display: -webkit-box;
          -webkit-box-orient: vertical;
          -webkit-line-clamp: 2;
 }
  </style>
  </head>
  <body>
  <header>
   <jsp:include page="/WEB-INF/views/includes/headerBook.jsp" />

  </header>

  <div id="wrapper" class="py-3">
        <div class="tab_menu">
          <ul class="d-flex justify-content-center gap-4 fw-bold">
            <li><a class="tm_a py-2" href="/search/total?keyword=${param.keyword}">Overview</a></li>
            <li class="active"><a class="tm_a py-2" href="#">Book</a></li>
            <%--<li><a class="tm_a py-2" href="/search/total/author?keyword=${param.keyword}">Author</a></li>--%>
            <li><a class="tm_a py-2" href="/search/total/post?keyword=${param.keyword}">Post</a></li>
            <li><a class="tm_a py-2" href="/search/total/user?keyword=${param.keyword}">User</a></li>
          </ul>
        </div>
        <!-- /tab_menu -->

  <div class="container py-5 px-0 overflow-hidden">
    <section class="book">
        <!-- 검색 결과 -->
        <div class="book_sch pb-3 border-bottom">
            <h5>'${keyword}'에 대한 도서 검색 결과 <span class="fw-bold">${bookList.totalPage}</span>건</h5>
        </div>

        <!-- 도서 목록 없을 때 메시지 표시 -->
        <c:if test="${empty bookList.data}">
            <p class="text-center py-5"> 도서 목록이 없습니다.</p>
        </c:if>

        <!-- 도서 목록 있을 때 리스트 표시 -->
        <c:if test="${not empty bookList.data}">

            <!-- 도서 목록 -->
            <ul class="book_list p-0">
                <c:forEach var="book" items="${bookList.data}">

                  <li class="row py-5">

                    <div class="col-1 fw-bold book_num">${book.num}.</div>
                    <div class="col-2 book_img">
                      <a href="/search/total/book/detail?isbn=${book.isbn}&keyword=${param.keyword}"><img
                          src="${book.image}" alt="${book.title}의 표지" /></a>

                    </div>
                    <div class="col">
                      <h3 class="fw-bold">
                        <a href="/search/total/book/detail?isbn=${book.isbn}&keyword=${param.keyword}"
                          class="book_title" style="color: var(--color-blue)">${book.title}</a>
                      </h3>
                      <p class="book_info">${book.author} | ${book.publisher} | ${book.pubdate}</p>
                      <p class="book_desc" class="book_desc">${book.description}</p>
                    </div>
                  </li>


                </c:forEach>
            </ul>
        </c:if>
        <!-- /book_list -->

      <!-- pagination -->
        <c:if test="${bookList.data.size() > 0}">
              <div class="mt-5">
                  <ul class="pagination d-flex justify-content-center gap-4 fw-bold">
                      <!-- Previous 버튼 -->
                      <c:if test="${bookList.beginPage != 1}">
                          <li class="${bookList.currentPage == 1 ? 'disabled' : ''}">
                              <a class="px-2 py-1" href="?keyword=${keyword}&page=${bookList.currentPage - 1}" ${bookList.currentPage == 1 ? 'onclick="return false;"' : ''}>Previous</a>
                          </li>
                      </c:if>
                      <!-- 동적 페이지 번호 버튼 -->
                      <c:forEach begin="${bookList.beginPage}" end="${bookList.beginPage + 5}" var="page">
                          <li class="${bookList.currentPage == page ? 'active' : ''}">
                              <a class="px-2 py-1" href="?keyword=${keyword}&page=${page}">${page}</a>
                          </li>
                      </c:forEach>

                      <!-- Next 버튼 -->
                      <li class="${bookList.currentPage == bookList.totalPage ? 'disabled' : ''}">
                          <a class="px-2 py-1" href="?keyword=${keyword}&page=${bookList.currentPage + 1}" ${bookList.currentPage == bookList.totalPage ? 'onclick="return false;"' : ''}>Next</a>
                      </li>
                  </ul>
                  </div>
              </c:if>

          <!-- /pagination -->
        </section>
        <!-- /book -->
      </div>
      <!-- /container -->
    </div>
    <!-- /wrapper -->
  </body>
</html>



