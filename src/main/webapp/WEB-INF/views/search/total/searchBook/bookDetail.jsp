<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title> 리플렛 - 도서 상세 페이지 </title>
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
    <script src="/resources/js/search/bookDetail.js"></script>
  </head>

  <body>
  <header>
    <jsp:include page="/WEB-INF/views/includes/header.jsp" />
  </header>

    <div id="wrapper" class="py-3">
      <div class="container py-5 px-0">
        <div id="imageModal" class="image-modal" style="display: none;">
          <span class="close">&times;</span>
          <img class="image-modal-content" id="modalImage" />
        </div>
        <article class="bs_top mb-5">
          <div class="row align-items-end g-0">
            <div class="col-3">
              <img src="${book.image}" alt="도서 사진" />
            </div>

            <div class="col ps-5">
              <h3 class="fw-bold mb-3" style="color: var(--color-blue)">${book.title}</h3>
                        <p class="mb-0 fs-5"> 저자 : ${book.author}</p>
                    <%--    <p class="mb-0 fs-5"> 출판사 : ${book.publisher}</p>--%>
                    <%--    <p class="mb-5 fs-5"> 출판일자 : ${book.pubdate}</p>--%>
              <!-- 책 리뷰와 찜 버튼을 같은 부모 요소에 배치 -->
              <div class="d-flex align-items-center">
                <p class="mb-0 fs-5 me-3">
                  <a href="#bs_review">
                    책 리뷰
                    <span class="review-count me-2" style="color: var(--color-0f62fe)">${reviewList.size()}</span>
                    <span>&starf;&starf;&starf;&starf;&starf;</span>
                    <span class="average-rating" style="color: var(--color-0f62fe)">${averageRating}</span>
                  </a>
                </p>
                <span id="bookDetail" data-id="${book.isbn}" class="bookFav" style="cursor: pointer;">
                  <span style="font-size: 1.5rem; color: var(--color-0f62fe);" class="heart-icon">&#x2661;</span> 찜
                </span>
              </div>              
          </div>
        </article>
        <!-- /bs_top -->

        <article class="bs_info pt-5">
          <h5 class="mb-3 pb-3 border-bottom border-black">책 정보</h5>
          <p class="p-3" style="background: var(--color-f2f4f8)"> 출판사 : ${book.publisher}</p>
          <p class="p-3" style="background: var(--color-f2f4f8)"> 출판일자 : ${book.pubdate}</p>
          <p class="p-3" style="background: var(--color-f2f4f8)"> ISBN : ${book.isbn}</p>
        </article>
        <!-- /bs_info -->

        <article class="bs_intro pt-5">
          <h5 class="mb-3 pb-3 border-bottom border-black">책 소개</h5>
          <p class="p-3" style="background: var(--color-f2f4f8)">${book.description}</p>
        </article>
        <!-- /bs_intro -->

        <article class="bs_images pt-5 pb-4 border-bottom border-black">
          <h5 class="mb-3">상세 이미지</h5>
          <div class="text-center" style="background: var(--color-f2f4f8)">
           <!-- 11.24 상세이미지 추가-->
             <!-- 반쯤 감춰진 이미지 영역 -->
          <div id="hiddenImages" style="height: 150px; overflow: hidden; transition: height 0.5s ease;">
            <img src="${book.image}" alt="상세 이미지" style="max-width: 100%; margin-bottom: 10px;" />
          </div>
            <!-- 11.24 주석처리함 button type="button">상세 이미지 더보기 &or;</button -->
            <button id="toggleButton" type="button" style="background: none; border: none; color: var(--color-blue); cursor: pointer;">
              상세 이미지 더보기 &or;
            </button>
          </div>
        </article>
        <!-- /bs_images -->

        <article class="bs_review py-5 px-3 border-bottom border-black" id="bs_review">
          <h5 class="fw-bold" style="color: var(--color-0f62fe)">review</h5>
          <!-- 추가된 리뷰 작성 폼 -->
          <form action="/review" method="post" class="d-flex align-items-center">
            <!-- Hidden Field: 책 ID -->
            <input type="hidden" name="bookId" value="${book.isbn}" />
          
            <!-- 평점 영역 -->
            <fieldset class="rate">
              <input type="radio" id="rating10" name="rating" value="10" />
              <label for="rating10" title="5점"></label>
              <input type="radio" id="rating9" name="rating" value="9" />
              <label class="half" for="rating9" title="4.5점"></label>
              <input type="radio" id="rating8" name="rating" value="8" />
              <label for="rating8" title="4점"></label>
              <input type="radio" id="rating7" name="rating" value="7" />
              <label class="half" for="rating7" title="3.5점"></label>
              <input type="radio" id="rating6" name="rating" value="6" />
              <label for="rating6" title="3점"></label>
              <input type="radio" id="rating5" name="rating" value="5" />
              <label class="half" for="rating5" title="2.5점"></label>
              <input type="radio" id="rating4" name="rating" value="4" />
              <label for="rating4" title="2점"></label>
              <input type="radio" id="rating3" name="rating" value="3" />
              <label class="half" for="rating3" title="1.5점"></label>
              <input type="radio" id="rating2" name="rating" value="2" />
              <label for="rating2" title="1점"></label>
              <input type="radio" id="rating1" name="rating" value="1" />
              <label class="half" for="rating1" title="0.5점"></label>
            </fieldset>
          
            <!-- 리뷰 내용 영역 -->
            <div class="flex-grow-1 mx-3">
              <textarea
                class="form-control"
                name="reviewContent"
                placeholder="리뷰를 작성해주세요"
                style="
                  height: 100px;
                  border: none;
                  background: var(--color-f2f4f8);
                  border-bottom: 2px solid #bbb;
                  border-radius: 0;
                "
                required
              ></textarea>
            </div>
          
            <!-- 등록 버튼 -->
            <div style="height: 100px">
              <button
                class="rounded-3 h-100 px-4"
                style="
                  background: var(--color-0f62fe);
                  color: var(--color-white);
                "
                type="submit"
              >
                등록
              </button>
            </div>
          </form>          
        </article>
        <!-- /bs_review -->

        <article class="bs_review_list py-5">
            <!-- 리뷰 목록 출력 시작 -->
            <c:choose>
                <c:when test="${empty reviewList}">
                    <div class="text-center py-5">
                        <p>리뷰가 없습니다.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <ul class="p-0">
                        <c:forEach var="review" items="${reviewList}">
                            <li class="mb-3">
                                <!-- 리뷰 내용 -->
                                <div class="row g-0 align-items-center">
                                    <!-- 별점 -->
                                    <p class="col-2 text-center">
                                        <c:forEach begin="1" end="${review.rating}">
                                            &starf;
                                        </c:forEach>
                                    </p>
                                    <!-- 리뷰 내용 -->
                                    <p class="col m-0">${review.content}</p>

                                    <!-- 삭제 및 좋아요 버튼 -->
                                    <div class="col text-end">
                                        <!-- 삭제 아이콘 -->
                                        <form action="/deleteReview" method="post" style="display:inline;">
                                            <input type="hidden" name="reviewId" value="${review.id}" />
                                            <button type="submit" style="border: none; background: none;">
                                                <img src="/resources/images/search/bs_icon1.jpg" alt="삭제" title="삭제" style="width: 16px;" />
                                            </button>
                                        </form>
                                        <!-- 좋아요 아이콘 -->
                                        <form action="/likeReview" method="post" style="display:inline;">
                                            <input type="hidden" name="reviewId" value="${review.id}" />
                                            <button type="submit" style="border: none; background: none;">
                                                <img src="/resources/images/search/bs_icon2.jpg" alt="좋아요" title="좋아요" style="width: 16px;" />
                                            </button>
                                            <span>${review.likeCount}</span>
                                        </form>
                                    </div>
                                </div>
                                <!-- 작성자 및 작성일 -->
                                <div class="row g-0">
                                    <div class="col-2"></div>
                                    <div class="col">
                                        <span class="me-5">${review.username}</span>
                                        <span>${review.date}</span>
                                    </div>
                                    <div class="col"></div>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </c:otherwise>
            </c:choose>
        </article>

        <!-- /bs_review_list -->
      </div>
    </div>
  </body>
</html>