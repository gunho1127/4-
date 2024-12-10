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
            <li><a class="tm_a py-2" href="/search/total/author?keyword=${param.keyword}">Author</a></li>
            <li><a class="tm_a py-2" href="/search/total/post?keyword=${param.keyword}">Post</a></li>
            <li><a class="tm_a py-2" href="/search/total/user?keyword=${param.keyword}">User</a></li>
          </ul>
        </div>
        <!-- /tab_menu -->

  <div class="container py-5 px-0 overflow-hidden">
    <section class="book">
        <!-- 검색 결과 -->
        <div class="book_sch pb-3 border-bottom">
            <h5>총 검색 결과 <span class="fw-bold">${bookList.size()}</span>건</h5>
        </div>

        <!-- 도서 목록 없을 때 메시지 표시 -->
        <c:if test="${empty bookList}">
            <p class="text-center py-5">도서 목록이 없습니다.</p>
        </c:if>

        <!-- 도서 목록 있을 때 리스트 표시 -->
        <c:if test="${not empty bookList}">

            <!-- 도서 목록 -->
            <ul class="book_list p-0">
                <c:forEach var="book" items="${bookList}">
                    <li class="row py-5">
                        <div class="col-1 fw-bold book_num">${book.index}.</div>
                        <div class="col-2 book_img">
                            <img src="${book.image}" alt="${book.title}의 표지" />
                        </div>
                        <div class="col">
                            <h3 class="fw-bold">
                                <a href="/search/total/book/detail?bookId=${book.id}" class="book_title" style="color: var(--color-blue)">${book.title}</a>
                            </h3>
                            <p class="book_info">${book.author} | ${book.publisher} | ${book.pubdate}</p>
                            <p class="book_desc">${book.description}</p>
                        </div>
                        <div class="col-1 text-end">
                            <button class="bookMark" type="button" data-id="${book.id}">
                                <img src="../../../../resources/images/search/book_mark_off.png" alt="북마크" />
                            </button>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </c:if>
        <!-- /book_list -->

      <!-- pagination -->
      <div class="mt-5">
        <ul class="pagination d-flex justify-content-center gap-4 fw-bold">
            <!-- Previous 버튼 -->
            <li class="${currentPage == 1 ? 'disabled' : ''}">
                <a class="px-2 py-1" href="?page=${currentPage - 1}" ${currentPage == 1 ? 'onclick="return false;"' : ''}>Previous</a>
            </li>

            <!-- 동적 페이지 번호 버튼 -->
            <c:forEach begin="1" end="${totalPages}" var="page">
                <li class="${currentPage == page ? 'active' : ''}">
                    <a class="px-2 py-1" href="?page=${page}">${page}</a>
                </li>
            </c:forEach>

            <!-- Next 버튼 -->
            <li class="${currentPage == totalPages ? 'disabled' : ''}">
                <a class="px-2 py-1" href="?page=${currentPage + 1}" ${currentPage == totalPages ? 'onclick="return false;"' : ''}>Next</a>
            </li>
        </ul>
    </div>
        
          <!-- /pagination -->
        </section>
        <!-- /book -->
      </div>
      <!-- /container -->
    </div>
    <!-- /wrapper -->
  </body>
</html>



