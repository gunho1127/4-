<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


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
      <script>
          $(document).ready(function () {
              $("form[action='/search/total/book/detail/review']").on("submit", function (event) {
                  event.preventDefault(); // 기본 폼 제출 방지

                  // 폼 데이터를 직렬화
                  var formData = $(this).serialize();

                  // AJAX 요청 보내기
                  $.ajax({
                      url: $(this).attr("action"), // form의 action URL 사용
                      type: $(this).attr("method"), // form의 method 사용
                      data: formData,
                      success: function (response) {
                          if(response.resultCode === "SUCCESS") {
                              location.reload();
                          } else if(response.resultCode === "ERR_LOGIN") {
                              alert(response.message);
                              location.replace("/login/enterEmail");
                          } else if(response.resultCode === "ERR_ALREADY_EXIST") {
                              alert(response.message);
                          }
                      },
                      error: function (xhr, status, error) {
                          // 에러 콜백
                          console.error("Error:", error.data);
                          alert("리뷰 등록 중 오류가 발생했습니다. 다시 시도해주세요.");
                      }
                  });
              });

              // 좋아요 폼 AJAX 처리
              $("#likeForm").on("submit", function (event) {
                  event.preventDefault(); // 기본 폼 제출 방지

                  // 폼 데이터를 직렬화
                  var formData = $(this).serialize();
                  console.log("Form Data Sent:", formData);

                  // AJAX 요청 보내기
                  $.ajax({
                      url: $(this).attr("action"), // 좋아요 폼의 action URL 사용
                      type: $(this).attr("method"), // 좋아요 폼의 method 사용
                      data: formData,
                      success: function (response) {
                      console.log("Response Received:", response);
                          if(response.resultCode === "SUCCESS") {
                              location.reload();
                          } else if(response.resultCode === "ERR_LOGIN") {
                              alert(response.message);
                              location.replace("/login/enterEmail");
                          } else if(response.resultCode === "ERR_ALREADY_EXIST") {
                              alert(response.message);
                          }
                      },
                      error: function (xhr, status, error) {
                          console.error("Like Error:", error);
                          alert("좋아요 처리 중 오류가 발생했습니다. 다시 시도해주세요.");
                      }
                  });
              });

              // 삭제 폼 AJAX 처리
              $("#deleteForm").on("submit", function (event) {
                  event.preventDefault(); // 기본 폼 제출 방지

                  var formData = $(this).serialize(); // 폼 데이터를 직렬화
                  var $form = $(this);

                  $.ajax({
                      url: $form.attr("action"), // 폼의 action URL 사용
                      type: $form.attr("method"), // 폼의 method 사용
                      data: formData,
                      success: function (response) {
                          if (response.resultCode === "SUCCESS") {
                              alert("리뷰가 삭제되었습니다.");
                              $form.closest(".review-item").remove(); // 삭제된 리뷰 항목 제거
                          } else if (response.resultCode === "ERR_LOGIN") {
                              alert("로그인이 필요합니다.");
                              location.replace("/login/enterEmail");
                          } else if (response.resultCode === "ERR_INVALID_PERMISSION") {
                              alert("삭제 권한이 없습니다.");
                          } else {
                              alert(response.message || "삭제 처리 중 오류가 발생했습니다.");
                          }
                      },
                      error: function (xhr, status, error) {
                          console.error("Delete Error:", error);
                          alert("삭제 처리 중 오류가 발생했습니다. 다시 시도해주세요.");
                      }
                  });
              });

          });
      </script>
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
              <h3 class="fw-bold mb-3_title" style="color: var(--color-blue)">${book.title}</h3>
                <p class="mb-0 fs-5_author"> 저자 : ${book.author}</p>
                    <%--    <p class="mb-0 fs-5"> 출판사 : ${book.publisher}</p>--%>
                    <%--    <p class="mb-5 fs-5"> 출판일자 : ${book.pubdate}</p>--%>
              <!-- 책 리뷰와 찜 버튼을 같은 부모 요소에 배치 -->
              <div class="d-flex align-items-center">
                <p class="mb-0 fs-5 me-3_review">
                  <a href="#bs_review">
                    책 리뷰
                    <span class="review-count me-2" style="color: var(--color-0f62fe)">${reviewList.size()}</span>
                      <span>
                   <%--   <c:forEach begin="1" end="${reviewAverage/2}"> --%>
                   <%--   <c:forEach var="i" begin="1" end="${(reviewAverage / 2).intValue()}">--%>
                      <c:forEach var="i" begin="1" end="${starCount}">
                  <%-- <c:forEach var="i" begin="1" end="${(reviewAverage/2).intValue()}">--%>
                          &starf;
                      </c:forEach>
                      </span>
                    <span class="average-rating" style="color: var(--color-0f62fe)">
                   <%-- ${averageRating}--%>
                   <c:choose>
                       <c:when test="${reviewAverage > 0}">
                    <%-- <c:when test="${reviewAverage != null && reviewAverage > 0}">--%>
                           ${reviewAverage}점
                       </c:when>
                       <c:otherwise>
                           평점 없음
                       </c:otherwise>
                   </c:choose>
                    </span>
                  </a>
                </p>
                <!-- 찜 도서 승연님 여기 css !! -->
                  <span id="bookDetail" data-id="${book.isbn}" style="cursor: pointer;">
                    <!-- <span id="bookDetail" data-id="${book.isbn}" class="bookFav" style="cursor: pointer;"></span> -->
                    <!-- <span style="font-size: 1.5rem; color: var(--color-0f62fe);" class="heart-icon" onclick="setBookmark()">&#x2661;찜 등록하기</span> -->


                    <c:choose>

                      <c:when test="${bookmarkList == null}">
                        <span style="font-size: 1.5rem; color: var(--color-0f62fe);"
                          onclick="window.location.href='/login/enterEmail'">찜 등록하기</span>
                      </c:when>

                      <c:otherwise>

                        <c:set var="i" value="0" />
                        <c:forEach var="bookmark" items="${bookmarkList}">
                          <c:if test="${bookmark.bookId == book.isbn}">

                            <c:set var="i" value="${i + 1}" />
                          </c:if>
                        </c:forEach>

                        <c:choose>

                          <c:when test="${i > 0}">

                            <span style="font-size: 1.5rem; color: var(--color-0f62fe);"
                              onclick="deleteBookmark('${book.isbn}')">찜 해제하기</span>
                          </c:when>


                          <c:otherwise>

                            <c:choose>
                              <c:when test="${user.id == null}">
                                <span style="font-size: 1.5rem; color: var(--color-0f62fe);"
                                  onclick="window.location.href='/login/enterEmail'">찜 등록하기</span>
                              </c:when>

                              <c:otherwise>

                                <span style="font-size: 1.5rem; color: var(—color-0f62fe);"
                                  onclick="setBookmark('${book.isbn}')">찜 등록하기</span>
                              </c:otherwise>

                            </c:choose>
                          </c:otherwise>


                        </c:choose>
                      </c:otherwise>
                    </c:choose>

                  </span>
              </div>              
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
          <form action="/search/total/book/detail/review" method="post" class="d-flex align-items-center">
            <!-- Hidden Field: 책 ID -->
            <input type="hidden" name="bookId" value="${book.isbn}" />
            <input type="hidden" name="bookImage" value="${book.image}" />
            <input type="hidden" name="bookTitle" value="${book.title}" />

            <!-- 평점 영역 -->
            <fieldset class="rate">
                <input type="radio" id="rating5" name="rating" value="10" />
                <label for="rating5" title="5점"></label>
                <input type="radio" id="rating4" name="rating" value="8" />
                <label for="rating4" title="4점"></label>
                <input type="radio" id="rating3" name="rating" value="6" />
                <label for="rating3" title="3점"></label>
                <input type="radio" id="rating2" name="rating" value="4" />
                <label for="rating2" title="2점"></label>
                <input type="radio" id="rating1" name="rating" value="2" />
                <label for="rating1" title="1점"></label>
            </fieldset>
           <%-- <fieldset class="rate">
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
            </fieldset> --%>
          
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
              <button id="reviewBtn" class="rounded-3 h-100 px-4" style="
                  background: var(--color-0f62fe);
                  color: var(--color-white);
                " type="submit">등록</button>
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
                            <div class="review-item">
                            <li class="mb-3">
                                <!-- 리뷰 내용 -->
                                <div class="row g-0 align-items-center">
                                    <!-- 별점 -->
                                    <p class="col-2 text-center_star">
                                        <c:forEach begin="1" end="${review.reviewRating/2}">
                                            &starf;
                                        </c:forEach>
                                    </p>
                                    <!-- 리뷰 내용 -->
                                    <p class="col m-0_content">${review.reviewContent}</p>

                                    <!-- 삭제 및 좋아요 버튼 -->
                                    <div class="col text-end">

                                        <!-- 삭제 버튼: 로그인 사용자와 리뷰 작성자가 같은 경우에만 표시 -->
                                        <c:if test="${user != null && user.id != null && user.id.equals(review.id)}">
                                        <form id="deleteForm" action="/search/total/book/detail/review/delete" method="post" style="display:inline;">
                                            <input type="hidden" name="reviewId" value="${review.reviewId}" />
                                            <button type="submit" style="border: none; background: none;">
                                                <img src="/resources/images/search/bs_icon1.jpg" alt="삭제" title="삭제" class="delete"/>
                                            </button>
                                            <span style="display:none;">${review.isDelete}</span>

                                        </form>
                                        </c:if>
                                        <!-- 좋아요 아이콘 -->
                                        <form id="likeForm" action="/search/total/book/detail/review/like" method="post" style="display:inline;">
                                            <input type="hidden" name="reviewId" value="${review.reviewId}" />
                                            <button type="submit" style="border: none; background: none;">
                                                <img src="/resources/images/search/bs_icon2.jpg" alt="좋아요" title="좋아요" style="width: 26px;" />
                                            </button>
                                            <span>${review.likeCount}</span>
                                        </form>
                                    </div>
                                </div>
                                <!-- 작성자 및 작성일 -->
                                <div class="row g-0">
                                    <div class="col-2"></div>
                                    <div class="col">
                                        <span class="me-5"><strong>${review.username}</strong></span>
                                        <span class="reviewDate">${review.date}</span>
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
    <script>
     function setBookmark() {
              // JSP에서 EL로 값을 JavaScript 변수에 할당
              const id = '${user.id}';
              const bookId = '${book.isbn}';
              const bookImageUrl = '${book.image}';
              const bookTitle = '${book.title}';
              const author = '${book.author}';

              // fetch 요청 시 변수 이름을 body에 담기
              fetch('/search/total/book/bookMark', {
                method: 'POST',
                headers: {
                  'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                  id: id,
                  bookId: bookId,
                  bookImageUrl: bookImageUrl,
                  bookTitle: bookTitle,
                  author: author
                })
              })
                .then(response => response.json())  // 서버 응답을 JSON으로 파싱
                .then(data => {
                  if (data.redirectUrl) {
                    // 리디렉션 URL이 존재하면 해당 URL로 이동
                    window.location.href = data.redirectUrl;
                  }
                })
                .catch(error => console.error('Error:', error));
            }

            function deleteBookmark() {
              // JSP에서 EL로 값을 JavaScript 변수에 할당
              const id = '${user.id}';
              const bookId = '${book.isbn}';

              // fetch 요청 시 변수 이름을 body에 담기
              fetch('/search/total/book/bookMark', {
                method: 'POST',
                headers: {
                  'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                  id: id,
                  bookId: bookId,
                })
              })
                .then(response => response.json())  // 서버 응답을 JSON으로 파싱
                .then(data => {
                  if (data.redirectUrl) {
                    // 리디렉션 URL이 존재하면 해당 URL로 이동
                    window.location.href = data.redirectUrl;
                  }
                })
                .catch(error => console.error('Error:', error));
            }

    </script>
  </body>
</html>