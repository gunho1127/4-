<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>리플렛 - 게시글 검색</title>
    <!-- CSS 경로 수정 -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
      crossorigin="anonymous"
    />
    <link rel="stylesheet" href="/resources/css/search/style.css" />
    <link rel="stylesheet" href="/resources/css/headerstyle.css">

    <!-- JavaScript 경로 수정 -->
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
  </head>
  <body>
  <header>
    <jsp:include page="/WEB-INF/views/includes/headerPost.jsp" />
  </header>

  <div id="wrapper" class="py-3">
    <div class="tab_menu">
      <ul class="d-flex justify-content-center gap-4 fw-bold">
        <li><a class="tm_a py-2" href="/search/total?keyword=${keyword}">Overview</a></li>
        <li><a class="tm_a py-2" href="/search/total/book?keyword=${keyword}">Book</a></li>
        <li><a class="tm_a py-2" href="/search/total/author?keyword=${keyword}">Author</a></li>
        <li class="active"><a class="tm_a py-2" href="#">Post</a></li>
        <li><a class="tm_a py-2" href="/search/total/user?keyword=${keyword}">User</a></li>
      </ul>
    </div>
    <!-- /tab_menu -->

      <div class="container py-5 px-0 overflow-hidden size">
        <section class="post">
          <div
            class="post_sch pb-3 border-bottom d-flex justify-content-between search"
          >
            <!-- 총 검색 결과 -->
            <h5>'${keyword}'에 대한 게시글 검색 결과 <span class="fw-bold">${boardList.size()}</span>건</h5>

            <div>
             <form method="get" action="/search/total/post" class="d-inline">
               <input type="hidden" name="sort" value="popular" />
               <!-- 검색어 유지 -->
               <input type="hidden" name="keyword" value="${keyword}" />
               <button
                 class="btn-filter ${sort == 'popular' ? 'active' : ''} "
                 type="submit"
               >
                 인기순
               </button>
             </form>
             <form method="get" action="/search/total/post" class="d-inline">
               <input type="hidden" name="sort" value="recent" />
               <!-- 검색어 유지 -->
               <input type="hidden" name="keyword" value="${keyword}" />
               <button
                 class="btn-filter ${sort == 'recent' ? 'active' : ''} me-3"
                 type="submit"
               >
                 최신순
               </button>
             </form>
           </div>
            <!-- 정렬 버튼
            <div>
              <form method="get" action="/search/total/post" class="d-inline">
                <input type="hidden" name="sort" value="latest" />
                <button
                  class="btn-filter ${sort == 'latest' ? 'active' : ''}"
                  type="submit">
                  최신순
                </button>
              </form>
              <form method="get" action="/search/total/post" class="d-inline">
                  <input type="hidden" name="sort" value="popular" />
                  <button
                    class="btn-filter ${sort == 'popular' ? 'active' : ''} me-3"
                    type="submit">
                    인기순
                  </button>
                </form>
            </div>-->
          </div>
        </section>
      </div>


          <!-- 게시물 목록 없을 때 메시지 표시 -->
          <c:if test="${empty boardList}">
              <div class="text-center py-5">
                  <p>게시물이 없습니다.</p>
              </div>
          </c:if>

          <c:if test="${not empty boardList}">
              <div class="board_list py-5 list" >
                  <c:forEach var="board" items="${boardList}">
                      <div class="row pt-2 pb-4 align-items-end" style="border-top: 4px groove #eee">
                          <!-- 사용자 정보 및 게시글 -->
                          <div class="col">
                              <div class="d-flex gap-4 align-items-center mb-1">
                                  <img src="${board.profileImagePath}" alt="프로필 이미지" class="profile-image" />
                                  <p class="mb-0 me-5">${board.username}</p>
                                  <p class="mb-0">${board.date}</p>
                              </div>

                              <p class="fw-bold fs-5 px-4 mb-2 rounded-4" style="background: var(--color-f4f4f4)">
                                  ${board.title}
                              </p>
                              <p class="fw-bold fs-5 px-4 py-1 mb-0 rounded-4 cont_desc" style="background: var(--color-f4f4f4)">
                                  ${board.content}
                              </p>
                          </div>

                          <!-- 게시물 이미지 -->
                          <c:if test="${not empty board.postImagePath}">
                              <div class="col-2 position-relative">
                                  <img src="${board.postImagePath}" alt="게시물 이미지" class="post-image" />
                              </div>
                          </c:if>
                      </div>
                  </c:forEach>
              </div>
          </c:if>
          </div>

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


        </section>
        <!-- /post -->
      </div>
      <!-- /container -->
    </div>
    <!-- /wrapper -->
  </body>
</html>

