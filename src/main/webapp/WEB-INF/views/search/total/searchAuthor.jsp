<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>리플렛 - 작가 검색</title>
    <!-- CSS 경로 수정 -->
    <link rel="stylesheet" href="/resources/css/search/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css">
    <!--link rel="stylesheet" href="/resources/css/headerstyle.css"-->

    <!-- JavaScript 경로 수정 -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    <script src="/resources/js/search/author.js"></script>
</head>
<body>
<header>
    <jsp:include page="/WEB-INF/views/includes/headerAuthor.jsp" />
</header>

<div id="wrapper" class="py-3">
      <div class="tab_menu">
        <ul class="d-flex justify-content-center gap-4 fw-bold">
          <li><a class="tm_a py-2" href="/search/total?keyword=${param.keyword}">Overview</a></li>
          <li><a class="tm_a py-2" href="/search/total/book?keyword=${param.keyword}&page=1">Book</a></li>
          <li class="active"><a class="tm_a py-2" href="#">Author</a></li>
          <li><a class="tm_a py-2" href="/search/total/post?keyword=${param.keyword}">Post</a></li>
          <li><a class="tm_a py-2" href="/search/total/user?keyword=${param.keyword}">User</a></li>
        </ul>
      </div>
      <!-- /tab_menu -->

    <article class="author_profile mb-5">
        <h4 class="mb-3">프로필</h4>
        <div class="border-top border-black py-4 d-flex align-items-start">
            <!-- 작가 프로필 사진 -->
            <div class="profile-img me-4">
                <img src="${author.image}" alt="${author.name} 작가 사진">
            </div>

            <!-- 작가 정보 박스 -->
            <div class="profile-info p-3">
                <!-- 작가 이름과 소개 -->
                <div class="mb-3">
                    <h5 class="fw-bold mb-2">${author.name}</h5>
                    <p class="mb-0">${author.bio}</p>
                </div>
                <!-- 작가 세부 정보 -->
                <ul class="list-unstyled mt-3">
                    <li><strong>출생 연도:</strong> ${author.birthYear}</li>
                    <li><strong>사망 연도:</strong> ${author.deathYear}</li>
                    <li><strong>출생지:</strong> ${author.birthPlace}</li>
                    <li><strong>국적:</strong> ${author.nationality}</li>
                    <li><strong>장르:</strong> ${author.genre}</li>
                    <li><strong>대표 도서:</strong> ${author.mainBooks}</li>
                    <li><strong>도서 수:</strong> ${author.bookCount}</li>
                </ul>
            </div>
        </div>
    </article>

    <article class="author_bookList">
        <div class="d-flex justify-content-between">
            <h4>도서 목록</h4>
            <a class="fw-bold" href="/allBooks?authorId=${author.id}">
                <span style="color: var(--color-black)">전체보기&raquo;</span>
            </a>
        </div>

        <div class="abl_list border-top border-black py-4">
            <!-- 도서 목록이 없는 경우 보여줄 메시지 -->
            <c:if test="${authorBooks == null || empty authorBooks}">
              <p>도서 목록이 없습니다.</p>
            </c:if>

            <!-- 도서 목록이 있는 경우 swiper를 렌더링 -->
            <c:if test="${not empty authorBooks}">
            <div class="swiper">
                <div class="swiper-wrapper">
                    <c:forEach var="book" items="${authorBooks}">
                        <div class="swiper-slide">
                            <img src="${book.image}" alt="${book.title} 도서 사진">
                            <div class="p-3">
                                <p class="abl_title fw-bold fs-5">
                                    <a href="/bookDetail?bookId=${book.id}">
                                        <span style="color: var(--color-black)">${book.title}</span>
                                    </a>
                                </p>
                                <a class="abl_more" href="/bookDetail?bookId=${book.id}"> 자세히 보기 &rarr;</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <!-- swiper-wrapper -->
                <div class="swiper-button-prev"></div>
                <div class="swiper-button-next"></div>
            </div>
            </c:if>
            <!-- /swiper -->
        </div>
    </article>
    <!-- /author_bookList -->
</div>
<!-- /wrapper -->
</body>
</html>

